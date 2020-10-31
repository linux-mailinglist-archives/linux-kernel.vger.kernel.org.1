Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E10F2A11EC
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 01:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgJaA16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 20:27:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:24067 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgJaA1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 20:27:55 -0400
IronPort-SDR: ybIz4PypFNN9n1SV7whEJX7YZSkFNd5AiwCEZ1yzGN7URZXjd60VqHs6Kw+o6oYj68MjcEj3lQ
 8y1/ZrEvo2HQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="230318026"
X-IronPort-AV: E=Sophos;i="5.77,435,1596524400"; 
   d="scan'208";a="230318026"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 17:27:53 -0700
IronPort-SDR: zOYLhQeURYODPsxgIBdbqUvgBbDpdTFhktO1FibCVQlYHz653ECjG+P8dUvdI3XgyMfXKbRNQH
 aPz4CQb4oaLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,435,1596524400"; 
   d="scan'208";a="469683912"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga004.jf.intel.com with ESMTP; 30 Oct 2020 17:27:53 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Christopherson Sean J" <sean.j.christopherson@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH RFC v3 3/4] x86/bus_lock: Set rate limit for bus lock
Date:   Sat, 31 Oct 2020 00:27:13 +0000
Message-Id: <20201031002714.3649728-4-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201031002714.3649728-1-fenghua.yu@intel.com>
References: <20201031002714.3649728-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enforce user application throttling or mitigations, extend the
existing split lock detect kernel parameter:
	split_lock_detect=ratelimit:N

It limits bus lock rate to N per second for non root users.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 37 ++++++++++++++++++++++++++++++++-----
 include/linux/sched/user.h  |  4 +++-
 kernel/user.c               |  7 +++++++
 3 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 3aa57199484b..6dcc7e404f8b 100644
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
@@ -1084,8 +1100,8 @@ static void sld_update_msr(bool on)
 
 static void split_lock_init(void)
 {
-	/* If supported, #DB for bus lock will handle warn. */
-	if (bld && sld_state == sld_warn)
+	/* If supported, #DB for bus lock will handle warn and ratelimit. */
+	if (bld && (sld_state == sld_warn || sld_state == sld_ratelimit))
 		return;
 
 	if (cpu_model_supports_sld)
@@ -1142,7 +1158,8 @@ static void bus_lock_init(void)
 
 bool handle_user_split_lock(struct pt_regs *regs, long error_code)
 {
-	if ((regs->flags & X86_EFLAGS_AC) || !sld || sld_state == sld_fatal)
+	if ((regs->flags & X86_EFLAGS_AC) || !sld || sld_state == sld_fatal ||
+	    sld_state == sld_ratelimit)
 		return false;
 	split_lock_warn(regs->ip);
 	return true;
@@ -1156,6 +1173,11 @@ bool handle_bus_lock(struct pt_regs *regs)
 	pr_warn_ratelimited("#DB: %s/%d took a bus_lock trap at address: 0x%lx\n",
 			    current->comm, current->pid, regs->ip);
 
+	if (sld_state == sld_ratelimit) {
+		while (!__ratelimit(&get_current_user()->ratelimit_bl))
+			msleep(1000 / ratelimit_bl);
+	}
+
 	return true;
 }
 
@@ -1251,6 +1273,11 @@ static void sld_state_show(void)
 		else
 			pr_info("#DB: sending SIGBUS on user-space bus_locks\n");
 		break;
+
+	case sld_ratelimit:
+		if (bld)
+			pr_info("#DB: setting rate limit to %d/sec per user on non root user-space bus_locks\n", ratelimit_bl);
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
index b1635d94a1f2..023dad617625 100644
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
 
+/* Architectures (e.g. X86) may set this for rate limited bus locks. */
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
2.29.1

