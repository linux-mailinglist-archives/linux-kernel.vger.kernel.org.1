Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307D826DD4E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 15:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgIQN6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 09:58:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:33992 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbgIQNyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:54:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 11DBEB13C;
        Thu, 17 Sep 2020 13:40:43 +0000 (UTC)
Date:   Thu, 17 Sep 2020 15:40:06 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "aris@ruivo.org" <aris@ruivo.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "cai@lca.pw" <cai@lca.pw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v4 0/7] HWpoison: further fixes and cleanups
Message-ID: <20200917133959.GA2504@linux>
References: <20200917081049.27428-1-osalvador@suse.de>
 <20200917113920.GA19898@hori.linux.bs1.fc.nec.co.jp>
 <20200917130948.GA1812@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917130948.GA1812@linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 03:09:52PM +0200, Oscar Salvador wrote:
> static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, bool release)
> {
>         if (release) {
>                 put_page(page);
>                 drain_all_pages(page_zone(page));
>         }
> 
> 	...
>         SetPageHWPoison(page);
>         page_ref_inc(page);
> 
> 1) You are freeing the page first, which means it goes to buddy
> 2) Then you set it as poisoned and you update its refcount.
> 
> Now we have a page sitting in Buddy with a refcount = 1 and poisoned, and that is quite wrong.

Hi Naoya,

Ok, I tested it and with the following changes on top I cannot reproduce the issue:

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index f68cb5e3b320..4ffaaa5c2603 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -67,11 +67,6 @@ atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
 static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, bool release)
 {
-	if (release) {
-		put_page(page);
-		drain_all_pages(page_zone(page));
-	}
-
 	if (hugepage_or_freepage) {
 		/*
 		 * Doing this check for free pages is also fine since dissolve_free_huge_page
@@ -89,6 +84,12 @@ static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, boo
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
@@ -1173,6 +1173,16 @@ static __always_inline bool free_pages_prepare(struct page *page,
 
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
 	 * avoid checking PageCompound for order-0 pages.


# sh tmp_run_ksm_madv.sh 
p1 0x7f6b6b08e000
p2 0x7f6b529ee000
madvise(p1) 0
madvise(p2) 0
writing p1 ... done
writing p2 ... done
soft offline
soft offline returns 0
OK


Can you try to re-run your tests and see if they come clean?
If they do, I will try to see if Andrew can squezee above changes into [1],
where they belong to.

Otherwise I will craft a v5 containing all fixups (pretty unfortunate).

[1] https://patchwork.kernel.org/patch/11704099/

-- 
Oscar Salvador
SUSE L3
