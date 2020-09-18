Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C77426F789
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 09:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgIRH6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 03:58:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:58164 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgIRH6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 03:58:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B7562AD33;
        Fri, 18 Sep 2020 07:58:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 18 Sep 2020 09:58:22 +0200
From:   osalvador@suse.de
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, tony.luck@intel.com, david@redhat.com,
        aneesh.kumar@linux.vnet.ibm.com, zeil@yandex-team.ru, cai@lca.pw,
        nao.horiguchi@gmail.com, naoya.horiguchi@nec.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/12] mm,hwpoison: Rework soft offline for in-use
 pages
In-Reply-To: <20200806184923.7007-9-nao.horiguchi@gmail.com>
References: <20200806184923.7007-1-nao.horiguchi@gmail.com>
 <20200806184923.7007-9-nao.horiguchi@gmail.com>
User-Agent: Roundcube Webmail
Message-ID: <7e948108488864b6d9131d990d5f6c80@suse.de>
X-Sender: osalvador@suse.de
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-06 20:49, nao.horiguchi@gmail.com wrote:
> From: Oscar Salvador <osalvador@suse.de>
> 
> This patch changes the way we set and handle in-use poisoned pages.
> Until now, poisoned pages were released to the buddy allocator, 
> trusting
> that the checks that take place prior to hand the page would act as a
> safe net and would skip that page.
> 
> This has proved to be wrong, as we got some pfn walkers out there, like
> compaction, that all they care is the page to be PageBuddy and be in a
> freelist.
> Although this might not be the only user, having poisoned pages
> in the buddy allocator seems a bad idea as we should only have
> free pages that are ready and meant to be used as such.
> 
> Before explaining the taken approach, let us break down the kind
> of pages we can soft offline.
> 
> - Anonymous THP (after the split, they end up being 4K pages)
> - Hugetlb
> - Order-0 pages (that can be either migrated or invalited)
> 
> * Normal pages (order-0 and anon-THP)
> 
>   - If they are clean and unmapped page cache pages, we invalidate
>     then by means of invalidate_inode_page().
>   - If they are mapped/dirty, we do the isolate-and-migrate dance.
> 
>   Either way, do not call put_page directly from those paths.
>   Instead, we keep the page and send it to page_set_poison to perform 
> the
>   right handling.
> 
>   page_set_poison sets the HWPoison flag and does the last put_page.
>   This call to put_page is mainly to be able to call 
> __page_cache_release,
>   since this function is not exported.
> 
>   Down the chain, we placed a check for HWPoison page in
>   free_pages_prepare, that just skips any poisoned page, so those pages
>   do not end up in any pcplist/freelist.
> 
>   After that, we set the refcount on the page to 1 and we increment
>   the poisoned pages counter.
> 
>   We could do as we do for free pages:
>   1) wait until the page hits buddy's freelists
>   2) take it off
>   3) flag it
> 
>   The problem is that we could race with an allocation, so by the time 
> we
>   want to take the page off the buddy, the page is already allocated, 
> so we
>   cannot soft-offline it.
>   This is not fatal of course, but if it is better if we can close the 
> race
>   as does not require a lot of code.
> 
> * Hugetlb pages
> 
>   - We isolate-and-migrate them
> 
>   After the migration has been successful, we call 
> dissolve_free_huge_page,
>   and we set HWPoison on the page if we succeed.
>   Hugetlb has a slightly different handling though.
> 
>   While for non-hugetlb pages we cared about closing the race with an
>   allocation, doing so for hugetlb pages requires quite some additional
>   code (we would need to hook in free_huge_page and some other places).
>   So I decided to not make the code overly complicated and just fail
>   normally if the page we allocated in the meantime.
> 
> Because of the way we handle now in-use pages, we no longer need the
> put-as-isolation-migratetype dance, that was guarding for poisoned 
> pages
> to end up in pcplists.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Hi Andrew,

I just found out yesterday that the patchset Naoya sent has diverged 
from mine in some aspects that lead to some bugs [1].
This was due to a misunderstanding so no blame here.
So, patch#8 and patch#9 need a little tweak [2].

I was wondering what do you prefer?

1) I paste the chunks that need to be changed in the offending patches 
(this and patch#9)
2) I just send them as standalone patches and you applied them on top

I am asking this because although patches had hit -next, we might still 
have time to change them.
If not, do not worry, I will send them as standalone.

[1] https://patchwork.kernel.org/comment/23622881/
[2] https://patchwork.kernel.org/comment/23622985/

I will go ahead and paste the chunks here, in case you lean towards 
option#1:

Patch#8:

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index f68cb5e3b320..4ffaaa5c2603 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -67,11 +67,6 @@ atomic_long_t num_poisoned_pages __read_mostly = 
ATOMIC_LONG_INIT(0);

  static bool page_handle_poison(struct page *page, bool 
hugepage_or_freepage, bool release)
  {
-	if (release) {
-		put_page(page);
-		drain_all_pages(page_zone(page));
-	}
-
  	if (hugepage_or_freepage) {
  		/*
  		 * Doing this check for free pages is also fine since 
dissolve_free_huge_page
@@ -89,6 +84,12 @@ static bool page_handle_poison(struct page *page, 
bool hugepage_or_freepage, boo
  	}

  	SetPageHWPoison(page);
+
+	if (release) {
+                put_page(page);
+                drain_all_pages(page_zone(page));
+        }
+
  	page_ref_inc(page);
  	num_poisoned_pages_inc();
  	return true;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0d9f9bd0e06c..8a6ab05f074c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1173,6 +1173,16 @@ static __always_inline bool 
free_pages_prepare(struct page *page,

  	trace_mm_page_free(page, order);

+	if (unlikely(PageHWPoison(page)) && !order) {
+		/*
+		 * Untie memcg state and reset page's owner
+		 */
+		if (memcg_kmem_enabled() && PageKmemcg(page))
+			__memcg_kmem_uncharge_page(page, order);
+		reset_page_owner(page, order);
+		return false;
+	}
+
  	/*
  	 * Check tail pages before head page information is cleared to
  	 * avoid checking PageCompound for order-0 pag

Patch#9:

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c3b96ca5c86d..a1bc573d91d5 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1835,7 +1835,7 @@ static int __soft_offline_page(struct page *page)
  		if (!ret) {
  			bool release = !huge;

-			if (!page_handle_poison(page, true, release))
+			if (!page_handle_poison(page, huge, release))
  				ret = -EBUSY;
  		} else {
  			if (!list_empty(&pagelist)

Thanks ans sorry for the inconvenience.

