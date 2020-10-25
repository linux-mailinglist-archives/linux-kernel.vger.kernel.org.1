Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5C7298508
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 00:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420667AbgJYXl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 19:41:29 -0400
Received: from casper.infradead.org ([90.155.50.34]:58308 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420660AbgJYXl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 19:41:28 -0400
X-Greylist: delayed 1292 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Oct 2020 19:41:28 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VwK0jJNMBFLTZhR5eyefyBrpMJ25xSMU+BYUItGgaU8=; b=R2XbFQg8z5q/d8ZeYuKXD/vP5R
        D5ZiFh8W4AXaS4lhLZKI89IJGMWSaq+o9J1b8f2gO3NMThYNaSRIOaKlbTSNVk1RNryP7smh4zh+7
        dhXQ2LZ5Ob5YbXGBDvKigQZHBJZft8UfjW+ONvVs1cavDxX5mzJ2cHyU51dpephyCKR43gZLW6jYp
        0nBaGhD1farUDo8FYvJofduE/1uxCEklgok3Z7kbHbb9lLyTCdQxruF3KP0v/9gTMcTA6ew+WeZcg
        7UlwHOV7ub/HjJWCrU2+TX1zis5V+OPENvUN/5J3fEM+F4P5jWyWeBK80UjA2N9GVqhtiOyXuhg9J
        mig0jqiQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWpIU-0001Jw-3L; Sun, 25 Oct 2020 23:19:34 +0000
Date:   Sun, 25 Oct 2020 23:19:34 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/12] mm/filemap: Return only head pages from
 find_get_entries
Message-ID: <20201025231934.GL20115@casper.infradead.org>
References: <20200914130042.11442-1-willy@infradead.org>
 <20200914130042.11442-13-willy@infradead.org>
 <20200930121512.GT10896@quack2.suse.cz>
 <20200930123637.GP20115@casper.infradead.org>
 <20200930170807.GA15977@quack2.suse.cz>
 <20200930172321.GS20115@casper.infradead.org>
 <20201001071728.GA17860@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001071728.GA17860@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 09:17:28AM +0200, Jan Kara wrote:
> > I have a followup patch which isn't part of this series which fixes it:
> > 
> > http://git.infradead.org/users/willy/pagecache.git/commitdiff/364283163847d1c106463223b858308c730592a1
> 
> Yeah, that looks good. How about partial THPs? The way you've implemented
> it we will now possibly evict more than strictly required. But OTOH
> evicting exactly may require THP split which is a bit unfortunate. But
> probably still a better option because otherwise we could have pages being
> repeatedly brought in and out of cache just because e.g. workload mixes
> direct and buffered IO and is not aligned to THP boundary (and although I
> find loads mixing buffered and direct IO to the same file badly designed,
> I know for a fact that they do exist and if the file ranges are not
> overlapping, it is not that insane design).

Sorry, forgot to reply to this.

In this patchset, THPs are created by readahead.  We always start
out by allocating order-0 pages and only ramp up after hitting a page
marked as PageReadahead.  So it's not like tmpfs where we'll try to jump
straight to order-9 pages and have to worry about the behaviour you're
describing above.  That means in this kind of scenario, we might have,
eg, an order-6 page in the cache, remove the whole thing, then bring
back in some order-0 pages.  If we hit on those, we'll bring in some
order-2 pages.  We won't bring in order-6 pages again until we've hit
in the readahead window twice more.

I think the ramp-up is probably too aggressive, but it's fun for testing.
