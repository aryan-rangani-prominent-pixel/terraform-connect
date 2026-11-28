import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def lambda_handler(event, context):
    parameters = event.get("Details", {}).get("Parameters", {})
    customer_id = str(parameters.get("customer_id", "")).strip()

    if customer_id == "12345":
        return {
            "verification_status": "VERIFIED",
            "customer_id": customer_id
        }

    return {
        "verification_status": "NOT_VERIFIED",
        "customer_id": customer_id
    }
