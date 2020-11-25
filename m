Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBDB2C3DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 11:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgKYKc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 05:32:29 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:36639 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgKYKc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 05:32:28 -0500
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 39A4310000F;
        Wed, 25 Nov 2020 10:32:23 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        <Steen.Hegelund@microchip.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v5 4/6] irqchip: ocelot: Add support for Luton platforms
Date:   Wed, 25 Nov 2020 11:32:04 +0100
Message-Id: <20201125103206.136498-5-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125103206.136498-1-gregory.clement@bootlin.com>
References: <20201125103206.136498-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends irqchip driver for oceleot to be used with an other
vcoreiii base platform: Luton.

For this platform there is a few differences:
   - the interrupt must be enabled for the parent controller
   - there is no trigger register needed to be managed

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/irqchip/irq-mscc-ocelot.c | 38 +++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
index 6d4029a2ded0..496f955b8fc4 100644
--- a/drivers/irqchip/irq-mscc-ocelot.c
+++ b/drivers/irqchip/irq-mscc-ocelot.c
@@ -16,6 +16,7 @@
 #define ICPU_CFG_INTR_INTR_TRIGGER(_p, x)   ((_p)->reg_off_trigger + 0x4 * (x))
 
 #define FLAGS_HAS_TRIGGER	BIT(0)
+#define FLAGS_NEED_INIT_ENABLE	BIT(1)
 
 struct chip_props {
 	u8 flags;
@@ -40,6 +41,17 @@ static struct chip_props ocelot_props = {
 	.n_irq			= 24,
 };
 
+static struct chip_props luton_props = {
+	.flags			= FLAGS_NEED_INIT_ENABLE,
+	.reg_off_sticky		= 0,
+	.reg_off_ena		= 0x4,
+	.reg_off_ena_clr	= 0x8,
+	.reg_off_ena_set	= 0xc,
+	.reg_off_ident		= 0x18,
+	.reg_off_ena_irq0	= 0x14,
+	.n_irq			= 28,
+};
+
 static void ocelot_irq_unmask(struct irq_data *data)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
@@ -115,17 +127,27 @@ static int __init vcoreiii_irq_init(struct device_node *node,
 		goto err_gc_free;
 	}
 
-	gc->chip_types[0].regs.ack = p->reg_off_sticky;
-	gc->chip_types[0].regs.mask = p->reg_off_ena_clr;
 	gc->chip_types[0].chip.irq_ack = irq_gc_ack_set_bit;
-	gc->chip_types[0].chip.irq_mask = irq_gc_mask_set_bit;
-	if (p->flags & FLAGS_HAS_TRIGGER)
+	gc->chip_types[0].regs.ack = p->reg_off_sticky;
+	if (p->flags & FLAGS_HAS_TRIGGER) {
+		gc->chip_types[0].regs.mask = p->reg_off_ena_clr;
 		gc->chip_types[0].chip.irq_unmask = ocelot_irq_unmask;
+		gc->chip_types[0].chip.irq_mask = irq_gc_mask_set_bit;
+	} else {
+		gc->chip_types[0].regs.enable = p->reg_off_ena_set;
+		gc->chip_types[0].regs.disable = p->reg_off_ena_clr;
+		gc->chip_types[0].chip.irq_mask = irq_gc_mask_disable_reg;
+		gc->chip_types[0].chip.irq_unmask = irq_gc_unmask_enable_reg;
+	}
 
 	/* Mask and ack all interrupts */
 	irq_reg_writel(gc, 0, p->reg_off_ena);
 	irq_reg_writel(gc, 0xffffffff, p->reg_off_sticky);
 
+	/* Overall init */
+	if (p->flags & FLAGS_NEED_INIT_ENABLE)
+		irq_reg_writel(gc, BIT(0), p->reg_off_ena_irq0);
+
 	domain->host_data = p;
 	irq_set_chained_handler_and_data(parent_irq, ocelot_irq_handler,
 					 domain);
@@ -148,3 +170,11 @@ static int __init ocelot_irq_init(struct device_node *node,
 }
 
 IRQCHIP_DECLARE(ocelot_icpu, "mscc,ocelot-icpu-intr", ocelot_irq_init);
+
+static int __init luton_irq_init(struct device_node *node,
+				 struct device_node *parent)
+{
+	return vcoreiii_irq_init(node, parent, &luton_props);
+}
+
+IRQCHIP_DECLARE(luton_icpu, "mscc,luton-icpu-intr", luton_irq_init);
-- 
2.29.2

