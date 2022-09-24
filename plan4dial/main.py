import json
import os
import subprocess
# import spacy
from pathlib import Path
from generate_files.parsers.json_config_parser import _convert_yaml
from generate_files.parsers.pddl_parser import _parse_to_pddl
from generate_files.parsers.parse_for_rasa import _make_nlu_file
from generate_files.parsers.pddl_for_rollout import rollout_config
# from rasa.model_training import train_nlu


def generate_files(
    yaml_filename: str, output_folder: str, rbp_path: str, train: bool = False
):
    # print("here")
    # # make a new directory for this domain if it doesn't exist
    # if not os.path.exists(output_folder):
    #     os.makedirs(output_folder)
    # # convert to hovor json config
    # writer = open(f"{output_folder}/data.json", "w")
    converted_json = _convert_yaml(yaml_filename)
    # writer.write(json.dumps(converted_json, indent=4))
    # # convert to PDDL
    # domain, problem = _parse_to_pddl(converted_json)
    # domain_str, problem_str = (
    #     f"{output_folder}/domain.pddl",
    #     f"{output_folder}/problem.pddl",
    # )
    # writer = open(domain_str, "w")
    # writer.write(domain)
    # writer = open(problem_str, "w")
    # writer.write(problem)

    # # train rasa NLU model
    # if train:
    #     writer = open(f"{output_folder}/nlu.yml", "w")
    #     # parse for rasa
    #     yaml.dump(_make_nlu_file(converted_json), writer)
    #     # download the spacy model if needed; wait until complete
    #     try:
    #         spacy.load("en_core_web_md")
    #     except OSError:
    #         subprocess.run(["python -m spacy download en_core_web_md"])
    #     train_nlu(
    #         config=f"nlu_config.yml",
    #         nlu_data=f"{output_folder}/nlu.yml",
    #         output=f"{output_folder}",
    #         fixed_model_name=f"nlu_model",
    #     )
    # generate PDDL files; convert policy.out to a prp.json file; wait until complete
    # subprocess.run([f"{rbp_path}/prp", domain_str, problem_str, "--output-format", "3"])
    # try:
    #     with open(f"policy.out") as f:
    #         plan_data = {f"plan": json.load(f)}
    # except FileNotFoundError:
    #     raise Exception("PDDL is invalid.")
    # with open(f"{output_folder}/data.prp.json", "w") as f:
    #     json.dump(plan_data, f, indent=4)
    # # delete extra output files
    # os.remove("./policy.out")
    # os.remove("./output.sas")
    # for rollout
    rollout_data = rollout_config(converted_json)
    with open(f"{output_folder}/rollout_config.json", "w") as f:
        json.dump(rollout_data, f, indent=4)


if __name__ == "__main__":
    #dirname = "./plan4dial/local_data/gold_standard_bot"
    dirname = "./old_local_data/end_message_v2"
    generate_files(
        f"{dirname}/end_message_v2.yml",
        f"{dirname}/output_files",
        str((Path(__file__).parent.parent / "rbp").resolve()),
        True,
    )
