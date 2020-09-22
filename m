Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E7827454E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgIVPbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:31:40 -0400
Received: from verein.lst.de ([213.95.11.211]:45169 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgIVPbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:31:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 785DF67373; Tue, 22 Sep 2020 17:31:36 +0200 (CEST)
Date:   Tue, 22 Sep 2020 17:31:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH 2/2] vfree: Update documentation
Message-ID: <20200922153136.GA30766@lst.de>
References: <20200921224628.20704-1-willy@infradead.org> <20200921224628.20704-2-willy@infradead.org> <20200922143506.GA26664@lst.de> <20200922150603.GH32101@casper.infradead.org> <20200922150910.GA29302@lst.de> <20200922152240.GI32101@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922152240.GI32101@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 04:22:40PM +0100, Matthew Wilcox wrote:
> On Tue, Sep 22, 2020 at 05:09:10PM +0200, Christoph Hellwig wrote:
> > On Tue, Sep 22, 2020 at 04:06:03PM +0100, Matthew Wilcox wrote:
> > > I don't think it makes sense to list all vmalloc-style allocators here.
> > > It won't be updated by people who add new variations.  How about this?
> > > 
> > >  * Free the virtually continuous memory area starting at @addr, as
> > >  * obtained from one of the vmalloc() family of APIs.  This will
> > >  * usually also free the physical memory underlying the virtual
> > >  * allocation, but that memory is reference counted, so it will not
> > >  * be freed until the last user goes away.
> > >  *
> > >  * If @addr is NULL, no operation is performed.
> > > 
> > > I'm trying to strike a balance between being accurate and not requiring
> > > device driver authors to learn all about struct page.  I may be too
> > > close to the implementation to write good documentation for it.
> > 
> > I think the above is sensible, but not enough.  vmap really needs to
> > be treated special, as by default area->pages for vmap is NULL.  So
> > for vfree to be useful on a vmap mapping, the callers needs to
> > manually set it up by poking into the internals.  Actually, I think
> > we really want another API rather than vmap for that.  Let me respin
> > my series to include that.
> 
> I've been thinking about somethng like:
> 
> void *vmap_mapping(struct address_space *mapping, pgoff_t start,
> 		unsigned long len);
> 
> but it doesn't quite work for the shmem cases because they need to use
> shmem_read_mapping_page_gfp() instead of ->readpage.  I'd also want it
> to work for DAX, but I don't have a user for that yet so it's hard to
> justify adding it.

That seems a little too special cased to me.

FYI, if you are fine with it I'll pick your two patches with the
updates from this thread up for my series.  It has be now morphed into
a general vmalloc.c cleanup series.
