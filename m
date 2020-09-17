Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EB626D69C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgIQI3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:29:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:56742 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgIQI2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:28:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A0572B053;
        Thu, 17 Sep 2020 08:29:05 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     aris@ruivo.org, naoya.horiguchi@nec.com, mhocko@kernel.org,
        tony.luck@intel.com, cai@lca.pw, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Oscar Salvador <osalvador@suse.de>,
        Oscar Salvador <osalvador@suse.com>
Subject: [PATCH v4 4/7] mm,hwpoison: refactor madvise_inject_error
Date:   Thu, 17 Sep 2020 10:10:46 +0200
Message-Id: <20200917081049.27428-5-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200917081049.27428-1-osalvador@suse.de>
References: <20200917081049.27428-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make a proper if-else condition for {hard,soft}-offline.

[akpm: remove zone variable and refactor comment]
Signed-off-by: Oscar Salvador <osalvador@suse.com>
---
 mm/madvise.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 4d87b31a1576..4a48f7215195 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -869,8 +869,6 @@ static long madvise_remove(struct vm_area_struct *vma,
 static int madvise_inject_error(int behavior,
 		unsigned long start, unsigned long end)
 {
-	struct page *page;
-	struct zone *zone;
 	unsigned long size;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -879,6 +877,7 @@ static int madvise_inject_error(int behavior,
 
 	for (; start < end; start += size) {
 		unsigned long pfn;
+		struct page *page;
 		int ret;
 
 		ret = get_user_pages_fast(start, 1, 0, &page);
@@ -895,25 +894,22 @@ static int madvise_inject_error(int behavior,
 
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
+			 * Drop the page reference taken by
+			 * get_user_pages_fast(). In the absence of
+			 * MF_COUNT_INCREASED the memory_failure() routine is
+			 * responsible for pinning the page to prevent it
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

