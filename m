Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD412888B5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbgJIMaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:30:13 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35975 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733112AbgJIMaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:30:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id l16so9159297eds.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 05:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mBfX44CRJdkX6tvy4nvPEnsRR4SoSTydTkcYzNIFk7Q=;
        b=JaBCFwHNvQePlIZnCkUQfncOW9Q4L8pm0RnPExldiYyT3BHvMkKROPTabpB+UmmXrh
         8sqMWUAybC0e1UaOOZwN3zu46rN9jfyzhh0t4d1n3S4UJjTb4u+8PSiYiw5iho1oG4qI
         s3rn02O+TuX0lnQpraRwxud/OqlrIstRJyzLNQebvfj8uuLz5d5p72wyl2T3NLQ0OQw4
         e3iittyufCcODhITLPqwDmiIbD3RXbBYD9ka2LKAZK43Qzv2w3Ac6hn85W4+cC9z5gGz
         4RZFMQGSxCWPLwO+r+zihZC62/WXMHcGfdaHrUHQajo3IdAgmqK8F3V6VyJKOdDJ6Ccw
         439g==
X-Gm-Message-State: AOAM533E4vOCL0U6/OZGA7cyS/agHEE34SQH8D8GWEr81ieuLHZg6d+p
        n+9ph3JJNKkyBYGT50DirXs=
X-Google-Smtp-Source: ABdhPJyXEtZ6axheBCxNqjB+GOBhfQAJIhdTg07Qc95gSMq2SzGKMkavx1bY+U/kudv7pbCTu98JZw==
X-Received: by 2002:a05:6402:21e9:: with SMTP id ce9mr14545321edb.125.1602246598294;
        Fri, 09 Oct 2020 05:29:58 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-85-160-42-169.eurotel.cz. [85.160.42.169])
        by smtp.gmail.com with ESMTPSA id q27sm6412701ejd.74.2020.10.09.05.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 05:29:57 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH v2 2/5] kernel: allow to configure PREEMPT_NONE, PREEMPT_VOLUNTARY on kernel command line
Date:   Fri,  9 Oct 2020 14:29:23 +0200
Message-Id: <20201009122926.29962-3-mhocko@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201009122926.29962-1-mhocko@kernel.org>
References: <20201007120401.11200-1-mhocko@kernel.org>
 <20201009122926.29962-1-mhocko@kernel.org>
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

Add an explicit include of jump_label to gpio/consumer.h to make sure
all its consumers will get static_branch_likely) as kernel.h cannot
include it directly.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 ++++
 include/linux/gpio/consumer.h                 |  1 +
 include/linux/kernel.h                        | 13 ++++++--
 kernel/sched/core.c                           | 30 +++++++++++++++++++
 4 files changed, 47 insertions(+), 2 deletions(-)

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
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index c25b8e41c0ea..d2d37bd5ecd5 100644
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
@@ -192,11 +193,19 @@ struct completion;
 struct pt_regs;
 struct user;
 
+#ifndef CONFIG_PREEMPTION
 #ifdef CONFIG_PREEMPT_VOLUNTARY
+DECLARE_STATIC_KEY_TRUE(preempt_voluntary_key);
+#else
+DECLARE_STATIC_KEY_FALSE(preempt_voluntary_key);
+#endif
+
 extern int _cond_resched(void);
-# define might_resched() _cond_resched()
+# define might_resched() \
+	do { if (static_branch_likely(&preempt_voluntary_key)) _cond_resched(); } while (0)
 #else
-# define might_resched() do { } while (0)
+# define might_resched() \
+	do { } while (0)
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

