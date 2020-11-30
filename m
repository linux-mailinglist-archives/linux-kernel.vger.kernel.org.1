Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933A52C8F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388432AbgK3UWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:22:16 -0500
Received: from mga04.intel.com ([192.55.52.120]:60096 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388424AbgK3UWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:22:15 -0500
IronPort-SDR: b61uSOw06eltDjmkD/ze1rTSXNYK7BnE4G7yRzCixH/Uvvzsa7gCdDbSxEUIyzFd4bgbZ3GUUG
 n0fSOUKDD3Iw==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="170140752"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="170140752"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 12:20:33 -0800
IronPort-SDR: miVHB+gXm6Ls4KyuxSdO1Fkws14UXYSS3y1cDz4JcKfHH5X74H+GLsP+t3iJZxXwFSbrjjDycS
 mlEWOAASl5Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="480793805"
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
Subject: [PATCH v4 14/17] selftests/resctrl: Skip the test if requested resctrl feature is not supported
Date:   Mon, 30 Nov 2020 20:20:07 +0000
Message-Id: <20201130202010.178373-15-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130202010.178373-1-fenghua.yu@intel.com>
References: <20201130202010.178373-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There could be two reasons why a resctrl feature might not be enabled on
the platform
1. H/W might not support the feature
2. Even if the H/W supports it, the user might have disabled the feature
   through kernel command line arguments

Hence, any resctrl unit test (like cmt, cat, mbm and mba) before starting
the test will first check if the feature is enabled on the platform or not.
If the feature isn't enabled, then the test returns with an error status.
For example, if MBA isn't supported on a platform and if the user tries to
run MBA, the output will look like this

ok mounting resctrl to "/sys/fs/resctrl"
not ok MBA: schemata change

But, not supporting a feature isn't a test failure. So, instead of treating
it as an error, use the SKIP directive of the TAP protocol. With the
change, the output will look as below

ok MBA # SKIP Hardware does not support MBA or MBA is disabled

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c    |  3 ---
 tools/testing/selftests/resctrl/mba_test.c    |  3 ---
 tools/testing/selftests/resctrl/mbm_test.c    |  3 ---
 .../testing/selftests/resctrl/resctrl_tests.c | 24 +++++++++++++++++++
 4 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 6e935a6bb3e6..9b38e6296d3d 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -128,9 +128,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	if (ret)
 		return ret;
 
-	if (!validate_resctrl_feature_request("cat"))
-		return -1;
-
 	/* Get default cbm mask for L3/L2 cache */
 	ret = get_cbm_mask(cache_type, cbm_mask);
 	if (ret)
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index b4c81d2ee53b..d10e030b1a55 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -156,9 +156,6 @@ int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd)
 
 	remove(RESULT_FILE_NAME);
 
-	if (!validate_resctrl_feature_request("mba"))
-		return -1;
-
 	ret = resctrl_val(benchmark_cmd, &param);
 	if (ret)
 		return ret;
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 672d3ddd6e85..614614ecd58b 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -129,9 +129,6 @@ int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd)
 
 	remove(RESULT_FILE_NAME);
 
-	if (!validate_resctrl_feature_request("mbm"))
-		return -1;
-
 	ret = resctrl_val(benchmark_cmd, &param);
 	if (ret)
 		return ret;
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 9b7017299ca2..63400a51cbd8 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -60,6 +60,12 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
 	int res;
 
 	printf("# Starting MBM BW change ...\n");
+
+	if (!validate_resctrl_feature_request("mbm")) {
+		printf("ok MBM # SKIP Hardware does not support MBM or MBM is disabled\n");
+		return;
+	}
+
 	if (!has_ben)
 		sprintf(benchmark_cmd[5], "%s", "mba");
 	res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
@@ -74,6 +80,12 @@ static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
 	int res;
 
 	printf("# Starting MBA Schemata change ...\n");
+
+	if (!validate_resctrl_feature_request("mba")) {
+		printf("ok MBA # SKIP Hardware does not support MBA or MBA is disabled\n");
+		return;
+	}
+
 	if (!has_ben)
 		sprintf(benchmark_cmd[1], "%d", span);
 	res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
@@ -87,6 +99,12 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
 	int res;
 
 	printf("# Starting CMT test ...\n");
+
+	if (!validate_resctrl_feature_request("cmt")) {
+		printf("ok CMT # SKIP Hardware does not support CMT or CMT is disabled\n");
+		return;
+	}
+
 	if (!has_ben)
 		sprintf(benchmark_cmd[5], "%s", "cmt");
 	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
@@ -100,6 +118,12 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 	int res;
 
 	printf("# Starting CAT test ...\n");
+
+	if (!validate_resctrl_feature_request("cat")) {
+		printf("ok CAT # SKIP Hardware does not support CAT or CAT is disabled\n");
+		return;
+	}
+
 	res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
 	printf("%sok CAT: test\n", res ? "not " : "");
 	tests_run++;
-- 
2.29.2

