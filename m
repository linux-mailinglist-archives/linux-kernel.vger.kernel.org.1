Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2823427BC2B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 06:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgI2Eq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 00:46:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI2Eq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 00:46:58 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D3D220BED;
        Tue, 29 Sep 2020 04:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601354816;
        bh=2JNWFFvPkQNc9xCN+nF98rnXbVrQkiwRrBXG/E5KEk8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KoNHW/UUp9UyLBeBeS36wRdwvVFTd0PNBptoUsT0g8GDrHs6XzDM4pL+Z2EAm8VWi
         zTzu2xltWbytaRQj/OL/K3SFKDlywj2HE3dqQAxDnDKB9oalDb47atfGcWejqApmIj
         WhhTPbck9eFkNgvi/bKlWI7vFVtFGO0XuKC/o6nE=
Date:   Mon, 28 Sep 2020 21:46:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Nick Piggin <npiggin@gmail.com>, Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] page_alloc: Fix freeing non-compound pages
Message-Id: <20200928214656.be4a0f29961589c074e518fa@linux-foundation.org>
In-Reply-To: <20200929011719.GD30994@casper.infradead.org>
References: <20200926213919.26642-1-willy@infradead.org>
        <20200928180307.7573f3b6128b5e3007dfc9f0@linux-foundation.org>
        <20200929011719.GD30994@casper.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 02:17:19 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Mon, Sep 28, 2020 at 06:03:07PM -0700, Andrew Morton wrote:
> > On Sat, 26 Sep 2020 22:39:19 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> > 
> > > Here is a very rare race which leaks memory:
> > 
> > Not worth a cc:stable?
> 
> Yes, it probably should have been.

Have you a feeling for how often this occurs?

>  I just assume the stablebot will
> pick up anything that has a Fixes: tag.

We asked them not to do that for mm/ patches.  Crazy stuff was getting
backported.

> > >
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -4947,6 +4947,9 @@ void __free_pages(struct page *page, unsigned int order)
> > >  {
> > >  	if (put_page_testzero(page))
> > >  		free_the_page(page, order);
> > > +	else if (!PageHead(page))
> > > +		while (order-- > 0)
> > > +			free_the_page(page + (1 << order), order);
> > 
> > Well that's weird and scary looking.  `page' has non-zero refcount yet
> > we go and free random followon pages.  Methinks it merits an
> > explanatory comment?
> 
> Well, poot.  I lost that comment in the shuffling of patches.  In a
> different tree, I have:
> 
> @@ -4943,10 +4943,19 @@ static inline void free_the_page(struct page *page, unsi
> gned int order)
>                 __free_pages_ok(page, order);
>  }
>  
> +/*
> + * If we free a non-compound allocation, another thread may have a

"non-compound, higher-order", I suggest?

> + * speculative reference to the first page.  It has no way of knowing
> + * about the rest of the allocation, so we have to free all but the
> + * first page here.
> + */
>  void __free_pages(struct page *page, unsigned int order)
>  {
>         if (put_page_testzero(page))
>                 free_the_page(page, order);
> +       else if (!PageHead(page))
> +               while (order-- > 0)
> +                       free_the_page(page + (1 << order), order);
>  }
>  EXPORT_SYMBOL(__free_pages);
>  
> 
> Although I'm now thinking of making that comment into kernel-doc and
> turning it into advice to the caller rather than an internal note to
> other mm developers.

hm.  But what action could the caller take?  The explanatory comment
seems OK to me.

