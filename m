Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4D72D460A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 16:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbgLIPzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 10:55:11 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9410 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731369AbgLIPzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:55:01 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CrhRV46tTz7Bq4;
        Wed,  9 Dec 2020 23:53:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 9 Dec 2020 23:54:06 +0800
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 3/3] iova: Stop exporting some more functions
Date:   Wed, 9 Dec 2020 23:50:19 +0800
Message-ID: <1607529019-229549-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1607529019-229549-1-git-send-email-john.garry@huawei.com>
References: <1607529019-229549-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following functions are not referenced outside dma-iommu.c (apart
from iova.c), which can only be built-in:
- init_iova_flush_queue()
- free_iova_fast()
- queue_iova()
- alloc_iova_fast()

So stop exporting them.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iova.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 04f0a3ae1c63..f9c35852018d 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -112,7 +112,6 @@ int init_iova_flush_queue(struct iova_domain *iovad,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(init_iova_flush_queue);
 
 static struct rb_node *
 __get_cached_rbnode(struct iova_domain *iovad, unsigned long limit_pfn)
@@ -451,7 +450,6 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 
 	return new_iova->pfn_lo;
 }
-EXPORT_SYMBOL_GPL(alloc_iova_fast);
 
 /**
  * free_iova_fast - free iova pfn range into rcache
@@ -469,7 +467,6 @@ free_iova_fast(struct iova_domain *iovad, unsigned long pfn, unsigned long size)
 
 	free_iova(iovad, pfn);
 }
-EXPORT_SYMBOL_GPL(free_iova_fast);
 
 #define fq_ring_for_each(i, fq) \
 	for ((i) = (fq)->head; (i) != (fq)->tail; (i) = ((i) + 1) % IOVA_FQ_SIZE)
@@ -598,7 +595,6 @@ void queue_iova(struct iova_domain *iovad,
 		mod_timer(&iovad->fq_timer,
 			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
 }
-EXPORT_SYMBOL_GPL(queue_iova);
 
 /**
  * put_iova_domain - destroys the iova doamin
-- 
2.26.2

