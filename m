Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE3C2C55FD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390619AbgKZNkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:40:42 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7994 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390022AbgKZNkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:40:41 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Chf5H5B0czhdfC;
        Thu, 26 Nov 2020 21:40:03 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 26 Nov 2020
 21:40:11 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
CC:     <will@kernel.org>, <joro@8bytes.org>, <yangyingliang@huawei.com>
Subject: [PATCH v2] iommu: return error code when it can't get group
Date:   Thu, 26 Nov 2020 21:38:25 +0800
Message-ID: <20201126133825.3643852-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's better to return error code if it can't get group
in iommu_probe_device(). It's no function change.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/iommu/iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index b53446bb8c6b..6f4a32df90f6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -253,8 +253,10 @@ int iommu_probe_device(struct device *dev)
 		goto err_out;
 
 	group = iommu_group_get(dev);
-	if (!group)
+	if (!group) {
+		ret = -ENODEV;
 		goto err_release;
+	}
 
 	/*
 	 * Try to allocate a default domain - needs support from the
-- 
2.25.1

