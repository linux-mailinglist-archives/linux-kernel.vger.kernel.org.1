Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8822A52B5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 21:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732094AbgKCUw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 15:52:28 -0500
Received: from leonov.paulk.fr ([185.233.101.22]:57352 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732074AbgKCUwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 15:52:23 -0500
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 335BDBFDEA;
        Tue,  3 Nov 2020 21:52:20 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 6080FC1D56; Tue,  3 Nov 2020 21:52:19 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=unavailable
        autolearn_force=no version=3.4.2
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id 3C836C1D48;
        Tue,  3 Nov 2020 21:51:01 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Paul Kocialkowski <contact@paulk.fr>,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH v2 2/6] irqchip/sunxi-nmi: Add support for the V3s NMI
Date:   Tue,  3 Nov 2020 21:50:54 +0100
Message-Id: <20201103205058.435207-3-contact@paulk.fr>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201103205058.435207-1-contact@paulk.fr>
References: <20201103205058.435207-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The V3s/V3 has a NMI IRQ controller, which is mainly used for the AXP209
interrupt. In great wisdom, Allwinner decided to invert the enable and
pending register offsets, compared to the A20.

As a result, a specific compatible and register description is required
for the V3s. This was tested with an AXP209 on a V3 board.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/irqchip/irq-sunxi-nmi.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index a412b5d5d0fa..59e0e4612ef7 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -44,6 +44,10 @@
 #define SUN7I_NMI_PENDING	0x04
 #define SUN7I_NMI_ENABLE	0x08
 
+#define SUN8I_V3S_NMI_CTRL	0x00
+#define SUN8I_V3S_NMI_ENABLE	0x04
+#define SUN8I_V3S_NMI_PENDING	0x08
+
 #define SUN9I_NMI_CTRL		0x00
 #define SUN9I_NMI_ENABLE	0x04
 #define SUN9I_NMI_PENDING	0x08
@@ -79,6 +83,12 @@ static const struct sunxi_sc_nmi_reg_offs sun7i_reg_offs __initconst = {
 	.enable	= SUN7I_NMI_ENABLE,
 };
 
+static const struct sunxi_sc_nmi_reg_offs sun8i_v3s_reg_offs __initconst = {
+	.ctrl	= SUN8I_V3S_NMI_CTRL,
+	.pend	= SUN8I_V3S_NMI_PENDING,
+	.enable	= SUN8I_V3S_NMI_ENABLE,
+};
+
 static const struct sunxi_sc_nmi_reg_offs sun9i_reg_offs __initconst = {
 	.ctrl	= SUN9I_NMI_CTRL,
 	.pend	= SUN9I_NMI_PENDING,
@@ -165,7 +175,6 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 	int ret;
 
-
 	domain = irq_domain_add_linear(node, 1, &irq_generic_chip_ops, NULL);
 	if (!domain) {
 		pr_err("Could not register interrupt domain.\n");
@@ -254,6 +263,13 @@ static int __init sun7i_sc_nmi_irq_init(struct device_node *node,
 }
 IRQCHIP_DECLARE(sun7i_sc_nmi, "allwinner,sun7i-a20-sc-nmi", sun7i_sc_nmi_irq_init);
 
+static int __init sun8i_v3s_sc_nmi_irq_init(struct device_node *node,
+					    struct device_node *parent)
+{
+	return sunxi_sc_nmi_irq_init(node, &sun8i_v3s_reg_offs);
+}
+IRQCHIP_DECLARE(sun8i_v3s_sc_nmi, "allwinner,sun8i-v3s-sc-nmi", sun8i_v3s_sc_nmi_irq_init);
+
 static int __init sun9i_nmi_irq_init(struct device_node *node,
 				     struct device_node *parent)
 {
-- 
2.29.1

