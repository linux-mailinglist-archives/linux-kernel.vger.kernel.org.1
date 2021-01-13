Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161432F4241
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 04:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbhAMDM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 22:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbhAMDM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 22:12:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2B4C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 19:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PYhcFKwwl0qxGd2eQaH6HOLWjqEIHN+Z3aPsFEpq6Q0=; b=ZJYaRnvu9JQb8emm9CbCbaQEL+
        prn8E19JIq/+NxNLM1ivFdQzHZleH6HBFaq7/LNEy9EmQq26Crka71IevTkkYev66Pe94H5BZ2u4s
        SffB4QJSn2EkHyN6WeYPPxWP+uWJsj24717am0PrYZP2StcdtGYUdvuThlE8eQa36+2k3ljbRWKnh
        M8vfQIiqO4ltnOQAR228GlUewfPKa171pq9yIzIHbc8DD9NWbpeXsg1SGknK0INCmnpnx+lRy1SrM
        ATlRevnatzFrkoF034uRrtF1SaQlSZjQHNQMygEYVmF3gtE/URASAv32oQSjAMc9wjJl2grVq7w/b
        64uGyV9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kzWZS-005j83-8K; Wed, 13 Jan 2021 03:11:50 +0000
Date:   Wed, 13 Jan 2021 03:11:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     huang ying <huang.ying.caritas@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH] mm: Free unused swap cache page in write protection
 fault handler
Message-ID: <20210113031142.GM35215@casper.infradead.org>
References: <20210113024241.179113-1-ying.huang@intel.com>
 <CAHk-=whn5kVxEitkC0AyzvWRyxbF91rMrO9ZG6JHBNYLckpDDw@mail.gmail.com>
 <CAC=cRTNpoqHpbtZM1uDvVQYQZVyRbfPh+Dirb=-Xgoh22u_W1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC=cRTNpoqHpbtZM1uDvVQYQZVyRbfPh+Dirb=-Xgoh22u_W1A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 11:08:56AM +0800, huang ying wrote:
> On Wed, Jan 13, 2021 at 10:47 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Tue, Jan 12, 2021 at 6:43 PM Huang Ying <ying.huang@intel.com> wrote:
> > >
> > > So in this patch, at the end of wp_page_copy(), the old unused swap
> > > cache page will be tried to be freed.
> >
> > I'd much rather free it later when needed, rather than when you're in
> > a COW section.
> 
> Unused swap cache isn't unused file cache.  Nobody can reuse them
> directly before freeing them firstly.  It will make COW a little
> faster via keeping them.  But I think the overhead to free them isn't
> high.  While keeping them in system will confuse users (users will
> expect file cache to use free memory, but not expect unused swap cache
> to use much free memory), make the swap space more fragmented, and add
> system overall overhead (scanning LRU list, etc.).

Couldn't we just move it to the tail of the LRU list so it's reclaimed
first?  Or is locking going to be a problem here?
