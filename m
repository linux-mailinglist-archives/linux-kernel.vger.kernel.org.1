Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045712BA408
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 08:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgKTH4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 02:56:39 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:13040 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726673AbgKTH4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:56:37 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AK7rfi4019313;
        Fri, 20 Nov 2020 02:56:36 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 34td19n60a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Nov 2020 02:56:36 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0AK7uYaH034920
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 20 Nov 2020 02:56:35 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 19 Nov
 2020 23:56:33 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 19 Nov 2020 23:56:33 -0800
Received: from saturn.ad.analog.com ([10.48.65.107])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AK7uUcs017423;
        Fri, 20 Nov 2020 02:56:30 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/2] uio: uio_dmem_genirq: convert simple allocations to device-managed
Date:   Fri, 20 Nov 2020 09:56:24 +0200
Message-ID: <20201120075625.12272-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-20_03:2020-11-19,2020-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=1
 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011200051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change converts the simple allocations in the driver to used
device-managed allocation functions.
This removes the error path entirely in the probe function, and reduces
some code in the remove function.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/uio/uio_dmem_genirq.c | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index ec7f66f4555a..72aa372d6ba6 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -154,11 +154,10 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 
 	if (pdev->dev.of_node) {
 		/* alloc uioinfo for one device */
-		uioinfo = kzalloc(sizeof(*uioinfo), GFP_KERNEL);
+		uioinfo = devm_kzalloc(&pdev->dev, sizeof(*uioinfo), GFP_KERNEL);
 		if (!uioinfo) {
-			ret = -ENOMEM;
 			dev_err(&pdev->dev, "unable to kmalloc\n");
-			goto bad2;
+			return -ENOMEM;
 		}
 		uioinfo->name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%pOFn",
 					       pdev->dev.of_node);
@@ -167,20 +166,19 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 
 	if (!uioinfo || !uioinfo->name || !uioinfo->version) {
 		dev_err(&pdev->dev, "missing platform_data\n");
-		goto bad0;
+		return -EINVAL;
 	}
 
 	if (uioinfo->handler || uioinfo->irqcontrol ||
 	    uioinfo->irq_flags & IRQF_SHARED) {
 		dev_err(&pdev->dev, "interrupt configuration error\n");
-		goto bad0;
+		return -EINVAL;
 	}
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
-		ret = -ENOMEM;
 		dev_err(&pdev->dev, "unable to kmalloc\n");
-		goto bad0;
+		return -ENOMEM;
 	}
 
 	dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
@@ -197,7 +195,7 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 		if (ret == -ENXIO && pdev->dev.of_node)
 			ret = UIO_IRQ_NONE;
 		else if (ret < 0)
-			goto bad1;
+			return ret;
 		uioinfo->irq = ret;
 	}
 
@@ -286,19 +284,11 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "unable to register uio device\n");
 		pm_runtime_disable(&pdev->dev);
-		goto bad1;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, priv);
 	return 0;
- bad1:
-	kfree(priv);
- bad0:
-	/* kfree uioinfo for OF */
-	if (pdev->dev.of_node)
-		kfree(uioinfo);
- bad2:
-	return ret;
 }
 
 static int uio_dmem_genirq_remove(struct platform_device *pdev)
@@ -308,14 +298,6 @@ static int uio_dmem_genirq_remove(struct platform_device *pdev)
 	uio_unregister_device(priv->uioinfo);
 	pm_runtime_disable(&pdev->dev);
 
-	priv->uioinfo->handler = NULL;
-	priv->uioinfo->irqcontrol = NULL;
-
-	/* kfree uioinfo for OF */
-	if (pdev->dev.of_node)
-		kfree(priv->uioinfo);
-
-	kfree(priv);
 	return 0;
 }
 
-- 
2.27.0

