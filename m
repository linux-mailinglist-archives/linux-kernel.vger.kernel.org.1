Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B63227700E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgIXLhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:37:24 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54196 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726701AbgIXLhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:37:24 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 58C29EBD63B2E3745623;
        Thu, 24 Sep 2020 19:37:23 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Thu, 24 Sep 2020
 19:37:14 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/swap_slots.c: Remove always zero and unused return value of enable_swap_slots_cache()
Date:   Thu, 24 Sep 2020 07:35:54 -0400
Message-ID: <20200924113554.50614-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enable_swap_slots_cache() always return zero and its return value is just
ignored by the caller. So make enable_swap_slots_cache() void.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/swap_slots.h | 2 +-
 mm/swap_slots.c            | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/swap_slots.h b/include/linux/swap_slots.h
index e36b200c2a77..347f1a304190 100644
--- a/include/linux/swap_slots.h
+++ b/include/linux/swap_slots.h
@@ -23,7 +23,7 @@ struct swap_slots_cache {
 
 void disable_swap_slots_cache_lock(void);
 void reenable_swap_slots_cache_unlock(void);
-int enable_swap_slots_cache(void);
+void enable_swap_slots_cache(void);
 int free_swap_slot(swp_entry_t entry);
 
 extern bool swap_slot_cache_enabled;
diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 3e6453573a89..0357fbe70645 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -237,7 +237,7 @@ static int free_slot_cache(unsigned int cpu)
 	return 0;
 }
 
-int enable_swap_slots_cache(void)
+void enable_swap_slots_cache(void)
 {
 	mutex_lock(&swap_slots_cache_enable_mutex);
 	if (!swap_slot_cache_initialized) {
@@ -255,7 +255,6 @@ int enable_swap_slots_cache(void)
 	__reenable_swap_slots_cache();
 out_unlock:
 	mutex_unlock(&swap_slots_cache_enable_mutex);
-	return 0;
 }
 
 /* called with swap slot cache's alloc lock held */
-- 
2.19.1

