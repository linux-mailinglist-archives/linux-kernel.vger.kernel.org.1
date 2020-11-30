Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F342C8EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgK3UVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:21:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:58346 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730094AbgK3UVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:21:16 -0500
IronPort-SDR: q54dCVkDYoh+yowP1U19tVINOA+/PFrm9zhQ34KJ2L9FeaZHYdK0aTBYCrevWOO5hMFnx8h9mx
 PeBAtVkM40Ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="169206688"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="169206688"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 12:20:34 -0800
IronPort-SDR: aotZFOwYFyG7GbsD9mVRIi6OeOxyLWJVehAMCCHejexHGjhpJk8zA/pANKOc8Z0igT7bk9HVT9
 THJpc0cq940g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="480793813"
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
Subject: [PATCH v4 16/17] selftests/resctrl: Fix incorrect parsing of iMC counters
Date:   Mon, 30 Nov 2020 20:20:09 +0000
Message-Id: <20201130202010.178373-17-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130202010.178373-1-fenghua.yu@intel.com>
References: <20201130202010.178373-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iMC (Integrated Memory Controller) counters are usually at
"/sys/bus/event_source/devices/" and are named as "uncore_imc_<n>".
num_of_imcs() function tries to count number of such iMC counters so that
it could appropriately initialize required number of perf_attr structures
that could be used to read these iMC counters.

num_of_imcs() function assumes that all the directories under this path
that start with "uncore_imc" are iMC counters. But, on some systems there
could be directories named as "uncore_imc_free_running" which aren't iMC
counters. Trying to read from such directories will result in "not found
file" errors and MBM/MBA tests will fail.

Hence, fix the logic in num_of_imcs() such that it looks at the first
character after "uncore_imc_" to check if it's a numerical digit or not. If
it's a digit then the directory represents an iMC counter, else, skip the
directory.

Reported-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_val.c | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 5ff336f62f8f..d6f0688182e8 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -221,8 +221,8 @@ static int read_from_imc_dir(char *imc_dir, int count)
  */
 static int num_of_imcs(void)
 {
+	char imc_dir[512], *temp;
 	unsigned int count = 0;
-	char imc_dir[512];
 	struct dirent *ep;
 	int ret;
 	DIR *dp;
@@ -230,7 +230,25 @@ static int num_of_imcs(void)
 	dp = opendir(DYN_PMU_PATH);
 	if (dp) {
 		while ((ep = readdir(dp))) {
-			if (strstr(ep->d_name, UNCORE_IMC)) {
+			temp = strstr(ep->d_name, UNCORE_IMC);
+			if (!temp)
+				continue;
+
+			/*
+			 * imc counters are named as "uncore_imc_<n>", hence
+			 * increment the pointer to point to <n>. Note that
+			 * sizeof(UNCORE_IMC) would count for null character as
+			 * well and hence the last underscore character in
+			 * uncore_imc'_' need not be counted.
+			 */
+			temp = temp + sizeof(UNCORE_IMC);
+
+			/*
+			 * Some directories under "DYN_PMU_PATH" could have
+			 * names like "uncore_imc_free_running", hence, check if
+			 * first character is a numerical digit or not.
+			 */
+			if (temp[0] >= '0' && temp[0] <= '9') {
 				sprintf(imc_dir, "%s/%s/", DYN_PMU_PATH,
 					ep->d_name);
 				ret = read_from_imc_dir(imc_dir, count);
-- 
2.29.2

