Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB976298985
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 10:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422584AbgJZJjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 05:39:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422459AbgJZJjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 05:39:42 -0400
Received: from kernel.org (unknown [87.70.96.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6718020874;
        Mon, 26 Oct 2020 09:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603705182;
        bh=9Aaz/fgIgvwzqz09IPukWhEn6OJpwI3J5aUonqRW1oI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gDPmyWFTGsDdTkmo1PfbwI1mtXXpVmb1ycRT+r0SimHGITeyEQM8sOegLWK48pxc7
         +w5eBhkaKMED9eSFCouva+Ty2bm684P95NgOzQWzf7gXwi36zTjKK6dUozBE2q04Vj
         Wl/XW1Db6eCnzgzl6MtUlLXK7X/gSNQ5W82uJ8wg=
Date:   Mon, 26 Oct 2020 11:39:34 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Zhenhua Huang <zhenhuah@codeaurora.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: fix page_owner initializing issue for arm32
Message-ID: <20201026093934.GD1154158@kernel.org>
References: <1602839640-13125-1-git-send-email-zhenhuah@codeaurora.org>
 <20201025154253.GH392079@kernel.org>
 <20201026071255.GA31027@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026071255.GA31027@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 03:12:55PM +0800, Zhenhua Huang wrote:
> Hi Mike,
> 
> On Sun, Oct 25, 2020 at 11:42:53PM +0800, Mike Rapoport wrote:
> > On Fri, Oct 16, 2020 at 05:14:00PM +0800, Zhenhua Huang wrote:
> > > Page owner of pages used by page owner itself used is missing on arm32
> > targets.
> > > The reason is dummy_handle and failure_handle is not initialized
> > correctly.
> > > Buddy allocator is used to initialize these two handles. However, buddy
> > > allocator is not ready when page owner calls it. This change fixed that
> > by
> > > initializing page owner after buddy initialization.
> > > 
> > > The working flow before and after this change are:
> > > original logic:
> > > 1. allocated memory for page_ext(using memblock).
> > 
> > Is anything that requires a memblock allocation FLATMEM?
> > Any fundamental reason why wouldn't alloc_pages_exact_nid/vzalloc_node()
> > work in this case?
> > 
> > It seems to me that for FLATMEM configuration we can allocate the
> > page_ext using alloc_pages() with a fallback to vzalloc_node() and then
> > we can unify lot's of page_ext code and entirely drop
> > page_ext_init_flatmem().
>
> From comments in codes: "page_ext requires contiguous pages, bigger than
> MAX_ORDER unless SPARSEMEM."
> The size of page_ext for FLATMEM(which used pgdat) should be much larger than
> the size for SPARSEMEM which used section.

Well, the vzalloc_node() fallback in alloc_page_ext() for SPARSEMEM case
implies that using pages that are not physically contiguous should be
fine. So, it seems to me that the comment is stale and vzalloc_node()
would work just fine for FLATMEM case if the allocation of page_ext
would exceed MAX_ORDER.

> > > 2. invoke the init callback of page_ext_ops like
> > > page_owner(using buddy allocator).
> > > 3. initialize buddy.
> > > 
> > > after this change:
> > > 1. allocated memory for page_ext(using memblock).
> > > 2. initialize buddy.
> > > 3. invoke the init callback of page_ext_ops like
> > > page_owner(using buddy allocator).
> > > 
> > > with the change, failure/dummy_handle can get its correct value and
> > > page owner output for example has the one for page owner itself:
> > > Page allocated via order 2, mask 0x6202c0(GFP_USER|__GFP_NOWARN), pid
> > 1006, ts
> > > 67278156558 ns
> > > PFN 543776 type Unmovable Block 531 type Unmovable Flags 0x0()
> > >  init_page_owner+0x28/0x2f8
> > >  invoke_init_callbacks_flatmem+0x24/0x34
> > >  start_kernel+0x33c/0x5d8
> > >    (null)
> > > 
> > > Signed-off-by: Zhenhua Huang <zhenhuah@codeaurora.org>
> > > ---
> > >  include/linux/page_ext.h | 8 ++++++++
> > >  init/main.c              | 2 ++
> > >  mm/page_ext.c            | 8 +++++++-
> > >  3 files changed, 17 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/page_ext.h b/include/linux/page_ext.h
> > > index cfce186..aff81ba 100644
> > > --- a/include/linux/page_ext.h
> > > +++ b/include/linux/page_ext.h
> > > @@ -44,8 +44,12 @@ static inline void page_ext_init_flatmem(void)
> > >  {
> > >  }
> > >  extern void page_ext_init(void);
> > > +static inline void page_ext_init_flatmem_late(void)
> > > +{
> > > +}
> > >  #else
> > >  extern void page_ext_init_flatmem(void);
> > > +extern void page_ext_init_flatmem_late(void);
> > >  static inline void page_ext_init(void)
> > >  {
> > >  }
> > > @@ -76,6 +80,10 @@ static inline void page_ext_init(void)
> > >  {
> > >  }
> > >  
> > > +static inline void page_ext_init_flatmem_late(void)
> > > +{
> > > +}
> > > +
> > >  static inline void page_ext_init_flatmem(void)
> > >  {
> > >  }
> > > diff --git a/init/main.c b/init/main.c
> > > index 130376e..b34c475 100644
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -818,6 +818,8 @@ static void __init mm_init(void)
> > >  	init_debug_pagealloc();
> > >  	report_meminit();
> > >  	mem_init();
> > > +	/* page_owner must be initialized after buddy is ready */
> > > +	page_ext_init_flatmem_late();
> > >  	kmem_cache_init();
> > >  	kmemleak_init();
> > >  	pgtable_init();
> > > diff --git a/mm/page_ext.c b/mm/page_ext.c
> > > index a3616f7..373f7a1 100644
> > > --- a/mm/page_ext.c
> > > +++ b/mm/page_ext.c
> > > @@ -99,6 +99,13 @@ static void __init invoke_init_callbacks(void)
> > >  	}
> > >  }
> > >  
> > > +#if !defined(CONFIG_SPARSEMEM)
> > > +void __init page_ext_init_flatmem_late(void)
> > > +{
> > > +	invoke_init_callbacks();
> > > +}
> > > +#endif
> > > +
> > >  static inline struct page_ext *get_entry(void *base, unsigned long
> > index)
> > >  {
> > >  	return base + page_ext_size * index;
> > > @@ -177,7 +184,6 @@ void __init page_ext_init_flatmem(void)
> > >  			goto fail;
> > >  	}
> > >  	pr_info("allocated %ld bytes of page_ext\n", total_usage);
> > > -	invoke_init_callbacks();
> > >  	return;
> > >  
> > >  fail:
> > > -- 
> > > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> > Forum,
> > > a Linux Foundation Collaborative Project
> > > 
> > > 
> > 
> > -- 
> > Sincerely yours,
> > Mike.
> > 

-- 
Sincerely yours,
Mike.
