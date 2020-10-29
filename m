Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9883E29E716
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgJ2JTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:19:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6707 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ2JTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:19:00 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CMKd00X6WzkYYL;
        Thu, 29 Oct 2020 17:19:00 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 29 Oct 2020
 17:18:47 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <joro@8bytes.org>, <mripard@kernel.org>, <wens@csie.org>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH] iommu/sun50i: check return value of of_find_device_by_node() in sun50i_iommu_of_xlate()
Date:   Thu, 29 Oct 2020 17:22:44 +0800
Message-ID: <20201029092244.900564-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If of_find_device_by_node() failed in sun50i_iommu_of_xlate(), null
pointer dereference will be triggered. Thus return error code if
of_find_device_by_node() failed.

Fixes: 4100b8c229b3("iommu: Add Allwinner H6 IOMMU driver")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/iommu/sun50i-iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index ea6db1341916..ce94ffa15215 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -764,6 +764,9 @@ static int sun50i_iommu_of_xlate(struct device *dev,
 	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
 	unsigned id = args->args[0];
 
+	if (!iommu_pdev)
+		return -ENODEV;
+
 	dev_iommu_priv_set(dev, platform_get_drvdata(iommu_pdev));
 
 	return iommu_fwspec_add_ids(dev, &id, 1);
-- 
2.25.4

