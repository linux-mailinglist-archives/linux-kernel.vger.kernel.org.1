Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A17F2C8F05
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388370AbgK3UVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:21:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:60153 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388351AbgK3UVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:21:53 -0500
IronPort-SDR: 8mYcSifuz2pM9TtBXgew6YxKzXWfRo+sO+cPRlRsKkOb8YYMAvO9e2In2FpLN8Btywn+U4wtdK
 XomHmbO29P9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="170140742"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="170140742"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 12:20:32 -0800
IronPort-SDR: qksE6Qoc0qVF1wNlHHyMwSwK+/oeFcUe1fxB8QDhH+pZguUQ7VYrGiGrngafqM5PuEhWyrXqtB
 m4wMuVlgnJBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="480793791"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga004.jf.intel.com with ESMTP; 30 Nov 2020 12:20:32 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "David Binderman" <dcb314@hotmail.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 10/17] selftests/resctrl: Fix MBA/MBM results reporting format
Date:   Mon, 30 Nov 2020 20:20:03 +0000
Message-Id: <20201130202010.178373-11-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130202010.178373-1-fenghua.yu@intel.com>
References: <20201130202010.178373-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MBM unit test starts fill_buf (default built-in benchmark) in a new con_mon
group (c1, m1) and records resctrl reported mbm values and iMC (Integrated
Memory Controller) values every second. It does this for five seconds
(randomly chosen value) in total. It then calculates average of resctrl_mbm
values and imc_mbm values and if the difference is greater than 300 MB/sec
(randomly chosen value), the test treats it as a failure. MBA unit test is
similar to MBM but after every run it changes schemata.

Checking for a difference of 300 MB/sec doesn't look very meaningful when
the mbm values are changing over a wide range. For example, below are the
values running MBA test on SKL with different allocations

1. With 10% as schemata both iMC and resctrl mbm_values are around 2000
   MB/sec
2. With 100% as schemata both iMC and resctrl mbm_values are around 10000
   MB/sec

A 300 MB/sec difference between resctrl_mbm and imc_mbm values is
acceptable at 100% schemata but it isn't acceptable at 10% schemata because
that's a huge difference.

So, fix this by checking for percentage difference instead of absolute
difference i.e. check if the difference between resctrl_mbm value and
imc_mbm value is within 5% (randomly chosen value) of imc_mbm value. If the
difference is greater than 5% of imc_mbm value, treat it is a failure.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/mba_test.c | 20 +++++++++++---------
 tools/testing/selftests/resctrl/mbm_test.c | 13 +++++++------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 6449fbd96096..b4c81d2ee53b 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -12,7 +12,7 @@
 
 #define RESULT_FILE_NAME	"result_mba"
 #define NUM_OF_RUNS		5
-#define MAX_DIFF		300
+#define MAX_DIFF_PERCENT	5
 #define ALLOCATION_MAX		100
 #define ALLOCATION_MIN		10
 #define ALLOCATION_STEP		10
@@ -62,7 +62,8 @@ static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 	     allocation++) {
 		unsigned long avg_bw_imc, avg_bw_resc;
 		unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
-		unsigned long avg_diff;
+		int avg_diff_per;
+		float avg_diff;
 
 		/*
 		 * The first run is discarded due to inaccurate value from
@@ -76,17 +77,18 @@ static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 
 		avg_bw_imc = sum_bw_imc / (NUM_OF_RUNS - 1);
 		avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
-		avg_diff = labs((long)(avg_bw_resc - avg_bw_imc));
+		avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
+		avg_diff_per = (int)(avg_diff * 100);
 
-		printf("%sok MBA schemata percentage %u smaller than %d %%\n",
-		       avg_diff > MAX_DIFF ? "not " : "",
-		       ALLOCATION_MAX - ALLOCATION_STEP * allocation,
-		       MAX_DIFF);
+		printf("%sok MBA: diff within %d%% for schemata %u\n",
+		       avg_diff_per > MAX_DIFF_PERCENT ? "not " : "",
+		       MAX_DIFF_PERCENT,
+		       ALLOCATION_MAX - ALLOCATION_STEP * allocation);
 		tests_run++;
-		printf("# avg_diff: %lu\n", avg_diff);
+		printf("# avg_diff_per: %d%%\n", avg_diff_per);
 		printf("# avg_bw_imc: %lu\n", avg_bw_imc);
 		printf("# avg_bw_resc: %lu\n", avg_bw_resc);
-		if (avg_diff > MAX_DIFF)
+		if (avg_diff_per > MAX_DIFF_PERCENT)
 			failed = true;
 	}
 
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index ec6cfe01c9c2..672d3ddd6e85 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -11,7 +11,7 @@
 #include "resctrl.h"
 
 #define RESULT_FILE_NAME	"result_mbm"
-#define MAX_DIFF		300
+#define MAX_DIFF_PERCENT	5
 #define NUM_OF_RUNS		5
 
 static void
@@ -19,8 +19,8 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
 {
 	unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
 	unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
-	long avg_diff = 0;
-	int runs;
+	int runs, avg_diff_per;
+	float avg_diff = 0;
 
 	/*
 	 * Discard the first value which is inaccurate due to monitoring setup
@@ -33,12 +33,13 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
 
 	avg_bw_imc = sum_bw_imc / 4;
 	avg_bw_resc = sum_bw_resc / 4;
-	avg_diff = avg_bw_resc - avg_bw_imc;
+	avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
+	avg_diff_per = (int)(avg_diff * 100);
 
 	printf("%sok MBM: diff within %d%%\n",
-	       labs(avg_diff) > MAX_DIFF ? "not " : "", MAX_DIFF);
+	       avg_diff_per > MAX_DIFF_PERCENT ? "not " : "", MAX_DIFF_PERCENT);
 	tests_run++;
-	printf("# avg_diff: %lu\n", labs(avg_diff));
+	printf("# avg_diff_per: %d%%\n", avg_diff_per);
 	printf("# Span (MB): %d\n", span);
 	printf("# avg_bw_imc: %lu\n", avg_bw_imc);
 	printf("# avg_bw_resc: %lu\n", avg_bw_resc);
-- 
2.29.2

