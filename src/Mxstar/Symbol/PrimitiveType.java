package Mxstar.Symbol;

import Mxstar.Config_Cons;

public class PrimitiveType extends VariableType {
    public String name;
    public PrimitiveSymbol symbol;

    public PrimitiveType() {
        name = null;
        symbol = null;
    }
    public PrimitiveType(String name, PrimitiveSymbol symbol) {
        this.name = name;
        this.symbol = symbol;
    }

    @Override
    public boolean match(VariableType other) {
        if(other instanceof ClassType && ((ClassType) other).name.equals("null")) {
            return false;
        } else  {
            return other instanceof PrimitiveType && ((PrimitiveType) other).name.equals(name);
        }
    }

    @Override
    public int getBytes() {
        return Config_Cons.REGISTER_WIDTH;
    }
}
