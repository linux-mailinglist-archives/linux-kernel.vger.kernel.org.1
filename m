Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC6C2A2556
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgKBHgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:36:49 -0500
Received: from inva021.nxp.com ([92.121.34.21]:42474 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgKBHgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:36:47 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 74B872013BE;
        Mon,  2 Nov 2020 08:36:45 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 198302013CB;
        Mon,  2 Nov 2020 08:36:42 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 833A04029C;
        Mon,  2 Nov 2020 08:36:37 +0100 (CET)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biwen Li <biwen.li@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v4 1/3] soc: fsl: handle RCPM errata A-008646 on SoC LS1021A
Date:   Mon,  2 Nov 2020 15:26:50 +0800
Message-Id: <20201102072652.34893-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

Hardware issue:
- Reading register RCPM_IPPDEXPCR1 always return zero, this causes
  system firmware could not get correct information and wrongly do
  clock gating for all wakeup source IP during system suspend. Then
  those IPs will never get chance to wake system.

Workaround:
- Copy register RCPM_IPPDEXPCR1's setting to register SCFG_SPARECR8
  to allow system firmware's psci method read it and do things accordingly.

Signed-off-by: Biwen Li <biwen.li@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Change in v4:
 - Replace property 'fsl,ippdexpcr1-alt-reg' with compatible checking as the
   workaround trigger condition.

Change in v3:
 - Add  copy_ippdexpcr1_setting(), simplize workaournd's implementation
   according to binding update.
 - Minor update on commit message.

Change in v2:
 - Update commit message to be more clear.
 - Replace device_property_read_u32_array() with syscon_regmap_lookup_by_phandle_args()
   to make code simpler.

 drivers/soc/fsl/rcpm.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/rcpm.c b/drivers/soc/fsl/rcpm.c
index a093dbe..4ace28c 100644
--- a/drivers/soc/fsl/rcpm.c
+++ b/drivers/soc/fsl/rcpm.c
@@ -2,7 +2,7 @@
 //
 // rcpm.c - Freescale QorIQ RCPM driver
 //
-// Copyright 2019 NXP
+// Copyright 2019-2020 NXP
 //
 // Author: Ran Wang <ran.wang_1@nxp.com>
 
@@ -22,6 +22,28 @@ struct rcpm {
 	bool		little_endian;
 };
 
+#define  SCFG_SPARECR8	0x051c
+
+static void copy_ippdexpcr1_setting(u32 val)
+{
+	struct device_node *np;
+	void __iomem *regs;
+	u32 reg_val;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,ls1021a-scfg");
+	if (!np)
+		return;
+
+	regs = of_iomap(np, 0);
+	if (!regs)
+		return;
+
+	reg_val = ioread32be(regs + SCFG_SPARECR8);
+	iowrite32be(val | reg_val, regs + SCFG_SPARECR8);
+
+	iounmap(regs);
+}
+
 /**
  * rcpm_pm_prepare - performs device-level tasks associated with power
  * management, such as programming related to the wakeup source control.
@@ -90,6 +112,17 @@ static int rcpm_pm_prepare(struct device *dev)
 			tmp |= ioread32be(address);
 			iowrite32be(tmp, address);
 		}
+		/*
+		 * Workaround of errata A-008646 on SoC LS1021A:
+		 * There is a bug of register ippdexpcr1.
+		 * Reading configuration register RCPM_IPPDEXPCR1
+		 * always return zero. So save ippdexpcr1's value
+		 * to register SCFG_SPARECR8.And the value of
+		 * ippdexpcr1 will be read from SCFG_SPARECR8.
+		 */
+		if (dev_of_node(dev) && (i == 1))
+			if (of_device_is_compatible(np, "fsl,ls1021a-rcpm"))
+				copy_ippdexpcr1_setting(tmp);
 	}
 
 	return 0;
-- 
2.7.4

