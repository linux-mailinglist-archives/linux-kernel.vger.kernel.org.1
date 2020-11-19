Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F302B9690
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgKSPoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:44:01 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:56756 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728158AbgKSPn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:43:58 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJFOU7N007711;
        Thu, 19 Nov 2020 10:43:55 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 34t9ybtmgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 10:43:55 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0AJFhsMY035790
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 19 Nov 2020 10:43:54 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 19 Nov 2020 10:43:53 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 19 Nov 2020 10:43:53 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 19 Nov 2020 10:43:53 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AJFhotQ032189;
        Thu, 19 Nov 2020 10:43:51 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/4] uio: uio_aec: use devm_kzalloc() for uio_info object
Date:   Thu, 19 Nov 2020 17:49:01 +0200
Message-ID: <20201119154903.82099-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119154903.82099-1-alexandru.ardelean@analog.com>
References: <20201119154903.82099-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_09:2020-11-19,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 suspectscore=3 impostorscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0 mlxlogscore=779
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The uio_info object is free'd last, so it's life-time is tied PCI device
object. Using devm_kzalloc() cleans up the error path a bit and the exit
path.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/uio/uio_aec.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/uio/uio_aec.c b/drivers/uio/uio_aec.c
index 381a26dfac46..32357f8a92b5 100644
--- a/drivers/uio/uio_aec.c
+++ b/drivers/uio/uio_aec.c
@@ -71,12 +71,12 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct uio_info *info;
 	int ret;
 
-	info = kzalloc(sizeof(struct uio_info), GFP_KERNEL);
+	info = devm_kzalloc(&pdev->dev, sizeof(struct uio_info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
 	if (pci_enable_device(pdev))
-		goto out_free;
+		return -ENODEV;
 
 	if (pci_request_regions(pdev, "aectc"))
 		goto out_disable;
@@ -117,8 +117,6 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pci_release_regions(pdev);
 out_disable:
 	pci_disable_device(pdev);
-out_free:
-	kfree(info);
 	return -ENODEV;
 }
 
@@ -136,8 +134,6 @@ static void remove(struct pci_dev *pdev)
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	iounmap(info->priv);
-
-	kfree(info);
 }
 
 static struct pci_driver pci_driver = {
-- 
2.17.1

