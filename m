Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC7826B808
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgIPAev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:34:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgIONkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:40:43 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AF89222BB;
        Tue, 15 Sep 2020 13:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600177219;
        bh=l8ZBD9TP9Sqrk5ArhBI3j0uMGU4B0/WAtLJBpy0K5AQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h392Twh8mN+iLk5hsBobvuCoLRd0NI8Ey+NSUrzDdZSZNRkher+E4C0p+8CVGJ84w
         4ZJdU3RogXRuh+K25pqtKEsXm/tiyENqkhsUS9CapAXnLlT0njh+d65A58ARvdL0vH
         kJky/6XdiHIppruX6n9XgogOElJBazJvPEWGujaw=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kIBBx-00C1TP-QQ; Tue, 15 Sep 2020 14:40:17 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        kernel-team@android.com
Subject: [PATCH 1/2] irqchip/gic: Handle non-standard SGI deactivation on Samsung's Franken-GIC
Date:   Tue, 15 Sep 2020 14:39:43 +0100
Message-Id: <20200915133944.1285456-2-maz@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915133944.1285456-1-maz@kernel.org>
References: <20200915133944.1285456-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, m.szyprowski@samsung.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GIC available on some of Samsung's A9-based platform is
thankfully one of a kind. On top of not presenting a banked
programing model (each CPU has its own base addresses for both
distributor and CPU interface), it also encodes the source CPU
for SGIs in the INTID read from IAR, and requires this exact
value to be written back to EOI.

Without this, interrupts are never deactivated, and the kernel
grinds to a halt.

Work around it by stashing the INTID for in-flight SGIs, and
using that value on EOI. This only works because we don't nest
SGIs.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: ac063232d4b0 ("irqchip/gic: Configure SGIs as standard interrupts")
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic.c | 49 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 4be2b62f816f..84a2d2a1aab7 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -150,10 +150,37 @@ static inline void gic_set_base_accessor(struct gic_chip_data *data,
 {
 	data->get_base = f;
 }
+
+static DEFINE_STATIC_KEY_FALSE(frankengic_key);
+static DEFINE_PER_CPU(u32, sgi_intid);
+
+static void enable_frankengic(void)
+{
+	static_branch_enable(&frankengic_key);
+}
+
+static inline bool is_frankengic(void)
+{
+	return static_branch_unlikely(&frankengic_key);
+}
+
+static inline void set_sgi_intid(u32 intid)
+{
+	this_cpu_write(sgi_intid, intid);
+}
+
+static inline u32 get_sgi_intid(void)
+{
+	return this_cpu_read(sgi_intid);
+}
 #else
 #define gic_data_dist_base(d)	((d)->dist_base.common_base)
 #define gic_data_cpu_base(d)	((d)->cpu_base.common_base)
 #define gic_set_base_accessor(d, f)
+#define enable_frankengic()	do { } while(0)
+#define is_frankengic()		false
+#define set_sgi_intid(i)	do { } while(0)
+#define get_sgi_intid()		0
 #endif
 
 static inline void __iomem *gic_dist_base(struct irq_data *d)
@@ -226,7 +253,12 @@ static void gic_unmask_irq(struct irq_data *d)
 
 static void gic_eoi_irq(struct irq_data *d)
 {
-	writel_relaxed(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
+	u32 hwirq = gic_irq(d);
+
+	if (is_frankengic() && hwirq < 16)
+		hwirq = get_sgi_intid();
+
+	writel_relaxed(hwirq, gic_cpu_base(d) + GIC_CPU_EOI);
 }
 
 static void gic_eoimode1_eoi_irq(struct irq_data *d)
@@ -348,8 +380,20 @@ static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 		 *
 		 * Pairs with the write barrier in gic_ipi_send_mask
 		 */
-		if (irqnr <= 15)
+		if (irqnr <= 15) {
 			smp_rmb();
+
+			/*
+			 * Samsung's funky GIC encodes the source CPU in
+			 * GICC_IAR, leading to the deactivation to fail if
+			 * not written back as is to GICC_EOI.  Stash the
+			 * INTID away for gic_eoi_irq() to write back.
+			 * This only works because we don't nest SGIs...
+			 */
+			if (is_frankengic())
+				set_sgi_intid(irqstat);
+		}
+
 		handle_domain_irq(gic->domain, irqnr, regs);
 	} while (1);
 }
@@ -1142,6 +1186,7 @@ static int gic_init_bases(struct gic_chip_data *gic,
 				gic->raw_cpu_base + offset;
 		}
 
+		enable_frankengic();
 		gic_set_base_accessor(gic, gic_get_percpu_base);
 	} else {
 		/* Normal, sane GIC... */
-- 
2.28.0

