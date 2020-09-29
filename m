Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6DA27B93B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 03:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgI2BRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 21:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgI2BRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 21:17:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F454C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 18:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=milDVUuSmfsrFdAiaYla+xJb7Ck9lXAUrHzP+4VmmLU=; b=ZQdPo6H20LXu1iZOWIBNJa8yEH
        uH3n4rP2XE4/AR9ONbmBuEIy496TgmygeYkD1I23N1f9tyJphyaMvsd1Zv1XrgNXdLYhk8/eYQ+ov
        DzcSrIEhB2j+cSuhENWH5SZ2cXk8PEgknrtmU1fkv2yzgwpHhCyRscOr/icVpPqOrlUe+zk+QBTGi
        oG3uda1pKDPTaajGAdui9H6LeinKU3/eYhZLxGBhf55M6mewss9Kh7yzsn/JGShzC6xdh3759Ebnx
        C1VMhq3s91BkO0oeumwx6fqbPvwvheLykwLuwA/yj9bnuNuoiovjxJzZ20/rFw2VXCq8lqw4aKQVR
        t93Mb1hw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kN4Gd-0003UE-Sw; Tue, 29 Sep 2020 01:17:19 +0000
Date:   Tue, 29 Sep 2020 02:17:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Piggin <npiggin@gmail.com>, Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] page_alloc: Fix freeing non-compound pages
Message-ID: <20200929011719.GD30994@casper.infradead.org>
References: <20200926213919.26642-1-willy@infradead.org>
 <20200928180307.7573f3b6128b5e3007dfc9f0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928180307.7573f3b6128b5e3007dfc9f0@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 06:03:07PM -0700, Andrew Morton wrote:
> On Sat, 26 Sep 2020 22:39:19 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> 
> > Here is a very rare race which leaks memory:
> 
> Not worth a cc:stable?

Yes, it probably should have been.  I just assume the stablebot will
pick up anything that has a Fixes: tag.

> > Page P0 is allocated to the page cache.  Page P1 is free.
> > 
> > Thread A                Thread B                Thread C
> > find_get_entry():
> > xas_load() returns P0
> > 						Removes P0 from page cache
> > 						P0 finds its buddy P1
> > 			alloc_pages(GFP_KERNEL, 1) returns P0
> > 			P0 has refcount 1
> > page_cache_get_speculative(P0)
> > P0 has refcount 2
> > 			__free_pages(P0)
> 
> 			__free_pages(P0, 1), I assume.

Good catch.  That was what I meant to type.

> > 			P0 has refcount 1
> > put_page(P0)
> 
> but this is implicitly order 0

Right, because it's not a compound page.

> > P1 is not freed
> 
> huh.

Yeah.  Nasty, and we'll never know how often it was hit.

> > Fix this by freeing all the pages in __free_pages() that won't be freed
> > by the call to put_page().  It's usually not a good idea to split a page,
> > but this is a very unlikely scenario.
> > 
> > ...
> >
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4947,6 +4947,9 @@ void __free_pages(struct page *page, unsigned int order)
> >  {
> >  	if (put_page_testzero(page))
> >  		free_the_page(page, order);
> > +	else if (!PageHead(page))
> > +		while (order-- > 0)
> > +			free_the_page(page + (1 << order), order);
> 
> Well that's weird and scary looking.  `page' has non-zero refcount yet
> we go and free random followon pages.  Methinks it merits an
> explanatory comment?

Well, poot.  I lost that comment in the shuffling of patches.  In a
different tree, I have:

@@ -4943,10 +4943,19 @@ static inline void free_the_page(struct page *page, unsi
gned int order)
                __free_pages_ok(page, order);
 }
 
+/*
+ * If we free a non-compound allocation, another thread may have a
+ * speculative reference to the first page.  It has no way of knowing
+ * about the rest of the allocation, so we have to free all but the
+ * first page here.
+ */
 void __free_pages(struct page *page, unsigned int order)
 {
        if (put_page_testzero(page))
                free_the_page(page, order);
+       else if (!PageHead(page))
+               while (order-- > 0)
+                       free_the_page(page + (1 << order), order);
 }
 EXPORT_SYMBOL(__free_pages);
 

Although I'm now thinking of making that comment into kernel-doc and
turning it into advice to the caller rather than an internal note to
other mm developers.
