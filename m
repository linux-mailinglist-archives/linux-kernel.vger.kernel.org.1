Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AEB2BA4EB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 09:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgKTImZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 03:42:25 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:28318 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726460AbgKTImX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:42:23 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AK8YlQQ007000;
        Fri, 20 Nov 2020 03:42:22 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 34t9ybwndk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Nov 2020 03:42:22 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0AK8gLm5038125
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 20 Nov 2020 03:42:21 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 20 Nov 2020 03:42:20 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 20 Nov 2020 03:42:19 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 20 Nov 2020 03:42:19 -0500
Received: from saturn.ad.analog.com ([10.48.65.107])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AK8gFSb027136;
        Fri, 20 Nov 2020 03:42:17 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 3/3] uio: uio_netx: use devm_kzalloc() for or uio_info object
Date:   Fri, 20 Nov 2020 10:42:07 +0200
Message-ID: <20201120084207.50736-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201120084207.50736-1-alexandru.ardelean@analog.com>
References: <20201120084207.50736-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-20_03:2020-11-19,2020-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 suspectscore=3 impostorscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0 mlxlogscore=717
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011200057
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change uses the devm_kzalloc() function to tie the life-time of the
uio_info object to PCI device. This cleans up the exit & error path a bit.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/uio/uio_netx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/uio/uio_netx.c b/drivers/uio/uio_netx.c
index 9ae29ffde410..2319d6de8d04 100644
--- a/drivers/uio/uio_netx.c
+++ b/drivers/uio/uio_netx.c
@@ -53,12 +53,12 @@ static int netx_pci_probe(struct pci_dev *dev,
 	struct uio_info *info;
 	int bar;
 
-	info = kzalloc(sizeof(struct uio_info), GFP_KERNEL);
+	info = devm_kzalloc(&dev->dev, sizeof(struct uio_info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
 	if (pci_enable_device(dev))
-		goto out_free;
+		return -ENODEV;
 
 	if (pci_request_regions(dev, "netx"))
 		goto out_disable;
@@ -112,8 +112,6 @@ static int netx_pci_probe(struct pci_dev *dev,
 	pci_release_regions(dev);
 out_disable:
 	pci_disable_device(dev);
-out_free:
-	kfree(info);
 	return -ENODEV;
 }
 
@@ -127,8 +125,6 @@ static void netx_pci_remove(struct pci_dev *dev)
 	pci_release_regions(dev);
 	pci_disable_device(dev);
 	iounmap(info->mem[0].internal_addr);
-
-	kfree(info);
 }
 
 static struct pci_device_id netx_pci_ids[] = {
-- 
2.27.0

