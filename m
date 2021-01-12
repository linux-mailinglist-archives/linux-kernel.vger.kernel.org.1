Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF622F3275
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388824AbhALOAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:00:51 -0500
Received: from foss.arm.com ([217.140.110.172]:46934 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbhALOAt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:00:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14CCB12FC;
        Tue, 12 Jan 2021 06:00:04 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2FD6A3F66E;
        Tue, 12 Jan 2021 06:00:03 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, maz@kernel.org, paulmck@kernel.org,
        peterz@infradead.org, tglx@linutronix.de
Subject: [PATCH 2/2] irq: detect long-running IRQ handlers
Date:   Tue, 12 Jan 2021 13:59:50 +0000
Message-Id: <20210112135950.30607-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210112135950.30607-1-mark.rutland@arm.com>
References: <20210112135950.30607-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a hard IRQ handler takes a long time to handle an IRQ, it may cause a
soft lockup or RCU stall, but as this will be detected once the handler
has returned it can be difficult to attribute the delay to the specific
IRQ handler.

It's possible to trace IRQ handlers to diagnose this, but that's not a
great fit for automated testing environments (e.g. fuzzers), where
something like the existing lockup/stall detectors works well.

This patch adds a new stall detector for IRQ handlers, which reports
when handlers took longer than a given timeout value (defaulting to 1
second). This won't detect hung IRQ handlers (which requires an NMI, and
should already be caught by hung task detection on systems with NMIs),
but helps on platforms without NMI or where a periodic watchdog is
undesireable.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/internals.h | 35 ++++++++++++++++++++++++++++++++---
 lib/Kconfig.debug      | 15 +++++++++++++++
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 70a4694cc891..191b6a9d30e2 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -6,6 +6,7 @@
  * kernel/irq/. Do not even think about using any information outside
  * of this file for your non core code.
  */
+#include <linux/bug.h>
 #include <linux/irqdesc.h>
 #include <linux/kernel_stat.h>
 #include <linux/pm_runtime.h>
@@ -122,17 +123,45 @@ static inline irqreturn_t __handle_irqaction(unsigned int irq,
 	return res;
 }
 
+#ifdef CONFIG_DETECT_SLOW_IRQ_HANDLER
+static inline irqreturn_t __handle_check_irqaction(unsigned int irq,
+						   struct irqaction *action,
+						   void *dev_id)
+{
+	u64 timeout = CONFIG_IRQ_HANDLER_TIMEOUT_NS;
+	u64 start, end, duration;
+	int res;
+
+	start = local_clock();
+	res = __handle_irqaction(irq, action, dev_id);
+	end = local_clock();
+
+	duration = end - start;
+	WARN(duration > timeout, "IRQ %d handler %ps took %llu ns\n",
+	     irq, action->handler, duration);
+
+	return res;
+}
+#else
+static inline irqreturn_t __handle_check_irqaction(unsigned int irq,
+						   struct irqaction *action,
+						   void *dev_id)
+{
+	return __handle_irqaction(irq, action, dev_id);
+}
+#endif
+
 static inline irqreturn_t handle_irqaction(unsigned int irq,
 					   struct irqaction *action)
 {
-	return __handle_irqaction(irq, action, action->dev_id);
+	return __handle_check_irqaction(irq, action, action->dev_id);
 }
 
 static inline irqreturn_t handle_irqaction_percpu_devid(unsigned int irq,
 							struct irqaction *action)
 {
-	return __handle_irqaction(irq, action,
-				  raw_cpu_ptr(action->percpu_dev_id));
+	return __handle_check_irqaction(irq, action,
+					raw_cpu_ptr(action->percpu_dev_id));
 }
 
 /* Resending of interrupts :*/
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5ea0c1773b0a..ea5289518dd6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1097,6 +1097,21 @@ config WQ_WATCHDOG
 	  state.  This can be configured through kernel parameter
 	  "workqueue.watchdog_thresh" and its sysfs counterpart.
 
+config DETECT_SLOW_IRQ_HANDLER
+	bool "Detect long-running IRQ handlers"
+	help
+	  Say Y here to enable detection of long-running IRQ handlers. When a
+	  (hard) IRQ handler returns after a given timeout value (1s by
+	  default) a warning will be printed with the name of the handler.
+
+	  This can help to identify specific IRQ handlers which are
+	  contributing to stalls.
+
+config IRQ_HANDLER_TIMEOUT_NS
+	int "Timeout for long-running IRQ handlers (in nanoseconds)"
+	depends on DETECT_SLOW_IRQ_HANDLER
+	default 1000000000
+
 config TEST_LOCKUP
 	tristate "Test module to generate lockups"
 	depends on m
-- 
2.11.0

