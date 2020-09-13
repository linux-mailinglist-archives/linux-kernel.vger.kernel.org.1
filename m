Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78255267F0C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 11:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgIMJ41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 05:56:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11823 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbgIMJ4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 05:56:24 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 73D2A87072464EBBDCB6;
        Sun, 13 Sep 2020 17:56:21 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Sun, 13 Sep 2020
 17:56:13 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: Fix some broken comments
Date:   Sun, 13 Sep 2020 05:54:56 -0400
Message-ID: <20200913095456.54873-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some broken comments including typo, grammar error and wrong function
name.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/filemap.c    | 4 ++--
 mm/swap_state.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 585278d13d96..ac04738bf11b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1347,7 +1347,7 @@ static inline bool clear_bit_unlock_is_negative_byte(long nr, volatile void *mem
  * unlock_page - unlock a locked page
  * @page: the page
  *
- * Unlocks the page and wakes up sleepers in ___wait_on_page_locked().
+ * Unlocks the page and wakes up sleepers in wait_on_page_locked().
  * Also wakes sleepers in wait_on_page_writeback() because the wakeup
  * mechanism between PageLocked pages and PageWriteback pages is shared.
  * But that's OK - sleepers in wait_on_page_writeback() just go back to sleep.
@@ -2902,7 +2902,7 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 		goto out;
 
 	/*
-	 * Page is not up to date and may be locked due one of the following
+	 * Page is not up to date and may be locked due to one of the following
 	 * case a: Page is being filled and the page lock is held
 	 * case b: Read/write error clearing the page uptodate status
 	 * case c: Truncation in progress (page locked)
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 7f9449bbffdb..6f4212d34aac 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -245,7 +245,7 @@ int add_to_swap(struct page *page)
 		goto fail;
 	/*
 	 * Normally the page will be dirtied in unmap because its pte should be
-	 * dirty. A special case is MADV_FREE page. The page'e pte could have
+	 * dirty. A special case is MADV_FREE page. The page's pte could have
 	 * dirty bit cleared but the page's SwapBacked bit is still set because
 	 * clearing the dirty bit and SwapBacked bit has no lock protected. For
 	 * such page, unmap will not set dirty bit for it, so page reclaim will
-- 
2.19.1

