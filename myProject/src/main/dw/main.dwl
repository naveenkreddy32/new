%dw 2.0
var req = {
  "fname": "Naveen K Reddy",
  "lname2": "Nagireddy",
  "fromAmt": 100.12,
  "department": {
    "id": 123,
    "name": "tech",
    "ph": "12355 666 88"
  }
}
var ast = {
  "fname": "first_name = :fname",
  "lname": "last_name = :lname",
  "fromAmt": "amount >= :fromAmt",
  "department": {
    "id": "department_id = :did",
    "name": "department_name = :dtech",
    "ph": "department_ph = :dph",
    "addr": {
      "line2": "dept_addr_line2 = :line2"
    }
  }
}

fun whereClause(request: Object, astree: Object, accltr: String = ""): String =
  (namesOf(request) reduce ((e, acc = accltr) ->  (e match {
      case e if (request[e] is Object) -> whereClause(request[e], astree[e] default {}, acc)
      case e if (e is String and astree[e] != null) -> acc ++ (astree[e] as String) ++ " and "
      else -> acc
  })
))

output application/java  
---
whereClause(req, ast)[0 to -5]