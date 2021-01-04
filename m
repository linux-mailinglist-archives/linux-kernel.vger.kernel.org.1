Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8997A2E9E30
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 20:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbhADTat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 14:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbhADTat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 14:30:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A736C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 11:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zMXccjfJXXeI6J1+siSWp8Bb0qMGr1Kxn66MZNWNsTw=; b=augF5D93uBWLlS3NI9UgDss8h9
        kqmWUV9D9XMholR3eIMvCZrMLOuMxxXRzW4NjSpzyzBmdEORkHCbAeKpMOzQkigj/FfwalvxKcn53
        Eq8aOSU5LAWBi6p8+bv1FsL2D31WYPgEtlgjFLGs31HAg9AaVq1i3HzguvYhYAB7DftESl7G1/MjW
        JRwT9EOwIKw6xCaTOmFhDuha2A39Tcg3KROlIKi7AfzbR+qrFsWoVSmuBsk2UIDBdwgsup8n6+lnQ
        FIA0QwrDv+Y2FDPq+iFIqvvPoCc94IhUeJHyU+cwrKfoEIJwmBavUcm42KMYVV8/rWQch26vuqctf
        PbYfT7Pg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kwVWD-000T52-Vz; Mon, 04 Jan 2021 19:28:03 +0000
Date:   Mon, 4 Jan 2021 19:27:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [RFC v2 PATCH 4/4] mm: pre zero out free pages to speed up page
 allocation for __GFP_ZERO
Message-ID: <20210104192753.GD22407@casper.infradead.org>
References: <20201221163024.GA22532@open-light-1.localdomain>
 <0e8b6a2f-527d-7c77-efcf-04f21ef2a77c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e8b6a2f-527d-7c77-efcf-04f21ef2a77c@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 11:19:13AM -0800, Dave Hansen wrote:
> On 12/21/20 8:30 AM, Liang Li wrote:
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -137,6 +137,9 @@ enum pageflags {
> >  #endif
> >  #ifdef CONFIG_64BIT
> >  	PG_arch_2,
> > +#endif
> > +#ifdef CONFIG_PREZERO_PAGE
> > +	PG_zero,
> >  #endif
> >  	__NR_PAGEFLAGS,
> 
> I don't think this is worth a generic page->flags bit.
> 
> There's a ton of space in 'struct page' for pages that are in the
> allocator.  Can't we use some of that space?

I was going to object to that too, but I think the entire approach is
flawed and needs to be thrown out.  It just nukes the caches in extremely
subtle and hard to measure ways, lowering overall system performance.
