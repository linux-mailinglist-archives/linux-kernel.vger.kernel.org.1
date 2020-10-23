Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6B9296FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 14:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464110AbgJWMz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 08:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464099AbgJWMz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 08:55:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4362CC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 05:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7Mf06wropCYoz+pvT981q8UQrBcoNfoNDUpkgD3jJ20=; b=HKRzA2I3isHd29L2LTasFeK7Gl
        eVyGuPncFwx3/bDp3I953xn0jwRz4Ov1NaaIYuNugteTRfR9RtPfXjQ26VpzlxiarCXubuKO9f8Oe
        p9xNbWu3BpaUpqZMDd4HCO4KLq4FLmsEoTkMnUwHpajGigc9bNGohXF+1acla/Z5yFThXmGUkt+o8
        SAM+t0xz7JW/OwRSwV1ie3lbw2NOrGa+SHI4W6IdycLZjeD657Lp+26y9qF635yjagWyuC0YO5lJ0
        u1+gvL384695DcXj0iRNyU1S1mnvfq6EOVxvChlHQy7i1lt6tgfJSSd4HPBUobwzqnSp3RYCUVw9s
        igQTAgTw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVwbE-0003wU-34; Fri, 23 Oct 2020 12:55:16 +0000
Date:   Fri, 23 Oct 2020 13:55:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Hugh Dickins <hughd@google.com>, Yu Xu <xuyu@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm,thp,shmem: limit shmem THP alloc gfp_mask
Message-ID: <20201023125516.GA20115@casper.infradead.org>
References: <20201022124511.72448a5f@imladris.surriel.com>
 <alpine.LSU.2.11.2010221909060.1001@eggly.anvils>
 <932f5931911e5ad7d730127b0784b0913045639c.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <932f5931911e5ad7d730127b0784b0913045639c.camel@surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 11:40:53PM -0400, Rik van Riel wrote:
> On Thu, 2020-10-22 at 19:54 -0700, Hugh Dickins wrote:
> > Michal is right to remember pushback before, because tmpfs is a
> > filesystem, and "huge=" is a mount option: in using a huge=always
> > filesystem, the user has already declared a preference for huge
> > pages.
> > Whereas the original anon THP had to deduce that preference from sys
> > tunables and vma madvice.
> 
> ...
> 
> > But it's likely that they have accumulated some defrag wisdom, which
> > tmpfs can take on board - but please accept that in using a huge
> > mount,
> > the preference for huge has already been expressed, so I don't expect
> > anon THP alloc_hugepage_direct_gfpmask() choices will map one to one.
> 
> In my mind, the huge= mount options for tmpfs corresponded
> to the "enabled" anon THP options, denoting a desired end
> state, not necessarily how much we will stall allocations
> to get there immediately.
> 
> The underlying allocation behavior has been changed repeatedly,
> with changes to the direct reclaim code and the compaction
> deferral code.
> 
> The shmem THP gfp_mask never tried really hard anyway,
> with __GFP_NORETRY being the default, which matches what
> is used for non-VM_HUGEPAGE anon VMAs.
> 
> Likewise, the direct reclaim done from the opportunistic
> THP allocations done by the shmem code limited itself to
> reclaiming 32 4kB pages per THP allocation.
> 
> In other words, mounting
> with huge=always has never behaved
> the same as the more aggressive allocations done for
> MADV_HUGEPAGE VMAs.
> 
> This patch would leave shmem THP allocations for non-MADV_HUGEPAGE
> mapped files opportunistic like today, and make shmem THP
> allocations for files mapped with MADV_HUGEPAGE more aggressive
> than today.
> 
> However, I would like to know what people think the shmem
> huge= mount options should do, and how things should behave
> when memory gets low, before pushing in a patch just because
> it makes the system run smoother "without changing current
> behavior too much".
> 
> What do people want tmpfs THP allocations to do?

I'm also interested for non-tmpfs THP allocations.  In my patchset, THPs
are no longer limited to being PMD sized, and allocating smaller pages
isn't such a tax on the VM.  So currently I'm doing:

        gfp_t gfp = readahead_gfp_mask(mapping);
...
        struct page *page = __page_cache_alloc_order(gfp, order);

which translates to:

        mapping_gfp_mask(mapping) | __GFP_NORETRY | __GFP_NOWARN;
        gfp |= GFP_TRANSHUGE_LIGHT;
        gfp &= ~__GFP_DIRECT_RECLAIM;

Everything's very willing to fall back to order-0 pages, but I can see
that, eg, for a VM_HUGEPAGE vma, we should perhaps be less willing to
fall back to small pages.  I would prefer not to add a mount option to
every filesystem.  People will only get it wrong.
