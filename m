Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D09128148F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387922AbgJBOAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBOAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:00:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DF0C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 07:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CUDGsfaX06RV82lRVdfunkb9Yk0TwCX6+kZd1kTshAQ=; b=SbK0nYmPxa1e4eYN/337RPAU/6
        Zi933T8DX436+uLM5QIy3XFcYxzc6NRdPhln+IwhSJ4FW2sa2SB0HYpJoGcsVgH4Mv2sAukCge/+W
        b+jwTuKpJiGxQKdVcSX57y2xBCWcetkbMy7nDy9mYN60KMC2fKlk6svRGKCSUfMs7CDJVXvq/exZH
        ddLlgLu92q/O2REzhz5Pwb2DHQnnPM3DxibKoHH1dTZbyRLxE0m7jqtP6P9GNVSeBDi2iIXz3LbPL
        pwUoKdFDML2Kfto6bcTDe/XEz62FkTxLHFao/r5MpBavVmfvELx/qJbR1PxIl8Sszp4kGvr81Xd1A
        +M5fghZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOLc2-0001FE-L6; Fri, 02 Oct 2020 14:00:42 +0000
Date:   Fri, 2 Oct 2020 15:00:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Sebastiaan Meijer <meijersebastiaan@gmail.com>,
        akpm@linux-foundation.org, buddy.lumpkin@oracle.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@suse.de
Subject: Re: [RFC PATCH 1/1] vmscan: Support multiple kswapd threads per node
Message-ID: <20201002140042.GB20115@casper.infradead.org>
References: <CANuy=C+JH7sZbMToWNNyWcKANbwSx5KLaiRBLHXBz6EU=JCABA@mail.gmail.com>
 <20201001123032.GC22560@dhcp22.suse.cz>
 <CANuy=CK-s=tEb57Kw+N8O2OGx1MXyUB=o-RDH-S=kYerb65dOw@mail.gmail.com>
 <20201002070333.GA21871@dhcp22.suse.cz>
 <656725362af9bd757a281f0799a0bb9c9b2487bd.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <656725362af9bd757a281f0799a0bb9c9b2487bd.camel@surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 09:53:05AM -0400, Rik van Riel wrote:
> On Fri, 2020-10-02 at 09:03 +0200, Michal Hocko wrote:
> > On Thu 01-10-20 18:18:10, Sebastiaan Meijer wrote:
> > > (Apologies for messing up the mailing list thread, Gmail had fooled
> > > me into
> > > believing that it properly picked up the thread)
> > > 
> > > On Thu, 1 Oct 2020 at 14:30, Michal Hocko <mhocko@suse.com> wrote:
> > > > On Wed 30-09-20 21:27:12, Sebastiaan Meijer wrote:
> > > > > > yes it shows the bottleneck but it is quite artificial. Read
> > > > > > data is
> > > > > > usually processed and/or written back and that changes the
> > > > > > picture a
> > > > > > lot.
> > > > > Apologies for reviving an ancient thread (and apologies in
> > > > > advance for my lack
> > > > > of knowledge on how mailing lists work), but I'd like to offer
> > > > > up another
> > > > > reason why merging this might be a good idea.
> > > > > 
> > > > > From what I understand, zswap runs its compression on the same
> > > > > kswapd thread,
> > > > > limiting it to a single thread for compression. Given enough
> > > > > processing power,
> > > > > zswap can get great throughput using heavier compression
> > > > > algorithms like zstd,
> > > > > but this is currently greatly limited by the lack of threading.
> > > > 
> > > > Isn't this a problem of the zswap implementation rather than
> > > > general
> > > > kswapd reclaim? Why zswap doesn't do the same as normal swap out
> > > > in a
> > > > context outside of the reclaim?
> 
> On systems with lots of very fast IO devices, we have
> also seen kswapd take 100% CPU time without any zswap
> in use.
> 
> This seems like a generic issue, though zswap does
> manage to bring it out on lower end systems.

Then, given Mel's observation about contention on the LRU lock, what's
the solution?  Partition the LRU list?  Batch removals from the LRU list
by kswapd and hand off to per-?node?cpu? worker threads?

Rik, if you have access to one of those systems, I'd be interested to know
whether using file THPs would help with your workload.  Tracking only
one THP instead of, say, 16 regular size pages is going to reduce the
amount of time taken to pull things off the LRU list.
