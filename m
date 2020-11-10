Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BAE2AC9EB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 01:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731376AbgKJA4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 19:56:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:54298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731317AbgKJA4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 19:56:33 -0500
Received: from localhost.localdomain (i15-lef02-th2-89-83-252-17.ft.lns.abo.bbox.fr [89.83.252.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C5F420789;
        Tue, 10 Nov 2020 00:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604969792;
        bh=bkWGjH6pmu6qNd1cz3G94jM4rNCum7bCTq/FQXNpETc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i7Oq5M5G9rfMBQt3y+yerucUQGko00d2c2NnQQBmIt3mjkYvI4jeTnkP50AeDtY7S
         f1LrxJ/3Cqmx18jLR+SsPF0llYQ4XYMBlOjRv7QVMjalgbshToM81Vszk4/LzNLzbQ
         B0VMpZ0KJ6qEaxSD9i+VR8cb3DgBDvF2iz5ikrpU=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 6/7] preempt/dynamic: Provide irqentry_exit_cond_resched() static call
Date:   Tue, 10 Nov 2020 01:56:08 +0100
Message-Id: <20201110005609.40989-7-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110005609.40989-1-frederic@kernel.org>
References: <20201110005609.40989-1-frederic@kernel.org>
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
[convert from static key to static call, only define static call when
PREEMPT_DYNAMIC]
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/entry-common.h |  4 ++++
 kernel/entry/common.c        | 10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 474f29638d2c..36738f67f6ad 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_ENTRYCOMMON_H
 #define __LINUX_ENTRYCOMMON_H
 
+#include <linux/static_call_types.h>
 #include <linux/tracehook.h>
 #include <linux/syscalls.h>
 #include <linux/seccomp.h>
@@ -385,6 +386,9 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
  * Conditional reschedule with additional sanity checks.
  */
 void irqentry_exit_cond_resched(void);
+#ifdef CONFIG_PREEMPT_DYNAMIC
+DECLARE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+#endif
 
 /**
  * irqentry_exit - Handle return from exception that used irqentry_enter()
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 2b8366693d5c..c501c951f8bc 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -357,6 +357,9 @@ void irqentry_exit_cond_resched(void)
 			preempt_schedule_irq();
 	}
 }
+#ifdef CONFIG_PREEMPT_DYNAMIC
+DEFINE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+#endif
 
 noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 {
@@ -383,8 +386,13 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
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

