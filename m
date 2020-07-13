Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEDA721D814
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 16:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbgGMOPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 10:15:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7845 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729649AbgGMOPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:15:50 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7CDD5BCC515B84495D4F;
        Mon, 13 Jul 2020 22:15:48 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Mon, 13 Jul 2020 22:15:38 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>, Joerg Roedel <joro@8bytes.org>,
        Eric Auger <eric.auger@redhat.com>,
        Tom Murphy <murphyt7@tcd.ie>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] iommu: Make some functions static
Date:   Mon, 13 Jul 2020 22:25:42 +0800
Message-ID: <20200713142542.50294-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

drivers/iommu/iommu.c:386:5: warning:
 symbol 'iommu_insert_resv_region' was not declared. Should it be static?
drivers/iommu/iommu.c:2182:5: warning:
 symbol '__iommu_map' was not declared. Should it be static?

Those functions are not used outside of iommu.c, so mark them static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/iommu/iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1ed1e14a1f0c..40947f5bc6c5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -383,8 +383,8 @@ static ssize_t iommu_group_show_name(struct iommu_group *group, char *buf)
  * Elements are sorted by start address and overlapping segments
  * of the same type are merged.
  */
-int iommu_insert_resv_region(struct iommu_resv_region *new,
-			     struct list_head *regions)
+static int iommu_insert_resv_region(struct iommu_resv_region *new,
+				    struct list_head *regions)
 {
 	struct iommu_resv_region *iter, *tmp, *nr, *top;
 	LIST_HEAD(stack);
@@ -2179,8 +2179,8 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
 	return pgsize;
 }
 
-int __iommu_map(struct iommu_domain *domain, unsigned long iova,
-	      phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
+		       phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
 {
 	const struct iommu_ops *ops = domain->ops;
 	unsigned long orig_iova = iova;

