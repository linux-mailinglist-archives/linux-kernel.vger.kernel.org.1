Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DF62BBC48
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 03:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgKUCgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 21:36:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:47086 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbgKUCge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 21:36:34 -0500
IronPort-SDR: GxEBNYyloPSMdYoDscpcbEaiHwNvJTXVxVu1rL9fc5LrAkkLQuVqZt5+hBke5RecyN5ejw2Cd5
 NOCFJj2qhgtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="170788363"
X-IronPort-AV: E=Sophos;i="5.78,358,1599548400"; 
   d="scan'208";a="170788363"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 18:36:33 -0800
IronPort-SDR: xfA8NPstKinEl3AGFs8p8/R+KjqifVAMcXPL0aPb8BWGPGxyN1oa5uNwBNmyDlUKwdptJ6n1xW
 HcvDfKAvWCGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,358,1599548400"; 
   d="scan'208";a="431759883"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by fmsmga001.fm.intel.com with ESMTP; 20 Nov 2020 18:36:32 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Xiaoyao Li " <xiaoyao.li@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 3/4] x86/bus_lock: Set rate limit for bus lock
Date:   Sat, 21 Nov 2020 02:36:23 +0000
Message-Id: <20201121023624.3604415-4-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201121023624.3604415-1-fenghua.yu@intel.com>
References: <20201121023624.3604415-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enforce user application throttling or mitigations, extend the
existing split lock detect kernel parameter:
	split_lock_detect=ratelimit:N

It limits bus lock rate to N per second for non-root users.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 35 ++++++++++++++++++++++++++++++-----
 include/linux/sched/user.h  |  4 +++-
 kernel/user.c               |  7 +++++++
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 77c3e33f41c7..5eb5822a446d 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -10,6 +10,9 @@
 #include <linux/thread_info.h>
 #include <linux/init.h>
 #include <linux/uaccess.h>
+#include <linux/cred.h>
+#include <linux/delay.h>
+#include <linux/sched/user.h>
 
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
@@ -40,6 +43,7 @@ enum split_lock_detect_state {
 	sld_off = 0,
 	sld_warn,
 	sld_fatal,
+	sld_ratelimit,
 };
 
 /*
@@ -998,13 +1002,25 @@ static const struct {
 	{ "off",	sld_off   },
 	{ "warn",	sld_warn  },
 	{ "fatal",	sld_fatal },
+	{ "ratelimit:", sld_ratelimit },
 };
 
 static inline bool match_option(const char *arg, int arglen, const char *opt)
 {
-	int len = strlen(opt);
 
-	return len == arglen && !strncmp(arg, opt, len);
+	int len = strlen(opt), ratelimit;
+
+	if (strncmp(arg, opt, len))
+		return false;
+
+	if (sscanf(arg, "ratelimit:%d", &ratelimit) == 1 && ratelimit > 0 &&
+	    ratelimit_bl <= HZ / 2) {
+		ratelimit_bl = ratelimit;
+
+		return true;
+	}
+
+	return len == arglen;
 }
 
 static bool split_lock_verify_msr(bool on)
@@ -1085,10 +1101,10 @@ static void sld_update_msr(bool on)
 static void split_lock_init(void)
 {
 	/*
-	 * If supported, #DB for bus lock will handle warn
+	 * If supported, #DB for bus lock will handle warn or ratelimit
 	 * and #AC for split lock is disabled.
 	 */
-	if (bld && sld_state == sld_warn) {
+	if ((bld && sld_state == sld_warn) || sld_state == sld_ratelimit) {
 		split_lock_verify_msr(false);
 		return;
 	}
@@ -1147,7 +1163,8 @@ static void bus_lock_init(void)
 
 bool handle_user_split_lock(struct pt_regs *regs, long error_code)
 {
-	if ((regs->flags & X86_EFLAGS_AC) || !sld || sld_state == sld_fatal)
+	if ((regs->flags & X86_EFLAGS_AC) || !sld || sld_state == sld_fatal ||
+	    sld_state == sld_ratelimit)
 		return false;
 	split_lock_warn(regs->ip);
 	return true;
@@ -1168,6 +1185,10 @@ void handle_bus_lock(struct pt_regs *regs)
 	case sld_fatal:
 		force_sig_fault(SIGBUS, BUS_ADRALN, NULL);
 		break;
+	case sld_ratelimit:
+		while (!__ratelimit(&get_current_user()->ratelimit_bl))
+			msleep(1000 / ratelimit_bl);
+		break;
 	}
 }
 
@@ -1261,6 +1282,10 @@ static void sld_state_show(void)
 		if (bld)
 			pr_info("#DB: sending SIGBUS on user-space bus_locks%s\n", sld ? " from non-WB" : "");
 		break;
+	case sld_ratelimit:
+		if (bld)
+			pr_info("#DB: setting rate limit to %d/sec per user on non-root user-space bus_locks\n", ratelimit_bl);
+		break;
 	}
 }
 
diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index a8ec3b6093fc..79f95002a123 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -40,8 +40,9 @@ struct user_struct {
 	atomic_t nr_watches;	/* The number of watches this user currently has */
 #endif
 
-	/* Miscellaneous per-user rate limit */
+	/* Miscellaneous per-user rate limits */
 	struct ratelimit_state ratelimit;
+	struct ratelimit_state ratelimit_bl;
 };
 
 extern int uids_sysfs_init(void);
@@ -51,6 +52,7 @@ extern struct user_struct *find_user(kuid_t);
 extern struct user_struct root_user;
 #define INIT_USER (&root_user)
 
+extern int ratelimit_bl;
 
 /* per-UID process charging. */
 extern struct user_struct * alloc_uid(kuid_t);
diff --git a/kernel/user.c b/kernel/user.c
index b1635d94a1f2..8fc19706bc91 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -103,6 +103,7 @@ struct user_struct root_user = {
 	.locked_shm     = 0,
 	.uid		= GLOBAL_ROOT_UID,
 	.ratelimit	= RATELIMIT_STATE_INIT(root_user.ratelimit, 0, 0),
+	.ratelimit_bl	= RATELIMIT_STATE_INIT(root_user.ratelimit_bl, 0, 0),
 };
 
 /*
@@ -172,6 +173,9 @@ void free_uid(struct user_struct *up)
 		free_user(up, flags);
 }
 
+/* Architectures (e.g. X86) may set this for rate-limited bus locks. */
+int ratelimit_bl;
+
 struct user_struct *alloc_uid(kuid_t uid)
 {
 	struct hlist_head *hashent = uidhashentry(uid);
@@ -190,6 +194,9 @@ struct user_struct *alloc_uid(kuid_t uid)
 		refcount_set(&new->__count, 1);
 		ratelimit_state_init(&new->ratelimit, HZ, 100);
 		ratelimit_set_flags(&new->ratelimit, RATELIMIT_MSG_ON_RELEASE);
+		ratelimit_state_init(&new->ratelimit_bl, HZ, ratelimit_bl);
+		ratelimit_set_flags(&new->ratelimit_bl,
+				    RATELIMIT_MSG_ON_RELEASE);
 
 		/*
 		 * Before adding this, check whether we raced
-- 
2.29.2

