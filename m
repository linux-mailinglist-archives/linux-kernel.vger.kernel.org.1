Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60E02A1E3D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 14:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgKANOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 08:14:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:57108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbgKANOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 08:14:41 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C6912158C;
        Sun,  1 Nov 2020 13:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604236480;
        bh=0Q0TyWyxmTzOkgODkUAvpvR4auOZp81vUdIbLC17N/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ofP7EqQnjQbpnpvjaL47h852YemIWNClTuCh67g1BlfRqaiq+GRqOzo9xBXAxRs5J
         A0Ty3JMFDk5Qnj8NrFAKcXsLz/aqHm7rCLyUXCfiuj/cfZbCwQkLI+nJuk3HZXyEk4
         Tmw/i1gonbWtGqjktdanhMLHb7vfMhLTc6WcL0OQ=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kZDBu-006QYT-QK; Sun, 01 Nov 2020 13:14:38 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: [PATCH 1/2] genirq: Allow an interrupt to be marked as 'naked'
Date:   Sun,  1 Nov 2020 13:14:29 +0000
Message-Id: <20201101131430.257038-2-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201101131430.257038-1-maz@kernel.org>
References: <20201101131430.257038-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, tglx@linutronix.de, Valentin.Schneider@arm.com, peterz@infradead.org, kernel-team@android.com
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
thing on normal interrupts.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irq.h   |  4 +++-
 kernel/irq/debugfs.c  |  1 +
 kernel/irq/irqdesc.c  | 17 ++++++++++++-----
 kernel/irq/settings.h |  7 +++++++
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index c54365309e97..af5ba7336925 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -72,6 +72,7 @@ enum irqchip_irq_state;
  *				  mechanism and from core side polling.
  * IRQ_DISABLE_UNLAZY		- Disable lazy irq disable
  * IRQ_HIDDEN			- Don't show up in /proc/interrupts
+ * IRQ_NAKED			- Bypass irq_enter()/irq_exit()
  */
 enum {
 	IRQ_TYPE_NONE		= 0x00000000,
@@ -99,13 +100,14 @@ enum {
 	IRQ_IS_POLLED		= (1 << 18),
 	IRQ_DISABLE_UNLAZY	= (1 << 19),
 	IRQ_HIDDEN		= (1 << 20),
+	IRQ_NAKED		= (1 << 21),
 };
 
 #define IRQF_MODIFY_MASK	\
 	(IRQ_TYPE_SENSE_MASK | IRQ_NOPROBE | IRQ_NOREQUEST | \
 	 IRQ_NOAUTOEN | IRQ_MOVE_PCNTXT | IRQ_LEVEL | IRQ_NO_BALANCING | \
 	 IRQ_PER_CPU | IRQ_NESTED_THREAD | IRQ_NOTHREAD | IRQ_PER_CPU_DEVID | \
-	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY | IRQ_HIDDEN)
+	 IRQ_IS_POLLED | IRQ_DISABLE_UNLAZY | IRQ_HIDDEN | IRQ_NAKED)
 
 #define IRQ_NO_BALANCING_MASK	(IRQ_PER_CPU | IRQ_NO_BALANCING)
 
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index e4cff358b437..e031d6afc0f8 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -140,6 +140,7 @@ static const struct irq_bit_descr irqdesc_states[] = {
 	BIT_MASK_DESCR(_IRQ_IS_POLLED),
 	BIT_MASK_DESCR(_IRQ_DISABLE_UNLAZY),
 	BIT_MASK_DESCR(_IRQ_HIDDEN),
+	BIT_MASK_DESCR(_IRQ_NAKED),
 };
 
 static const struct irq_bit_descr irqdesc_istates[] = {
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 1a7723604399..c08a1c19d061 100644
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
+	desc = irq_to_desc(irq);
+	if (unlikely(!desc || irq >= nr_irqs)) {
 		ack_bad_irq(irq);
 		ret = -EINVAL;
+		goto out;
+	}
+
+	if (unlikely(irq_settings_is_naked(desc))) {
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
index 403378b9947b..587e67f9c302 100644
--- a/kernel/irq/settings.h
+++ b/kernel/irq/settings.h
@@ -18,6 +18,7 @@ enum {
 	_IRQ_IS_POLLED		= IRQ_IS_POLLED,
 	_IRQ_DISABLE_UNLAZY	= IRQ_DISABLE_UNLAZY,
 	_IRQ_HIDDEN		= IRQ_HIDDEN,
+	_IRQ_NAKED		= IRQ_NAKED,
 	_IRQF_MODIFY_MASK	= IRQF_MODIFY_MASK,
 };
 
@@ -33,6 +34,7 @@ enum {
 #define IRQ_IS_POLLED		GOT_YOU_MORON
 #define IRQ_DISABLE_UNLAZY	GOT_YOU_MORON
 #define IRQ_HIDDEN		GOT_YOU_MORON
+#define IRQ_NAKED		GOT_YOU_MORON
 #undef IRQF_MODIFY_MASK
 #define IRQF_MODIFY_MASK	GOT_YOU_MORON
 
@@ -174,3 +176,8 @@ static inline bool irq_settings_is_hidden(struct irq_desc *desc)
 {
 	return desc->status_use_accessors & _IRQ_HIDDEN;
 }
+
+static inline bool irq_settings_is_naked(struct irq_desc *desc)
+{
+	return desc->status_use_accessors & _IRQ_NAKED;
+}
-- 
2.28.0

