package r;

import java.util.HashMap;
import java.util.Map;

public class EvalVisitor extends r.RBaseVisitor<Value> {
    public static final double SMALL_VALUE = 0.000000001;

    // store variables (global scope)
    private Map<String, Value> memory = new HashMap<String, Value>();

    @Override
    public Value visitAssignstmt(r.RParser.AssignstmtContext ctx) {
        System.out.println("visit assignment");
        String id = ctx.ID().getText();
        Value value = this.visit(ctx.expression());
        return memory.put(id, value);
//        return new Value(new Object());
    }

    @Override
    public Value visitPrintstmt(r.RParser.PrintstmtContext ctx) {
        System.out.println(this.visit(ctx.expression()));
        return new Value(new Object());
    }

    @Override
    public Value visitAddSubExpr(r.RParser.AddSubExprContext ctx) {
        Value left = this.visit(ctx.expression(0));
        Value right = this.visit(ctx.expression(1));

        switch (ctx.op.getType()) {
            case r.RParser.ADD:
                return left.isDouble() && right.isDouble() ?
                        new Value(left.asDouble() + right.asDouble()) :
                        new Value(left.asString() + right.asString());
            case r.RParser.SUB:
                return new Value(left.asDouble() - right.asDouble());
            default:
                throw new RuntimeException("unknown operator: " + r.RParser.tokenNames[ctx.op.getType()]);
        }
    }

    @Override
    public Value visitIdExpr(r.RParser.IdExprContext ctx) {
        String id = ctx.getText();
        Value value = memory.get(id);
        if(value == null) {
            throw new RuntimeException("no such variable: " + id);
        }
        return value;
    }

    @Override
    public Value visitNumber(r.RParser.NumberContext ctx) {
        return new Value(Double.valueOf(ctx.getText()));
    }
}

class Value {
    public static Value VOID = new Value(new Object());

    final Object value;

    public Value(Object value) {
        this.value = value;
    }

    public Boolean asBoolean() {
        return (Boolean)value;
    }

    public Double asDouble() {
        return (Double)value;
    }

    public String asString() {
        return String.valueOf(value);
    }

    public boolean isDouble() {
        return value instanceof Double;
    }

    @Override
    public int hashCode() {

        if(value == null) {
            return 0;
        }

        return this.value.hashCode();
    }

    @Override
    public boolean equals(Object o) {

        if(value == o) {
            return true;
        }

        if(value == null || o == null || o.getClass() != value.getClass()) {
            return false;
        }

        Value that = (Value)o;

        return this.value.equals(that.value);
    }

    @Override
    public String toString() {
        return String.valueOf(value);
    }
}