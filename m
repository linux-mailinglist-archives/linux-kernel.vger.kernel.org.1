Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA142B0974
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgKLQEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 11:04:39 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:58523 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbgKLQEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:04:37 -0500
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 5EE6AE0023;
        Thu, 12 Nov 2020 16:04:34 +0000 (UTC)
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
Subject: [PATCH v2 5/5] irqchip: ocelot: Add support for Jaguar2 platforms
Date:   Thu, 12 Nov 2020 17:04:24 +0100
Message-Id: <20201112160424.1383051-6-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201112160424.1383051-1-gregory.clement@bootlin.com>
References: <20201112160424.1383051-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends irqchip driver for ocelot to be used with an other
vcoreiii base platform: Jaguar2.

Based on a larger patch from Lars Povlsen <lars.povlsen@microchip.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/irqchip/irq-mscc-ocelot.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
index 584af3b0a9e2..0dfea8771172 100644
--- a/drivers/irqchip/irq-mscc-ocelot.c
+++ b/drivers/irqchip/irq-mscc-ocelot.c
@@ -70,6 +70,18 @@ static const struct chip_props luton_props = {
 	.n_irq			= 28,
 };
 
+static const struct chip_props jaguar2_props = {
+	.flags			= FLAGS_HAS_TRIGGER,
+	.reg_off_sticky		= 0x10,
+	.reg_off_ena		= 0x18,
+	.reg_off_ena_clr	= 0x1c,
+	.reg_off_ena_set	= 0x20,
+	.reg_off_ident		= 0x38,
+	.reg_off_trigger	= 0x5c,
+	.reg_off_force		= 0xc,
+	.n_irq			= 29,
+};
+
 static void ocelot_irq_unmask(struct irq_data *data)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
@@ -237,3 +249,11 @@ static int __init luton_irq_init(struct device_node *node,
 }
 
 IRQCHIP_DECLARE(luton_icpu, "mscc,luton-icpu-intr", luton_irq_init);
+
+static int __init jaguar2_irq_init(struct device_node *node,
+				   struct device_node *parent)
+{
+	return vcoreiii_irq_init(node, parent, &jaguar2_props);
+}
+
+IRQCHIP_DECLARE(jaguar2_icpu, "mscc,jaguar2-icpu-intr", jaguar2_irq_init);
-- 
2.28.0

