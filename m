Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BBC2EA6F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbhAEJGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:06:32 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:8856 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727672AbhAEJGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:06:30 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10593qwp012400;
        Tue, 5 Jan 2021 10:05:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=/2wbABcAabZ863t3k+1NIXCvucu34dgQxMNtvkMdxHk=;
 b=qJzvVEVpMCoN7KzR9C7//Z0RdRNGGEe3AP5f6TFQ+fXDdQFVJUoceKphTp5wTi3rhSdL
 Qwtdo8yQHGtVwpqACNjtl8epgIkbrzPVqNyNfPWrj7uBVaKie0iMXPel7utxbFWiZwwu
 KnaE5XURQZFmpVJt6q5jOc+xMhztshdHlow9y8gJcWluDWisSlaQ+WGrSHJ0JJXbANek
 VNsD8OSlIcyxgZE9dzuF9KdDYHH8AWAL83Q67hTKoiqbttNeDd08f6lEbZujsnb39YGL
 Eo8ASP/xdgo/jJR6LJA/sE7VSp+nfoYgq7Olbwaou35qhlyGaM6RfOCI312PLW9atg31 3A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35teuuywxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 10:05:39 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B7DB110002A;
        Tue,  5 Jan 2021 10:05:38 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A735922AA5B;
        Tue,  5 Jan 2021 10:05:38 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 Jan 2021 10:05:38
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
Subject: [PATCH v2 5/6] phy: stm32: ensure phy are no more active when removing the driver
Date:   Tue, 5 Jan 2021 10:05:24 +0100
Message-ID: <20210105090525.23164-6-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105090525.23164-1-amelie.delaunay@foss.st.com>
References: <20210105090525.23164-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_01:2021-01-05,2021-01-05 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ensure a good balancing of regulators, and allow PLL disabling when the
driver is removed, call stm32_usbphyc_phy_exit on each ports to set phys
inactive and disable PLL.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/phy/st/phy-stm32-usbphyc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
index 33367a325612..8b11d95b2c20 100644
--- a/drivers/phy/st/phy-stm32-usbphyc.c
+++ b/drivers/phy/st/phy-stm32-usbphyc.c
@@ -470,6 +470,12 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
 static int stm32_usbphyc_remove(struct platform_device *pdev)
 {
 	struct stm32_usbphyc *usbphyc = dev_get_drvdata(&pdev->dev);
+	int port;
+
+	/* Ensure PHYs are not active, to allow PLL disabling */
+	for (port = 0; port < usbphyc->nphys; port++)
+		if (usbphyc->phys[port]->active)
+			stm32_usbphyc_phy_exit(usbphyc->phys[port]->phy);
 
 	clk_disable_unprepare(usbphyc->clk);
 
-- 
2.17.1

