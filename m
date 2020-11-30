Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260E02C8F0C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388422AbgK3UWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:22:11 -0500
Received: from mga04.intel.com ([192.55.52.120]:60153 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388401AbgK3UWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:22:10 -0500
IronPort-SDR: ozw7R5IqaLOMKZJprYZ9rajriGKw1M580CaALhuZwzkhEx4iVvelmCuBS/Bd7aZS6bJTMj1Nr4
 +SNX5+KAxyJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="170140749"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="170140749"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 12:20:33 -0800
IronPort-SDR: J8Nyypf6LEL/x90WzZU6/El+7Ymfcmk+48+yn3eYRzzDbfuIJ1C5E2DoK1GWF92d84hkEscHFM
 1XH7m9Txjdag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="480793802"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga004.jf.intel.com with ESMTP; 30 Nov 2020 12:20:33 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "David Binderman" <dcb314@hotmail.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 13/17] selftests/resctrl: Modularize resctrl test suite main() function
Date:   Mon, 30 Nov 2020 20:20:06 +0000
Message-Id: <20201130202010.178373-14-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130202010.178373-1-fenghua.yu@intel.com>
References: <20201130202010.178373-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resctrl test suite main() function does the following things
1. Parses command line arguments passed by user
2. Some setup checks
3. Logic that calls into each unit test
4. Print result and clean up after running each unit test

Introduce wrapper functions for steps 3 and 4 to modularize the main()
function. Adding these wrapper functions makes it easier to add any logic
to each individual test.

Please note that this is a preparatory patch for the next one and no
functional changes are intended.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 .../testing/selftests/resctrl/resctrl_tests.c | 96 ++++++++++++-------
 1 file changed, 61 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 244f1beb75da..9b7017299ca2 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -54,10 +54,62 @@ void tests_cleanup(void)
 	cat_test_cleanup();
 }
 
+static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
+			 int cpu_no, char *bw_report)
+{
+	int res;
+
+	printf("# Starting MBM BW change ...\n");
+	if (!has_ben)
+		sprintf(benchmark_cmd[5], "%s", "mba");
+	res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
+	printf("%sok MBM: bw change\n", res ? "not " : "");
+	mbm_test_cleanup();
+	tests_run++;
+}
+
+static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
+			 int cpu_no, char *bw_report)
+{
+	int res;
+
+	printf("# Starting MBA Schemata change ...\n");
+	if (!has_ben)
+		sprintf(benchmark_cmd[1], "%d", span);
+	res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
+	printf("%sok MBA: schemata change\n", res ? "not " : "");
+	mba_test_cleanup();
+	tests_run++;
+}
+
+static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
+{
+	int res;
+
+	printf("# Starting CMT test ...\n");
+	if (!has_ben)
+		sprintf(benchmark_cmd[5], "%s", "cmt");
+	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
+	printf("%sok CMT: test\n", res ? "not " : "");
+	cmt_test_cleanup();
+	tests_run++;
+}
+
+static void run_cat_test(int cpu_no, int no_of_bits)
+{
+	int res;
+
+	printf("# Starting CAT test ...\n");
+	res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
+	printf("%sok CAT: test\n", res ? "not " : "");
+	tests_run++;
+	cat_test_cleanup();
+}
+
 int main(int argc, char **argv)
 {
 	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
-	int res, c, cpu_no = 1, span = 250, argc_new = argc, i, no_of_bits = 0;
+	int c, cpu_no = 1, span = 250, argc_new = argc, i, no_of_bits = 0;
 	char *benchmark_cmd[BENCHMARK_ARGS], bw_report[64], bm_type[64];
 	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
 	int ben_ind, ben_count;
@@ -168,43 +220,17 @@ int main(int argc, char **argv)
 
 	filter_dmesg();
 
-	if (!is_amd && mbm_test) {
-		printf("# Starting MBM BW change ...\n");
-		if (!has_ben)
-			sprintf(benchmark_cmd[5], "%s", MBA_STR);
-		res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
-		printf("%sok MBM: bw change\n", res ? "not " : "");
-		mbm_test_cleanup();
-		tests_run++;
-	}
+	if (!is_amd && mbm_test)
+		run_mbm_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
 
-	if (!is_amd && mba_test) {
-		printf("# Starting MBA Schemata change ...\n");
-		if (!has_ben)
-			sprintf(benchmark_cmd[1], "%d", span);
-		res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
-		printf("%sok MBA: schemata change\n", res ? "not " : "");
-		mba_test_cleanup();
-		tests_run++;
-	}
+	if (!is_amd && mba_test)
+		run_mba_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
 
-	if (cmt_test) {
-		printf("# Starting CMT test ...\n");
-		if (!has_ben)
-			sprintf(benchmark_cmd[5], "%s", "cmt");
-		res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
-		printf("%sok CMT: test\n", res ? "not " : "");
-		cmt_test_cleanup();
-		tests_run++;
-	}
+	if (cmt_test)
+		run_cmt_test(has_ben, benchmark_cmd, cpu_no);
 
-	if (cat_test) {
-		printf("# Starting CAT test ...\n");
-		res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
-		printf("%sok CAT: test\n", res ? "not " : "");
-		tests_run++;
-		cat_test_cleanup();
-	}
+	if (cat_test)
+		run_cat_test(cpu_no, no_of_bits);
 
 out:
 	printf("1..%d\n", tests_run);
-- 
2.29.2

