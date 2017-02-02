<?php
/**
 * Created by IntelliJ IDEA.
 * User: dbyers55
 * Date: 2/1/17
 * Time: 11:32 AM
 */

echo "hello world! <br>";

echo "a place for another breakpoint! <br>";

$x = 3;

echo sprintf("if you double %d you get: %d", $x, double_this($x));


function double_this($x) {
    return 2 * $x;
}