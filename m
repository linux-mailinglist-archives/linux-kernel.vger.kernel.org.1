Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF1A29E713
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgJ2JSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:18:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:6924 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ2JSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:18:25 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CMKcH1GJ7z7005;
        Thu, 29 Oct 2020 17:18:23 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Thu, 29 Oct 2020
 17:18:12 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <joro@8bytes.org>, <heiko@sntech.de>, <robin.murphy@arm.com>,
        <jeffy.chen@rock-chips.com>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH] iommu/rockchip: check return value of of_find_device_by_node() in rk_iommu_of_xlate()
Date:   Thu, 29 Oct 2020 17:22:02 +0800
Message-ID: <20201029092202.900218-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If of_find_device_by_node() failed in rk_iommu_of_xlate(), null pointer
dereference will be triggered. Thus return error code if
of_find_device_by_node() failed.

Fixes: 5fd577c3eac3("iommu/rockchip: Use OF_IOMMU to attach devices automatically")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/iommu/rockchip-iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index e5d86b7177de..090d149ef8e9 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1099,6 +1099,9 @@ static int rk_iommu_of_xlate(struct device *dev,
 
 	iommu_dev = of_find_device_by_node(args->np);
 
+	if (!iommu_dev)
+		return -ENODEV;
+
 	data->iommu = platform_get_drvdata(iommu_dev);
 	dev_iommu_priv_set(dev, data);
 
-- 
2.25.4

