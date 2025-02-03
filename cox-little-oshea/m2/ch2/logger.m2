LogLevel = new Type of List;
LogLevelInfo = new LogLevel from {"Info"};
LogLevelDebug = new LogLevel from {"Debug"};
LogLevelNoLog = new LogLevel from {"NoLog"};

logInfo = method(TypicalValue=>Boolean);
logInfo(LogLevel) := l -> l != LogLevelNoLog;

logDebug = method(TypicalValue=>Boolean);
logDebug(LogLevel) := l -> (l === LogLevelDebug);

Logger = new Type of MutableHashTable;

newLogger = logLevel -> (
	if not (instance(logLevel, LogLevel)) then (
		error ("Expected argument 'logLevel' to have type LogLevel, whilst it has type: " | 
			toString(class logLevel))
	);
	new Logger from {
		level=>logLevel,
		prefixes=>{},
		counts=>new MutableHashTable
	}
);

setLogLevel = method();
setLogLevel(Logger, LogLevel) := (logger, logLevel) -> (
	logger#level = logLevel
);

appendPrefix = method();
appendPrefix(Logger, String) := (logger, prefix) -> (
	logger#prefixes = logger#prefixes | {prefix};
);

popPrefix = method();
popPrefix(Logger) := logger -> (
	logger#prefixes = drop(logger#prefixes, -1);		
);

weakEq = (s1, s2) -> (
	for i in (0..<(min(#s1, #s2))) do
		if s1_i =!= s2_i then return false;
	return true;
);

popPrefixAssert = method();
popPrefixAssert(Logger, String) := (logger, expected) -> (
	assert(weakEq(logger#prefixes#-1, expected));
	logger#prefixes = drop(logger#prefixes, -1);		
);

constructPrefix = method();
constructPrefix(Logger) := logger -> (
	fold((s1, s2) -> (s1 | s2), "", logger#prefixes)
);

incrementCount = method();
incrementCount(Logger, Thing) := (logger, key) -> (
	count := if logger#counts#?key then logger#counts#key else 0;
	logger#counts#key = count + 1;
	logger#counts#key
);

decrementCount = method();
decrementCount(Logger, Thing) := (logger, key) -> (
	if not logger#counts#?key then 
		error "Decrementing count for non-existing key: " | (toString key);
	logger#counts#key = logger#counts#key - 1;
	logger#counts#key
);

logPrint = method()
logPrint(Logger, String) := (logger, msg) -> (
	<< (constructPrefix logger) << msg << endl;
);

logInfo(Logger, String) := (logger, msg) -> (
	if logInfo(logger#level) then logPrint(logger, msg)
);

logDebug(Logger, String) := (logger, msg) -> (
	if logInfo(logger#level) then logPrint(logger, msg)
);

enterFunction = method();
enterFunction(Logger, String, Sequence) := (logger, functionName, args) -> (
	appendPrefix(logger, functionName | ": ");
	logInfo(logger, "called " | functionName | (toString args));
);

enterFunction(Logger, String) := (logger, functionName) -> (
	appendPrefix(logger, functionName | ": ");
	logInfo(logger, "called " | functionName);
);

enterCountedFunction = method();
enterCountedFunction(Logger, String, Sequence) := (logger, functionName, args) -> (
	count := incrementCount(logger, functionName);
	appendPrefix(logger, functionName | " [" | count | "]: ");
	logInfo(logger, "called " | functionName | (toString args));
);

enterCountedFunction(Logger, String) := (logger, functionName) -> (
	count := incrementCount(logger, functionName);
	appendPrefix(logger, functionName | " [" | count | "]: ");
	logInfo(logger, "called " | functionName);
);

exitFunction = method();
exitFunction(Logger, String) := (logger, functionName) -> (
	popPrefixAssert(logger, functionName);
	logInfo(logger, "exiting function " | functionName);
);

exitFunctionRet = method();
exitFunctionRet(Logger, String, String) := (logger, functionName, retVal) -> (
	popPrefixAssert(logger, functionName);
	logInfo(logger, "exiting function " | functionName | ", returning " | retVal);
);
