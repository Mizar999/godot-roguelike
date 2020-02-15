extends Reference
class_name CommandResult

enum ResultType {
	Success,
	Failure,
	Wait
}

var result_type
var message: String

func _init(result_type_p, message_p: String = ""):
	result_type = result_type_p
	message = message_p
