Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B055A2C8EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbgK3UV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:21:29 -0500
Received: from mga04.intel.com ([192.55.52.120]:60096 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730117AbgK3UV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:21:28 -0500
IronPort-SDR: akDwRQFRixtoXV0EKZ5A5Z7HpTpQDRR6Z9bb5ER2goZkCeoDv4wjqYdy4xyWt5CxTSTEi/rem9
 XknnyP9i0JPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="170140727"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="170140727"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 12:20:31 -0800
IronPort-SDR: XnZF63SxPo964g5MdcwEfHQzIsbIjxLi1Rfqy3HTNVazVK+HQsPnA4SCW1uSS05uyz6KOiyHiC
 uB/WEAUsRg8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="480793752"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga004.jf.intel.com with ESMTP; 30 Nov 2020 12:20:30 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "David Binderman" <dcb314@hotmail.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 02/17] selftests/resctrl: Clean up resctrl features check
Date:   Mon, 30 Nov 2020 20:19:55 +0000
Message-Id: <20201130202010.178373-3-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130202010.178373-1-fenghua.yu@intel.com>
References: <20201130202010.178373-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking resctrl features call strcmp() to compare feature strings
(e.g. "mba", "cat" etc). The checkings are error prone and don't have
good coding style. Define the constant strings in macros and call
strncmp() to solve the potential issues.

Suggested-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/cache.c       |  8 +++---
 tools/testing/selftests/resctrl/cat_test.c    |  2 +-
 tools/testing/selftests/resctrl/cqm_test.c    |  2 +-
 tools/testing/selftests/resctrl/fill_buf.c    |  4 +--
 tools/testing/selftests/resctrl/mba_test.c    |  2 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  2 +-
 tools/testing/selftests/resctrl/resctrl.h     | 25 +++++++++++++++++++
 .../testing/selftests/resctrl/resctrl_tests.c | 12 ++++-----
 tools/testing/selftests/resctrl/resctrl_val.c | 19 ++++++--------
 tools/testing/selftests/resctrl/resctrlfs.c   | 14 +++++------
 10 files changed, 55 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 38dbf4962e33..248bf000c978 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -182,7 +182,7 @@ int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
 	/*
 	 * Measure cache miss from perf.
 	 */
-	if (!strcmp(param->resctrl_val, "cat")) {
+	if (is_cat(param->resctrl_val)) {
 		ret = get_llc_perf(&llc_perf_miss);
 		if (ret < 0)
 			return ret;
@@ -192,7 +192,7 @@ int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
 	/*
 	 * Measure llc occupancy from resctrl.
 	 */
-	if (!strcmp(param->resctrl_val, "cqm")) {
+	if (is_cqm(param->resctrl_val)) {
 		ret = get_llc_occu_resctrl(&llc_occu_resc);
 		if (ret < 0)
 			return ret;
@@ -234,7 +234,7 @@ int cat_val(struct resctrl_val_param *param)
 	if (ret)
 		return ret;
 
-	if ((strcmp(resctrl_val, "cat") == 0)) {
+	if (is_cat(resctrl_val)) {
 		ret = initialize_llc_perf();
 		if (ret)
 			return ret;
@@ -242,7 +242,7 @@ int cat_val(struct resctrl_val_param *param)
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
-		if (strcmp(resctrl_val, "cat") == 0) {
+		if (is_cat(resctrl_val)) {
 			ret = param->setup(1, param);
 			if (ret) {
 				ret = 0;
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 7f723bd8f328..6d9a41f3939a 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -160,7 +160,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		return -1;
 
 	struct resctrl_val_param param = {
-		.resctrl_val	= "cat",
+		.resctrl_val	= CAT_STR,
 		.cpu_no		= cpu_no,
 		.mum_resctrlfs	= 0,
 		.setup		= cat_setup,
diff --git a/tools/testing/selftests/resctrl/cqm_test.c b/tools/testing/selftests/resctrl/cqm_test.c
index b6af940ccfc2..6635b24a74cc 100644
--- a/tools/testing/selftests/resctrl/cqm_test.c
+++ b/tools/testing/selftests/resctrl/cqm_test.c
@@ -142,7 +142,7 @@ int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 	}
 
 	struct resctrl_val_param param = {
-		.resctrl_val	= "cqm",
+		.resctrl_val	= CQM_STR,
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.cpu_no		= cpu_no,
diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 79c611c99a3d..bece8bb4b575 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -115,7 +115,7 @@ static int fill_cache_read(unsigned char *start_ptr, unsigned char *end_ptr,
 
 	while (1) {
 		ret = fill_one_span_read(start_ptr, end_ptr);
-		if (!strcmp(resctrl_val, "cat"))
+		if (is_cat(resctrl_val))
 			break;
 	}
 
@@ -134,7 +134,7 @@ static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
 {
 	while (1) {
 		fill_one_span_write(start_ptr, end_ptr);
-		if (!strcmp(resctrl_val, "cat"))
+		if (is_cat(resctrl_val))
 			break;
 	}
 
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 7bf8eaa6204b..6449fbd96096 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -141,7 +141,7 @@ void mba_test_cleanup(void)
 int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd)
 {
 	struct resctrl_val_param param = {
-		.resctrl_val	= "mba",
+		.resctrl_val	= MBA_STR,
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.cpu_no		= cpu_no,
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 4700f7453f81..ec6cfe01c9c2 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -114,7 +114,7 @@ void mbm_test_cleanup(void)
 int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd)
 {
 	struct resctrl_val_param param = {
-		.resctrl_val	= "mbm",
+		.resctrl_val	= MBM_STR,
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.span		= span,
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 12b77182cb44..bfbc16b39a9e 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -62,6 +62,31 @@ struct resctrl_val_param {
 	int		(*setup)(int num, ...);
 };
 
+#define MBM_STR			"mbm"
+#define MBA_STR			"mba"
+#define CQM_STR			"cqm"
+#define CAT_STR			"cat"
+
+static inline bool is_mbm(const char *str)
+{
+	return !strncmp(str, MBM_STR, 3);
+}
+
+static inline bool is_mba(const char *str)
+{
+	return !strncmp(str, MBA_STR, 3);
+}
+
+static inline bool is_cqm(const char *str)
+{
+	return !strncmp(str, CQM_STR, 3);
+}
+
+static inline bool is_cat(const char *str)
+{
+	return !strncmp(str, CAT_STR, 3);
+}
+
 extern pid_t bm_pid, ppid;
 extern int tests_run;
 
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 425cc85ac883..f425eaf8c331 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -85,13 +85,13 @@ int main(int argc, char **argv)
 			cqm_test = false;
 			cat_test = false;
 			while (token) {
-				if (!strcmp(token, "mbm")) {
+				if (is_mbm(token)) {
 					mbm_test = true;
-				} else if (!strcmp(token, "mba")) {
+				} else if (is_mba(token)) {
 					mba_test = true;
-				} else if (!strcmp(token, "cqm")) {
+				} else if (is_cqm(token)) {
 					cqm_test = true;
-				} else if (!strcmp(token, "cat")) {
+				} else if (is_cat(token)) {
 					cat_test = true;
 				} else {
 					printf("invalid argument\n");
@@ -161,7 +161,7 @@ int main(int argc, char **argv)
 	if (!is_amd && mbm_test) {
 		printf("# Starting MBM BW change ...\n");
 		if (!has_ben)
-			sprintf(benchmark_cmd[5], "%s", "mba");
+			sprintf(benchmark_cmd[5], "%s", MBA_STR);
 		res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
 		printf("%sok MBM: bw change\n", res ? "not " : "");
 		mbm_test_cleanup();
@@ -181,7 +181,7 @@ int main(int argc, char **argv)
 	if (cqm_test) {
 		printf("# Starting CQM test ...\n");
 		if (!has_ben)
-			sprintf(benchmark_cmd[5], "%s", "cqm");
+			sprintf(benchmark_cmd[5], "%s", CQM_STR);
 		res = cqm_resctrl_val(cpu_no, no_of_bits, benchmark_cmd);
 		printf("%sok CQM: test\n", res ? "not " : "");
 		cqm_test_cleanup();
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 520fea3606d1..f55e04a30a77 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -397,10 +397,10 @@ static void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mongrp,
 		return;
 	}
 
-	if (strcmp(resctrl_val, "mbm") == 0)
+	if (is_mbm(resctrl_val))
 		set_mbm_path(ctrlgrp, mongrp, resource_id);
 
-	if ((strcmp(resctrl_val, "mba") == 0)) {
+	if (is_mba(resctrl_val)) {
 		if (ctrlgrp)
 			sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH,
 				RESCTRL_PATH, ctrlgrp, resource_id);
@@ -524,7 +524,7 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
 		return;
 	}
 
-	if (strcmp(resctrl_val, "cqm") == 0)
+	if (is_cqm(resctrl_val))
 		set_cqm_path(ctrlgrp, mongrp, resource_id);
 }
 
@@ -579,8 +579,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 	if (strcmp(param->filename, "") == 0)
 		sprintf(param->filename, "stdio");
 
-	if ((strcmp(resctrl_val, "mba")) == 0 ||
-	    (strcmp(resctrl_val, "mbm")) == 0) {
+	if (is_mba(resctrl_val) || is_mbm(resctrl_val)) {
 		ret = validate_bw_report_request(param->bw_report);
 		if (ret)
 			return ret;
@@ -674,15 +673,14 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 	if (ret)
 		goto out;
 
-	if ((strcmp(resctrl_val, "mbm") == 0) ||
-	    (strcmp(resctrl_val, "mba") == 0)) {
+	if (is_mbm(resctrl_val) || is_mba(resctrl_val)) {
 		ret = initialize_mem_bw_imc();
 		if (ret)
 			goto out;
 
 		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
 					  param->cpu_no, resctrl_val);
-	} else if (strcmp(resctrl_val, "cqm") == 0)
+	} else if (is_cqm(resctrl_val))
 		initialize_llc_occu_resctrl(param->ctrlgrp, param->mongrp,
 					    param->cpu_no, resctrl_val);
 
@@ -710,8 +708,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
-		if ((strcmp(resctrl_val, "mbm") == 0) ||
-		    (strcmp(resctrl_val, "mba") == 0)) {
+		if (is_mbm(resctrl_val) || is_mba(resctrl_val)) {
 			ret = param->setup(1, param);
 			if (ret) {
 				ret = 0;
@@ -721,7 +718,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 			ret = measure_vals(param, &bw_resc_start);
 			if (ret)
 				break;
-		} else if (strcmp(resctrl_val, "cqm") == 0) {
+		} else if (is_cqm(resctrl_val)) {
 			ret = param->setup(1, param);
 			if (ret) {
 				ret = 0;
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 2a16100c9c3f..dc4f1286aefa 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -334,7 +334,7 @@ void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 		operation = atoi(benchmark_cmd[4]);
 		sprintf(resctrl_val, "%s", benchmark_cmd[5]);
 
-		if (strcmp(resctrl_val, "cqm") != 0)
+		if (!is_cqm(resctrl_val))
 			buffer_span = span * MB;
 		else
 			buffer_span = span;
@@ -459,8 +459,7 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
 		goto out;
 
 	/* Create mon grp and write pid into it for "mbm" and "cqm" test */
-	if ((strcmp(resctrl_val, "cqm") == 0) ||
-	    (strcmp(resctrl_val, "mbm") == 0)) {
+	if (is_cqm(resctrl_val) || is_mbm(resctrl_val)) {
 		if (strlen(mongrp)) {
 			sprintf(monitorgroup_p, "%s/mon_groups", controlgroup);
 			sprintf(monitorgroup, "%s/%s", monitorgroup_p, mongrp);
@@ -505,9 +504,8 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 	int resource_id, ret = 0;
 	FILE *fp;
 
-	if ((strcmp(resctrl_val, "mba") != 0) &&
-	    (strcmp(resctrl_val, "cat") != 0) &&
-	    (strcmp(resctrl_val, "cqm") != 0))
+	if (!is_mba(resctrl_val) && !is_cat(resctrl_val) &&
+	    !is_cqm(resctrl_val))
 		return -ENOENT;
 
 	if (!schemata) {
@@ -528,9 +526,9 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 	else
 		sprintf(controlgroup, "%s/schemata", RESCTRL_PATH);
 
-	if (!strcmp(resctrl_val, "cat") || !strcmp(resctrl_val, "cqm"))
+	if (is_cat(resctrl_val) || is_cqm(resctrl_val))
 		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=', schemata);
-	if (strcmp(resctrl_val, "mba") == 0)
+	if (is_mba(resctrl_val))
 		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
 
 	fp = fopen(controlgroup, "w");
-- 
2.29.2

