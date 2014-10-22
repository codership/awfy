import utils;
from slaves import Slave;
from submitter import Submitter;

utils.InitConfig("awfy.config");

slave = Slave("main");
submitter = Submitter(slave);

submitter.Start();

mode_name = "mysql_single";
mode_revision = "1234";
suite_name = "suite1";
test_name = "test1";
test_duration = 100;

submitter.AddMode(mode_name, mode_revision);
submitter.SubmitTest(test_name, suite_name, "1.0", mode_name, test_duration);
submitter.SubmitTest("__total__", suite_name, "1.0", mode_name, test_duration);
submitter.Finish(1);

