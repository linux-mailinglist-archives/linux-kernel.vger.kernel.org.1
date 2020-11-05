Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3112A84A7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731989AbgKERQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:16:05 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:42991 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731901AbgKERQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:16:02 -0500
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 74D001BF20B;
        Thu,  5 Nov 2020 17:15:59 +0000 (UTC)
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
Subject: [PATCH 5/6] irqchip: ocelot: Add support for Serval platforms
Date:   Thu,  5 Nov 2020 18:15:34 +0100
Message-Id: <20201105171535.923570-6-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201105171535.923570-1-gregory.clement@bootlin.com>
References: <20201105171535.923570-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends irqchip driver for ocelot to be used with an other
vcoreiii base platform: Serval.

Based on a larger patch from Lars Povlsen <lars.povlsen@microchip.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/irqchip/irq-mscc-ocelot.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
index 9964800c53c2..584af3b0a9e2 100644
--- a/drivers/irqchip/irq-mscc-ocelot.c
+++ b/drivers/irqchip/irq-mscc-ocelot.c
@@ -44,6 +44,18 @@ static const struct chip_props ocelot_props = {
 	.n_irq			= 24,
 };
 
+static const struct chip_props serval_props = {
+	.flags			= FLAGS_HAS_TRIGGER,
+	.reg_off_sticky		= 0xc,
+	.reg_off_ena		= 0x14,
+	.reg_off_ena_clr	= 0x18,
+	.reg_off_ena_set	= 0x1c,
+	.reg_off_ident		= 0x20,
+	.reg_off_trigger	= 0x4,
+	.reg_off_force		= 0x8,
+	.n_irq			= 24,
+};
+
 static const struct chip_props luton_props = {
 	.flags			= FLAGS_NEED_INIT_ENABLE |
 				  FLAGS_FORCE_LUTON_STYLE,
@@ -210,6 +222,14 @@ static int __init ocelot_irq_init(struct device_node *node,
 
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
2.28.0

