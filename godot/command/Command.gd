extends Reference
class_name Command

#warning-ignore:unused_signal
signal executed

#warning-ignore:unused_argument
func execute(game: Game):
	success()

func success():
	emit_signal(RL.SIGNAL_EXECUTED, CommandResult.new(CommandResult.ResultType.Success))

func fail(reason: String = ""):
	emit_signal(RL.SIGNAL_EXECUTED, CommandResult.new(CommandResult.ResultType.Failure, reason))

func wait(reason: String = ""):
	emit_signal(RL.SIGNAL_EXECUTED, CommandResult.new(CommandResult.ResultType.Wait, reason))

func alternate(game: Game, command: Command):
	command.execute(game)
