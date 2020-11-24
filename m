Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3BC2C2930
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388716AbgKXOPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:15:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:49908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbgKXOO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:14:58 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CABD82083E;
        Tue, 24 Nov 2020 14:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606227297;
        bh=enfZjxQRfmwzAt9rTt0EM0f2Ef5i7mBRCVbttaT5h34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qr9RDw53iJk0TC/b/Ar6GGahhPJ4hbpob0ITh/fE7tJdtoZJFuZx2LvlHQ9mRgoJb
         l9EI9j/UpbTlYGmHO6NxUu2xR36xmtgQBANd0ITryILGL73sU8NqehBPBFPVFpPuGm
         ba29rsH6FVPVKbKbZfnob73EPQJMbTjLdcRX0uCE=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1khZ5q-00DGcy-T3; Tue, 24 Nov 2020 14:14:55 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>
Subject: [PATCH v2 2/6] genirq: Allow an interrupt to be marked as 'raw'
Date:   Tue, 24 Nov 2020 14:14:45 +0000
Message-Id: <20201124141449.572446-3-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201124141449.572446-1-maz@kernel.org>
References: <20201124141449.572446-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, tglx@linutronix.de, Valentin.Schneider@arm.com, peterz@infradead.org, mark.rutland@arm.com, linux@arm.linux.org.uk, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some interrupts (such as the rescheduling IPI) rely on not going through
the irq_enter()/irq_exit() calls. To distinguish such interrupts, add
a new IRQ flag that allows the low-level handling code to sidestep the
enter()/exit() calls.

Only the architecture code is expected to use this. It will do the wrong
thing on normal interrupts. Note that this is a band-aid until we can
move to some more correct infrastructure (such as kernel/entry/common.c).

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irq.h   |  2 ++
 kernel/irq/Kconfig    |  3 +++
 kernel/irq/debugfs.c  |  1 +
 kernel/irq/irqdesc.c  | 17 ++++++++++++-----
 kernel/irq/settings.h | 15 +++++++++++++++
 5 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index c55f218d5b61..605ba5949255 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -72,6 +72,7 @@ enum irqchip_irq_state;
  *				  mechanism and from core side polling.
  * IRQ_DISABLE_UNLAZY		- Disable lazy irq disable
  * IRQ_HIDDEN			- Don't show up in /proc/interrupts
+ * IRQ_RAW			- Skip tick management and irqtime accounting
  */
 enum {
 	IRQ_TYPE_NONE		= 0x00000000,
@@ -99,6 +100,7 @@ enum {
 	IRQ_IS_POLLED		= (1 << 18),
 	IRQ_DISABLE_UNLAZY	= (1 << 19),
 	IRQ_HIDDEN		= (1 << 20),
+	IRQ_RAW			= (1 << 21),
 };
 
 #define IRQF_MODIFY_MASK	\
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 164a031cfdb6..ae9b13d5ee91 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -109,6 +109,9 @@ config GENERIC_IRQ_MATRIX_ALLOCATOR
 config GENERIC_IRQ_RESERVATION_MODE
 	bool
 
+config ARCH_WANTS_IRQ_RAW
+	bool
+
 # Support forced irq threading
 config IRQ_FORCED_THREADING
        bool
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index e4cff358b437..f53475d88072 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -140,6 +140,7 @@ static const struct irq_bit_descr irqdesc_states[] = {
 	BIT_MASK_DESCR(_IRQ_IS_POLLED),
 	BIT_MASK_DESCR(_IRQ_DISABLE_UNLAZY),
 	BIT_MASK_DESCR(_IRQ_HIDDEN),
+	BIT_MASK_DESCR(_IRQ_RAW),
 };
 
 static const struct irq_bit_descr irqdesc_istates[] = {
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 1a7723604399..f5beee546a6f 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -667,10 +667,9 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	unsigned int irq = hwirq;
+	struct irq_desc *desc;
 	int ret = 0;
 
-	irq_enter();
-
 #ifdef CONFIG_IRQ_DOMAIN
 	if (lookup)
 		irq = irq_find_mapping(domain, hwirq);
@@ -680,14 +679,22 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
 	 * Some hardware gives randomly wrong interrupts.  Rather
 	 * than crashing, do something sensible.
 	 */
-	if (unlikely(!irq || irq >= nr_irqs)) {
+	if (unlikely(!irq || irq >= nr_irqs || !(desc = irq_to_desc(irq)))) {
 		ack_bad_irq(irq);
 		ret = -EINVAL;
+		goto out;
+	}
+
+	if (IS_ENABLED(CONFIG_ARCH_WANTS_IRQ_RAW) &&
+	    unlikely(irq_settings_is_raw(desc))) {
+		generic_handle_irq_desc(desc);
 	} else {
-		generic_handle_irq(irq);
+		irq_enter();
+		generic_handle_irq_desc(desc);
+		irq_exit();
 	}
 
-	irq_exit();
+out:
 	set_irq_regs(old_regs);
 	return ret;
 }
diff --git a/kernel/irq/settings.h b/kernel/irq/settings.h
index 51acdf43eadc..0033d459fdac 100644
--- a/kernel/irq/settings.h
+++ b/kernel/irq/settings.h
@@ -18,6 +18,7 @@ enum {
 	_IRQ_IS_POLLED		= IRQ_IS_POLLED,
 	_IRQ_DISABLE_UNLAZY	= IRQ_DISABLE_UNLAZY,
 	_IRQ_HIDDEN		= IRQ_HIDDEN,
+	_IRQ_RAW		= IRQ_RAW,
 	_IRQF_MODIFY_MASK	= IRQF_MODIFY_MASK,
 };
 
@@ -33,6 +34,7 @@ enum {
 #define IRQ_IS_POLLED		GOT_YOU_MORON
 #define IRQ_DISABLE_UNLAZY	GOT_YOU_MORON
 #define IRQ_HIDDEN		GOT_YOU_MORON
+#define IRQ_RAW			GOT_YOU_MORON
 #undef IRQF_MODIFY_MASK
 #define IRQF_MODIFY_MASK	GOT_YOU_MORON
 
@@ -180,3 +182,16 @@ static inline bool irq_settings_is_hidden(struct irq_desc *desc)
 {
 	return desc->status_use_accessors & _IRQ_HIDDEN;
 }
+
+static inline bool irq_settings_is_raw(struct irq_desc *desc)
+{
+	if (IS_ENABLED(CONFIG_ARCH_WANTS_IRQ_RAW))
+		return desc->status_use_accessors & _IRQ_RAW;
+
+	/*
+	 * Using IRQ_RAW on architectures that don't expect it is
+	 * likely to be wrong.
+	 */
+	WARN_ON_ONCE(1);
+	return false;
+}
-- 
2.28.0

