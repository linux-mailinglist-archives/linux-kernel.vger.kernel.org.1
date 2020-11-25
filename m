Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F072C3FA2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 13:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgKYMKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 07:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgKYMKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:10:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6E7C0613D4;
        Wed, 25 Nov 2020 04:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WgqdCZm44c4zo7nXGiTkfBH6DwmKe/+NVffeMr88V+8=; b=sZbXrNtIa0haszcLNmr0AoIUJn
        oS+IvO1F5SwhlFfESoeo7W2DAlT2zmdEHCerEVYyA3kxmiu5rIW2wqGvuAc+c7NRWRLELW9VouSfZ
        s7Vr6aHjh26gvZgnbGo6MOyklx67G1lAE1HxSgOJSfSxc3BJmyWkfZPEMlt9qb0RRLrsjMAjofFAZ
        WpTmnsnRgweW3PKcbMkSZXODd5GPbvqMk65YkfW5GGo6Qkg6XvoEcz4bYyrGwPiwB9n0+7Cw1NOzH
        rWzToFQhshj4Lua8nxrW65ocsUYqEgwCxI7Q4Wq0PBV6qGfGQhPD/aOrNzMp9t9tNXDGNyWG/WaOt
        vSDTSXPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khtd8-0002VN-0C; Wed, 25 Nov 2020 12:10:38 +0000
Date:   Wed, 25 Nov 2020 12:10:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, davem@davemloft.net, rppt@kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] sparc: Fix handling of page table constructor failure
Message-ID: <20201125121037.GJ4327@casper.infradead.org>
References: <20201125034655.27687-1-willy@infradead.org>
 <b761abc9-12de-f003-b8c4-26e7e506700e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b761abc9-12de-f003-b8c4-26e7e506700e@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 09:43:15AM +0100, David Hildenbrand wrote:
> On 25.11.20 04:46, Matthew Wilcox (Oracle) wrote:
> > The page has just been allocated, so its refcount is 1.  free_unref_page()
> > is for use on pages which have a zero refcount.  Use __free_page()
> > like the other implementations of pte_alloc_one().
> > 
> > Fixes: 1ae9ae5f7df7 ("sparc: handle pgtable_page_ctor() fail")
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  arch/sparc/mm/init_64.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> > index 96edf64d4fb3..182bb7bdaa0a 100644
> > --- a/arch/sparc/mm/init_64.c
> > +++ b/arch/sparc/mm/init_64.c
> > @@ -2894,7 +2894,7 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
> >  	if (!page)
> >  		return NULL;
> >  	if (!pgtable_pte_page_ctor(page)) {
> > -		free_unref_page(page);
> > +		__free_page(page);
> >  		return NULL;
> >  	}
> >  	return (pte_t *) page_address(page);
> > 
> 
> I wonder if reusing __pte_alloc_one() - e.g., internally - would be even
> cleaner.

It's really awkward to do because pgtable_t is defined differently.
The clean thing to do would be:

--- arch/sparc/include/asm/page_64.h
-typedef pte_t *pgtable_t;
+typedef struct page *pgtable_t;

and then do all the other changes that would require.

But that feels like a lot more work than appropriate to fix this
unlikely bug.
