resource "aws_iam_role" "lex_role" {
  name = "ar_connect_lex_role"
    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lexv2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}
resource "aws_iam_role_policy" "lex_polly_policy" {
  name = "ar_connect_lex_polly_policy"
  role = aws_iam_role.lex_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "polly:SynthesizeSpeech"
        ]
        Resource = "*"
      }
    ]
  })
}
# resource "aws_iam_role_policy_attachment" "lex_policy" {
#     role = aws_iam_role.lex_role.name
#     policy_arn = "arn:aws:iam::aws:policy/AmazonLexFullAccess"
# }
resource "aws_lexv2models_bot" "bank_bot" {
    name = "ar_bank_lex_bot"
    idle_session_ttl_in_seconds = 300
    role_arn = aws_iam_role.lex_role.arn
    type = "Bot"
    data_privacy  {
        child_directed = false
    }
}
resource "aws_lexv2models_bot_locale" "english" {
    bot_id = aws_lexv2models_bot.bank_bot.id
    bot_version = "DRAFT"
    locale_id = "en_US"
    n_lu_intent_confidence_threshold = 0.40
}
resource "aws_lexv2models_intent" "cards_support" {
    bot_id = aws_lexv2models_bot.bank_bot.id
    bot_version = aws_lexv2models_bot_locale.english.bot_version
    locale_id = aws_lexv2models_bot_locale.english.locale_id
    name = "CardsSupport"
    sample_utterance {
        utterance = "I need help with my card"
    }
    sample_utterance {
        utterance = "Help me with my debit card"
    }
    sample_utterance {
        utterance = "My credit card is not working"
    }
}
resource "aws_lexv2models_intent" "fraud_support" {
    bot_id = aws_lexv2models_bot.bank_bot.id
    bot_version = aws_lexv2models_bot_locale.english.bot_version
    locale_id = aws_lexv2models_bot_locale.english.locale_id
    name = "FraudSupport"
    sample_utterance {
        utterance = "I want to report fraud"
    }
    sample_utterance {
        utterance = "Someone used my card"
    }
    sample_utterance {
        utterance = "I see an unauthorized transaction"
    }
}
resource "aws_lexv2models_bot_version" "bank_bot_version" {
    bot_id = aws_lexv2models_bot.bank_bot.id
    locale_specification = {
        "en_US" = {
            source_bot_version = "DRAFT"
        }
    }
    depends_on = [
        aws_lexv2models_intent.cards_support,
        aws_lexv2models_intent.fraud_support
    ]
}
data "aws_connect_instance" "exisitng" {
    instance_id = "10cbce69-375a-4650-b14c-9b53be745e5a"
}
resource "aws_cloudformation_stack" "lex_connect_integration" {
  name = "ar_bank_lex_connect_integration"
  parameters = {
    BotId = aws_lexv2models_bot.bank_bot.id
    BotVersion = aws_lexv2models_bot_version.bank_bot_version.bot_version
    InstanceArn = data.aws_connect_instance.exisitng.arn
  }
  template_body = jsonencode({
    AWSTemplateFormatVersion = "2010-09-09"
    Parameters = {
      BotId = {
        Type = "String"
      }
      BotVersion = {
        Type = "String"
      }
      InstanceArn = {
        Type = "String"
      }
    }
    Resources = {
      BankLexAlias = {
        Type = "AWS::Lex::BotAlias"
        Properties = {
          BotAliasName = "BankHelplineAlias"
          BotId        = { Ref = "BotId" }
          BotVersion   = { Ref = "BotVersion" }
          BotAliasLocaleSettings = [
            {
              LocaleId = "en_US"
              BotAliasLocaleSettings = {
                Enabled = true
              }
            }
          ]
        }
      }
      ConnectLexAssociation = {
        Type = "AWS::Connect::IntegrationAssociation"
        Properties = {
          InstanceId     = { Ref = "InstanceArn" }
          IntegrationArn = { "Fn::GetAtt" = ["BankLexAlias", "Arn"] }
          IntegrationType = "LEX_BOT"
        }
      }
    }
    Outputs = {
      LexBotAliasArn = {
        Value = { "Fn::GetAtt" = ["BankLexAlias", "Arn"] }
      }
      ConnectAssociationId = {
        Value = { Ref = "ConnectLexAssociation" }
      }
    }
  })
}