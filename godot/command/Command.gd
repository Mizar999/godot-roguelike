extends Reference
class_name Command

signal executed

func execute(_game: Game):
	success()

func success():
	emit_signal("executed", CommandResult.new(CommandResult.ResultType.Success))

func fail(reason: String = ""):
	emit_signal("executed", CommandResult.new(CommandResult.ResultType.Failure, reason))

func wait(reason: String = ""):
	emit_signal("executed", CommandResult.new(CommandResult.ResultType.Wait, reason))

func alternate(game: Game, command: Command):
	command.execute(game)
