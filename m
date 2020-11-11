Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B6B2AEFA6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 12:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgKKLdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 06:33:44 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:56728 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725909AbgKKLdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 06:33:37 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ABBVeHU019773;
        Wed, 11 Nov 2020 06:33:36 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 34nsc94xmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Nov 2020 06:33:36 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0ABBXZoC043115
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 11 Nov 2020 06:33:35 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 11 Nov
 2020 06:33:34 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 11 Nov 2020 06:33:34 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0ABBXWKa031837;
        Wed, 11 Nov 2020 06:33:32 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] uio/uio_pci_generic: use device-managed function equivalents
Date:   Wed, 11 Nov 2020 13:38:28 +0200
Message-ID: <20201111113828.64992-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-11_02:2020-11-10,2020-11-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 mlxlogscore=751 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011110066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver can be easily converted to use the device-managed allocator
function and the PCI managed enable function.

With these conversions the probe error paths are no longer needed and
neither is the remove function.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/uio/uio_pci_generic.c | 37 +++++++++--------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/uio/uio_pci_generic.c b/drivers/uio/uio_pci_generic.c
index dde5cbb27178..1c6c09e1280d 100644
--- a/drivers/uio/uio_pci_generic.c
+++ b/drivers/uio/uio_pci_generic.c
@@ -74,23 +74,19 @@ static int probe(struct pci_dev *pdev,
 	struct uio_pci_generic_dev *gdev;
 	int err;
 
-	err = pci_enable_device(pdev);
+	err = pcim_enable_device(pdev);
 	if (err) {
 		dev_err(&pdev->dev, "%s: pci_enable_device failed: %d\n",
 			__func__, err);
 		return err;
 	}
 
-	if (pdev->irq && !pci_intx_mask_supported(pdev)) {
-		err = -ENODEV;
-		goto err_verify;
-	}
+	if (pdev->irq && !pci_intx_mask_supported(pdev))
+		return -ENOMEM;
 
-	gdev = kzalloc(sizeof(struct uio_pci_generic_dev), GFP_KERNEL);
-	if (!gdev) {
-		err = -ENOMEM;
-		goto err_alloc;
-	}
+	gdev = devm_kzalloc(&pdev->dev, sizeof(struct uio_pci_generic_dev), GFP_KERNEL);
+	if (!gdev)
+		return -ENOMEM;
 
 	gdev->info.name = "uio_pci_generic";
 	gdev->info.version = DRIVER_VERSION;
@@ -105,34 +101,19 @@ static int probe(struct pci_dev *pdev,
 			 "no support for interrupts?\n");
 	}
 
-	err = uio_register_device(&pdev->dev, &gdev->info);
+	err = devm_uio_register_device(&pdev->dev, &gdev->info);
 	if (err)
-		goto err_register;
+		return err;
+
 	pci_set_drvdata(pdev, gdev);
 
 	return 0;
-err_register:
-	kfree(gdev);
-err_alloc:
-err_verify:
-	pci_disable_device(pdev);
-	return err;
-}
-
-static void remove(struct pci_dev *pdev)
-{
-	struct uio_pci_generic_dev *gdev = pci_get_drvdata(pdev);
-
-	uio_unregister_device(&gdev->info);
-	pci_disable_device(pdev);
-	kfree(gdev);
 }
 
 static struct pci_driver uio_pci_driver = {
 	.name = "uio_pci_generic",
 	.id_table = NULL, /* only dynamic id's */
 	.probe = probe,
-	.remove = remove,
 };
 
 module_pci_driver(uio_pci_driver);
-- 
2.17.1

