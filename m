Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849C5260CA8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 09:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbgIHH4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 03:56:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:53144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729359AbgIHH4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:56:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 40BBCB6D4;
        Tue,  8 Sep 2020 07:56:36 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     naoya.horiguchi@nec.com, mhocko@kernel.org, tony.luck@intel.com,
        cai@lca.pw, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>,
        Oscar Salvador <osalvador@suse.com>
Subject: [PATCH v2 2/5] mm,hwpoison: Refactor madvise_inject_error
Date:   Tue,  8 Sep 2020 09:56:23 +0200
Message-Id: <20200908075626.11976-3-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200908075626.11976-1-osalvador@suse.de>
References: <20200908075626.11976-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make a proper if-else condition for {hard,soft}-offline.

Signed-off-by: Oscar Salvador <osalvador@suse.com>
---
 mm/madvise.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index e32e7efbba0f..e92e06890b08 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -885,7 +885,6 @@ static long madvise_remove(struct vm_area_struct *vma,
 static int madvise_inject_error(int behavior,
 		unsigned long start, unsigned long end)
 {
-	struct page *page;
 	struct zone *zone;
 	unsigned long size;
 
@@ -895,6 +894,7 @@ static int madvise_inject_error(int behavior,
 
 	for (; start < end; start += size) {
 		unsigned long pfn;
+		struct page *page;
 		int ret;
 
 		ret = get_user_pages_fast(start, 1, 0, &page);
@@ -911,25 +911,21 @@ static int madvise_inject_error(int behavior,
 
 		if (behavior == MADV_SOFT_OFFLINE) {
 			pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
-					pfn, start);
-
+				 pfn, start);
 			ret = soft_offline_page(pfn, MF_COUNT_INCREASED);
-			if (ret)
-				return ret;
-			continue;
+		} else {
+			pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
+				 pfn, start);
+			/*
+			 * Drop the page reference taken by get_user_pages_fast(). In
+			 * the absence of MF_COUNT_INCREASED the memory_failure()
+			 * routine is responsible for pinning the page to prevent it
+			 * from being released back to the page allocator.
+			 */
+			put_page(page);
+			ret = memory_failure(pfn, 0);
 		}
 
-		pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
-				pfn, start);
-
-		/*
-		 * Drop the page reference taken by get_user_pages_fast(). In
-		 * the absence of MF_COUNT_INCREASED the memory_failure()
-		 * routine is responsible for pinning the page to prevent it
-		 * from being released back to the page allocator.
-		 */
-		put_page(page);
-		ret = memory_failure(pfn, 0);
 		if (ret)
 			return ret;
 	}
-- 
2.26.2

