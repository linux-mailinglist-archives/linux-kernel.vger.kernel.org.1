Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341E5295AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 10:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508703AbgJVIxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 04:53:25 -0400
Received: from inva021.nxp.com ([92.121.34.21]:46778 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506704AbgJVIxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 04:53:25 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5709F2012EE;
        Thu, 22 Oct 2020 10:53:23 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8C0A7200D8F;
        Thu, 22 Oct 2020 10:53:17 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 06743402F3;
        Thu, 22 Oct 2020 10:53:09 +0200 (CEST)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, zhiqiang.hou@nxp.com, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, xiaobo.xie@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Biwen Li <biwen.li@nxp.com>
Subject: [PATCH 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A external interrupt
Date:   Thu, 22 Oct 2020 16:44:00 +0800
Message-Id: <20201022084410.28249-1-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add an new IRQ chip declaration for LS1043A and LS1088A
- compatible "fsl,ls1043a-extirq" for LS1043A, LS1046A
- compatible "fsl,ls1088a-extirq" for LS1088A, LS208xA, LX216xA

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
 drivers/irqchip/irq-ls-extirq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
index 4d1179fed77c..564e6de0bd8e 100644
--- a/drivers/irqchip/irq-ls-extirq.c
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+// Copyright 2019-2020 NXP
 
 #define pr_fmt(fmt) "irq-ls-extirq: " fmt
 
@@ -183,6 +184,9 @@ ls_extirq_of_init(struct device_node *node, struct device_node *parent)
 		priv->bit_reverse = (revcr != 0);
 	}
 
+	if (of_device_is_compatible(node, "fsl,ls1043a-extirq"))
+		priv->bit_reverse = true;
+
 	domain = irq_domain_add_hierarchy(parent_domain, 0, priv->nirq, node,
 					  &extirq_domain_ops, priv);
 	if (!domain)
@@ -195,3 +199,5 @@ ls_extirq_of_init(struct device_node *node, struct device_node *parent)
 }
 
 IRQCHIP_DECLARE(ls1021a_extirq, "fsl,ls1021a-extirq", ls_extirq_of_init);
+IRQCHIP_DECLARE(ls1043a_extirq, "fsl,ls1043a-extirq", ls_extirq_of_init);
+IRQCHIP_DECLARE(ls1088a_extirq, "fsl,ls1088a-extirq", ls_extirq_of_init);
-- 
2.17.1

