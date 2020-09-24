Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7959C276F5E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgIXLHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgIXLHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:07:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E1DC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 04:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xHIvmY7SxVL7QZZfXEa16TQCn1PJXqfXa3DjNUUN44k=; b=WThpDVP8mqSB79pWIGHyJJ/AN5
        dayM0iJlJ2Uno57sSCPp5a6sv2TaMjaZW1tFbmsY3bkXQ38+XAbhiZ4Ueybtrafrx9YyP4okZgST1
        OjM2lt8rizcNcYmaE+wCDPsW9//mo4aS1fB0nl6OQvSaFa8zB33xSnO8GxgaF7sYQB44n6UMZq+8v
        cMyj4wJW3JnuOikTvkfma41UBLB3na4DDzOmruIAVGD8qKTQLVuFOwrK+TPXu7yu76M/KUm+SZ4ee
        1D24ePf/LLN25uP+cObw7FXf0ALjJyhgzRHk8K+XlnwAEsFu+TaKjIl7aZ/DQXIHMiL5fy7/RayCb
        bhMzLh2A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLP5k-0000FL-QV; Thu, 24 Sep 2020 11:07:14 +0000
Date:   Thu, 24 Sep 2020 12:07:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     peterz@infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, npiggin@gmail.com
Subject: Re: [PATCH] page_alloc: Fix freeing non-compound pages
Message-ID: <20200924110712.GU32101@casper.infradead.org>
References: <20200922140017.26387-1-willy@infradead.org>
 <20200924090002.GG1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924090002.GG1362448@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 11:00:02AM +0200, peterz@infradead.org wrote:
> On Tue, Sep 22, 2020 at 03:00:17PM +0100, Matthew Wilcox (Oracle) wrote:
> > Here is a very rare race which leaks memory:
> > 
> > Page P0 is allocated to the page cache.
> > Page P1 is free.
> > 
> > Thread A		Thread B		Thread C
> > find_get_entry():
> > xas_load() returns P0
> > 						Removes P0 from page cache
> > 						Frees P0
> > 						P0 merged with its buddy P1
> > 			alloc_pages(GFP_KERNEL, 1) returns P0
> > 			P0 has refcount 1
> > page_cache_get_speculative(P0)
> > P0 has refcount 2
> > 			__free_pages(P0)
> > 			P0 has refcount 1
> > put_page(P0)
> > P1 is not freed
> > 
> > Fix this by freeing all the pages in __free_pages() that won't be freed
> > by the call to put_page().  It's usually not a good idea to split a page,
> > but this is a very unlikely scenario.
> > 
> > Fixes: e286781d5f2e ("mm: speculative page references")
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  mm/page_alloc.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index fab5e97dc9ca..5db74797db39 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4943,10 +4943,19 @@ static inline void free_the_page(struct page *page, unsigned int order)
> >  		__free_pages_ok(page, order);
> >  }
> >  
> > +/*
> > + * If we free a non-compound allocation, another thread may have a
> > + * speculative reference to the first page.  It has no way of knowing
> > + * about the rest of the allocation, so we have to free all but the
> > + * first page here.
> > + */
> >  void __free_pages(struct page *page, unsigned int order)
> >  {
> >  	if (put_page_testzero(page))
> >  		free_the_page(page, order);
> > +	else if (!PageHead(page))
> > +		while (order-- > 0)
> > +			free_the_page(page + (1 << order), order);
> >  }
> >  EXPORT_SYMBOL(__free_pages);
> 
> So the obvious question I have here is why not teach put_page() to free
> the whole thing?

That's more complicated.  It looks like this:

    Fix this by converting P0 into a compound page if it is not freed by
    __free_pages().
    
    Fixes: e286781d5f2e ("mm: speculative page references")
    Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fab5e97dc9ca..3e9f6e6694e7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4943,10 +4943,25 @@ static inline void free_the_page(struct page *page, unsigned int order)
                __free_pages_ok(page, order);
 }
 
+/*
+ * Have to be careful when freeing a non-compound allocation in case somebody
+ * else takes a temporary reference on the first page and then calls put_page()
+ */
 void __free_pages(struct page *page, unsigned int order)
 {
-       if (put_page_testzero(page))
-               free_the_page(page, order);
+       if (likely(page_ref_freeze(page, 1)))
+               goto free;
+       if (likely(order == 0 || PageHead(page))) {
+               if (put_page_testzero(page))
+                       goto free;
+               return;
+       }
+
+       prep_compound_page(page, order);
+       put_page(page);
+       return;
+free:
+       free_the_page(page, order);
 }
 EXPORT_SYMBOL(__free_pages);

