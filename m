Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938172C8F03
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388363AbgK3UVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:21:48 -0500
Received: from mga04.intel.com ([192.55.52.120]:60098 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387449AbgK3UVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:21:45 -0500
IronPort-SDR: pNNdHUpvJavu62nSHzf1oacGs8AQF6oDgIef83zWt6RKTVEZKnJo3QdxFWoHeFh6+Ez3P1K31a
 /2w90N1llVtw==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="170140739"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="170140739"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 12:20:32 -0800
IronPort-SDR: 4mdP8BOG7rB4bYvJajEfZNqmZUdJyyAlPbg77uj2b08Tx5HcEpQiCKM1xk7AhgXQdmADT4PU8J
 FsJbf+5i1WUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="480793774"
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
Subject: [PATCH v4 07/17] selftests/resctrl: Use resctrl/info for feature detection
Date:   Mon, 30 Nov 2020 20:20:00 +0000
Message-Id: <20201130202010.178373-8-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130202010.178373-1-fenghua.yu@intel.com>
References: <20201130202010.178373-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resctrl test suite before running any unit test (like cmt, cat, mbm and
mba) should first check if the feature is enabled (by kernel and not just
supported by H/W) on the platform or not.
validate_resctrl_feature_request() is supposed to do that. This function
intends to grep for relevant flags in /proc/cpuinfo but there are several
issues here

1. validate_resctrl_feature_request() calls fgrep() to get flags from
   /proc/cpuinfo. But, fgrep() can only return a string with maximum of 255
   characters and hence the complete cpu flags are never returned.
2. The substring search logic is also busted. If strstr() finds requested
   resctrl feature in the cpu flags, it returns pointer to the first
   occurrence. But, the logic negates the return value of strstr() and
   hence validate_resctrl_feature_request() returns false if the feature is
   present in the cpu flags and returns true if the feature is not present.
3. validate_resctrl_feature_request() checks if a resctrl feature is
   reported in /proc/cpuinfo flags or not. Having a cpu flag means that the
   H/W supports the feature, but it doesn't mean that the kernel enabled
   it. A user could selectively enable only a subset of resctrl features
   using kernel command line arguments. Hence, /proc/cpuinfo isn't a
   reliable source to check if a feature is enabled or not.

The 3rd issue being the major one and fixing it requires changing the way
validate_resctrl_feature_request() works. Since, /proc/cpuinfo isn't the
right place to check if a resctrl feature is enabled or not, a more
appropriate place is /sys/fs/resctrl/info directory. Change
validate_resctrl_feature_request() such that,

1. For cat, check if /sys/fs/resctrl/info/L3 directory is present or not
2. For mba, check if /sys/fs/resctrl/info/MB directory is present or not
3. For cmt, check if /sys/fs/resctrl/info/L3_MON directory is present and
   check if /sys/fs/resctrl/info/L3_MON/mon_features has llc_occupancy
4. For mbm, check if /sys/fs/resctrl/info/L3_MON directory is present and
   check if /sys/fs/resctrl/info/L3_MON/mon_features has
   mbm_<total/local>_bytes

Please note that only L3_CAT, L3_CMT, MBA and MBM are supported. CDP and L2
variants can be added later.

Reported-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h   |  6 ++-
 tools/testing/selftests/resctrl/resctrlfs.c | 51 ++++++++++++++++-----
 2 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index e99e62fddc61..5ff71870e61c 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -28,6 +28,10 @@
 #define RESCTRL_PATH		"/sys/fs/resctrl"
 #define PHYS_ID_PATH		"/sys/devices/system/cpu/cpu"
 #define CBM_MASK_PATH		"/sys/fs/resctrl/info"
+#define L3_PATH			"/sys/fs/resctrl/info/L3"
+#define MB_PATH			"/sys/fs/resctrl/info/MB"
+#define L3_MON_PATH		"/sys/fs/resctrl/info/L3_MON"
+#define L3_MON_FEATURES_PATH	"/sys/fs/resctrl/info/L3_MON/mon_features"
 
 #define PARENT_EXIT(err_msg)			\
 	do {					\
@@ -99,7 +103,7 @@ int remount_resctrlfs(bool mum_resctrlfs);
 int get_resource_id(int cpu_no, int *resource_id);
 int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
-bool validate_resctrl_feature_request(char *resctrl_val);
+bool validate_resctrl_feature_request(const char *resctrl_val);
 char *fgrep(FILE *inf, const char *str);
 int taskset_benchmark(pid_t bm_pid, int cpu_no);
 void run_benchmark(int signum, siginfo_t *info, void *ucontext);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index c676557b376d..d2cae4927b62 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -616,26 +616,55 @@ char *fgrep(FILE *inf, const char *str)
  * validate_resctrl_feature_request - Check if requested feature is valid.
  * @resctrl_val:	Requested feature
  *
- * Return: 0 on success, non-zero on failure
+ * Return: True if the feature is supported, else false
  */
-bool validate_resctrl_feature_request(char *resctrl_val)
+bool validate_resctrl_feature_request(const char *resctrl_val)
 {
-	FILE *inf = fopen("/proc/cpuinfo", "r");
+	struct stat statbuf;
 	bool found = false;
 	char *res;
+	FILE *inf;
 
-	if (!inf)
+	if (!resctrl_val)
 		return false;
 
-	res = fgrep(inf, "flags");
-
-	if (res) {
-		char *s = strchr(res, ':');
+	if (remount_resctrlfs(false))
+		return false;
 
-		found = s && !strstr(s, resctrl_val);
-		free(res);
+	if (is_cat(resctrl_val)) {
+		if (!stat(L3_PATH, &statbuf))
+			return true;
+	} else if (is_mba(resctrl_val)) {
+		if (!stat(MB_PATH, &statbuf))
+			return true;
+	} else if (is_mbm(resctrl_val) || is_cmt(resctrl_val)) {
+		if (!stat(L3_MON_PATH, &statbuf)) {
+			inf = fopen(L3_MON_FEATURES_PATH, "r");
+			if (!inf)
+				return false;
+
+			if (is_cmt(resctrl_val)) {
+				res = fgrep(inf, "llc_occupancy");
+				if (res) {
+					found = true;
+					free(res);
+				}
+			}
+
+			if (is_mbm(resctrl_val)) {
+				res = fgrep(inf, "mbm_total_bytes");
+				if (res) {
+					free(res);
+					res = fgrep(inf, "mbm_local_bytes");
+					if (res) {
+						found = true;
+						free(res);
+					}
+				}
+			}
+			fclose(inf);
+		}
 	}
-	fclose(inf);
 
 	return found;
 }
-- 
2.29.2

