Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2EB2C292E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388703AbgKXOPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:15:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:50076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388662AbgKXOPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:15:01 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32D962087D;
        Tue, 24 Nov 2020 14:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606227300;
        bh=KDb8p/armZtxz11aQu8//JYvtmjfjrEFuV9QVgGqRxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wkg4aPfug+fkN2rV94H7/JHMonpVeNz61GcGP39Am291StkPu+ympXYiM2XHm0CBx
         /04OKomC4/BibQT3PdvVNVVug0KDlxWTk0hSNwfnikUWycumvgN/Rpgu6pdZ1ElBwt
         iIsPP6HjyqvwPtXu1PtMgxJ9enh3+tGbT7Hq9is8=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1khZ5u-00DGcy-9N; Tue, 24 Nov 2020 14:14:58 +0000
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
Subject: [PATCH v2 6/6] genirq: Rename IRQ_HIDDEN to IRQ_IPI
Date:   Tue, 24 Nov 2020 14:14:49 +0000
Message-Id: <20201124141449.572446-7-maz@kernel.org>
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

IRQ_HIDDEN was probably the wrong name, so let's rename it to IRQ_IPI,
which more accurately describe an IPI with special arch code handling.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/kernel/smp.c   | 2 +-
 arch/arm64/kernel/smp.c | 2 +-
 include/linux/irq.h     | 4 ++--
 kernel/irq/debugfs.c    | 2 +-
 kernel/irq/proc.c       | 2 +-
 kernel/irq/settings.h   | 8 ++++----
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index dc746f808400..7fc43f64a2d2 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -737,7 +737,7 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 		WARN_ON(err);
 
 		ipi_desc[i] = irq_to_desc(ipi_base + i);
-		__irq_modify_status(ipi_base + i, 0, IRQ_HIDDEN, ~0);
+		__irq_modify_status(ipi_base + i, 0, IRQ_IPI, ~0);
 
 		/* The recheduling IPI is special... */
 		if (i == IPI_RESCHEDULE)
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 684f41a3ba58..048d0d1df88a 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -994,7 +994,7 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 		WARN_ON(err);
 
 		ipi_desc[i] = irq_to_desc(ipi_base + i);
-		__irq_modify_status(ipi_base + i, 0, IRQ_HIDDEN, ~0);
+		__irq_modify_status(ipi_base + i, 0, IRQ_IPI, ~0);
 
 		/* The recheduling IPI is special... */
 		if (i == IPI_RESCHEDULE)
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 0e71227fd3ec..d61f5ecd6938 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -71,7 +71,7 @@ enum irqchip_irq_state;
  *				  it from the spurious interrupt detection
  *				  mechanism and from core side polling.
  * IRQ_DISABLE_UNLAZY		- Disable lazy irq disable
- * IRQ_HIDDEN			- Don't show up in /proc/interrupts
+ * IRQ_IPI			- Don't show up in /proc/interrupts
  * IRQ_RAW			- Skip tick management and irqtime accounting
  */
 enum {
@@ -99,7 +99,7 @@ enum {
 	IRQ_PER_CPU_DEVID	= (1 << 17),
 	IRQ_IS_POLLED		= (1 << 18),
 	IRQ_DISABLE_UNLAZY	= (1 << 19),
-	IRQ_HIDDEN		= (1 << 20),
+	IRQ_IPI			= (1 << 20),
 	IRQ_RAW			= (1 << 21),
 };
 
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index f53475d88072..8e128253cf0e 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -139,7 +139,7 @@ static const struct irq_bit_descr irqdesc_states[] = {
 	BIT_MASK_DESCR(_IRQ_PER_CPU_DEVID),
 	BIT_MASK_DESCR(_IRQ_IS_POLLED),
 	BIT_MASK_DESCR(_IRQ_DISABLE_UNLAZY),
-	BIT_MASK_DESCR(_IRQ_HIDDEN),
+	BIT_MASK_DESCR(_IRQ_IPI),
 	BIT_MASK_DESCR(_IRQ_RAW),
 };
 
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 72513ed2a5fc..19114dafb5db 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -485,7 +485,7 @@ int show_interrupts(struct seq_file *p, void *v)
 
 	rcu_read_lock();
 	desc = irq_to_desc(i);
-	if (!desc || irq_settings_is_hidden(desc))
+	if (!desc || irq_settings_is_ipi(desc))
 		goto outsparse;
 
 	if (desc->kstat_irqs)
diff --git a/kernel/irq/settings.h b/kernel/irq/settings.h
index 0033d459fdac..46e5c2802388 100644
--- a/kernel/irq/settings.h
+++ b/kernel/irq/settings.h
@@ -17,7 +17,7 @@ enum {
 	_IRQ_PER_CPU_DEVID	= IRQ_PER_CPU_DEVID,
 	_IRQ_IS_POLLED		= IRQ_IS_POLLED,
 	_IRQ_DISABLE_UNLAZY	= IRQ_DISABLE_UNLAZY,
-	_IRQ_HIDDEN		= IRQ_HIDDEN,
+	_IRQ_IPI		= IRQ_IPI,
 	_IRQ_RAW		= IRQ_RAW,
 	_IRQF_MODIFY_MASK	= IRQF_MODIFY_MASK,
 };
@@ -33,7 +33,7 @@ enum {
 #define IRQ_PER_CPU_DEVID	GOT_YOU_MORON
 #define IRQ_IS_POLLED		GOT_YOU_MORON
 #define IRQ_DISABLE_UNLAZY	GOT_YOU_MORON
-#define IRQ_HIDDEN		GOT_YOU_MORON
+#define IRQ_IPI			GOT_YOU_MORON
 #define IRQ_RAW			GOT_YOU_MORON
 #undef IRQF_MODIFY_MASK
 #define IRQF_MODIFY_MASK	GOT_YOU_MORON
@@ -178,9 +178,9 @@ static inline void irq_settings_clr_disable_unlazy(struct irq_desc *desc)
 	desc->status_use_accessors &= ~_IRQ_DISABLE_UNLAZY;
 }
 
-static inline bool irq_settings_is_hidden(struct irq_desc *desc)
+static inline bool irq_settings_is_ipi(struct irq_desc *desc)
 {
-	return desc->status_use_accessors & _IRQ_HIDDEN;
+	return desc->status_use_accessors & _IRQ_IPI;
 }
 
 static inline bool irq_settings_is_raw(struct irq_desc *desc)
-- 
2.28.0

