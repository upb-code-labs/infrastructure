import sys
import os
import re

services_paths = {
    "gateway": os.path.join(os.getcwd(), "k8s", "gateway"),
    "static_files_microservice": os.path.join(
        os.getcwd(), "k8s", "static-files-microservice"
    ),
    "submissions_status_updater_microservice": os.path.join(
        os.getcwd(), "k8s", "submissions-status-updater-microservice"
    ),
    "tests_microservice": os.path.join(os.getcwd(), "k8s", "tests-microservice"),
    "web": os.path.join(os.getcwd(), "k8s", "web"),
}


def check_service(service):
    # Check the service exists
    if service not in services_paths:
        print(f"Service {service} not found")
        sys.exit(1)


def check_version(version):
    # Check the version is a valid semver
    semver_regex = r"^\d+\.\d+\.\d+$"
    if not re.match(semver_regex, version):
        print(f"Version {version} is not a valid semver")
        sys.exit(1)


def update_version_in_file(file_path, version):
    # By default all services are defined in the spec.yaml file
    file_name = "spec.yaml"
    file_path = os.path.join(file_path, file_name)

    # Read the content of the file
    with open(file_path, "r") as file:
        file_data = file.read()

        # Match the image version
        image_field_regex = re.compile(r"image: (\S+/\S+:\S+)")
        image_field_match = image_field_regex.search(file_data)

        if not image_field_match:
            print(f"Image version not found in {file_path}")
            sys.exit(1)

        # Replace the image version
        current_image_field = image_field_match.group(1)
        current_image_version = current_image_field.split(":")[-1]
        new_file_data = file_data.replace(current_image_version, version)

        # Write the new content to the file
        with open(file_path, "w") as file:
            file.write(new_file_data)


if __name__ == "__main__":
    # Get the service and the image version from the command line
    args = sys.argv[1:]
    service, image_version = args

    # Check the service exists
    check_service(service)

    # Check the version is a valid semver
    check_version(image_version)

    # Update the image version in the k8s files
    update_version_in_file(services_paths[service], image_version)
