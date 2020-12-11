Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F542D788D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437091AbgLKPAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436793AbgLKPAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:00:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22980C0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:58:49 -0800 (PST)
Date:   Fri, 11 Dec 2020 14:58:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607698725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Cn/jq4TXRu9Bz51SjGc0oddsf25sGI19cT3ygLmhBQ=;
        b=SuAHlyndamW6B1TDb0wsMoepSClRudQq2TMRh5HJ8s2xFQ4K0WPpx+U5b57O59Huxp77xD
        IJKOYWIO8Ddjc8VsqMd059dpEl+LB9mr3IWHcmO+8iwE2cbfJI/CjdO2CWt4FTEDegYzuV
        Gn8471yEJx6UES/Zzg1Mtbk8tXgK137UREvTDwDosdFEUWeLb5KxcD5f3sucZ2kNtnCdyh
        d6x985Lmmy20YLrouLtnM+jM16rg2PG+VzAPuJSRnA49LJW3qbbwCnPx9RQkewt5ISjPT3
        +MHDlHN1LxHneRjGfcmgk85yT622srnGoPZOW1nmBWrnc0ac67XMWUE0cf59IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Cn/jq4TXRu9Bz51SjGc0oddsf25sGI19cT3ygLmhBQ=;
        b=hC3dCWyTc/ifmb9BAV0amNjp8AYeln2SMpEIO3p5jPNFr4yV2UhZB2YuwlIlCH9kQcVqUp
        6d+NF/aHzOtQcPCg==
From:   "irqchip-bot for Gregory CLEMENT" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/ocelot: Add support for Luton platforms
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Marc Zyngier <maz@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        tglx@linutronix.de
In-Reply-To: <20201125103206.136498-5-gregory.clement@bootlin.com>
References: <20201125103206.136498-5-gregory.clement@bootlin.com>
MIME-Version: 1.0
Message-ID: <160769872474.3364.17687663397142618770.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     ffce73d4415391b2d6da4878bf04d6610edf56db
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/ffce73d4415391b2d6da4878bf04d6610edf56db
Author:        Gregory CLEMENT <gregory.clement@bootlin.com>
AuthorDate:    Wed, 25 Nov 2020 11:32:04 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:47:49 

irqchip/ocelot: Add support for Luton platforms

This patch extends irqchip driver for oceleot to be used with an other
vcoreiii base platform: Luton.

For this platform there is a few differences:
   - the interrupt must be enabled for the parent controller
   - there is no trigger register needed to be managed

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20201125103206.136498-5-gregory.clement@bootlin.com
---
 drivers/irqchip/irq-mscc-ocelot.c | 38 ++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
index 6d4029a..496f955 100644
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
