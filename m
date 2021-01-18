Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2127B2FA2BB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392802AbhAROPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:15:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:42560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392736AbhARON7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:13:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67C9F22CA1;
        Mon, 18 Jan 2021 14:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610979168;
        bh=maOE0t2qCzLXXJa98F60rxAWTjZbx3uDnfqiP1D+1ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HHTtHWWdAoXP2indwjIi65y5b0vSF9XU6CZyFyn0rUaFkdPBXGsFB8aVJlfwRfTWf
         m6TumGzwlbnNlljDGnGnicQSgaZOGn02ONgGG0mp2kAzPun+0WGNb2HM0tJO8gdwav
         X6KgV1K2DFTwp+HM+cX/eTEKlks58VZT6piZZvKYNCsLsqywQ4jj9OdnVY/mH0Q/n9
         C9n9TZwsQuE3bl/qciwCinr9bdwDw9N3PGSOtCq2tqeZVGDCpGE/TdAcG3vNf4UXde
         7cYt7bmMHtXtmVviMpuAHJ9mYqyfWaKHPsvMp2J3+Bxk64aeHqA1kTqhe30jWWMb/b
         msdSRe5kp4CBQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 8/8] preempt/dynamic: Support dynamic preempt with preempt= boot option
Date:   Mon, 18 Jan 2021 15:12:23 +0100
Message-Id: <20210118141223.123667-9-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118141223.123667-1-frederic@kernel.org>
References: <20210118141223.123667-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

Support the preempt= boot option and patch the static call sites
accordingly.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/core.c | 67 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index faff4b546c5f..509bd51f59aa 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -12,6 +12,7 @@
 
 #include "sched.h"
 
+#include <linux/entry-common.h>
 #include <linux/nospec.h>
 
 #include <linux/kcov.h>
@@ -5314,9 +5315,73 @@ DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func());
 EXPORT_STATIC_CALL(preempt_schedule_notrace);
 #endif
 
-
 #endif /* CONFIG_PREEMPTION */
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+
+/*
+ * SC:cond_resched
+ * SC:might_resched
+ * SC:preempt_schedule
+ * SC:preempt_schedule_notrace
+ * SC:irqentry_exit_cond_resched
+ *
+ *
+ * NONE:
+ *   cond_resched               <- __cond_resched
+ *   might_resched              <- RET0
+ *   preempt_schedule           <- NOP
+ *   preempt_schedule_notrace   <- NOP
+ *   irqentry_exit_cond_resched <- NOP
+ *
+ * VOLUNTARY:
+ *   cond_resched               <- __cond_resched
+ *   might_resched              <- __cond_resched
+ *   preempt_schedule           <- NOP
+ *   preempt_schedule_notrace   <- NOP
+ *   irqentry_exit_cond_resched <- NOP
+ *
+ * FULL:
+ *   cond_resched               <- RET0
+ *   might_resched              <- RET0
+ *   preempt_schedule           <- preempt_schedule
+ *   preempt_schedule_notrace   <- preempt_schedule_notrace
+ *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
+ */
+static int __init setup_preempt_mode(char *str)
+{
+	if (!strcmp(str, "none")) {
+		static_call_update(cond_resched, __cond_resched);
+		static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
+		static_call_update(preempt_schedule, (typeof(&preempt_schedule)) NULL);
+		static_call_update(preempt_schedule_notrace, (typeof(&preempt_schedule_notrace)) NULL);
+		static_call_update(irqentry_exit_cond_resched, (typeof(&irqentry_exit_cond_resched)) NULL);
+		pr_info("Dynamic Preempt: %s\n", str);
+	} else if (!strcmp(str, "voluntary")) {
+		static_call_update(cond_resched, __cond_resched);
+		static_call_update(might_resched, __cond_resched);
+		static_call_update(preempt_schedule, (typeof(&preempt_schedule)) NULL);
+		static_call_update(preempt_schedule_notrace, (typeof(&preempt_schedule_notrace)) NULL);
+		static_call_update(irqentry_exit_cond_resched, (typeof(&irqentry_exit_cond_resched)) NULL);
+		pr_info("Dynamic Preempt: %s\n", str);
+	} else if (!strcmp(str, "full")) {
+		static_call_update(cond_resched, (typeof(&__cond_resched)) __static_call_return0);
+		static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
+		static_call_update(preempt_schedule, __preempt_schedule_func());
+		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func());
+		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+		pr_info("Dynamic Preempt: %s\n", str);
+	} else {
+		pr_warn("Dynamic Preempt: Unsupported preempt mode %s, default to full\n", str);
+		return 1;
+	}
+	return 0;
+}
+__setup("preempt=", setup_preempt_mode);
+
+#endif /* CONFIG_PREEMPT_DYNAMIC */
+
+
 /*
  * This is the entry point to schedule() from kernel preemption
  * off of irq context.
-- 
2.25.1

