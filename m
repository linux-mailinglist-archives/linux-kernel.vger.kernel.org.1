Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED4B2993F2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788010AbgJZRfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:35:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3624 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780901AbgJZRfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:35:39 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CKhnT14fFzLn9q;
        Tue, 27 Oct 2020 01:35:41 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 27 Oct 2020 01:35:28 +0800
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <robin.murphy@arm.com>
CC:     <xiyou.wangcong@gmail.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <chenxiang66@hisilicon.com>, <thunder.leizhen@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 1/4] iommu/iova: Add free_all_cpu_cached_iovas()
Date:   Tue, 27 Oct 2020 01:31:38 +0800
Message-ID: <1603733501-211004-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1603733501-211004-1-git-send-email-john.garry@huawei.com>
References: <1603733501-211004-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper function to free the CPU rcache for all online CPUs.

There also exists a function of the same name in
drivers/iommu/intel/iommu.c, but the parameters are different, and there
should be no conflict.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iova.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 30d969a4c5fd..81b7399dd5e8 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -227,6 +227,14 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	return -ENOMEM;
 }
 
+static void free_all_cpu_cached_iovas(struct iova_domain *iovad)
+{
+	unsigned int cpu;
+
+	for_each_online_cpu(cpu)
+		free_cpu_cached_iovas(cpu, iovad);
+}
+
 static struct kmem_cache *iova_cache;
 static unsigned int iova_cache_users;
 static DEFINE_MUTEX(iova_cache_mutex);
@@ -422,15 +430,12 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 retry:
 	new_iova = alloc_iova(iovad, size, limit_pfn, true);
 	if (!new_iova) {
-		unsigned int cpu;
-
 		if (!flush_rcache)
 			return 0;
 
 		/* Try replenishing IOVAs by flushing rcache. */
 		flush_rcache = false;
-		for_each_online_cpu(cpu)
-			free_cpu_cached_iovas(cpu, iovad);
+		free_all_cpu_cached_iovas(iovad);
 		goto retry;
 	}
 
-- 
2.26.2

