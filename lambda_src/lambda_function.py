import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def lambda_handler(event, context):
    logger.info("Amazon Connect invoked the Terraform-managed Lambda.")

    return {
        "status": "success",
        "message": "Lambda invoked successfully"
    }
