import utils;
from slaves import Slave;
from submitter import Submitter;

utils.InitConfig("awfy.config");

slave = Slave("main");
submitter = Submitter(slave);

submitter.Start();

product = "mysql";
product_revision = "1234";
suite = "suite1";
test = "test1";
test_duration = 100;

submitter.AddEngine(product, product_revision);
submitter.SubmitTest(test_name, suite_name, "1.0", product_name, test_duration);
submitter.SubmitTest("__total__", suite_name, "1.0", product_name, test_duration);
submitter.Finish(1);

