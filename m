Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5902EFE93
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 09:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbhAIILC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 03:11:02 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:10427 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbhAIILC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 03:11:02 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DCXgc1LXfzj3wh;
        Sat,  9 Jan 2021 16:09:32 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Sat, 9 Jan 2021
 16:10:07 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/swap_slots.c: Remove unnecessary NULL pointer check
Date:   Sat, 9 Jan 2021 03:09:43 -0500
Message-ID: <20210109080943.34832-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cache->slots and cache->slots_ret is already checked before we try to
drain it. And kvfree can handle the NULL pointer itself. So remove the
NULL pointer check here.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swap_slots.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 0357fbe70645..4cf99ce033d0 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -178,7 +178,7 @@ static void drain_slots_cache_cpu(unsigned int cpu, unsigned int type,
 		swapcache_free_entries(cache->slots + cache->cur, cache->nr);
 		cache->cur = 0;
 		cache->nr = 0;
-		if (free_slots && cache->slots) {
+		if (free_slots) {
 			kvfree(cache->slots);
 			cache->slots = NULL;
 		}
@@ -188,13 +188,12 @@ static void drain_slots_cache_cpu(unsigned int cpu, unsigned int type,
 		spin_lock_irq(&cache->free_lock);
 		swapcache_free_entries(cache->slots_ret, cache->n_ret);
 		cache->n_ret = 0;
-		if (free_slots && cache->slots_ret) {
+		if (free_slots) {
 			slots = cache->slots_ret;
 			cache->slots_ret = NULL;
 		}
 		spin_unlock_irq(&cache->free_lock);
-		if (slots)
-			kvfree(slots);
+		kvfree(slots);
 	}
 }
 
-- 
2.19.1

