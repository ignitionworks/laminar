/*
 * This Java source file was generated by the Gradle 'init' task.
 */
package laminar;

import org.sat4j.core.VecInt;
import org.sat4j.pb.SolverFactory;
import org.sat4j.pb.tools.DependencyHelper;
import org.sat4j.reader.InstanceReader;
import org.sat4j.reader.Reader;
import org.sat4j.specs.ContradictionException;
import org.sat4j.specs.ISolver;
import org.sat4j.specs.IVec;
import org.sat4j.specs.TimeoutException;
import org.sat4j.tools.ModelIterator;

import java.util.Arrays;
import java.util.Iterator;
import java.util.Set;

public class App {

    public static void main(String[] args) throws ContradictionException, TimeoutException {
        ISolver solver = SolverFactory.newDefault();

//        gNo impact on customer ⊕ gPotential impact is limited ⊕ gPotential impact is significant = 1
        solver.addClause(new VecInt(new int[]{-1, -2}));
        solver.addClause(new VecInt(new int[]{-1, -3}));
        solver.addClause(new VecInt(new int[]{1, 2, 3}));
        solver.addClause(new VecInt(new int[]{-2, -3}));

//        tCopy changes = ¬tNo copy changes
//        solver.addClause(new VecInt(new int[]{-4, -5}));
//        solver.addClause(new VecInt(new int[]{4, 5}));

        solver.addClause(new VecInt(new int[]{-4, -5}));

//        tDatabase migration = ¬tNo database migration
//        solver.addClause(new VecInt(new int[]{-6, -7}));
//        solver.addClause(new VecInt(new int[]{6, 7}));

        solver.addClause(new VecInt(new int[]{-6, -7}));

//        tNo copy changes & tNo database migration = gNo impact on customer
//        solver.addClause(new VecInt(new int[]{1, -5}));
        solver.addClause(new VecInt(new int[]{1, -7}));
        solver.addClause(new VecInt(new int[]{1, -5, -7}));

//        solver.addClause(new VecInt(new int[]{1, 4}));
//        solver.addClause(new VecInt(new int[]{1, 6}));
//        solver.addClause(new VecInt(new int[]{1, 4, 6}));

//        tDatabase migration -> gPotential impact is significant = 1
//        solver.addClause(new VecInt(new int[]{3, -6}));

//        tDatabase migration = gPotential impact is significant
//        solver.addClause(new VecInt(new int[]{-6, 3}));
//        solver.addClause(new VecInt(new int[]{6, -3}));

//        tDatabase migration -> gPotential impact is significant = 1
//        solver.addClause(new VecInt(new int[]{-6, 3}));

//        tCopy changes & tNo database migration -> gPotential impact is limited
//        solver.addClause(new VecInt(new int[]{2, -4}));
//        solver.addClause(new VecInt(new int[]{2, -7}));

        solver.addClause(new VecInt(new int[]{2}));
//        solver.addClause(new VecInt(new int[]{7}));


        ModelIterator mi = new ModelIterator(solver);
        boolean unsat = true;
        while (mi.isSatisfiable()) {
            unsat = false;
            int[] model = mi.model();
            System.out.println(String.format("Solution: %s", Arrays.toString(model)));
        }
        if (unsat) {
            System.out.println("No solutions");
        }

//        DependencyHelper<String, String> helper = new DependencyHelper<>(
//                SolverFactory.newEclipseP2());
//
//        helper.implication("A").implies("B").and("C").and("D").named("I1");
//        helper.implication("C").implies("C1", "C2", "C3").named("C versions");
//        helper.atMost(1, "C1", "C2", "C3").named("Singleton on C");
//        helper.setFalse("A", "User selection A");
//        helper.setTrue("C2", "User selection C");
//
//        System.out.println(String.format("Has a solution: %b", helper.hasASolution()));
//
//        IVec<String> solution = helper.getSolution();
//        System.out.println(solution.toString());
//
//        System.out.println(String.format("Solution contains A: %b", solution.contains("A")));
//        System.out.println(String.format("Solution contains B: %b", solution.contains("B")));
//        System.out.println(String.format("Solution contains C: %b", solution.contains("C")));
//        System.out.println(String.format("Solution contains D: %b", solution.contains("D")));
//        System.out.println(String.format("Solution contains C: %b", solution.contains("C")));
//        System.out.println(String.format("Solution contains C1: %b", solution.contains("C1")));
//        System.out.println(String.format("Solution contains C2: %b", solution.contains("C2")));
//        System.out.println(String.format("Solution contains C3: %b", solution.contains("C3")));
//        System.out.println(String.format("Solution D: %b", solution.get(solution.indexOf("D"))));
//        System.out.println(String.format("Solution C: %b", solution.get(solution.indexOf("C"))));
//
//        Set<String> causeD = helper.why("D");
//        System.out.println(String.format("D causes: %d", causeD.size()));
//
//        Iterator<String> itD = causeD.iterator();
//        System.out.println(String.format("D causes 1: %s", itD.next()));
//        System.out.println(String.format("D causes 2: %s", itD.next()));
//
//        Set<String> causeC = helper.why("C");
//        System.out.println(String.format("C causes: %d", causeC.size()));
//
//        Iterator<String> itC = causeC.iterator();
//        System.out.println(String.format("C causes 1: %s", itC.next()));
//        System.out.println(String.format("C causes 2: %s", itC.next()));
    }
}