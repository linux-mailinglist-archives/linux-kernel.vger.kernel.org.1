Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8452C8F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388407AbgK3UWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:22:04 -0500
Received: from mga04.intel.com ([192.55.52.120]:60098 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388391AbgK3UWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:22:00 -0500
IronPort-SDR: +1OKuu8D9m9OAhlTFg/5dwxTWE3MY+tKJhp/TX1e1/keGVALelKbyd9k9uMTAKcfMsiyriJVV8
 Kyz9EK6u1UlQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="170140747"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="170140747"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 12:20:33 -0800
IronPort-SDR: Td1//O8BW1sPmNwO+wwNxsAnc/kvhgVxnrzk0xnB77AZPEwlbMIhWDSaQKVA44MDdYxSm3zyty
 ZHuIxjoPpS/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="480793798"
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
Subject: [PATCH v4 12/17] selftests/resctrl: Don't hard code value of "no_of_bits" variable
Date:   Mon, 30 Nov 2020 20:20:05 +0000
Message-Id: <20201130202010.178373-13-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130202010.178373-1-fenghua.yu@intel.com>
References: <20201130202010.178373-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cache related tests (like CAT and CMT) depend on a variable called
no_of_bits to run. no_of_bits defines the number of contiguous bits
that should be set in the CBM mask and a user can pass a value for
no_of_bits using -n command line argument. If a user hasn't passed any
value, it defaults to 5 (randomly chosen value).

Hard coding no_of_bits to 5 will make the cache tests fail to run on
systems that support maximum cbm mask that is less than or equal to 5 bits.
Hence, don't hard code no_of_bits value.

If a user passes a value for "no_of_bits" using -n option, use it.
Otherwise, no_of_bits is equal to half of the maximum number of bits in
the cbm mask.

Please note that CMT test is still hard coded to 5 bits. It will change in
subsequent patches that change CMT test.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c      | 5 ++++-
 tools/testing/selftests/resctrl/resctrl_tests.c | 8 ++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 6d9a41f3939a..6e935a6bb3e6 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -147,7 +147,10 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	/* Get max number of bits from default-cabm mask */
 	count_of_bits = count_bits(long_mask);
 
-	if (n < 1 || n > count_of_bits - 1) {
+	if (!n)
+		n = count_of_bits / 2;
+
+	if (n > count_of_bits - 1) {
 		printf("Invalid input value for no_of_bits n!\n");
 		printf("Please Enter value in range 1 to %d\n",
 		       count_of_bits - 1);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index ef09e0ef2366..244f1beb75da 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -57,7 +57,7 @@ void tests_cleanup(void)
 int main(int argc, char **argv)
 {
 	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
-	int res, c, cpu_no = 1, span = 250, argc_new = argc, i, no_of_bits = 5;
+	int res, c, cpu_no = 1, span = 250, argc_new = argc, i, no_of_bits = 0;
 	char *benchmark_cmd[BENCHMARK_ARGS], bw_report[64], bm_type[64];
 	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
 	int ben_ind, ben_count;
@@ -106,6 +106,10 @@ int main(int argc, char **argv)
 			break;
 		case 'n':
 			no_of_bits = atoi(optarg);
+			if (no_of_bits <= 0) {
+				printf("Bail out! invalid argument for no_of_bits\n");
+				return -1;
+			}
 			break;
 		case 'h':
 			cmd_help();
@@ -188,7 +192,7 @@ int main(int argc, char **argv)
 		printf("# Starting CMT test ...\n");
 		if (!has_ben)
 			sprintf(benchmark_cmd[5], "%s", "cmt");
-		res = cmt_resctrl_val(cpu_no, no_of_bits, benchmark_cmd);
+		res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
 		printf("%sok CMT: test\n", res ? "not " : "");
 		cmt_test_cleanup();
 		tests_run++;
-- 
2.29.2

