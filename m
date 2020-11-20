Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0162BA4E9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 09:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbgKTImW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 03:42:22 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:25728 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725801AbgKTImV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:42:21 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AK8b2i4018746;
        Fri, 20 Nov 2020 03:42:20 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 34td19n9ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Nov 2020 03:42:20 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0AK8gIFJ053252
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 20 Nov 2020 03:42:19 -0500
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 20 Nov 2020 00:42:17 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 20 Nov 2020 00:42:17 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 20 Nov 2020 00:42:16 -0800
Received: from saturn.ad.analog.com ([10.48.65.107])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AK8gFSZ027136;
        Fri, 20 Nov 2020 03:42:15 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/3] uio: uio_sercos3: use device-managed functions for simple allocs
Date:   Fri, 20 Nov 2020 10:42:05 +0200
Message-ID: <20201120084207.50736-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-20_03:2020-11-19,2020-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=3
 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 mlxlogscore=842 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011200057
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change converts the simple allocations [kzalloc()] to devm_kzalloc()
tying the life-time of these objects to the PCI device object.
It cleans up the error and exit path and bit, and does a minor correction
that -ENOMEM is returned (vs -ENODEV) in case the 'priv' object cannot be
allocated.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/uio/uio_sercos3.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/uio/uio_sercos3.c b/drivers/uio/uio_sercos3.c
index 9658a0887fee..b93a5f8f4cba 100644
--- a/drivers/uio/uio_sercos3.c
+++ b/drivers/uio/uio_sercos3.c
@@ -124,16 +124,16 @@ static int sercos3_pci_probe(struct pci_dev *dev,
 	struct sercos3_priv *priv;
 	int i;
 
-	info = kzalloc(sizeof(struct uio_info), GFP_KERNEL);
+	info = devm_kzalloc(&dev->dev, sizeof(struct uio_info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
-	priv = kzalloc(sizeof(struct sercos3_priv), GFP_KERNEL);
+	priv = devm_kzalloc(&dev->dev, sizeof(struct sercos3_priv), GFP_KERNEL);
 	if (!priv)
-		goto out_free;
+		return -ENOMEM;
 
 	if (pci_enable_device(dev))
-		goto out_free_priv;
+		return -ENODEV;
 
 	if (pci_request_regions(dev, "sercos3"))
 		goto out_disable;
@@ -174,10 +174,6 @@ static int sercos3_pci_probe(struct pci_dev *dev,
 	pci_release_regions(dev);
 out_disable:
 	pci_disable_device(dev);
-out_free_priv:
-	kfree(priv);
-out_free:
-	kfree(info);
 	return -ENODEV;
 }
 
@@ -193,8 +189,6 @@ static void sercos3_pci_remove(struct pci_dev *dev)
 		if (info->mem[i].internal_addr)
 			iounmap(info->mem[i].internal_addr);
 	}
-	kfree(info->priv);
-	kfree(info);
 }
 
 static struct pci_device_id sercos3_pci_ids[] = {
-- 
2.27.0

