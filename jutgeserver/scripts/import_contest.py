#!/usr/bin/env python3
# import subprocess
import argparse
import json
import sys
import requests

auth_data = ('admin', 'jutgeitb2020')

parser = argparse.ArgumentParser()
parser.add_argument("-f", "--file", nargs="?", default="contest.yml")
#parser.add_argument("base_url")
args = parser.parse_args()

def print_json(content):
    print(json.dumps(content, indent=4, sort_keys=True, separators=(',', ': ')))

class JutgeAPI:
    def __init__(self, url_api, auth_data=None):
        self.url_api = url_api
        self.auth_data = auth_data

    def _request(self, request, url, data={}, files={}, message=None):
        print("Sending HTTP", request, message if message else url, "... ", end="")
        for k, v in files.items():
            files[k] = open(v, 'rb')

        if request == "GET":
            http_request = requests.get
        elif request == "POST":
            http_request = requests.post

        r = http_request(self.url_api + url, data=data, files=files, auth=self.auth_data)
        output = r.text

        if not r:
            print("ERROR")
            print(output, r)
            sys.exit(1)
        print("OK")
        return output

    def get(self, url, data={}, message=None):
        return self._request("GET", url, data=data, message=message)

    def post(self, url, data={}, files={}, message=None):
        return self._request("POST", url, data=data, files=files, message=message)

#jutge = JutgeAPI(args.base_url, auth_data)
jutge = JutgeAPI("http://zombies.itb.cat/api/", auth_data)
contest_id = jutge.post("contests", files={"yaml": args.file}, message="contest request")
problems = json.loads(jutge.get("contests/{}/problems".format(contest_id), message="contest problems request"))

for pr in problems:
    pr_name = pr["externalid"]
    pr_id = pr["id"]
    problem = jutge.post(
                  "contests/{}/problems".format(contest_id), 
                  files={"zip[]": "../problem_definition/{}.zip".format(pr_name)},
                  data={"problem": pr_id},
                  message="zip problem {} request".format(pr_name)
              )
