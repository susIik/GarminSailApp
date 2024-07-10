import subprocess
import configparser


def Build():
    data = ReadCfg()

    for device in data["devices"]:
        out_path = f"./build/{device}/{data['name']}-{device}.prg"
        subprocess.run(["monkeyc", "-o", out_path, "-d", device, "-f", data["jungle"], "-y", data["key"]], shell=True)


def ReadCfg():
    conf = configparser.ConfigParser()
    conf.read("build.cfg")

    return {"name": conf.get("DEFAULT", "app_name"),
            "devices": conf.get("DEFAULT", "devices").strip().split(", "),
            "key": conf.get("DEFAULT", "key"),
            "jungle": conf.get("DEFAULT", "jungle"),}


if __name__ == "__main__":
    Build()
