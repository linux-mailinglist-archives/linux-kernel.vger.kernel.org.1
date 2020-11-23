Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA7F2C1141
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 18:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390119AbgKWRCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 12:02:00 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:32030 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387746AbgKWRB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 12:01:58 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ANGw36W020959;
        Mon, 23 Nov 2020 18:01:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=OhkM3GnsryVwRniGczOnyMv/O1v+dH40168fq4YXBNM=;
 b=V7ImlZJ5slggkYPBVrMwCw0IGyOTStkBpt0fU/s8I3zP0U0SllYdLHESAtSeLDKmaiLx
 Cc4WHDJ0yrPcuu912zn/00uZ7ZHMeToWy8CGE8B6QFToZXkcYF+id7y/Dt8CjFX857jK
 st1wBF0fnTZBC0nm+mE/I+MSC5Ss9CagHOQAckfSO5+j5NLUtGeZDr3HfqW7Io9J5+jm
 svvixi25I4mmWXPPrVd8Iq5CLCmN+vAxXqk1Z+NYZahqL987jfXCvgRl64949qKmWvJO
 DbCs3r33Qm490+q8MwEVCWPETyUO8Ajg3KxdXluYLpZYnDRsMYfokkSQPWWe+x+N/gLg Vg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34y05h2eu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 18:01:41 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4FF7010002A;
        Mon, 23 Nov 2020 18:01:41 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 420F32BA2D0;
        Mon, 23 Nov 2020 18:01:41 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Nov 2020 18:01:40
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 4/6] phy: stm32: ensure pll is disabled before phys creation
Date:   Mon, 23 Nov 2020 18:01:30 +0100
Message-ID: <20201123170132.17859-5-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201123170132.17859-1-amelie.delaunay@st.com>
References: <20201123170132.17859-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_14:2020-11-23,2020-11-23 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ensure a good balancing of regulators, force PLL disable either by
reset or by clearing the PLLEN bit.
If waiting the powerdown pulse delay isn't enough, return -EPROBE_DEFER
instead of polling the PLLEN bit, which will be low at the next probe.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/phy/st/phy-stm32-usbphyc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
index 8ef97c8806ff..33367a325612 100644
--- a/drivers/phy/st/phy-stm32-usbphyc.c
+++ b/drivers/phy/st/phy-stm32-usbphyc.c
@@ -8,7 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
@@ -334,7 +334,7 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *child, *np = dev->of_node;
 	struct phy_provider *phy_provider;
-	u32 version;
+	u32 pllen, version;
 	int ret, port = 0;
 
 	usbphyc = devm_kzalloc(dev, sizeof(*usbphyc), GFP_KERNEL);
@@ -366,6 +366,19 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
 		ret = PTR_ERR(usbphyc->rst);
 		if (ret == -EPROBE_DEFER)
 			goto clk_disable;
+
+		stm32_usbphyc_clr_bits(usbphyc->base + STM32_USBPHYC_PLL, PLLEN);
+	}
+
+	/*
+	 * Wait for minimum width of powerdown pulse (ENABLE = Low):
+	 * we have to ensure the PLL is disabled before phys initialization.
+	 */
+	if (readl_relaxed_poll_timeout(usbphyc->base + STM32_USBPHYC_PLL,
+				       pllen, !(pllen & PLLEN), 5, 50)) {
+		dev_warn(usbphyc->dev, "PLL not reset\n");
+		ret = -EPROBE_DEFER;
+		goto clk_disable;
 	}
 
 	usbphyc->switch_setup = -EINVAL;
-- 
2.17.1

