Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2510229892F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 10:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772733AbgJZJMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 05:12:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:51298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1772726AbgJZJMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 05:12:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 519D9AC35;
        Mon, 26 Oct 2020 09:12:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F37711E0EAA; Mon, 26 Oct 2020 10:11:55 +0100 (CET)
Date:   Mon, 26 Oct 2020 10:11:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/12] mm/filemap: Return only head pages from
 find_get_entries
Message-ID: <20201026091155.GB28769@quack2.suse.cz>
References: <20200914130042.11442-1-willy@infradead.org>
 <20200914130042.11442-13-willy@infradead.org>
 <20200930121512.GT10896@quack2.suse.cz>
 <20200930123637.GP20115@casper.infradead.org>
 <20200930170807.GA15977@quack2.suse.cz>
 <20200930172321.GS20115@casper.infradead.org>
 <20201001071728.GA17860@quack2.suse.cz>
 <20201025231934.GL20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201025231934.GL20115@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 25-10-20 23:19:34, Matthew Wilcox wrote:
> On Thu, Oct 01, 2020 at 09:17:28AM +0200, Jan Kara wrote:
> > > I have a followup patch which isn't part of this series which fixes it:
> > > 
> > > http://git.infradead.org/users/willy/pagecache.git/commitdiff/364283163847d1c106463223b858308c730592a1
> > 
> > Yeah, that looks good. How about partial THPs? The way you've implemented
> > it we will now possibly evict more than strictly required. But OTOH
> > evicting exactly may require THP split which is a bit unfortunate. But
> > probably still a better option because otherwise we could have pages being
> > repeatedly brought in and out of cache just because e.g. workload mixes
> > direct and buffered IO and is not aligned to THP boundary (and although I
> > find loads mixing buffered and direct IO to the same file badly designed,
> > I know for a fact that they do exist and if the file ranges are not
> > overlapping, it is not that insane design).
> 
> Sorry, forgot to reply to this.
> 
> In this patchset, THPs are created by readahead.  We always start
> out by allocating order-0 pages and only ramp up after hitting a page
> marked as PageReadahead.  So it's not like tmpfs where we'll try to jump
> straight to order-9 pages and have to worry about the behaviour you're
> describing above.  That means in this kind of scenario, we might have,
> eg, an order-6 page in the cache, remove the whole thing, then bring
> back in some order-0 pages.  If we hit on those, we'll bring in some
> order-2 pages.  We won't bring in order-6 pages again until we've hit
> in the readahead window twice more.
> 
> I think the ramp-up is probably too aggressive, but it's fun for testing.

OK, sounds good then. Thanks for explanation.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
