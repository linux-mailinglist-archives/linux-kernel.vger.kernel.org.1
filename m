Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B12C2BA407
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 08:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgKTH4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 02:56:37 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:12586 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbgKTH4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:56:37 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AK7sZqt011156;
        Fri, 20 Nov 2020 02:56:35 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 34t9ybwhpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Nov 2020 02:56:35 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0AK7uYCJ034921
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 20 Nov 2020 02:56:34 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 20 Nov 2020 02:56:33 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 20 Nov 2020 02:56:33 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 20 Nov 2020 02:56:33 -0500
Received: from saturn.ad.analog.com ([10.48.65.107])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AK7uUct017423;
        Fri, 20 Nov 2020 02:56:31 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/2] uio: uio_dmem_genirq: finalize conversion of probe to devm_ handlers
Date:   Fri, 20 Nov 2020 09:56:25 +0200
Message-ID: <20201120075625.12272-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201120075625.12272-1-alexandru.ardelean@analog.com>
References: <20201120075625.12272-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-20_03:2020-11-19,2020-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 suspectscore=1 impostorscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0 mlxlogscore=766
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011200051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves move pm_runtime_disable on a devm_add_action_or_reset() handler.
And with the use of the devm_uio_register_device() function, the remove
hook is no longer required.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/uio/uio_dmem_genirq.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index 72aa372d6ba6..6b5cfa5b0673 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -143,6 +143,13 @@ static int uio_dmem_genirq_irqcontrol(struct uio_info *dev_info, s32 irq_on)
 	return 0;
 }
 
+static void uio_dmem_genirq_pm_disable(void *data)
+{
+	struct device *dev = data;
+
+	pm_runtime_disable(dev);
+}
+
 static int uio_dmem_genirq_probe(struct platform_device *pdev)
 {
 	struct uio_dmem_genirq_pdata *pdata = dev_get_platdata(&pdev->dev);
@@ -280,25 +287,11 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 	 */
 	pm_runtime_enable(&pdev->dev);
 
-	ret = uio_register_device(&pdev->dev, priv->uioinfo);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to register uio device\n");
-		pm_runtime_disable(&pdev->dev);
+	ret = devm_add_action_or_reset(&pdev->dev, uio_dmem_genirq_pm_disable, &pdev->dev);
+	if (ret)
 		return ret;
-	}
-
-	platform_set_drvdata(pdev, priv);
-	return 0;
-}
-
-static int uio_dmem_genirq_remove(struct platform_device *pdev)
-{
-	struct uio_dmem_genirq_platdata *priv = platform_get_drvdata(pdev);
-
-	uio_unregister_device(priv->uioinfo);
-	pm_runtime_disable(&pdev->dev);
 
-	return 0;
+	return devm_uio_register_device(&pdev->dev, priv->uioinfo);
 }
 
 static int uio_dmem_genirq_runtime_nop(struct device *dev)
@@ -332,7 +325,6 @@ MODULE_DEVICE_TABLE(of, uio_of_genirq_match);
 
 static struct platform_driver uio_dmem_genirq = {
 	.probe = uio_dmem_genirq_probe,
-	.remove = uio_dmem_genirq_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.pm = &uio_dmem_genirq_dev_pm_ops,
-- 
2.27.0

