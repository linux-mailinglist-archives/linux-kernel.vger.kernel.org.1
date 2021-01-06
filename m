Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249B92EBEEE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 14:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbhAFNkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 08:40:10 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:10402 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbhAFNjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 08:39:54 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D9r6F6RKmz7Q16;
        Wed,  6 Jan 2021 21:38:13 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 6 Jan 2021 21:39:02 +0800
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <robin.murphy@arm.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 1/6] iova: Make has_iova_flush_queue() private
Date:   Wed, 6 Jan 2021 21:35:06 +0800
Message-ID: <1609940111-28563-2-git-send-email-john.garry@huawei.com>
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

Function has_iova_flush_queue() has no users outside iova.c, so make it
private.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iova.c | 2 +-
 include/linux/iova.h | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 4bb3293ae4d7..0a758ec2a1c4 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -55,7 +55,7 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
 
-bool has_iova_flush_queue(struct iova_domain *iovad)
+static bool has_iova_flush_queue(struct iova_domain *iovad)
 {
 	return !!iovad->fq;
 }
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 76e16ae20729..2b76e0be1c5b 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -153,7 +153,6 @@ struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
 void copy_reserved_iova(struct iova_domain *from, struct iova_domain *to);
 void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	unsigned long start_pfn);
-bool has_iova_flush_queue(struct iova_domain *iovad);
 int init_iova_flush_queue(struct iova_domain *iovad,
 			  iova_flush_cb flush_cb, iova_entry_dtor entry_dtor);
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
@@ -223,11 +222,6 @@ static inline void init_iova_domain(struct iova_domain *iovad,
 {
 }
 
-static inline bool has_iova_flush_queue(struct iova_domain *iovad)
-{
-	return false;
-}
-
 static inline int init_iova_flush_queue(struct iova_domain *iovad,
 					iova_flush_cb flush_cb,
 					iova_entry_dtor entry_dtor)
-- 
2.26.2

