Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E562C81BA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 11:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgK3KID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 05:08:03 -0500
Received: from inva021.nxp.com ([92.121.34.21]:51614 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726532AbgK3KID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 05:08:03 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6F8BC200A72;
        Mon, 30 Nov 2020 11:07:15 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4AC4F2005F3;
        Mon, 30 Nov 2020 11:07:09 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B5E314024F;
        Mon, 30 Nov 2020 11:07:01 +0100 (CET)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     linux@rasmusvillemoes.dk, shawnguo@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, leoyang.li@nxp.com, zhiqiang.hou@nxp.com,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, xiaobo.xie@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Biwen Li <biwen.li@nxp.com>
Subject: [v4 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A external interrupt
Date:   Mon, 30 Nov 2020 18:15:05 +0800
Message-Id: <20201130101515.27431-1-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add an new IRQ chip declaration for LS1043A and LS1088A
- compatible "fsl,ls1043a-extirq" for LS1043A, LS1046A.
- compatible "fsl,ls1088a-extirq" for LS1088A, LS208xA, LX216xA.
- get mask value directly according to compatible property of DT
  and remove confused code(bit_reverse field of struct ls_extirq_data,
  no need this field for SoC LS1021A. Because the register
  LS1021A_SCFGREVCR is initialized to 0xffffffff by the relative rcw)

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
Change in v4:
	- fix warning when checking patch
	- simplify code
	- update commit message

Change in v3:
	- cleanup code
	- remove robust copyright

Change in v2:
	- add despcription of bit reverse
	- update copyright

 drivers/irqchip/irq-ls-extirq.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
index 4d1179fed77c..f94f974a8764 100644
--- a/drivers/irqchip/irq-ls-extirq.c
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -18,7 +18,7 @@
 struct ls_extirq_data {
 	struct regmap		*syscon;
 	u32			intpcr;
-	bool			bit_reverse;
+	bool			is_ls1021a_or_ls1043a;
 	u32			nirq;
 	struct irq_fwspec	map[MAXIRQ];
 };
@@ -30,7 +30,7 @@ ls_extirq_set_type(struct irq_data *data, unsigned int type)
 	irq_hw_number_t hwirq = data->hwirq;
 	u32 value, mask;
 
-	if (priv->bit_reverse)
+	if (priv->is_ls1021a_or_ls1043a)
 		mask = 1U << (31 - hwirq);
 	else
 		mask = 1U << hwirq;
@@ -174,14 +174,8 @@ ls_extirq_of_init(struct device_node *node, struct device_node *parent)
 	if (ret)
 		goto out;
 
-	if (of_device_is_compatible(node, "fsl,ls1021a-extirq")) {
-		u32 revcr;
-
-		ret = regmap_read(priv->syscon, LS1021A_SCFGREVCR, &revcr);
-		if (ret)
-			goto out;
-		priv->bit_reverse = (revcr != 0);
-	}
+	priv->is_ls1021a_or_ls1043a = of_device_is_compatible(node, "fsl,ls1021a-extirq") ||
+				      of_device_is_compatible(node, "fsl,ls1043a-extirq");
 
 	domain = irq_domain_add_hierarchy(parent_domain, 0, priv->nirq, node,
 					  &extirq_domain_ops, priv);
@@ -195,3 +189,5 @@ ls_extirq_of_init(struct device_node *node, struct device_node *parent)
 }
 
 IRQCHIP_DECLARE(ls1021a_extirq, "fsl,ls1021a-extirq", ls_extirq_of_init);
+IRQCHIP_DECLARE(ls1043a_extirq, "fsl,ls1043a-extirq", ls_extirq_of_init);
+IRQCHIP_DECLARE(ls1088a_extirq, "fsl,ls1088a-extirq", ls_extirq_of_init);
-- 
2.17.1

