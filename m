Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D6B2C3DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 11:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgKYKcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 05:32:32 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:56139 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgKYKca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 05:32:30 -0500
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 7541310001A;
        Wed, 25 Nov 2020 10:32:27 +0000 (UTC)
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
Subject: [PATCH v5 6/6] irqchip: ocelot: Add support for Jaguar2 platforms
Date:   Wed, 25 Nov 2020 11:32:06 +0100
Message-Id: <20201125103206.136498-7-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125103206.136498-1-gregory.clement@bootlin.com>
References: <20201125103206.136498-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends irqchip driver for ocelot to be used with an other
vcoreiii base platform: Jaguar2.

Based on a larger patch from Lars Povlsen <lars.povlsen@microchip.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/irqchip/irq-mscc-ocelot.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
index da5a0ad991a1..8235d98650c1 100644
--- a/drivers/irqchip/irq-mscc-ocelot.c
+++ b/drivers/irqchip/irq-mscc-ocelot.c
@@ -63,6 +63,17 @@ static struct chip_props luton_props = {
 	.n_irq			= 28,
 };
 
+static struct chip_props jaguar2_props = {
+	.flags			= FLAGS_HAS_TRIGGER,
+	.reg_off_sticky		= 0x10,
+	.reg_off_ena		= 0x18,
+	.reg_off_ena_clr	= 0x1c,
+	.reg_off_ena_set	= 0x20,
+	.reg_off_ident		= 0x38,
+	.reg_off_trigger	= 0x5c,
+	.n_irq			= 29,
+};
+
 static void ocelot_irq_unmask(struct irq_data *data)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
@@ -197,3 +208,11 @@ static int __init luton_irq_init(struct device_node *node,
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
2.29.2

