Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CEB2743A7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgIVN5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:57:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:33670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbgIVN5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:57:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8D086AFF7;
        Tue, 22 Sep 2020 13:57:47 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     aris@ruivo.org, naoya.horiguchi@nec.com, mhocko@kernel.org,
        tony.luck@intel.com, cai@lca.pw, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v7 11/14] mm,hwpoison: return 0 if the page is already poisoned in soft-offline
Date:   Tue, 22 Sep 2020 15:56:47 +0200
Message-Id: <20200922135650.1634-12-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200922135650.1634-1-osalvador@suse.de>
References: <20200922135650.1634-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there is an inconsistency when calling soft-offline from
different paths on a page that is already poisoned.

1) madvise:

        madvise_inject_error skips any poisoned page and continues
        the loop.
        If that was the only page to madvise, it returns 0.

2) /sys/devices/system/memory/:

        When calling soft_offline_page_store()->soft_offline_page(),
        we return -EBUSY in case the page is already poisoned.
        This is inconsistent with a) the above example and b)
        memory_failure, where we return 0 if the page was poisoned.

Fix this by dropping the PageHWPoison() check in madvise_inject_error, and
let soft_offline_page return 0 if it finds the page already poisoned.

Please, note that this represents a user-api change, since now the return
error when calling soft_offline_page_store()->soft_offline_page() will be
different.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/madvise.c        | 5 -----
 mm/memory-failure.c | 4 ++--
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index f3a86d547ceb..5ab978b828f0 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -896,11 +896,6 @@ static int madvise_inject_error(int behavior,
 		 */
 		size = page_size(compound_head(page));
 
-		if (PageHWPoison(page)) {
-			put_page(page);
-			continue;
-		}
-
 		if (behavior == MADV_SOFT_OFFLINE) {
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
 				 pfn, start);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 7c122cca9f31..087f070b06b5 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1802,7 +1802,7 @@ static int __soft_offline_page(struct page *page)
 		unlock_page(page);
 		put_page(page);
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
-		return -EBUSY;
+		return 0;
 	}
 
 	if (!PageHuge(page))
@@ -1906,7 +1906,7 @@ int soft_offline_page(unsigned long pfn, int flags)
 		pr_info("soft offline: %#lx page already poisoned\n", pfn);
 		if (flags & MF_COUNT_INCREASED)
 			put_page(page);
-		return -EBUSY;
+		return 0;
 	}
 
 	get_online_mems();
-- 
2.26.2

