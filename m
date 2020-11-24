Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4AE2C292B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388648AbgKXOO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:14:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:49882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730869AbgKXOO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:14:57 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 113482076B;
        Tue, 24 Nov 2020 14:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606227296;
        bh=+rG5SNZYbcFtY3MLFgwny2sPTFB4xCGZc4NSf/NRIs8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z7J/st1fc+p1OP01zR/e3032fDqvIEza2mRMm48l53Ioub2V0xS8uMJW9nVdOs1Px
         S6nDQnhXASLpFyLmBA6W4cCIAO6sjvR35gyF5HrFeL5xR2v/BXkgGWqKSWp3GheqMo
         ZjR2Ht0aNnR4iy75x3k/N29WiKYTHeSiNHjmdzT8=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1khZ5q-00DGcy-6t; Tue, 24 Nov 2020 14:14:54 +0000
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
Subject: [PATCH v2 1/6] genirq: Add __irq_modify_status() helper to clear/set special flags
Date:   Tue, 24 Nov 2020 14:14:44 +0000
Message-Id: <20201124141449.572446-2-maz@kernel.org>
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

Some arch-specific flags need to be set/cleared, but not exposed to
random device drivers. Introduce a new helper (__irq_modify_status())
that takes an arbitrary mask, and rewrite irq_modify_status() to use
this new helper.

No functionnal change.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irq.h   |  3 +++
 kernel/irq/chip.c     | 12 ++++++++++--
 kernel/irq/settings.h | 10 ++++++++--
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index c54365309e97..c55f218d5b61 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -751,6 +751,9 @@ void
 irq_set_chained_handler_and_data(unsigned int irq, irq_flow_handler_t handle,
 				 void *data);
 
+void __irq_modify_status(unsigned int irq, unsigned long clr,
+			 unsigned long set, unsigned long mask);
+
 void irq_modify_status(unsigned int irq, unsigned long clr, unsigned long set);
 
 static inline void irq_set_status_flags(unsigned int irq, unsigned long set)
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index b9b9618e1aca..85176712a484 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1107,7 +1107,8 @@ irq_set_chip_and_handler_name(unsigned int irq, struct irq_chip *chip,
 }
 EXPORT_SYMBOL_GPL(irq_set_chip_and_handler_name);
 
-void irq_modify_status(unsigned int irq, unsigned long clr, unsigned long set)
+void __irq_modify_status(unsigned int irq, unsigned long clr,
+			 unsigned long set, unsigned long mask)
 {
 	unsigned long flags, trigger, tmp;
 	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
@@ -1121,7 +1122,9 @@ void irq_modify_status(unsigned int irq, unsigned long clr, unsigned long set)
 	 */
 	WARN_ON_ONCE(!desc->depth && (set & _IRQ_NOAUTOEN));
 
-	irq_settings_clr_and_set(desc, clr, set);
+	/* Warn when trying to clear or set a bit disallowed by the mask */
+	WARN_ON((clr | set) & ~mask);
+	__irq_settings_clr_and_set(desc, clr, set, mask);
 
 	trigger = irqd_get_trigger_type(&desc->irq_data);
 
@@ -1144,6 +1147,11 @@ void irq_modify_status(unsigned int irq, unsigned long clr, unsigned long set)
 
 	irq_put_desc_unlock(desc, flags);
 }
+
+void irq_modify_status(unsigned int irq, unsigned long clr, unsigned long set)
+{
+	__irq_modify_status(irq, clr, set, _IRQF_MODIFY_MASK);
+}
 EXPORT_SYMBOL_GPL(irq_modify_status);
 
 /**
diff --git a/kernel/irq/settings.h b/kernel/irq/settings.h
index 403378b9947b..51acdf43eadc 100644
--- a/kernel/irq/settings.h
+++ b/kernel/irq/settings.h
@@ -36,11 +36,17 @@ enum {
 #undef IRQF_MODIFY_MASK
 #define IRQF_MODIFY_MASK	GOT_YOU_MORON
 
+static inline void
+__irq_settings_clr_and_set(struct irq_desc *desc, u32 clr, u32 set, u32 mask)
+{
+	desc->status_use_accessors &= ~(clr & mask);
+	desc->status_use_accessors |= (set & mask);
+}
+
 static inline void
 irq_settings_clr_and_set(struct irq_desc *desc, u32 clr, u32 set)
 {
-	desc->status_use_accessors &= ~(clr & _IRQF_MODIFY_MASK);
-	desc->status_use_accessors |= (set & _IRQF_MODIFY_MASK);
+	__irq_settings_clr_and_set(desc, clr, set, _IRQF_MODIFY_MASK);
 }
 
 static inline bool irq_settings_is_per_cpu(struct irq_desc *desc)
-- 
2.28.0

