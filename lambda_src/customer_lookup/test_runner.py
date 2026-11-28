import json
from lambda_function import lambda_handler

with open("test_event.json") as f:
    event = json.load(f)

result = lambda_handler(event, None)

print("Lambda test result:")
print(json.dumps(result, indent=2))
