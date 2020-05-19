Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7201D9312
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 11:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgESJPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 05:15:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55070 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728582AbgESJPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 05:15:47 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3006BE2481FF2DFF7BBE;
        Tue, 19 May 2020 17:15:45 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 19 May 2020 17:15:35 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Joerg Roedel <joro@8bytes.org>, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Maxime Ripard" <maxime@cerno.tech>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] iommu/sun50i: Fix return value check in sun50i_iommu_probe()
Date:   Tue, 19 May 2020 09:18:57 +0000
Message-ID: <20200519091857.134170-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, the function devm_platform_ioremap_resource() returns
ERR_PTR() not NULL. The NULL test in the return value check must be
replaced with IS_ERR().

Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/iommu/sun50i-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 9c763d4a8e2a..1fa09ddcebd4 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -941,7 +941,7 @@ static int sun50i_iommu_probe(struct platform_device *pdev)
 	}
 
 	iommu->base = devm_platform_ioremap_resource(pdev, 0);
-	if (!iommu->base) {
+	if (IS_ERR(iommu->base)) {
 		ret = PTR_ERR(iommu->base);
 		goto err_free_group;
 	}



