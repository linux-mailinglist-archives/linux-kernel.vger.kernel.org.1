Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7901274529
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgIVPWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIVPWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:22:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F7EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=47IgGGQcOCGVOf/10+SQlAajxJWXxBSCU0PDicFXtkQ=; b=Nk8D8afDKDMQRFSjD6NLhYDDGP
        8z35Z+0f0THPgALMziI37cQjTCJ83agSD5D7eoYqE9haljcEWI/kCVHLIGD4ENNnOql3VNeo9Arjc
        mw1jdyE4ASIwoSoxoziaHqgP8Nx7KGZicQxCi/GeG2OhZJVKDom9fxV8wxAOBt25bAsz3HCJFZu6j
        zsalt0MTZFbDvLaqoZ7IKuRpo3F+nCB9xaaVz7X5bqj9x9cKL0RP8f7RwJzqIPRp0kWYWPqIN2kfu
        XO/UYZM2SXNX2ck6pdhPFWJTZOmu/qs/2fFcWVsPa+/pf2Rf05RMkWPTUQR/ts/HL6MVT6zCxwiWr
        Wm+tHVoQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKk7s-0003rS-Ur; Tue, 22 Sep 2020 15:22:40 +0000
Date:   Tue, 22 Sep 2020 16:22:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH 2/2] vfree: Update documentation
Message-ID: <20200922152240.GI32101@casper.infradead.org>
References: <20200921224628.20704-1-willy@infradead.org>
 <20200921224628.20704-2-willy@infradead.org>
 <20200922143506.GA26664@lst.de>
 <20200922150603.GH32101@casper.infradead.org>
 <20200922150910.GA29302@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922150910.GA29302@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 05:09:10PM +0200, Christoph Hellwig wrote:
> On Tue, Sep 22, 2020 at 04:06:03PM +0100, Matthew Wilcox wrote:
> > I don't think it makes sense to list all vmalloc-style allocators here.
> > It won't be updated by people who add new variations.  How about this?
> > 
> >  * Free the virtually continuous memory area starting at @addr, as
> >  * obtained from one of the vmalloc() family of APIs.  This will
> >  * usually also free the physical memory underlying the virtual
> >  * allocation, but that memory is reference counted, so it will not
> >  * be freed until the last user goes away.
> >  *
> >  * If @addr is NULL, no operation is performed.
> > 
> > I'm trying to strike a balance between being accurate and not requiring
> > device driver authors to learn all about struct page.  I may be too
> > close to the implementation to write good documentation for it.
> 
> I think the above is sensible, but not enough.  vmap really needs to
> be treated special, as by default area->pages for vmap is NULL.  So
> for vfree to be useful on a vmap mapping, the callers needs to
> manually set it up by poking into the internals.  Actually, I think
> we really want another API rather than vmap for that.  Let me respin
> my series to include that.

I've been thinking about somethng like:

void *vmap_mapping(struct address_space *mapping, pgoff_t start,
		unsigned long len);

but it doesn't quite work for the shmem cases because they need to use
shmem_read_mapping_page_gfp() instead of ->readpage.  I'd also want it
to work for DAX, but I don't have a user for that yet so it's hard to
justify adding it.

I have ideas for making shmem/tmpfs work more like other filesystems,
so we don't need shmem_read_mapping_page_gfp() but there are only so
many hours in the day.
