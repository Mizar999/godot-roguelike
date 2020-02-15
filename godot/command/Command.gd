extends Reference
class_name Command

func execute(_game: Game) -> CommandResult:
	return success()

func success() -> CommandResult:
	return CommandResult.new(CommandResult.ResultType.Success)

func fail(reason: String = "") -> CommandResult:
	return CommandResult.new(CommandResult.ResultType.Failure, reason)

func wait(reason: String = "") -> CommandResult:
	return CommandResult.new(CommandResult.ResultType.Wait, reason)

func alternate(game: Game, command: Command) -> CommandResult:
	return command.execute(game)
