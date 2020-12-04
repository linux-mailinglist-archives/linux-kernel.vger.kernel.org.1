Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DD32CEC24
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgLDK0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:26:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:41432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729872AbgLDK0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:26:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 49628AD11;
        Fri,  4 Dec 2020 10:26:05 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, vbabka@suse.cz, qcai@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 3/3] mm,hwpoison: Remove drain_all_pages from shake_page
Date:   Fri,  4 Dec 2020 11:25:58 +0100
Message-Id: <20201204102558.31607-4-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20201204102558.31607-1-osalvador@suse.de>
References: <20201204102558.31607-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_hwpoison_page already drains pcplists, previously disabling
them when trying to grab a refcount.
We do not need shake_page to take care of it anymore.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 079c6b430084..428991e297e2 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -263,8 +263,8 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 }
 
 /*
- * When a unknown page type is encountered drain as many buffers as possible
- * in the hope to turn the page into a LRU or free page, which we can handle.
+ * Unknown page type encountered. Try to check whether it can turn PageLRU by
+ * lru_add_drain_all, or a free page by reclaiming slabs when possible.
  */
 void shake_page(struct page *p, int access)
 {
@@ -273,9 +273,6 @@ void shake_page(struct page *p, int access)
 
 	if (!PageSlab(p)) {
 		lru_add_drain_all();
-		if (PageLRU(p))
-			return;
-		drain_all_pages(page_zone(p));
 		if (PageLRU(p) || is_free_buddy_page(p))
 			return;
 	}
-- 
2.26.2

