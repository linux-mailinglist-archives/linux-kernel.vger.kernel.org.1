Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3051AACB5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 18:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415124AbgDOQA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 12:00:26 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17542 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2410029AbgDOP67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:58:59 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03FFX9Hr020652;
        Wed, 15 Apr 2020 17:58:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=ysOQdhxkH/yrY5LkPt2G2khgQ9eVt+ECxotn643GF5M=;
 b=zxVPhSIXIipKdyN43ht2fZhnWd2je/Ls21V8h85LhCNHLSrJvKD3jhO/1M+GhJjG6RAd
 aRWJkbPx5oxTdC+fi9f+2p1VWrgWptTcD4YA1dQeB17HVUS32g4PuuF+HQzCqbngkZRe
 c/1R6B45PMIpx+OdlIGWMfWi97NRl+/M25gx0ws8S4dFcfYteZmln85vK4Co0n2hs2fQ
 Iq3LFQbeZ9pdHNs7dla4TBBl8AR+HG4GN5/+p2ocj4uwnLW0Hs+iFJw54PPqR78nOqcF
 yJ1dFwl4LDQe5IyQixNkpxkl7uxXLjFsNcpg6uAxNdi2UArX1q/nuwMsS0r23ANwsM83 TQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30dn6svygw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Apr 2020 17:58:41 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E24D2100039;
        Wed, 15 Apr 2020 17:58:40 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CDF302AF597;
        Wed, 15 Apr 2020 17:58:40 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 15 Apr 2020 17:58:40
 +0200
From:   Christophe Kerello <christophe.kerello@st.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <tony@atomide.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>,
        Christophe Kerello <christophe.kerello@st.com>
Subject: [PATCH v2 04/12] mtd: rawnand: stm32_fmc2: manage all errors cases at probe time
Date:   Wed, 15 Apr 2020 17:57:28 +0200
Message-ID: <1586966256-29548-5-git-send-email-christophe.kerello@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
References: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-15_05:2020-04-14,2020-04-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defers its probe when the expected reset control is not
yet ready. This patch also handles properly all errors cases at probe
time.

Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index b6d45cd..0a96797 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -1967,7 +1967,11 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
 	}
 
 	rstc = devm_reset_control_get(dev, NULL);
-	if (!IS_ERR(rstc)) {
+	if (IS_ERR(rstc)) {
+		ret = PTR_ERR(rstc);
+		if (ret == -EPROBE_DEFER)
+			goto err_clk_disable;
+	} else {
 		reset_control_assert(rstc);
 		reset_control_deassert(rstc);
 	}
@@ -1975,7 +1979,7 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
 	/* DMA setup */
 	ret = stm32_fmc2_dma_setup(fmc2);
 	if (ret)
-		return ret;
+		goto err_dma_setup;
 
 	/* FMC2 init routine */
 	stm32_fmc2_init(fmc2);
@@ -1997,7 +2001,7 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
 	/* Scan to find existence of the device */
 	ret = nand_scan(chip, nand->ncs);
 	if (ret)
-		goto err_scan;
+		goto err_dma_setup;
 
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret)
@@ -2010,7 +2014,7 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
 err_device_register:
 	nand_cleanup(chip);
 
-err_scan:
+err_dma_setup:
 	if (fmc2->dma_ecc_ch)
 		dma_release_channel(fmc2->dma_ecc_ch);
 	if (fmc2->dma_tx_ch)
@@ -2021,6 +2025,7 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
 	sg_free_table(&fmc2->dma_data_sg);
 	sg_free_table(&fmc2->dma_ecc_sg);
 
+err_clk_disable:
 	clk_disable_unprepare(fmc2->clk);
 
 	return ret;
-- 
1.9.1

