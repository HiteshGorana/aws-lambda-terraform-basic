# -*- coding: utf-8 -*-
# @Date    : 06-10-2021
# @Author  : Hitesh Gorana
# @Link    : None
# @Version : 0.0
import json


def lambda_handler(event: dict, context):
    for k, v in event.items():
        print("Key", k, " ", "value", v)

    return {
        "statusCode": 200,
        "body": json.dumps("AWS Lambda deployed using terraform")
    }
