Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A0B1C5E85
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 19:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbgEEROW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 13:14:22 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:56404 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729209AbgEEROG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 13:14:06 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 045GvZBx012960;
        Tue, 5 May 2020 19:13:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=P+DYjJ1GrlLPWPS5TfKbJgOvt9CYy26/DlrQnU+Di10=;
 b=W6mNMQCdIJRf33+gh9d+cXNdNjuyibvk6X5ws2pPtPEdjX1tBF2pN2g+IHiZfg3CDoqd
 84Rp5sAiAsIyfcluUtXeHEkeRaGMeV2O5Td/f8ZB3azYQt8ovQ4Q6gMwijsfyIK7HHya
 u1ZVQ/zYc3TCZO5ArutMN6IUnnR4O2WsOBh+pFNZXfjFSqhUCqlOx4TUvsh8wd4Wvkk1
 vXkdLNq5/6jMc3e46m3VoYqwagGY2ILQPTU4FlpjCbHJ6TEzbch/eG5g7Qu/tbvTAnab
 vh++B7s3y0L6EJp5+KdY96ZyS7psJxO24SBqXEA8ZCmg/2ukM3Hdh0WXfyUsTTKYhYHR 2w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30ryrj9ded-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 19:13:43 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C41C410002A;
        Tue,  5 May 2020 19:13:42 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ACCC52B5A78;
        Tue,  5 May 2020 19:13:42 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 5 May 2020 19:13:41
 +0200
From:   Christophe Kerello <christophe.kerello@st.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <gregkh@linuxfoundation.org>, <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>,
        Christophe Kerello <christophe.kerello@st.com>
Subject: [PATCH v3 01/10] mtd: rawnand: stm32_fmc2: manage all errors cases at probe time
Date:   Tue, 5 May 2020 19:10:59 +0200
Message-ID: <1588698668-25288-2-git-send-email-christophe.kerello@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1588698668-25288-1-git-send-email-christophe.kerello@st.com>
References: <1588698668-25288-1-git-send-email-christophe.kerello@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-05_09:2020-05-04,2020-05-05 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defers its probe when the expected reset control is not
yet ready. This patch also handles properly all errors cases at probe
time.

Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
---
Changes in v3:
 - rename labels used on errors

 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index b6d45cd..50a6377 100644
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
+		goto err_release_dma;
 
 	/* FMC2 init routine */
 	stm32_fmc2_init(fmc2);
@@ -1997,20 +2001,20 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
 	/* Scan to find existence of the device */
 	ret = nand_scan(chip, nand->ncs);
 	if (ret)
-		goto err_scan;
+		goto err_release_dma;
 
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret)
-		goto err_device_register;
+		goto err_nand_cleanup;
 
 	platform_set_drvdata(pdev, fmc2);
 
 	return 0;
 
-err_device_register:
+err_nand_cleanup:
 	nand_cleanup(chip);
 
-err_scan:
+err_release_dma:
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

