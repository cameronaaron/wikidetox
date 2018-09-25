# Wikipedia Live Viewing of Conversations

## Development

### Setup

This is a standard nodejs/yarn project. You need to have installed
`npm` and `node` (Recommended to install using [nvm](https://github.com/creationix/nvm), the node version manager).

Once you have `npm`, install `yarn` and `typescript` globally with:

```shell
npm install -g yarn typescript
```

Then, from this directory, you can setup the this node package with:

```shell
yarn install
```

### Build and test

```shell
yarn run test
yarn run build
```

## Notes
### Suppression/Deletion monitoring

 * [Revision Deletion](https://en.wikipedia.org/wiki/Wikipedia:Revision_deletion)

#### Creating the ts Schema for RecentChanges

The [Wikipedia EventStream
page](https://wikitech.wikimedia.org/wiki/EventStreams) describes the schema and
links to it. The `recentchanges_schema.ts` file was generated by using YAML to
JSON, and then JSON to JSON-Schema to TS, starting from [the Wikimedia github
event schema for
recentchange](https://github.com/wikimedia/mediawiki-event-schemas/tree/master/jsonschema/mediawiki/recentchange)

#### Streaming delete actions

```
ts-node src/print_recentchanges.ts > tmp/deletes.jsonl
```

#### Examining the delete actions for .log_action == "revision" deletes

```
cat tmp/deletes.jsonl | tail -n +4 | jq '. | select(.log_action == "revision")'
```

Note: `tail -n +4` is used to skip the first few printed lines.

Similarly, but to restrict to enflish wikipedia:

```
cat tmp/deletes.jsonl | tail -n +4 | jq '. | select(.wiki == "enwiki", .log_action == "revision")'
```

```
cat tmp/deletes.jsonl | tail -n +4 | jq '. | select(.wiki == "enwiki" and .log_action == "revision" and .log_params.nfield != 0)'
```

```
cat tmp/deletes.jsonl | tail -n +4 | jq '. | select(.log_type == "suppress")'
```
