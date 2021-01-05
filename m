Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C012EA6F8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbhAEJGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:06:45 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:8850 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727670AbhAEJGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:06:30 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10593vKQ012821;
        Tue, 5 Jan 2021 10:05:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=2Z6aA2xM5KmOkEYCXhXC5WTtn79IXskuK3OjvQYi6L4=;
 b=m5AqsyWPSgn8+MS+QlKJG9tBG5h05Ok1tTEbW9F3jVmtqbIfdeMsIUdF7h/8kaOmrVHr
 1HskGu//68mUb+vwEiSHxhSxOxonXlKdEVZ02/YnSE9efjzYkQb5ex2fTJjvkFrZbfkj
 +jR2t9PuZabgsQpYM/30x8h3IkJFvpkjDENgt2h+f7sc0/cEQWDmzRtYvIif1V3jxmGO
 KYvygDOm5j0fRXKBetav02WJ8m27w8iApUEUDFl1psHbkwQLMmTD/d4BFa/8+D6kAoNo
 AR6u5quq2Ks+C37BA90e8ZIsYvLyl7juMNgxhg2Xif2T9OJvnwcfG5K/XrgzjlxL7Bs0 kA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35teuuywxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 10:05:38 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BF89410002A;
        Tue,  5 Jan 2021 10:05:37 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ADCB822AA5B;
        Tue,  5 Jan 2021 10:05:37 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 Jan 2021 10:05:37
 +0100
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH v2 4/6] phy: stm32: ensure pll is disabled before phys creation
Date:   Tue, 5 Jan 2021 10:05:23 +0100
Message-ID: <20210105090525.23164-5-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105090525.23164-1-amelie.delaunay@foss.st.com>
References: <20210105090525.23164-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_01:2021-01-05,2021-01-05 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ensure a good balancing of regulators, force PLL disable either by
reset or by clearing the PLLEN bit.
If waiting the powerdown pulse delay isn't enough, return -EPROBE_DEFER
instead of polling the PLLEN bit, which will be low at the next probe.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
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

