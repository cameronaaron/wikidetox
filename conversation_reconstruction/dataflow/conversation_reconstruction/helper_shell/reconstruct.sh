cd ..
for i in $(seq 1 52)
do
    gsutil -m mv -p gs://wikidetox-viz-dataflow/process_tmp/current/* gs://wikidetox-viz-dataflow/process_tmp/bakup/
    gsutil -m mv -p gs://wikidetox-viz-dataflow/process_tmp/next_stage/* gs://wikidetox-viz-dataflow/process_tmp/current/
    echo "start job on week $i"
    python dataflow_main.py --input gs://wikidetox-viz-dataflow/ingested/en-20180501/20180501-en/date-{week}at{year}/revisions*.json --week $i --year 2005 --setup_file ./setup.py || exit
done
