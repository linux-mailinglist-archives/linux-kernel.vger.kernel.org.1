Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6B92BB0C3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgKTQlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:41:24 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:58407 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730099AbgKTQlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:41:21 -0500
Received: from localhost (lfbn-lyo-1-1010-39.w86-194.abo.wanadoo.fr [86.194.86.39])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 61B1420000E;
        Fri, 20 Nov 2020 16:41:19 +0000 (UTC)
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
Subject: [PATCH v4 5/6] irqchip: ocelot: Add support for Serval platforms
Date:   Fri, 20 Nov 2020 17:41:07 +0100
Message-Id: <20201120164108.2096359-6-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120164108.2096359-1-gregory.clement@bootlin.com>
References: <20201120164108.2096359-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends irqchip driver for ocelot to be used with an other
vcoreiii base platform: Serval.

Based on a larger patch from Lars Povlsen <lars.povlsen@microchip.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/irqchip/irq-mscc-ocelot.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
index 496f955b8fc4..da5a0ad991a1 100644
--- a/drivers/irqchip/irq-mscc-ocelot.c
+++ b/drivers/irqchip/irq-mscc-ocelot.c
@@ -41,6 +41,17 @@ static struct chip_props ocelot_props = {
 	.n_irq			= 24,
 };
 
+static struct chip_props serval_props = {
+	.flags			= FLAGS_HAS_TRIGGER,
+	.reg_off_sticky		= 0xc,
+	.reg_off_ena		= 0x14,
+	.reg_off_ena_clr	= 0x18,
+	.reg_off_ena_set	= 0x1c,
+	.reg_off_ident		= 0x20,
+	.reg_off_trigger	= 0x4,
+	.n_irq			= 24,
+};
+
 static struct chip_props luton_props = {
 	.flags			= FLAGS_NEED_INIT_ENABLE,
 	.reg_off_sticky		= 0,
@@ -171,6 +182,14 @@ static int __init ocelot_irq_init(struct device_node *node,
 
 IRQCHIP_DECLARE(ocelot_icpu, "mscc,ocelot-icpu-intr", ocelot_irq_init);
 
+static int __init serval_irq_init(struct device_node *node,
+				  struct device_node *parent)
+{
+	return vcoreiii_irq_init(node, parent, &serval_props);
+}
+
+IRQCHIP_DECLARE(serval_icpu, "mscc,serval-icpu-intr", serval_irq_init);
+
 static int __init luton_irq_init(struct device_node *node,
 				 struct device_node *parent)
 {
-- 
2.29.2

