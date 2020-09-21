Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23972723D1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgIUMXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:23:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13750 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726460AbgIUMXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:23:51 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6A4C5BE4391C92E5B691;
        Mon, 21 Sep 2020 20:23:49 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 20:23:43 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: swap: Use memset to fill the swap_map with SWAP_HAS_CACHE
Date:   Mon, 21 Sep 2020 08:22:24 -0400
Message-ID: <20200921122224.7139-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We could use helper memset to fill the swap_map with SWAP_HAS_CACHE instead
of a direct loop here to simplify the code. Also we can remove the local
variable i and map this way.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swapfile.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 8feaab31a3a9..b0b629b24e3a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -975,8 +975,7 @@ static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
 {
 	unsigned long idx;
 	struct swap_cluster_info *ci;
-	unsigned long offset, i;
-	unsigned char *map;
+	unsigned long offset;
 
 	/*
 	 * Should not even be attempting cluster allocations when huge
@@ -996,9 +995,7 @@ static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
 	alloc_cluster(si, idx);
 	cluster_set_count_flag(ci, SWAPFILE_CLUSTER, CLUSTER_FLAG_HUGE);
 
-	map = si->swap_map + offset;
-	for (i = 0; i < SWAPFILE_CLUSTER; i++)
-		map[i] = SWAP_HAS_CACHE;
+	memset(si->swap_map + offset, SWAP_HAS_CACHE, SWAPFILE_CLUSTER);
 	unlock_cluster(ci);
 	swap_range_alloc(si, offset, SWAPFILE_CLUSTER);
 	*slot = swp_entry(si->type, offset);
-- 
2.19.1

