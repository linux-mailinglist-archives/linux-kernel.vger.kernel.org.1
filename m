Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546432AEF66
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 12:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgKKLRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 06:17:45 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:60346 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725859AbgKKLRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 06:17:43 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ABBFDlX021615;
        Wed, 11 Nov 2020 06:17:42 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 34npaaw3rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Nov 2020 06:17:42 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0ABBHfNr002707
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 11 Nov 2020 06:17:41 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 11 Nov 2020 06:17:40 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 11 Nov 2020 06:17:40 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 11 Nov 2020 06:17:40 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0ABBHcF5031045;
        Wed, 11 Nov 2020 06:17:38 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/2] uio: pruss: move simple allocations to dem_ equivalents
Date:   Wed, 11 Nov 2020 13:22:41 +0200
Message-ID: <20201111112242.62116-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-11_02:2020-11-10,2020-11-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxlogscore=865 clxscore=1011 lowpriorityscore=0
 suspectscore=3 bulkscore=0 impostorscore=0 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011110064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change moves the simple allocations to their device-managed
equivalents.
This cleans up some error/exit paths.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/uio/uio_pruss.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/uio/uio_pruss.c b/drivers/uio/uio_pruss.c
index 1cc175d3c25c..41470c4dba02 100644
--- a/drivers/uio/uio_pruss.c
+++ b/drivers/uio/uio_pruss.c
@@ -99,7 +99,6 @@ static void pruss_cleanup(struct device *dev, struct uio_pruss_dev *gdev)
 
 	for (cnt = 0; cnt < MAX_PRUSS_EVT; cnt++, p++) {
 		uio_unregister_device(p);
-		kfree(p->name);
 	}
 	iounmap(gdev->prussio_vaddr);
 	if (gdev->ddr_vaddr) {
@@ -110,10 +109,8 @@ static void pruss_cleanup(struct device *dev, struct uio_pruss_dev *gdev)
 		gen_pool_free(gdev->sram_pool,
 			      gdev->sram_vaddr,
 			      sram_pool_sz);
-	kfree(gdev->info);
 	clk_disable(gdev->pruss_clk);
 	clk_put(gdev->pruss_clk);
-	kfree(gdev);
 }
 
 static int pruss_probe(struct platform_device *pdev)
@@ -125,22 +122,19 @@ static int pruss_probe(struct platform_device *pdev)
 	int ret, cnt, i, len;
 	struct uio_pruss_pdata *pdata = dev_get_platdata(dev);
 
-	gdev = kzalloc(sizeof(struct uio_pruss_dev), GFP_KERNEL);
+	gdev = devm_kzalloc(dev, sizeof(struct uio_pruss_dev), GFP_KERNEL);
 	if (!gdev)
 		return -ENOMEM;
 
-	gdev->info = kcalloc(MAX_PRUSS_EVT, sizeof(*p), GFP_KERNEL);
-	if (!gdev->info) {
-		ret = -ENOMEM;
-		goto err_free_gdev;
-	}
+	gdev->info = devm_kcalloc(dev, MAX_PRUSS_EVT, sizeof(*p), GFP_KERNEL);
+	if (!gdev->info)
+		return -ENOMEM;
 
 	/* Power on PRU in case its not done as part of boot-loader */
 	gdev->pruss_clk = clk_get(dev, "pruss");
 	if (IS_ERR(gdev->pruss_clk)) {
 		dev_err(dev, "Failed to get clock\n");
-		ret = PTR_ERR(gdev->pruss_clk);
-		goto err_free_info;
+		return PTR_ERR(gdev->pruss_clk);
 	}
 
 	ret = clk_enable(gdev->pruss_clk);
@@ -206,7 +200,7 @@ static int pruss_probe(struct platform_device *pdev)
 		p->mem[2].size = extram_pool_sz;
 		p->mem[2].memtype = UIO_MEM_PHYS;
 
-		p->name = kasprintf(GFP_KERNEL, "pruss_evt%d", cnt);
+		p->name = devm_kasprintf(dev, GFP_KERNEL, "pruss_evt%d", cnt);
 		p->version = DRV_VERSION;
 
 		/* Register PRUSS IRQ lines */
@@ -215,10 +209,8 @@ static int pruss_probe(struct platform_device *pdev)
 		p->priv = gdev;
 
 		ret = uio_register_device(dev, p);
-		if (ret < 0) {
-			kfree(p->name);
+		if (ret < 0)
 			goto err_unloop;
-		}
 	}
 
 	platform_set_drvdata(pdev, gdev);
@@ -227,7 +219,6 @@ static int pruss_probe(struct platform_device *pdev)
 err_unloop:
 	for (i = 0, p = gdev->info; i < cnt; i++, p++) {
 		uio_unregister_device(p);
-		kfree(p->name);
 	}
 	iounmap(gdev->prussio_vaddr);
 err_free_ddr_vaddr:
@@ -240,10 +231,6 @@ static int pruss_probe(struct platform_device *pdev)
 	clk_disable(gdev->pruss_clk);
 err_clk_put:
 	clk_put(gdev->pruss_clk);
-err_free_info:
-	kfree(gdev->info);
-err_free_gdev:
-	kfree(gdev);
 
 	return ret;
 }
-- 
2.17.1

