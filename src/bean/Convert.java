package bean;

public class Convert {
    public Convert() { }

    public String arr2Str(String[] s) {
        if (s == null) return "";
        StringBuilder ans = new StringBuilder();
        for (String t: s)
            ans.append("、").append(t);
        return ans.toString().substring(1);
    }
}
