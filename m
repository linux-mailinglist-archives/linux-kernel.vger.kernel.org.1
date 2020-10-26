Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E8C298806
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 09:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771270AbgJZIK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 04:10:56 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55246 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1771244AbgJZIKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 04:10:52 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 75DEB20098C;
        Mon, 26 Oct 2020 09:10:45 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A3A0320097B;
        Mon, 26 Oct 2020 09:10:39 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 86828402B1;
        Mon, 26 Oct 2020 09:10:32 +0100 (CET)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, zhiqiang.hou@nxp.com, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, xiaobo.xie@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Biwen Li <biwen.li@nxp.com>
Subject: [RESEND 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A external interrupt
Date:   Mon, 26 Oct 2020 16:01:17 +0800
Message-Id: <20201026080127.40499-1-biwen.li@oss.nxp.com>
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

