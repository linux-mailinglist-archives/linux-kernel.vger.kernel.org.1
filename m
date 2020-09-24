Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541E1276C89
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgIXJAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIXJAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:00:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116B1C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mmMTuVMaVxuGLQvB+jy13FMm4lnU6MIfeDStXdPYzIo=; b=llXIJ797DVSbnwRMqdQXQmT3yu
        JJdv5D+VU5ItCkcQ55462b8/5ISuhq2eyR4WRpHjITq5vzv5I+N61oS3ZDbDkCU0Dhyppeu+q0gSR
        0M8vyjoTChsfAme4Vy1T0t5uhjFLlAV5G39afdBnODDCCJe+ysh8o7gmHdiI4tUX7QAcN79pcYZRK
        oK11vx5cPesE+kVy0SvR4IXbPmmlDR3wYHBXgd37AqrqTjuKdEkVraZh+wYjh0kA4f6QwF8JpQfSr
        PFvWFrOs7fHsjFX2hUufg4dFX6Wl1jKeqY9T+Of+4r1b/cvlNymB9Cu7pzEAecRrVMHGEEcjVldNS
        ZB1B7u1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLN6h-0000rQ-Ts; Thu, 24 Sep 2020 09:00:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E025F300455;
        Thu, 24 Sep 2020 11:00:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CBBC22BC0B6B4; Thu, 24 Sep 2020 11:00:02 +0200 (CEST)
Date:   Thu, 24 Sep 2020 11:00:02 +0200
From:   peterz@infradead.org
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, npiggin@gmail.com
Subject: Re: [PATCH] page_alloc: Fix freeing non-compound pages
Message-ID: <20200924090002.GG1362448@hirez.programming.kicks-ass.net>
References: <20200922140017.26387-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922140017.26387-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 03:00:17PM +0100, Matthew Wilcox (Oracle) wrote:
> Here is a very rare race which leaks memory:
> 
> Page P0 is allocated to the page cache.
> Page P1 is free.
> 
> Thread A		Thread B		Thread C
> find_get_entry():
> xas_load() returns P0
> 						Removes P0 from page cache
> 						Frees P0
> 						P0 merged with its buddy P1
> 			alloc_pages(GFP_KERNEL, 1) returns P0
> 			P0 has refcount 1
> page_cache_get_speculative(P0)
> P0 has refcount 2
> 			__free_pages(P0)
> 			P0 has refcount 1
> put_page(P0)
> P1 is not freed
> 
> Fix this by freeing all the pages in __free_pages() that won't be freed
> by the call to put_page().  It's usually not a good idea to split a page,
> but this is a very unlikely scenario.
> 
> Fixes: e286781d5f2e ("mm: speculative page references")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/page_alloc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index fab5e97dc9ca..5db74797db39 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4943,10 +4943,19 @@ static inline void free_the_page(struct page *page, unsigned int order)
>  		__free_pages_ok(page, order);
>  }
>  
> +/*
> + * If we free a non-compound allocation, another thread may have a
> + * speculative reference to the first page.  It has no way of knowing
> + * about the rest of the allocation, so we have to free all but the
> + * first page here.
> + */
>  void __free_pages(struct page *page, unsigned int order)
>  {
>  	if (put_page_testzero(page))
>  		free_the_page(page, order);
> +	else if (!PageHead(page))
> +		while (order-- > 0)
> +			free_the_page(page + (1 << order), order);
>  }
>  EXPORT_SYMBOL(__free_pages);

So the obvious question I have here is why not teach put_page() to free
the whole thing?

