Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A39729A3B8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 05:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505447AbgJ0Ezm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 00:55:42 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59426 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505437AbgJ0Ezm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 00:55:42 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 036D7200C86;
        Tue, 27 Oct 2020 05:55:40 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CB27F200CA8;
        Tue, 27 Oct 2020 05:55:33 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4D60A40291;
        Tue, 27 Oct 2020 05:55:26 +0100 (CET)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     linux@rasmusvillemoes.dk, shawnguo@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, leoyang.li@nxp.com, zhiqiang.hou@nxp.com,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, xiaobo.xie@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Biwen Li <biwen.li@nxp.com>
Subject: [v2 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A external interrupt
Date:   Tue, 27 Oct 2020 12:46:09 +0800
Message-Id: <20201027044619.41879-1-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add an new IRQ chip declaration for LS1043A and LS1088A
- compatible "fsl,ls1043a-extirq" for LS1043A, LS1046A. SCFG_INTPCR[31:0]
  of these SoCs is stored/read as SCFG_INTPCR[0:31] defaultly(bit
  reverse)
- compatible "fsl,ls1088a-extirq" for LS1088A, LS208xA, LX216xA

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
Change in v2:
	- add despcription of bit reverse
	- update copyright

 drivers/irqchip/irq-ls-extirq.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
index 4d1179fed77c..9587bc2607fc 100644
--- a/drivers/irqchip/irq-ls-extirq.c
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-
+/*
+ * Author: Rasmus Villemoes <linux@rasmusvillemoes.dk>
+ * Copyright 2020 NXP
+ */
 #define pr_fmt(fmt) "irq-ls-extirq: " fmt
 
 #include <linux/irq.h>
@@ -183,6 +186,9 @@ ls_extirq_of_init(struct device_node *node, struct device_node *parent)
 		priv->bit_reverse = (revcr != 0);
 	}
 
+	if (of_device_is_compatible(node, "fsl,ls1043a-extirq"))
+		priv->bit_reverse = true;
+
 	domain = irq_domain_add_hierarchy(parent_domain, 0, priv->nirq, node,
 					  &extirq_domain_ops, priv);
 	if (!domain)
@@ -195,3 +201,5 @@ ls_extirq_of_init(struct device_node *node, struct device_node *parent)
 }
 
 IRQCHIP_DECLARE(ls1021a_extirq, "fsl,ls1021a-extirq", ls_extirq_of_init);
+IRQCHIP_DECLARE(ls1043a_extirq, "fsl,ls1043a-extirq", ls_extirq_of_init);
+IRQCHIP_DECLARE(ls1088a_extirq, "fsl,ls1088a-extirq", ls_extirq_of_init);
-- 
2.17.1

