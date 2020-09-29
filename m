Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5D927BF7C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgI2Ib3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:31:29 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53744 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgI2IbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:31:22 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6404C201185;
        Tue, 29 Sep 2020 10:31:20 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AC477201181;
        Tue, 29 Sep 2020 10:31:16 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 21327402FA;
        Tue, 29 Sep 2020 10:31:12 +0200 (CEST)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biwen Li <biwen.li@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v3 2/5] soc: fsl: handle RCPM errata A-008646 on SoC LS1021A
Date:   Tue, 29 Sep 2020 16:22:31 +0800
Message-Id: <20200929082234.36619-2-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929082234.36619-1-ran.wang_1@nxp.com>
References: <20200929082234.36619-1-ran.wang_1@nxp.com>
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
index a093dbe..4ac2a77 100644
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
+			if (device_property_read_bool(dev, "fsl,ippdexpcr1-alt-reg"))
+				copy_ippdexpcr1_setting(tmp);
 	}
 
 	return 0;
-- 
2.7.4

