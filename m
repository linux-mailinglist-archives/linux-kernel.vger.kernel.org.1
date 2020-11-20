Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35EBD2BA4EA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 09:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgKTImY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 03:42:24 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:27870 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725801AbgKTImX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:42:23 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AK8b2Rj018755;
        Fri, 20 Nov 2020 03:42:22 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 34td19n9rc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Nov 2020 03:42:22 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0AK8gKPk038121
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 20 Nov 2020 03:42:20 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 20 Nov
 2020 00:42:19 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 20 Nov 2020 00:42:18 -0800
Received: from saturn.ad.analog.com ([10.48.65.107])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AK8gFSa027136;
        Fri, 20 Nov 2020 03:42:16 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/3] uio: uio_mf624: use devm_kzalloc() for uio_info object
Date:   Fri, 20 Nov 2020 10:42:06 +0200
Message-ID: <20201120084207.50736-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201120084207.50736-1-alexandru.ardelean@analog.com>
References: <20201120084207.50736-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-20_03:2020-11-19,2020-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=3
 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 mlxlogscore=762 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011200057
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change uses the devm_kzalloc() function to tie the life-time of the
uio_info object to PCI device. This cleans up the exit & error path a bit.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/uio/uio_mf624.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/uio/uio_mf624.c b/drivers/uio/uio_mf624.c
index b6a406986667..5065c6a073a8 100644
--- a/drivers/uio/uio_mf624.c
+++ b/drivers/uio/uio_mf624.c
@@ -136,12 +136,12 @@ static int mf624_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct uio_info *info;
 
-	info = kzalloc(sizeof(struct uio_info), GFP_KERNEL);
+	info = devm_kzalloc(&dev->dev, sizeof(struct uio_info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
 	if (pci_enable_device(dev))
-		goto out_free;
+		return -ENODEV;
 
 	if (pci_request_regions(dev, "mf624"))
 		goto out_disable;
@@ -189,8 +189,6 @@ static int mf624_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 out_disable:
 	pci_disable_device(dev);
 
-out_free:
-	kfree(info);
 	return -ENODEV;
 }
 
@@ -207,8 +205,6 @@ static void mf624_pci_remove(struct pci_dev *dev)
 	iounmap(info->mem[0].internal_addr);
 	iounmap(info->mem[1].internal_addr);
 	iounmap(info->mem[2].internal_addr);
-
-	kfree(info);
 }
 
 static const struct pci_device_id mf624_pci_id[] = {
-- 
2.27.0

