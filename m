Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B672B1D28
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgKMOYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:24:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52544 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgKMOY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:24:28 -0500
Message-Id: <20201113141733.864469886@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605277466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nizsG88oO/X3MAUujrJwkAWDoWXjRvd/hu62TCrMv00=;
        b=MgbURSwOdt2u2AfAXuvt5e3xI+wad7mH9+9w+LH8RtRgcvyiuie/7z3Ircx4qNNKtyXNxN
        n/qTUFL91x5E4rqamZQEE6AwvSWsBlClV89x7y5/02KhBULAPFYoxOqqgJaeAUoAuY9OV2
        ILnN2zBb5V4sCj91YMROOwHtddlh/gcxyp6g5IUS0Im7gU79gdvprs3rL8QhGARB/G64ot
        qMr1gQ9jLMyp2aUmt1nAAHReLBbqwKkiOjB1kJ3i5n/+bMDBAJFy4DazZM9tpYBsn72mMC
        5pIZSXRya7s/NB9Rmvl2uZ4Ga6Vrl3ooi24lEOubx3YblZfMP84/7fqdt+6VCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605277466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nizsG88oO/X3MAUujrJwkAWDoWXjRvd/hu62TCrMv00=;
        b=U31sNj/t2lOnt0NAoJOjrAxdod3h1s384ukHOPLY/KJc+CvGOTBvXvkWlC460hGxUiLJaZ
        vD3C6rVE+MxoNCDQ==
Date:   Fri, 13 Nov 2020 15:02:17 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [patch 10/19] preempt: Cleanup the macro maze a bit
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the macro maze consistent and prepare it for adding the RT variant for
BH accounting.

 - Use nmi_count() for the NMI portion of preempt count
 - Introduce in_hardirq() to make the naming consistent and non-ambiguos
 - Use the macros to create combined checks (e.g. in_task()) so the
   softirq representation for RT just falls into place.
 - Update comments and move the deprecated macros aside

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/preempt.h |   30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -77,31 +77,33 @@
 /* preempt_count() and related functions, depends on PREEMPT_NEED_RESCHED */
 #include <asm/preempt.h>
 
+#define nmi_count()	(preempt_count() & NMI_MASK)
 #define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
 #define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
-#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK \
-				 | NMI_MASK))
+#define irq_count()	(nmi_count() | hardirq_count() | softirq_count())
 
 /*
- * Are we doing bottom half or hardware interrupt processing?
+ * Macros to retrieve the current execution context:
  *
- * in_irq()       - We're in (hard) IRQ context
+ * in_nmi()		- We're in NMI context
+ * in_hardirq()		- We're in hard IRQ context
+ * in_serving_softirq()	- We're in softirq context
+ * in_task()		- We're in task context
+ */
+#define in_nmi()		(nmi_count())
+#define in_hardirq()		(hardirq_count())
+#define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
+#define in_task()		(!(in_nmi() | in_hardirq() | in_serving_softirq()))
+
+/*
+ * The following macros are deprecated and should not be used in new code:
+ * in_irq()       - Obsolete version of in_hardirq()
  * in_softirq()   - We have BH disabled, or are processing softirqs
  * in_interrupt() - We're in NMI,IRQ,SoftIRQ context or have BH disabled
- * in_serving_softirq() - We're in softirq context
- * in_nmi()       - We're in NMI context
- * in_task()	  - We're in task context
- *
- * Note: due to the BH disabled confusion: in_softirq(),in_interrupt() really
- *       should not be used in new code.
  */
 #define in_irq()		(hardirq_count())
 #define in_softirq()		(softirq_count())
 #define in_interrupt()		(irq_count())
-#define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
-#define in_nmi()		(preempt_count() & NMI_MASK)
-#define in_task()		(!(preempt_count() & \
-				   (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
 
 /*
  * The preempt_count offset after preempt_disable();

