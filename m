Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EF92B9574
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgKSOqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:46:08 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:1166 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727875AbgKSOqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:46:07 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJEgx6g023029;
        Thu, 19 Nov 2020 09:46:06 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 34td19hx6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 09:46:06 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0AJEk5qr031326
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 19 Nov 2020 09:46:05 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 19 Nov 2020 09:46:04 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 19 Nov 2020 09:46:04 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 19 Nov 2020 09:46:04 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AJEk2KT029332;
        Thu, 19 Nov 2020 09:46:02 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2] uio: pruss: use devm_clk_get() for clk init
Date:   Thu, 19 Nov 2020 16:50:59 +0200
Message-ID: <20201119145059.48326-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111112242.62116-2-alexandru.ardelean@analog.com>
References: <20201111112242.62116-2-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_09:2020-11-19,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=3
 impostorscore=0 mlxscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 mlxlogscore=676 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change uses devm_clk_get() to obtain a reference to the clock. It has
the benefit that clk_put() is no longer required, and cleans up the exit &
error path.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
* reverted silly/goofed `return ret` to `return PTR_ERR(gdev->pruss_clk);`
  this caused a warning about `ret` being uninitialized

 drivers/uio/uio_pruss.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/uio/uio_pruss.c b/drivers/uio/uio_pruss.c
index 41470c4dba02..e9096f53b4cc 100644
--- a/drivers/uio/uio_pruss.c
+++ b/drivers/uio/uio_pruss.c
@@ -110,7 +110,6 @@ static void pruss_cleanup(struct device *dev, struct uio_pruss_dev *gdev)
 			      gdev->sram_vaddr,
 			      sram_pool_sz);
 	clk_disable(gdev->pruss_clk);
-	clk_put(gdev->pruss_clk);
 }
 
 static int pruss_probe(struct platform_device *pdev)
@@ -131,7 +130,7 @@ static int pruss_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* Power on PRU in case its not done as part of boot-loader */
-	gdev->pruss_clk = clk_get(dev, "pruss");
+	gdev->pruss_clk = devm_clk_get(dev, "pruss");
 	if (IS_ERR(gdev->pruss_clk)) {
 		dev_err(dev, "Failed to get clock\n");
 		return PTR_ERR(gdev->pruss_clk);
@@ -140,7 +139,7 @@ static int pruss_probe(struct platform_device *pdev)
 	ret = clk_enable(gdev->pruss_clk);
 	if (ret) {
 		dev_err(dev, "Failed to enable clock\n");
-		goto err_clk_put;
+		return ret;
 	}
 
 	regs_prussio = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -229,8 +228,6 @@ static int pruss_probe(struct platform_device *pdev)
 		gen_pool_free(gdev->sram_pool, gdev->sram_vaddr, sram_pool_sz);
 err_clk_disable:
 	clk_disable(gdev->pruss_clk);
-err_clk_put:
-	clk_put(gdev->pruss_clk);
 
 	return ret;
 }
-- 
2.17.1

