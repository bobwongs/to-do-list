echo "\$0: {$0}"

workdir=$(cd $(dirname $0); pwd)
echo "workdir: "$workdir

echo "dirname: "$(dirname $0)
script_directory_path=$(dirname $0)
echo $script_directory_path