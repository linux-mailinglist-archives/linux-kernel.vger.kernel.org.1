Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E62285EAE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 14:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgJGMEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 08:04:10 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41519 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgJGMEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 08:04:10 -0400
Received: by mail-ed1-f66.google.com with SMTP id l24so1866231edj.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 05:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=muvKrLKP35h4bWGkx1S7XK5URQZ/JcZ/MW3PavNqeWQ=;
        b=lhQyqv97qakUBjpsa5wpNv4UbvA+YVXMln4ihXsilT0r35ut3phcH2qqJXE9WmAHfZ
         2jftQWJHAajoPelcXOZtwrYqX/QN13fPjp4Jw/sb71JQU3mNzs5D9S4AgQBSN8q9+w0K
         u79NX1ER8XUnqNZEG6Xi+2y32lGk3Gzbz4zIvYUk24wYNftqM9mtUhpYKgNz6Sj283Te
         lGvb9zL30WxAf6j1LmEa7ZkZYsov2+nLvTskORP6Ei2D7VrKKCctR4wAklRdFH1SfP4K
         Edu71Mmb4i3fezzzLS2baSwsOrqnmP1znzNgEuP5C9+Gaz+3QuL5IZQ5EuDNpr43K3UN
         kFDw==
X-Gm-Message-State: AOAM533ke5ZEPFmwYjRXXKov70aDXvyWUP4qV1oaviTk1IoB4OjQa2BN
        8p826ljFFHT69hIRTx+MIXg=
X-Google-Smtp-Source: ABdhPJz2Ujf+gLfupuyd7miaXeK4lBak6uIrnZh43fba1tgGZTX9cdiGuyLwMkizmj1+JPFG0n2j+w==
X-Received: by 2002:a50:d696:: with SMTP id r22mr3162659edi.209.1602072247682;
        Wed, 07 Oct 2020 05:04:07 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-85-160-43-187.eurotel.cz. [85.160.43.187])
        by smtp.gmail.com with ESMTPSA id o12sm1411644ejb.36.2020.10.07.05.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 05:04:07 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Frederic Weisbecker <fweisbecker@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH] kernel: allow to configure PREEMPT_NONE, PREEMPT_VOLUNTARY on kernel command line
Date:   Wed,  7 Oct 2020 14:04:01 +0200
Message-Id: <20201007120401.11200-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Many people are still relying on pre built distribution kernels and so
distributions have to provide mutliple kernel flavors to offer different
preemption models. Most of them are providing PREEMPT_NONE for typical
server deployments and PREEMPT_VOLUNTARY for desktop users.

Having two different kernel binaries differing only by the preemption
mode seems rather wasteful and inflexible. Especially when the difference
between PREEMPT_NONE and PREEMPT_VOLUNTARY is really minimal. Both only
allow explicit scheduling points while running in the kernel and it is
only might_sleep which adds additional preemption points for
PREEMPT_VOLUNTARY.

Add a kernel command line parameter preempt_mode=[none, voluntary] which
allows to override the default compile time preemption mode
(CONFIG_PREEMPT_NONE resp. CONFIG_PREEMPT_VOLUTARY). Voluntary preempt
mode is guarded by a jump label to prevent any potential runtime overhead.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---

Hi all,
this is sent as an RFC because it still needs some work. E.g. move jump
label changes into their own patch. They are needed mostly to get rid of
header files dependencies (seen for CONFIG_JUMP_LABEL=n via atomic.h ->
bug.h).

I wanted to make sure that the idea is sound for maintainers first. The
next step would be extending the command line to support full preemption
as well but there is much more work in that area. Frederic has promissed
to look into that.

Thoughts?

 .../admin-guide/kernel-parameters.txt         |  5 ++
 include/linux/gpio/consumer.h                 |  1 +
 include/linux/jump_label.h                    | 44 +----------------
 include/linux/jump_label_type.h               | 49 +++++++++++++++++++
 include/linux/kernel.h                        | 12 +++--
 kernel/sched/core.c                           | 30 ++++++++++++
 6 files changed, 95 insertions(+), 46 deletions(-)
 create mode 100644 include/linux/jump_label_type.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a1068742a6df..96bb74faeb50 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3873,6 +3873,11 @@
 			Format: {"off"}
 			Disable Hardware Transactional Memory
 
+	preempt_mode={none,voluntary}
+			Set the preemption mode.
+			none - equivalent to CONFIG_PREEMPT_NONE
+			voluntary - equivalent to CONFIG_PREEMPT_VOLUNTARY
+
 	print-fatal-signals=
 			[KNL] debug: print fatal signals
 
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 901aab89d025..d64e6dda5755 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -3,6 +3,7 @@
 #define __LINUX_GPIO_CONSUMER_H
 
 #include <linux/bits.h>
+#include <linux/jump_label.h>
 #include <linux/bug.h>
 #include <linux/compiler_types.h>
 #include <linux/err.h>
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 32809624d422..bd0d846d0bde 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -75,6 +75,7 @@
 
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/jump_label_type.h>
 
 extern bool static_key_initialized;
 
@@ -82,35 +83,6 @@ extern bool static_key_initialized;
 				    "%s(): static key '%pS' used before call to jump_label_init()", \
 				    __func__, (key))
 
-#ifdef CONFIG_JUMP_LABEL
-
-struct static_key {
-	atomic_t enabled;
-/*
- * Note:
- *   To make anonymous unions work with old compilers, the static
- *   initialization of them requires brackets. This creates a dependency
- *   on the order of the struct with the initializers. If any fields
- *   are added, STATIC_KEY_INIT_TRUE and STATIC_KEY_INIT_FALSE may need
- *   to be modified.
- *
- * bit 0 => 1 if key is initially true
- *	    0 if initially false
- * bit 1 => 1 if points to struct static_key_mod
- *	    0 if points to struct jump_entry
- */
-	union {
-		unsigned long type;
-		struct jump_entry *entries;
-		struct static_key_mod *next;
-	};
-};
-
-#else
-struct static_key {
-	atomic_t enabled;
-};
-#endif	/* CONFIG_JUMP_LABEL */
 #endif /* __ASSEMBLY__ */
 
 #ifdef CONFIG_JUMP_LABEL
@@ -343,14 +315,6 @@ static inline void static_key_disable(struct static_key *key)
  * All the below code is macros in order to play type games.
  */
 
-struct static_key_true {
-	struct static_key key;
-};
-
-struct static_key_false {
-	struct static_key key;
-};
-
 #define STATIC_KEY_TRUE_INIT  (struct static_key_true) { .key = STATIC_KEY_INIT_TRUE,  }
 #define STATIC_KEY_FALSE_INIT (struct static_key_false){ .key = STATIC_KEY_INIT_FALSE, }
 
@@ -360,18 +324,12 @@ struct static_key_false {
 #define DEFINE_STATIC_KEY_TRUE_RO(name)	\
 	struct static_key_true name __ro_after_init = STATIC_KEY_TRUE_INIT
 
-#define DECLARE_STATIC_KEY_TRUE(name)	\
-	extern struct static_key_true name
-
 #define DEFINE_STATIC_KEY_FALSE(name)	\
 	struct static_key_false name = STATIC_KEY_FALSE_INIT
 
 #define DEFINE_STATIC_KEY_FALSE_RO(name)	\
 	struct static_key_false name __ro_after_init = STATIC_KEY_FALSE_INIT
 
-#define DECLARE_STATIC_KEY_FALSE(name)	\
-	extern struct static_key_false name
-
 #define DEFINE_STATIC_KEY_ARRAY_TRUE(name, count)		\
 	struct static_key_true name[count] = {			\
 		[0 ... (count) - 1] = STATIC_KEY_TRUE_INIT,	\
diff --git a/include/linux/jump_label_type.h b/include/linux/jump_label_type.h
new file mode 100644
index 000000000000..37cb02c12f35
--- /dev/null
+++ b/include/linux/jump_label_type.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_JUMP_LABEL_TYPE_H
+#define _LINUX_JUMP_LABEL_TYPE_H
+
+#ifdef CONFIG_JUMP_LABEL
+
+struct static_key {
+	atomic_t enabled;
+/*
+ * Note:
+ *   To make anonymous unions work with old compilers, the static
+ *   initialization of them requires brackets. This creates a dependency
+ *   on the order of the struct with the initializers. If any fields
+ *   are added, STATIC_KEY_INIT_TRUE and STATIC_KEY_INIT_FALSE may need
+ *   to be modified.
+ *
+ * bit 0 => 1 if key is initially true
+ *	    0 if initially false
+ * bit 1 => 1 if points to struct static_key_mod
+ *	    0 if points to struct jump_entry
+ */
+	union {
+		unsigned long type;
+		struct jump_entry *entries;
+		struct static_key_mod *next;
+	};
+};
+
+#else
+struct static_key {
+	atomic_t enabled;
+};
+#endif	/* CONFIG_JUMP_LABEL */
+
+struct static_key_true {
+	struct static_key key;
+};
+
+struct static_key_false {
+	struct static_key key;
+};
+
+#define DECLARE_STATIC_KEY_TRUE(name)	\
+	extern struct static_key_true name
+
+#define DECLARE_STATIC_KEY_FALSE(name)	\
+	extern struct static_key_false name
+
+#endif /* _LINUX_JUMP_LABEL_TYPE_H */
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index c25b8e41c0ea..94238df64afc 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -14,6 +14,7 @@
 #include <linux/typecheck.h>
 #include <linux/printk.h>
 #include <linux/build_bug.h>
+#include <linux/jump_label_type.h>
 #include <asm/byteorder.h>
 #include <asm/div64.h>
 #include <uapi/linux/kernel.h>
@@ -192,11 +193,16 @@ struct completion;
 struct pt_regs;
 struct user;
 
+#ifndef CONFIG_PREEMPTION
 #ifdef CONFIG_PREEMPT_VOLUNTARY
-extern int _cond_resched(void);
-# define might_resched() _cond_resched()
+DECLARE_STATIC_KEY_TRUE(preempt_voluntary_key);
 #else
-# define might_resched() do { } while (0)
+DECLARE_STATIC_KEY_FALSE(preempt_voluntary_key);
+#endif
+
+extern int _cond_resched(void);
+# define might_resched() \
+	do { if (static_branch_likely(&preempt_voluntary_key)) _cond_resched(); } while (0)
 #endif
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d95dc3f4644..07d37d862637 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -43,6 +43,14 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
+#ifdef CONFIG_PREEMPT_VOLUNTARY
+DEFINE_STATIC_KEY_TRUE(preempt_voluntary_key);
+#else
+/* PREEMPT_NONE vs PREEMPT_VOLUNTARY */
+DEFINE_STATIC_KEY_FALSE(preempt_voluntary_key);
+#endif
+EXPORT_SYMBOL(preempt_voluntary_key);
+
 #if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_JUMP_LABEL)
 /*
  * Debugging: various feature bits
@@ -8482,3 +8490,25 @@ void call_trace_sched_update_nr_running(struct rq *rq, int count)
 {
         trace_sched_update_nr_running_tp(rq, count);
 }
+
+#ifndef CONFIG_PREEMPTION
+static int __init setup_non_preempt_mode(char *str)
+{
+	if (!strcmp(str, "none")) {
+		if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)) {
+			static_branch_disable(&preempt_voluntary_key);
+			pr_info("Switching to PREEMPT_NONE mode.");
+		}
+	} else if (!strcmp(str, "voluntary")) {
+		if (!IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)) {
+			static_branch_enable(&preempt_voluntary_key);
+			pr_info("Switching to PREEMPT_VOLUNTARY mode.");
+		}
+	} else {
+		pr_warn("Unsupported preempt mode %s\n", str);
+		return 1;
+	}
+	return 0;
+}
+__setup("preempt_mode=", setup_non_preempt_mode);
+#endif
-- 
2.28.0

