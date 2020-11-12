Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63C92B03EB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgKLLcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:32:36 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7213 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgKLLc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:32:28 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CWzwC4Rl2zkjj2;
        Thu, 12 Nov 2020 19:32:11 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 12 Nov 2020 19:32:15 +0800
From:   John Garry <john.garry@huawei.com>
To:     <robin.murphy@arm.com>, <joro@8bytes.org>
CC:     <xiyou.wangcong@gmail.com>, <linuxarm@huawei.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v3 4/4] iommu: avoid taking iova_rbtree_lock twice
Date:   Thu, 12 Nov 2020 19:28:29 +0800
Message-ID: <1605180509-9183-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1605180509-9183-1-git-send-email-john.garry@huawei.com>
References: <1605180509-9183-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

Both find_iova() and __free_iova() take iova_rbtree_lock,
there is no reason to take and release it twice inside
free_iova().

Fold them into one critical section by calling the unlock
versions instead.

Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iova.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 386005055aca..3b32e6746c70 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -398,10 +398,14 @@ EXPORT_SYMBOL_GPL(__free_iova);
 void
 free_iova(struct iova_domain *iovad, unsigned long pfn)
 {
-	struct iova *iova = find_iova(iovad, pfn);
+	unsigned long flags;
+	struct iova *iova;
 
+	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+	iova = private_find_iova(iovad, pfn);
 	if (iova)
-		__free_iova(iovad, iova);
+		private_free_iova(iovad, iova);
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 
 }
 EXPORT_SYMBOL_GPL(free_iova);
-- 
2.26.2

