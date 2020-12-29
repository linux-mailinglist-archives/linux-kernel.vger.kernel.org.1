Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B51A2E70F2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 14:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgL2NlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 08:41:03 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10092 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgL2NlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 08:41:02 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D4wW701LPzMBDJ;
        Tue, 29 Dec 2020 21:39:15 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.179) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Tue, 29 Dec 2020 21:40:08 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>
CC:     <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] dma-debug: Delete outdated comment of the hash function
Date:   Tue, 29 Dec 2020 21:40:06 +0800
Message-ID: <20201229134006.1691-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.179]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We actually use dev_addr[26:13] as the index into dma_entry_hash. Given
that the code itself is clear enough, let's drop the hardcoded comment so
that we won't need to revisit it every time HASH_FN_{SHIFT,MASK} gets
updated.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 kernel/dma/debug.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 14de1271463f..d89341162d35 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -235,10 +235,7 @@ static bool driver_filter(struct device *dev)
  */
 static int hash_fn(struct dma_debug_entry *entry)
 {
-	/*
-	 * Hash function is based on the dma address.
-	 * We use bits 20-27 here as the index into the hash
-	 */
+	/* Hash function is based on the dma address. */
 	return (entry->dev_addr >> HASH_FN_SHIFT) & HASH_FN_MASK;
 }
 
-- 
2.19.1

