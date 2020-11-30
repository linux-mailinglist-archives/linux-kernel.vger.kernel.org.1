Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC232C8F01
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388345AbgK3UVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:21:45 -0500
Received: from mga04.intel.com ([192.55.52.120]:60096 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729279AbgK3UVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:21:44 -0500
IronPort-SDR: q2eimo+9ZqhXBJoAPRe/rh8bFY+BRLmNg2W7qmoe5j/4ut3UWo3RVhNoh/YNgIAFpxGU6Idm0V
 +VVqR8EBp9Vw==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="170140734"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="170140734"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 12:20:32 -0800
IronPort-SDR: I9zoryjf5rhSxVCjpcTLy3w4c/p308GNiYGmOElmd0FQRm1F5oOTAemjy/s/qbAn0ruSzW8S3Q
 j6/rddZF1m1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="480793766"
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
Subject: [PATCH v4 05/17] selftests/resctrl: Add a few dependencies
Date:   Mon, 30 Nov 2020 20:19:58 +0000
Message-Id: <20201130202010.178373-6-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130202010.178373-1-fenghua.yu@intel.com>
References: <20201130202010.178373-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a couple of sanity checks and the config file for test dependencies.

Running any resctrl unit test involves writing to resctrl file system
and only a root user has permission to write to resctrl FS. Resctrl
test suite before running any test checks for the privilege of the
user and if it's not a root user, the test suite prints a warning
and continues attempting to run tests.

Attempting to run any test without root privileges will fail as below

TAP version 13
ok kernel supports resctrl filesystem
.................
not ok mounting resctrl to "/sys/fs/resctrl"
not ok MBA: schemata change

Hence, don't attempt to run any test if the user is not a root user and
change the warning message to a bail out message to comply with TAP 13
standards.

Regarding the second check, check_resctrlfs_support() checks if the
platform supports resctrl file system or not by looking for resctrl
in /proc/filesystems and returns a boolean value. The main function
of resctrl test suite calls check_resctrlfs_support() but forgets to
check for it's return value. This means that resctrl test suite will
attempt to run resctrl tests (like CMT, CAT, MBM and MBA) even if the
platform doesn't support resctrl file system.

Fix this by checking for the return value of check_resctrlfs_support() in
the main function. If resctrl file system isn't supported on the platform
then exit the test suite gracefully without attempting to run any of
resctrl unit tests.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/config          |  2 ++
 tools/testing/selftests/resctrl/resctrl_tests.c | 13 ++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/resctrl/config

diff --git a/tools/testing/selftests/resctrl/config b/tools/testing/selftests/resctrl/config
new file mode 100644
index 000000000000..8d9f2deb56ed
--- /dev/null
+++ b/tools/testing/selftests/resctrl/config
@@ -0,0 +1,2 @@
+CONFIG_X86_CPU_RESCTRL=y
+CONFIG_PROC_CPU_RESCTRL=y
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index d92b0b32a349..0e036dbf5d17 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -125,8 +125,10 @@ int main(int argc, char **argv)
 	 * 1. We write to resctrl FS
 	 * 2. We execute perf commands
 	 */
-	if (geteuid() != 0)
-		printf("# WARNING: not running as root, tests may fail.\n");
+	if (geteuid() != 0) {
+		printf("Bail out! not running as root, abort testing\n");
+		goto out;
+	}
 
 	/* Detect AMD vendor */
 	detect_amd();
@@ -155,7 +157,11 @@ int main(int argc, char **argv)
 	sprintf(bw_report, "reads");
 	sprintf(bm_type, "fill_buf");
 
-	check_resctrlfs_support();
+	if (!check_resctrlfs_support()) {
+		printf("Bail out! resctrl FS does not exist\n");
+		goto out;
+	}
+
 	filter_dmesg();
 
 	if (!is_amd && mbm_test) {
@@ -196,6 +202,7 @@ int main(int argc, char **argv)
 		cat_test_cleanup();
 	}
 
+out:
 	printf("1..%d\n", tests_run);
 
 	return 0;
-- 
2.29.2

