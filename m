Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DCF2A1977
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 19:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgJaSXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 14:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgJaSXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 14:23:20 -0400
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 31 Oct 2020 11:23:20 PDT
Received: from leonov.paulk.fr (vpn-0-22.aquilenet.fr [IPv6:2a0c:e300:4:22::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F653C0617A6;
        Sat, 31 Oct 2020 11:23:20 -0700 (PDT)
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id A4E78C036C;
        Sat, 31 Oct 2020 19:23:17 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 0634FC1D69; Sat, 31 Oct 2020 19:23:16 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=5.0 tests=RDNS_NONE autolearn=no
        autolearn_force=no version=3.4.2
Received: from localhost.localdomain (unknown [192.168.1.101])
        by gagarine.paulk.fr (Postfix) with ESMTP id 7ECA4C1D6B;
        Sat, 31 Oct 2020 19:21:55 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matteo Scordino <matteo.scordino@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 5/9] irqchip/sunxi-nmi: Add support for the V3s NMI
Date:   Sat, 31 Oct 2020 19:21:33 +0100
Message-Id: <20201031182137.1879521-6-contact@paulk.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031182137.1879521-1-contact@paulk.fr>
References: <20201031182137.1879521-1-contact@paulk.fr>
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
2.28.0

