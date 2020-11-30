Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E99F2C8EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgK3UVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:21:15 -0500
Received: from mga04.intel.com ([192.55.52.120]:60098 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730094AbgK3UVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:21:14 -0500
IronPort-SDR: W0X04hQhqMFzuWuF+Ek3KXjwDV9wzRO5sEv/HGcMM8XDWRiuKJ508DvLipWPxwBtpP9w96qleV
 ds2/UosxG3vw==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="170140726"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="170140726"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 12:20:31 -0800
IronPort-SDR: V1uhTitOTNcxUCpJkASRU4Ff+DrGnAYPVluoLUd/5pmenugj5ZMK//7q3urw4unQbk4oud6Hq5
 juBlING17ZvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="480793748"
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
Subject: [PATCH v4 01/17] selftests/resctrl: Fix compilation issues for global variables
Date:   Mon, 30 Nov 2020 20:19:54 +0000
Message-Id: <20201130202010.178373-2-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130202010.178373-1-fenghua.yu@intel.com>
References: <20201130202010.178373-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reinette reported following compilation issue on Fedora 32, gcc version
10.1.1

/usr/bin/ld: cqm_test.o:<src_dir>/cqm_test.c:22: multiple definition of
`cache_size'; cat_test.o:<src_dir>/cat_test.c:23: first defined here

The same issue is reported for long_mask, cbm_mask, count_of_bits etc
variables as well. Compiler isn't happy because these variables are
defined globally in two .c files namely cqm_test.c and cat_test.c and
the compiler during compilation finds that the variable is already
defined (multiple definition error).

Taking a closer look at the usage of these variables reveals that these
variables are used only locally to functions such as cqm_resctrl_val()
(defined in cqm_test.c) and cat_perf_miss_val() (defined in cat_test.c).
These variables are not shared between those functions. So, there is no
need for these variables to be global. Hence, fix this issue by making
them local variables to the functions where they are used.

To fix issues for other global variables (e.g: bm_pid, ppid, llc_occup_path
and is_amd) that are used across .c files, declare them as extern.

Reported-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c  | 12 ++++--------
 tools/testing/selftests/resctrl/cqm_test.c  | 11 ++++-------
 tools/testing/selftests/resctrl/resctrl.h   | 10 +++++-----
 tools/testing/selftests/resctrl/resctrlfs.c | 10 +++++-----
 4 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 5da43767b973..7f723bd8f328 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -17,11 +17,6 @@
 #define MAX_DIFF_PERCENT	4
 #define MAX_DIFF		1000000
 
-int count_of_bits;
-char cbm_mask[256];
-unsigned long long_mask;
-unsigned long cache_size;
-
 /*
  * Change schemata. Write schemata to specified
  * con_mon grp, mon_grp in resctrl FS.
@@ -121,8 +116,9 @@ void cat_test_cleanup(void)
 
 int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 {
-	unsigned long l_mask, l_mask_1;
-	int ret, pipefd[2], sibling_cpu_no;
+	unsigned long l_mask, l_mask_1, long_mask, cache_size;
+	int ret, pipefd[2], sibling_cpu_no, count_of_bits;
+	char cbm_mask[256];
 	char pipe_message;
 	pid_t bm_pid;
 
@@ -136,7 +132,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		return -1;
 
 	/* Get default cbm mask for L3/L2 cache */
-	ret = get_cbm_mask(cache_type);
+	ret = get_cbm_mask(cache_type, cbm_mask);
 	if (ret)
 		return ret;
 
diff --git a/tools/testing/selftests/resctrl/cqm_test.c b/tools/testing/selftests/resctrl/cqm_test.c
index c8756152bd61..b6af940ccfc2 100644
--- a/tools/testing/selftests/resctrl/cqm_test.c
+++ b/tools/testing/selftests/resctrl/cqm_test.c
@@ -16,11 +16,6 @@
 #define MAX_DIFF		2000000
 #define MAX_DIFF_PERCENT	15
 
-int count_of_bits;
-char cbm_mask[256];
-unsigned long long_mask;
-unsigned long cache_size;
-
 static int cqm_setup(int num, ...)
 {
 	struct resctrl_val_param *p;
@@ -113,7 +108,9 @@ void cqm_test_cleanup(void)
 
 int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 {
-	int ret, mum_resctrlfs;
+	int ret, mum_resctrlfs, count_of_bits;
+	unsigned long long_mask, cache_size;
+	char cbm_mask[256];
 
 	cache_size = 0;
 	mum_resctrlfs = 1;
@@ -125,7 +122,7 @@ int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 	if (!validate_resctrl_feature_request("cqm"))
 		return -1;
 
-	ret = get_cbm_mask("L3");
+	ret = get_cbm_mask("L3", cbm_mask);
 	if (ret)
 		return ret;
 
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 39bf59c6b9c5..12b77182cb44 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -62,11 +62,11 @@ struct resctrl_val_param {
 	int		(*setup)(int num, ...);
 };
 
-pid_t bm_pid, ppid;
-int tests_run;
+extern pid_t bm_pid, ppid;
+extern int tests_run;
 
-char llc_occup_path[1024];
-bool is_amd;
+extern char llc_occup_path[1024];
+extern bool is_amd;
 
 bool check_resctrlfs_support(void);
 int filter_dmesg(void);
@@ -92,7 +92,7 @@ void tests_cleanup(void);
 void mbm_test_cleanup(void);
 int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd);
 void mba_test_cleanup(void);
-int get_cbm_mask(char *cache_type);
+int get_cbm_mask(char *cache_type, char *cbm_mask);
 int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int cat_val(struct resctrl_val_param *param);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 19c0ec4045a4..2a16100c9c3f 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -49,8 +49,6 @@ static int find_resctrl_mount(char *buffer)
 	return -ENOENT;
 }
 
-char cbm_mask[256];
-
 /*
  * remount_resctrlfs - Remount resctrl FS at /sys/fs/resctrl
  * @mum_resctrlfs:	Should the resctrl FS be remounted?
@@ -205,16 +203,18 @@ int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size)
 /*
  * get_cbm_mask - Get cbm mask for given cache
  * @cache_type:	Cache level L2/L3
- *
- * Mask is stored in cbm_mask which is global variable.
+ * @cbm_mask:	cbm_mask returned as a string
  *
  * Return: = 0 on success, < 0 on failure.
  */
-int get_cbm_mask(char *cache_type)
+int get_cbm_mask(char *cache_type, char *cbm_mask)
 {
 	char cbm_mask_path[1024];
 	FILE *fp;
 
+	if (!cbm_mask)
+		return -1;
+
 	sprintf(cbm_mask_path, "%s/%s/cbm_mask", CBM_MASK_PATH, cache_type);
 
 	fp = fopen(cbm_mask_path, "r");
-- 
2.29.2

