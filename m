Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3510F1AB122
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 21:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387583AbgDOTGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 15:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416809AbgDOSeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:34:14 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 197A320771;
        Wed, 15 Apr 2020 18:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586975653;
        bh=MTokGZDzIGGhXc8vlKSJ3HxBIYpNzS6zJBjPY0lqXtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h9oCWi+WFK7hI0yXZreTarqRbM7Vi3m8ZqZawX0m432VFCZFC28XnBSjLXgpE8QWq
         Ps7bH2zXrjzClqGpLWQRyGKza4RKTLJB85MbgzIp3JLm+YuazhBOY4lF8gqtpJud3T
         DgTx4Ba2P2M6qC9S4wTLnmebnyg0O/RAEI2uKb5Q=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 01/15] kcsan: Add option to allow watcher interruptions
Date:   Wed, 15 Apr 2020 11:33:57 -0700
Message-Id: <20200415183411.12368-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415183343.GA12265@paulmck-ThinkPad-P72>
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Add option to allow interrupts while a watchpoint is set up. This can be
enabled either via CONFIG_KCSAN_INTERRUPT_WATCHER or via the boot
parameter 'kcsan.interrupt_watcher=1'.

Note that, currently not all safe per-CPU access primitives and patterns
are accounted for, which could result in false positives. For example,
asm-generic/percpu.h uses plain operations, which by default are
instrumented. On interrupts and subsequent accesses to the same
variable, KCSAN would currently report a data race with this option.

Therefore, this option should currently remain disabled by default, but
may be enabled for specific test scenarios.

To avoid new warnings, changes all uses of smp_processor_id() to use the
raw version (as already done in kcsan_found_watchpoint()). The exact SMP
processor id is for informational purposes in the report, and
correctness is not affected.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c | 34 ++++++++++------------------------
 lib/Kconfig.kcsan   | 11 +++++++++++
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 589b1e7..e7387fe 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -21,6 +21,7 @@ static bool kcsan_early_enable = IS_ENABLED(CONFIG_KCSAN_EARLY_ENABLE);
 static unsigned int kcsan_udelay_task = CONFIG_KCSAN_UDELAY_TASK;
 static unsigned int kcsan_udelay_interrupt = CONFIG_KCSAN_UDELAY_INTERRUPT;
 static long kcsan_skip_watch = CONFIG_KCSAN_SKIP_WATCH;
+static bool kcsan_interrupt_watcher = IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER);
 
 #ifdef MODULE_PARAM_PREFIX
 #undef MODULE_PARAM_PREFIX
@@ -30,6 +31,7 @@ module_param_named(early_enable, kcsan_early_enable, bool, 0);
 module_param_named(udelay_task, kcsan_udelay_task, uint, 0644);
 module_param_named(udelay_interrupt, kcsan_udelay_interrupt, uint, 0644);
 module_param_named(skip_watch, kcsan_skip_watch, long, 0644);
+module_param_named(interrupt_watcher, kcsan_interrupt_watcher, bool, 0444);
 
 bool kcsan_enabled;
 
@@ -354,7 +356,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	unsigned long access_mask;
 	enum kcsan_value_change value_change = KCSAN_VALUE_CHANGE_MAYBE;
 	unsigned long ua_flags = user_access_save();
-	unsigned long irq_flags;
+	unsigned long irq_flags = 0;
 
 	/*
 	 * Always reset kcsan_skip counter in slow-path to avoid underflow; see
@@ -370,26 +372,9 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		goto out;
 	}
 
-	/*
-	 * Disable interrupts & preemptions to avoid another thread on the same
-	 * CPU accessing memory locations for the set up watchpoint; this is to
-	 * avoid reporting races to e.g. CPU-local data.
-	 *
-	 * An alternative would be adding the source CPU to the watchpoint
-	 * encoding, and checking that watchpoint-CPU != this-CPU. There are
-	 * several problems with this:
-	 *   1. we should avoid stealing more bits from the watchpoint encoding
-	 *      as it would affect accuracy, as well as increase performance
-	 *      overhead in the fast-path;
-	 *   2. if we are preempted, but there *is* a genuine data race, we
-	 *      would *not* report it -- since this is the common case (vs.
-	 *      CPU-local data accesses), it makes more sense (from a data race
-	 *      detection point of view) to simply disable preemptions to ensure
-	 *      as many tasks as possible run on other CPUs.
-	 *
-	 * Use raw versions, to avoid lockdep recursion via IRQ flags tracing.
-	 */
-	raw_local_irq_save(irq_flags);
+	if (!kcsan_interrupt_watcher)
+		/* Use raw to avoid lockdep recursion via IRQ flags tracing. */
+		raw_local_irq_save(irq_flags);
 
 	watchpoint = insert_watchpoint((unsigned long)ptr, size, is_write);
 	if (watchpoint == NULL) {
@@ -507,7 +492,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		if (is_assert && value_change == KCSAN_VALUE_CHANGE_TRUE)
 			kcsan_counter_inc(KCSAN_COUNTER_ASSERT_FAILURES);
 
-		kcsan_report(ptr, size, type, value_change, smp_processor_id(),
+		kcsan_report(ptr, size, type, value_change, raw_smp_processor_id(),
 			     KCSAN_REPORT_RACE_SIGNAL);
 	} else if (value_change == KCSAN_VALUE_CHANGE_TRUE) {
 		/* Inferring a race, since the value should not have changed. */
@@ -518,13 +503,14 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 
 		if (IS_ENABLED(CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN) || is_assert)
 			kcsan_report(ptr, size, type, KCSAN_VALUE_CHANGE_TRUE,
-				     smp_processor_id(),
+				     raw_smp_processor_id(),
 				     KCSAN_REPORT_RACE_UNKNOWN_ORIGIN);
 	}
 
 	kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
 out_unlock:
-	raw_local_irq_restore(irq_flags);
+	if (!kcsan_interrupt_watcher)
+		raw_local_irq_restore(irq_flags);
 out:
 	user_access_restore(ua_flags);
 }
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index f0b7911..081ed2e 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -88,6 +88,17 @@ config KCSAN_SKIP_WATCH_RANDOMIZE
 	  KCSAN_WATCH_SKIP. If false, the chosen value is always
 	  KCSAN_WATCH_SKIP.
 
+config KCSAN_INTERRUPT_WATCHER
+	bool "Interruptible watchers"
+	help
+	  If enabled, a task that set up a watchpoint may be interrupted while
+	  delayed. This option will allow KCSAN to detect races between
+	  interrupted tasks and other threads of execution on the same CPU.
+
+	  Currently disabled by default, because not all safe per-CPU access
+	  primitives and patterns may be accounted for, and therefore could
+	  result in false positives.
+
 config KCSAN_REPORT_ONCE_IN_MS
 	int "Duration in milliseconds, in which any given race is only reported once"
 	default 3000
-- 
2.9.5

