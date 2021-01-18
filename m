Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9DE2FA2AB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392829AbhAROPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:15:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:42562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392737AbhARON7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:13:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FD8022CA0;
        Mon, 18 Jan 2021 14:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610979166;
        bh=DPcFSuOJj5EPa3HsRHn5XhRjCMb0tvC8HxGOg34yolY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZGyDcz5nFUKwOx22mg51NAIXO4AJqIUY5rBtUBH3LiOD633XhJLAzjR4nPxArzu65
         59mhzVx7CVUm9xAlPd1MNMW1JuNkQVDNUoe0g3aVtcGLAl2KUEbTOD1O3DKXz6L/uo
         maF2auila/+SE66czTIPYpkcF1ENRt03jK1wkHpIOMVtLuj2poEaLyilyNxv5xKCUt
         n0pUgwQ/m1iio3HhKXYjTD/abvthkmKMvHQ2LIpW82R84xP6JOKeyQSfbAA0vWR2xU
         +1JSIP+Cb6Y2nvMyW/ICwqxG57ncdb2+h6tlSq3T3//jIkLG0AUo9XB2871XqiLvBR
         0XzXVk1TNZHmg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 7/8] preempt/dynamic: Provide irqentry_exit_cond_resched() static call
Date:   Mon, 18 Jan 2021 15:12:22 +0100
Message-Id: <20210118141223.123667-8-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118141223.123667-1-frederic@kernel.org>
References: <20210118141223.123667-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

Provide static call to control IRQ preemption (called in CONFIG_PREEMPT)
so that we can override its behaviour when preempt= is overriden.

Since the default behaviour is full preemption, its call is
initialized to provide IRQ preemption when preempt= isn't passed.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/entry-common.h |  4 ++++
 kernel/entry/common.c        | 10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index ca86a00abe86..1401c93b65e1 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_ENTRYCOMMON_H
 #define __LINUX_ENTRYCOMMON_H
 
+#include <linux/static_call_types.h>
 #include <linux/tracehook.h>
 #include <linux/syscalls.h>
 #include <linux/seccomp.h>
@@ -453,6 +454,9 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
  * Conditional reschedule with additional sanity checks.
  */
 void irqentry_exit_cond_resched(void);
+#ifdef CONFIG_PREEMPT_DYNAMIC
+DECLARE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+#endif
 
 /**
  * irqentry_exit - Handle return from exception that used irqentry_enter()
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 378341642f94..84fa7ec28c36 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -393,6 +393,9 @@ void irqentry_exit_cond_resched(void)
 			preempt_schedule_irq();
 	}
 }
+#ifdef CONFIG_PREEMPT_DYNAMIC
+DEFINE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+#endif
 
 noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 {
@@ -419,8 +422,13 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 		}
 
 		instrumentation_begin();
-		if (IS_ENABLED(CONFIG_PREEMPTION))
+		if (IS_ENABLED(CONFIG_PREEMPTION)) {
+#ifdef CONFIG_PREEMT_DYNAMIC
+			static_call(irqentry_exit_cond_resched)();
+#else
 			irqentry_exit_cond_resched();
+#endif
+		}
 		/* Covers both tracing and lockdep */
 		trace_hardirqs_on();
 		instrumentation_end();
-- 
2.25.1

