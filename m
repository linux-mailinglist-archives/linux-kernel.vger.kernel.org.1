Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213982C8EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbgK3UVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:21:14 -0500
Received: from mga04.intel.com ([192.55.52.120]:60096 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728839AbgK3UVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:21:13 -0500
IronPort-SDR: Egu0udIbr7gX3pmUOUEo71qDfhCT9jOHMa8y7DvQPseIyjJ1bmNF5XDU8YkuOLIPw5Vs3UdnD9
 DPX5oI/gtoNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="170140731"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="170140731"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 12:20:32 -0800
IronPort-SDR: UTPINNDHU/iis8XWgiK9+gTZezlDSSeJV+7JVfkSgRUsHT4HwVzo6wzyAfU/vFjyIjyR9wUr3+
 ao3eyRLnf3Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="480793759"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga004.jf.intel.com with ESMTP; 30 Nov 2020 12:20:31 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "David Binderman" <dcb314@hotmail.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 03/17] selftests/resctrl: Rename CQM test as CMT test
Date:   Mon, 30 Nov 2020 20:19:56 +0000
Message-Id: <20201130202010.178373-4-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130202010.178373-1-fenghua.yu@intel.com>
References: <20201130202010.178373-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CMT (Cache Monitoring Technology) [1] is a H/W feature that reports cache
occupancy of a process. resctrl selftest suite has a unit test to test CMT
for LLC but the test is named as CQM (Cache Quality Monitoring).
Furthermore, the unit test source file is named as cqm_test.c and several
functions, variables, comments, preprocessors and statements widely use
"cqm" as either suffix or prefix. This rampant misusage of CQM for CMT
might confuse someone who is newly looking at resctrl selftests because
this feature is named CMT in the Intel Software Developer's Manual.

Hence, rename all the occurrences (unit test source file name, functions,
variables, comments and preprocessors) of cqm with cmt.

[1] Please see Intel SDM, Volume 3, chapter 17 and section 18 for more
    information on CMT: https://software.intel.com/content/www/us/en/develop/articles/intel-sdm.html

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/README        |  4 +--
 tools/testing/selftests/resctrl/cache.c       |  4 +--
 .../resctrl/{cqm_test.c => cmt_test.c}        | 20 +++++++-------
 tools/testing/selftests/resctrl/resctrl.h     | 10 +++----
 .../testing/selftests/resctrl/resctrl_tests.c | 26 +++++++++----------
 tools/testing/selftests/resctrl/resctrl_val.c | 12 ++++-----
 tools/testing/selftests/resctrl/resctrlfs.c   | 10 +++----
 7 files changed, 43 insertions(+), 43 deletions(-)
 rename tools/testing/selftests/resctrl/{cqm_test.c => cmt_test.c} (89%)

diff --git a/tools/testing/selftests/resctrl/README b/tools/testing/selftests/resctrl/README
index 6e5a0ffa18e8..4b36b25b6ac0 100644
--- a/tools/testing/selftests/resctrl/README
+++ b/tools/testing/selftests/resctrl/README
@@ -46,8 +46,8 @@ ARGUMENTS
 Parameter '-h' shows usage information.
 
 usage: resctrl_tests [-h] [-b "benchmark_cmd [options]"] [-t test list] [-n no_of_bits]
-        -b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CQM default benchmark is builtin fill_buf
-        -t test list: run tests specified in the test list, e.g. -t mbm, mba, cqm, cat
+        -b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CMT default benchmark is builtin fill_buf
+        -t test list: run tests specified in the test list, e.g. -t mbm, mba, cmt, cat
         -n no_of_bits: run cache tests using specified no of bits in cache bit mask
         -p cpu_no: specify CPU number to run the test. 1 is default
         -h: help
diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 248bf000c978..4366a12ada11 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -111,7 +111,7 @@ static int get_llc_perf(unsigned long *llc_perf_miss)
 
 /*
  * Get LLC Occupancy as reported by RESCTRL FS
- * For CQM,
+ * For CMT,
  * 1. If con_mon grp and mon grp given, then read from mon grp in
  * con_mon grp
  * 2. If only con_mon grp given, then read from con_mon grp
@@ -192,7 +192,7 @@ int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
 	/*
 	 * Measure llc occupancy from resctrl.
 	 */
-	if (is_cqm(param->resctrl_val)) {
+	if (is_cmt(param->resctrl_val)) {
 		ret = get_llc_occu_resctrl(&llc_occu_resc);
 		if (ret < 0)
 			return ret;
diff --git a/tools/testing/selftests/resctrl/cqm_test.c b/tools/testing/selftests/resctrl/cmt_test.c
similarity index 89%
rename from tools/testing/selftests/resctrl/cqm_test.c
rename to tools/testing/selftests/resctrl/cmt_test.c
index 6635b24a74cc..05a180d85e93 100644
--- a/tools/testing/selftests/resctrl/cqm_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Cache Monitoring Technology (CQM) test
+ * Cache Monitoring Technology (CMT) test
  *
  * Copyright (C) 2018 Intel Corporation
  *
@@ -11,12 +11,12 @@
 #include "resctrl.h"
 #include <unistd.h>
 
-#define RESULT_FILE_NAME	"result_cqm"
+#define RESULT_FILE_NAME	"result_cmt"
 #define NUM_OF_RUNS		5
 #define MAX_DIFF		2000000
 #define MAX_DIFF_PERCENT	15
 
-static int cqm_setup(int num, ...)
+static int cmt_setup(int num, ...)
 {
 	struct resctrl_val_param *p;
 	va_list param;
@@ -53,7 +53,7 @@ static void show_cache_info(unsigned long sum_llc_occu_resc, int no_of_bits,
 	else
 		res = false;
 
-	printf("%sok CQM: diff within %d, %d\%%\n", res ? "" : "not",
+	printf("%sok CMT: diff within %d, %d\%%\n", res ? "" : "not",
 	       MAX_DIFF, (int)MAX_DIFF_PERCENT);
 
 	printf("# diff: %ld\n", avg_diff);
@@ -101,12 +101,12 @@ static int check_results(struct resctrl_val_param *param, int no_of_bits)
 	return 0;
 }
 
-void cqm_test_cleanup(void)
+void cmt_test_cleanup(void)
 {
 	remove(RESULT_FILE_NAME);
 }
 
-int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
+int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 {
 	int ret, mum_resctrlfs, count_of_bits;
 	unsigned long long_mask, cache_size;
@@ -119,7 +119,7 @@ int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 	if (ret)
 		return ret;
 
-	if (!validate_resctrl_feature_request("cqm"))
+	if (!validate_resctrl_feature_request("cmt"))
 		return -1;
 
 	ret = get_cbm_mask("L3", cbm_mask);
@@ -142,7 +142,7 @@ int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 	}
 
 	struct resctrl_val_param param = {
-		.resctrl_val	= CQM_STR,
+		.resctrl_val	= CMT_STR,
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.cpu_no		= cpu_no,
@@ -151,7 +151,7 @@ int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 		.mask		= ~(long_mask << n) & long_mask,
 		.span		= cache_size * n / count_of_bits,
 		.num_of_runs	= 0,
-		.setup		= cqm_setup,
+		.setup		= cmt_setup,
 	};
 
 	if (strcmp(benchmark_cmd[0], "fill_buf") == 0)
@@ -167,7 +167,7 @@ int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 	if (ret)
 		return ret;
 
-	cqm_test_cleanup();
+	cmt_test_cleanup();
 
 	return 0;
 }
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index bfbc16b39a9e..e99e62fddc61 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -64,7 +64,7 @@ struct resctrl_val_param {
 
 #define MBM_STR			"mbm"
 #define MBA_STR			"mba"
-#define CQM_STR			"cqm"
+#define CMT_STR			"cmt"
 #define CAT_STR			"cat"
 
 static inline bool is_mbm(const char *str)
@@ -77,9 +77,9 @@ static inline bool is_mba(const char *str)
 	return !strncmp(str, MBA_STR, 3);
 }
 
-static inline bool is_cqm(const char *str)
+static inline bool is_cmt(const char *str)
 {
-	return !strncmp(str, CQM_STR, 3);
+	return !strncmp(str, CMT_STR, 3);
 }
 
 static inline bool is_cat(const char *str)
@@ -123,9 +123,9 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int cat_val(struct resctrl_val_param *param);
 void cat_test_cleanup(void);
 int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type);
-int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd);
+int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd);
 unsigned int count_bits(unsigned long n);
-void cqm_test_cleanup(void);
+void cmt_test_cleanup(void);
 int get_core_sibling(int cpu_no);
 int measure_cache_vals(struct resctrl_val_param *param, int bm_pid);
 
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index f425eaf8c331..2dceff59e245 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -37,10 +37,10 @@ void detect_amd(void)
 static void cmd_help(void)
 {
 	printf("usage: resctrl_tests [-h] [-b \"benchmark_cmd [options]\"] [-t test list] [-n no_of_bits]\n");
-	printf("\t-b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CQM");
+	printf("\t-b benchmark_cmd [options]: run specified benchmark for MBM, MBA and CMT");
 	printf("\t default benchmark is builtin fill_buf\n");
 	printf("\t-t test list: run tests specified in the test list, ");
-	printf("e.g. -t mbm, mba, cqm, cat\n");
+	printf("e.g. -t mbm, mba, cmt, cat\n");
 	printf("\t-n no_of_bits: run cache tests using specified no of bits in cache bit mask\n");
 	printf("\t-p cpu_no: specify CPU number to run the test. 1 is default\n");
 	printf("\t-h: help\n");
@@ -50,13 +50,13 @@ void tests_cleanup(void)
 {
 	mbm_test_cleanup();
 	mba_test_cleanup();
-	cqm_test_cleanup();
+	cmt_test_cleanup();
 	cat_test_cleanup();
 }
 
 int main(int argc, char **argv)
 {
-	bool has_ben = false, mbm_test = true, mba_test = true, cqm_test = true;
+	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
 	int res, c, cpu_no = 1, span = 250, argc_new = argc, i, no_of_bits = 5;
 	char *benchmark_cmd[BENCHMARK_ARGS], bw_report[64], bm_type[64];
 	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
@@ -82,15 +82,15 @@ int main(int argc, char **argv)
 
 			mbm_test = false;
 			mba_test = false;
-			cqm_test = false;
+			cmt_test = false;
 			cat_test = false;
 			while (token) {
 				if (is_mbm(token)) {
 					mbm_test = true;
 				} else if (is_mba(token)) {
 					mba_test = true;
-				} else if (is_cqm(token)) {
-					cqm_test = true;
+				} else if (is_cmt(token)) {
+					cmt_test = true;
 				} else if (is_cat(token)) {
 					cat_test = true;
 				} else {
@@ -178,13 +178,13 @@ int main(int argc, char **argv)
 		tests_run++;
 	}
 
-	if (cqm_test) {
-		printf("# Starting CQM test ...\n");
+	if (cmt_test) {
+		printf("# Starting CMT test ...\n");
 		if (!has_ben)
-			sprintf(benchmark_cmd[5], "%s", CQM_STR);
-		res = cqm_resctrl_val(cpu_no, no_of_bits, benchmark_cmd);
-		printf("%sok CQM: test\n", res ? "not " : "");
-		cqm_test_cleanup();
+			sprintf(benchmark_cmd[5], "%s", "cmt");
+		res = cmt_resctrl_val(cpu_no, no_of_bits, benchmark_cmd);
+		printf("%sok CMT: test\n", res ? "not " : "");
+		cmt_test_cleanup();
 		tests_run++;
 	}
 
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index f55e04a30a77..5ff336f62f8f 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -492,7 +492,7 @@ static int print_results_bw(char *filename,  int bm_pid, float bw_imc,
 	return 0;
 }
 
-static void set_cqm_path(const char *ctrlgrp, const char *mongrp, char sock_num)
+static void set_cmt_path(const char *ctrlgrp, const char *mongrp, char sock_num)
 {
 	if (strlen(ctrlgrp) && strlen(mongrp))
 		sprintf(llc_occup_path,	CON_MON_LCC_OCCUP_PATH,	RESCTRL_PATH,
@@ -512,7 +512,7 @@ static void set_cqm_path(const char *ctrlgrp, const char *mongrp, char sock_num)
  * @ctrlgrp:			Name of the control monitor group (con_mon grp)
  * @mongrp:			Name of the monitor group (mon grp)
  * @cpu_no:			CPU number that the benchmark PID is binded to
- * @resctrl_val:		Resctrl feature (Eg: cat, cqm.. etc)
+ * @resctrl_val:		Resctrl feature (Eg: cat, cmt.. etc)
  */
 static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
 					int cpu_no, char *resctrl_val)
@@ -524,8 +524,8 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
 		return;
 	}
 
-	if (is_cqm(resctrl_val))
-		set_cqm_path(ctrlgrp, mongrp, resource_id);
+	if (is_cmt(resctrl_val))
+		set_cmt_path(ctrlgrp, mongrp, resource_id);
 }
 
 static int
@@ -680,7 +680,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 
 		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
 					  param->cpu_no, resctrl_val);
-	} else if (is_cqm(resctrl_val))
+	} else if (is_cmt(resctrl_val))
 		initialize_llc_occu_resctrl(param->ctrlgrp, param->mongrp,
 					    param->cpu_no, resctrl_val);
 
@@ -718,7 +718,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 			ret = measure_vals(param, &bw_resc_start);
 			if (ret)
 				break;
-		} else if (is_cqm(resctrl_val)) {
+		} else if (is_cmt(resctrl_val)) {
 			ret = param->setup(1, param);
 			if (ret) {
 				ret = 0;
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index dc4f1286aefa..2c574d143ff0 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -334,7 +334,7 @@ void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 		operation = atoi(benchmark_cmd[4]);
 		sprintf(resctrl_val, "%s", benchmark_cmd[5]);
 
-		if (!is_cqm(resctrl_val))
+		if (!is_cmt(resctrl_val))
 			buffer_span = span * MB;
 		else
 			buffer_span = span;
@@ -458,8 +458,8 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
 	if (ret)
 		goto out;
 
-	/* Create mon grp and write pid into it for "mbm" and "cqm" test */
-	if (is_cqm(resctrl_val) || is_mbm(resctrl_val)) {
+	/* Create mon grp and write pid into it for "mbm" and "cmt" test */
+	if (is_cmt(resctrl_val) || is_mbm(resctrl_val)) {
 		if (strlen(mongrp)) {
 			sprintf(monitorgroup_p, "%s/mon_groups", controlgroup);
 			sprintf(monitorgroup, "%s/%s", monitorgroup_p, mongrp);
@@ -505,7 +505,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 	FILE *fp;
 
 	if (!is_mba(resctrl_val) && !is_cat(resctrl_val) &&
-	    !is_cqm(resctrl_val))
+	    !is_cmt(resctrl_val))
 		return -ENOENT;
 
 	if (!schemata) {
@@ -526,7 +526,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 	else
 		sprintf(controlgroup, "%s/schemata", RESCTRL_PATH);
 
-	if (is_cat(resctrl_val) || is_cqm(resctrl_val))
+	if (is_cat(resctrl_val) || is_cmt(resctrl_val))
 		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=', schemata);
 	if (is_mba(resctrl_val))
 		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
-- 
2.29.2

