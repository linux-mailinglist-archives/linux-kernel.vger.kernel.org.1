Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE72A2CFC56
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgLER6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 12:58:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:48368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbgLERoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 12:44:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E7FCBAC55;
        Sat,  5 Dec 2020 15:34:27 +0000 (UTC)
Date:   Sat, 5 Dec 2020 16:34:23 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     akpm@linux-foundation.org, n-horiguchi@ah.jp.nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 3/7] mm,madvise: call soft_offline_page() without
 MF_COUNT_INCREASED
Message-ID: <20201205153423.GA4108@localhost.localdomain>
References: <20201119105716.5962-1-osalvador@suse.de>
 <20201119105716.5962-4-osalvador@suse.de>
 <2aa4bf71-443b-9b9b-b761-12761263dfec@suse.cz>
 <20201201113511.GA22242@linux>
 <840d4669-ae3f-b7c4-6132-e20d1bf9e952@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <840d4669-ae3f-b7c4-6132-e20d1bf9e952@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 06:25:31PM +0100, Vlastimil Babka wrote:
> OK, so that means we don't introduce this race for MADV_SOFT_OFFLINE, but it's
> already (and still) there for MADV_HWPOISON since Dan's 23e7b5c2e271 ("mm,
> madvise_inject_error: Let memory_failure() optionally take a page reference") no?

What about the following?
CCing Dan as well.

From: Oscar Salvador <osalvador@suse.de>
Date: Sat, 5 Dec 2020 16:14:40 +0100
Subject: [PATCH] mm,memory_failure: Always pin the page in
 madvise_inject_error

madvise_inject_error() uses get_user_pages_fast to get the page
from the addr we specified.
After [1], we drop such extra reference for memory_failure() path.
That commit says that memory_failure wanted to keep the pin in order
to take the page out of circulation.

The truth is that we need to keep the page pinned, otherwise the
page might be re-used after the put_page(), and we can end up messing
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
index 869ece2a1de2..ba861169c9ae 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1269,6 +1269,12 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	if (!cookie)
 		goto out;
 
+	if (flags & MF_COUNT_INCREASED)
+		/*
+		 * Drop the extra refcount in case we come from madvise().
+		 */
+		put_page(page);
+
 	if (hwpoison_filter(page)) {
 		rc = 0;
 		goto unlock;


-- 
Oscar Salvador
SUSE L3
