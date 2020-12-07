Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817912D0D5C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgLGJtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:49:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:58322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgLGJtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:49:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B8377ACBA;
        Mon,  7 Dec 2020 09:48:27 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, vbabka@suse.cz,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH] mm,memory_failure: Always pin the page in madvise_inject_error
Date:   Mon,  7 Dec 2020 10:48:18 +0100
Message-Id: <20201207094818.8518-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

madvise_inject_error() uses get_user_pages_fast to translate the
address we specified to a page.
After [1], we drop the extra reference count for memory_failure() path.
That commit says that memory_failure wanted to keep the pin in order
to take the page out of circulation.

The truth is that we need to keep the page pinned, otherwise the
page might be re-used after the put_page() and we can end up messing
with someone else's memory.

E.g:

CPU0
process X					CPU1
 madvise_inject_error
  get_user_pages
   put_page
					page gets reclaimed
					process Y allocates the page
  memory_failure
   // We mess with process Y memory

madvise() is meant to operate on a self address space, so messing with
pages that do not belong to us seems the wrong thing to do.
To avoid that, let us keep the page pinned for memory_failure as well.

Pages for DAX mappings will release this extra refcount in
memory_failure_dev_pagemap.

[1] ("23e7b5c2e271: mm, madvise_inject_error:
      Let memory_failure() optionally take a page reference")

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Fixes: 23e7b5c2e271 ("mm, madvise_inject_error: Let memory_failure() optionally take a page reference")
---
 mm/madvise.c        | 9 +--------
 mm/memory-failure.c | 6 ++++++
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index c6b5524add58..19edddba196d 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -907,14 +907,7 @@ static int madvise_inject_error(int behavior,
 		} else {
 			pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
 				 pfn, start);
-			/*
-			 * Drop the page reference taken by get_user_pages_fast(). In
-			 * the absence of MF_COUNT_INCREASED the memory_failure()
-			 * routine is responsible for pinning the page to prevent it
-			 * from being released back to the page allocator.
-			 */
-			put_page(page);
-			ret = memory_failure(pfn, 0);
+			ret = memory_failure(pfn, MF_COUNT_INCREASED);
 		}
 
 		if (ret)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 869ece2a1de2..064d605cc416 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1258,6 +1258,12 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	loff_t start;
 	dax_entry_t cookie;
 
+	if (flags & MF_COUNT_INCREASED)
+		/*
+		 * Drop the extra refcount in case we come from madvise().
+		 */
+		put_page(page);
+
 	/*
 	 * Prevent the inode from being freed while we are interrogating
 	 * the address_space, typically this would be handled by
-- 
2.26.2

