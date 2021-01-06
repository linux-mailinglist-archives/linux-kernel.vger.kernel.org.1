Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187682EBEF0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 14:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbhAFNkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 08:40:07 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10028 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbhAFNj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 08:39:57 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D9r6L53K4zhwLG;
        Wed,  6 Jan 2021 21:38:18 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 6 Jan 2021 21:39:03 +0800
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <robin.murphy@arm.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 3/6] iova: Stop exporting some more functions
Date:   Wed, 6 Jan 2021 21:35:08 +0800
Message-ID: <1609940111-28563-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1609940111-28563-1-git-send-email-john.garry@huawei.com>
References: <1609940111-28563-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following functions are not referenced outside dma-iommu.c (and
iova.c), which can only be built-in:
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

