exports.handler = async function(event, context) {
    console.log("EVENT: \n" + JSON.stringify(event, null, 2))
    console.log("DYNAMO: \n" + process.env.DYNAMO_DB)
    return context.logStreamName;
}
