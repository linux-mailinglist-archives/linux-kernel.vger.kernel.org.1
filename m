Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D272B968E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgKSPoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:44:00 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:56942 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728741AbgKSPn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:43:58 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJFQu7i016533;
        Thu, 19 Nov 2020 10:43:56 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 34td19j7fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 10:43:55 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0AJFhs8s035793
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 19 Nov 2020 10:43:54 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 19 Nov
 2020 10:43:53 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 19 Nov 2020 10:43:53 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AJFhotR032189;
        Thu, 19 Nov 2020 10:43:52 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 3/4] uio: uio_fsl_elbc_gpcm: use device-managed allocators
Date:   Thu, 19 Nov 2020 17:49:02 +0200
Message-ID: <20201119154903.82099-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119154903.82099-1-alexandru.ardelean@analog.com>
References: <20201119154903.82099-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_09:2020-11-19,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=3
 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 mlxlogscore=914 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change moves all the simple allocations to use device-managed
allocator functions. This way their life-time is tied to the
platform_device object, so when this gets free'd these allocations also get
cleaned up.
The final effect is that error & exit paths get cleaned up a bit.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/uio/uio_fsl_elbc_gpcm.c | 32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/uio/uio_fsl_elbc_gpcm.c b/drivers/uio/uio_fsl_elbc_gpcm.c
index be8a6905f507..7d8eb9dc2068 100644
--- a/drivers/uio/uio_fsl_elbc_gpcm.c
+++ b/drivers/uio/uio_fsl_elbc_gpcm.c
@@ -299,7 +299,7 @@ static int get_of_data(struct fsl_elbc_gpcm *priv, struct device_node *node,
 	/* get optional uio name */
 	if (of_property_read_string(node, "uio_name", &dt_name) != 0)
 		dt_name = "eLBC_GPCM";
-	*name = kstrdup(dt_name, GFP_KERNEL);
+	*name = devm_kstrdup(priv->dev, dt_name, GFP_KERNEL);
 	if (!*name)
 		return -ENOMEM;
 
@@ -324,7 +324,7 @@ static int uio_fsl_elbc_gpcm_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	/* allocate private data */
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 	priv->dev = &pdev->dev;
@@ -334,14 +334,12 @@ static int uio_fsl_elbc_gpcm_probe(struct platform_device *pdev)
 	ret = get_of_data(priv, node, &res, &reg_br_new, &reg_or_new,
 			  &irq, &uio_name);
 	if (ret)
-		goto out_err0;
+		return ret;
 
 	/* allocate UIO structure */
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
-	if (!info) {
-		ret = -ENOMEM;
-		goto out_err0;
-	}
+	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
 
 	/* get current BR/OR values */
 	reg_br_cur = in_be32(&priv->lbc->bank[priv->bank].br);
@@ -354,8 +352,7 @@ static int uio_fsl_elbc_gpcm_probe(struct platform_device *pdev)
 		     != fsl_lbc_addr(res.start)) {
 			dev_err(priv->dev,
 				"bank in use by another peripheral\n");
-			ret = -ENODEV;
-			goto out_err1;
+			return -ENODEV;
 		}
 
 		/* warn if behavior settings changing */
@@ -382,12 +379,11 @@ static int uio_fsl_elbc_gpcm_probe(struct platform_device *pdev)
 	info->mem[0].internal_addr = ioremap(res.start, resource_size(&res));
 	if (!info->mem[0].internal_addr) {
 		dev_err(priv->dev, "failed to map chip region\n");
-		ret = -ENODEV;
-		goto out_err1;
+		return -ENODEV;
 	}
 
 	/* set all UIO data */
-	info->mem[0].name = kasprintf(GFP_KERNEL, "%pOFn", node);
+	info->mem[0].name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%pOFn", node);
 	info->mem[0].addr = res.start;
 	info->mem[0].size = resource_size(&res);
 	info->mem[0].memtype = UIO_MEM_PHYS;
@@ -428,12 +424,6 @@ static int uio_fsl_elbc_gpcm_probe(struct platform_device *pdev)
 	if (priv->shutdown)
 		priv->shutdown(info, true);
 	iounmap(info->mem[0].internal_addr);
-out_err1:
-	kfree(info->mem[0].name);
-	kfree(info);
-out_err0:
-	kfree(uio_name);
-	kfree(priv);
 	return ret;
 }
 
@@ -447,10 +437,6 @@ static int uio_fsl_elbc_gpcm_remove(struct platform_device *pdev)
 	if (priv->shutdown)
 		priv->shutdown(info, false);
 	iounmap(info->mem[0].internal_addr);
-	kfree(info->mem[0].name);
-	kfree(info->name);
-	kfree(info);
-	kfree(priv);
 
 	return 0;
 
-- 
2.17.1

