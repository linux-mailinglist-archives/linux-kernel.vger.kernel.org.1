Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DEE2C7D40
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 04:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgK3DXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 22:23:42 -0500
Received: from inva020.nxp.com ([92.121.34.13]:33518 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgK3DXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 22:23:42 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D34FE1A084B;
        Mon, 30 Nov 2020 04:22:54 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id ADC211A085A;
        Mon, 30 Nov 2020 04:22:48 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 234BD402B6;
        Mon, 30 Nov 2020 04:22:41 +0100 (CET)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     linux@rasmusvillemoes.dk, shawnguo@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, leoyang.li@nxp.com, zhiqiang.hou@nxp.com,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, xiaobo.xie@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Biwen Li <biwen.li@nxp.com>
Subject: [v3 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A external interrupt
Date:   Mon, 30 Nov 2020 11:30:45 +0800
Message-Id: <20201130033055.38462-1-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add an new IRQ chip declaration for LS1043A and LS1088A
- compatible "fsl,ls1043a-extirq" for LS1043A, LS1046A.
- compatible "fsl,ls1088a-extirq" for LS1088A, LS208xA, LX216xA

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
Change in v3:
	- cleanup code
	- remove robust copyright

Change in v2:
	- add despcription of bit reverse
	- update copyright

 drivers/irqchip/irq-ls-extirq.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
index 4d1179fed77c..47804ce78b21 100644
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
@@ -174,14 +174,9 @@ ls_extirq_of_init(struct device_node *node, struct device_node *parent)
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
+	if (of_device_is_compatible(node, "fsl,ls1021a-extirq") || \
+	    of_device_is_compatible(node, "fsl,ls1043a-extirq"))
+		priv->is_ls1021a_or_ls1043a = true;
 
 	domain = irq_domain_add_hierarchy(parent_domain, 0, priv->nirq, node,
 					  &extirq_domain_ops, priv);
@@ -195,3 +190,5 @@ ls_extirq_of_init(struct device_node *node, struct device_node *parent)
 }
 
 IRQCHIP_DECLARE(ls1021a_extirq, "fsl,ls1021a-extirq", ls_extirq_of_init);
+IRQCHIP_DECLARE(ls1043a_extirq, "fsl,ls1043a-extirq", ls_extirq_of_init);
+IRQCHIP_DECLARE(ls1088a_extirq, "fsl,ls1088a-extirq", ls_extirq_of_init);
-- 
2.17.1

