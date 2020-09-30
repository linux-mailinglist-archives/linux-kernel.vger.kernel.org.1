Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BA427F034
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 19:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbgI3RXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 13:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgI3RXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 13:23:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF62C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 10:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=no00GtEvC4Ccb0AEQA7+4iXCIrB4UVLH9f7Oc/XUFOU=; b=tdiUgSZNbCCmbgDvEq3BZxq+BA
        uGnRWZer6nIii7KYunB1Um9AZ3kaqp+YgXZ2JbEcnFc6QV+QDn/dy7QxrttKcgEs+XntYKgzGnFsX
        5aGX5xC/GyMGrI5jIEbxaoAdfZ6762CpmX2eSc1BOw1Z0n+7bRvOwh0UBezYuNkf+VyPx5/eznh6H
        uOUKfYXsy5C6MIkB3OtVO8oQr40a63qqQ6PshXcgero1BwXhApigDH3l61R69wcE6Ac5ZgshXC1bY
        0KmqhLj8FHCOClLRFPMG+KrkpyVkCtUvu3D8MIqQyKagc/u9/KluR+hMVBoxr0S9viPv3cJqoVn1+
        fUPvBE7A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNfp4-00082g-49; Wed, 30 Sep 2020 17:23:22 +0000
Date:   Wed, 30 Sep 2020 18:23:21 +0100
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
Message-ID: <20200930172321.GS20115@casper.infradead.org>
References: <20200914130042.11442-1-willy@infradead.org>
 <20200914130042.11442-13-willy@infradead.org>
 <20200930121512.GT10896@quack2.suse.cz>
 <20200930123637.GP20115@casper.infradead.org>
 <20200930170807.GA15977@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930170807.GA15977@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 07:08:07PM +0200, Jan Kara wrote:
> On Wed 30-09-20 13:36:37, Matthew Wilcox wrote:
> > On Wed, Sep 30, 2020 at 02:15:12PM +0200, Jan Kara wrote:
> > > On Mon 14-09-20 14:00:42, Matthew Wilcox (Oracle) wrote:
> > > > All callers now expect head (and base) pages, and can handle multiple
> > > > head pages in a single batch, so make find_get_entries() behave that way.
> > > > Also take the opportunity to make it use the pagevec infrastructure
> > > > instead of open-coding how pvecs behave.  This has the side-effect of
> > > > being able to append to a pagevec with existing contents, although we
> > > > don't make use of that functionality anywhere yet.
> > > > 
> > > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > 
> > > Looks good to me. You can add:
> > > 
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > 
> > > I'm just curious: What has happened to pagevec_lookup_entries() call in
> > > invalidate_inode_pages2_range()? Your series appears to be based on a tree
> > > where the call already does not exist...
> > 
> > That went away in patch 10 of this series.
> 
> Ah, I see. Thanks. Then I'm somewhat wondering is really
> invalidate_inode_pages2_range() safe for THP head pages? At least the:
> 
> 	unmap_mapping_pages(mapping, index, 1, false);
> 
> doesn't look adequate for THP head pages... do_launder_page() is also
> doubtful but probably currently OK because THPs cannot be dirty at this
> moment. But how about THPs that are partialy inside start-end range? So far
> the function didn't care because it was operating on page basis so it
> didn't care but now it is probably relevant... At least it would warrant a
> comment in some changelog if you are convinced everything is safe.

You're right, it's inadequate.  It's safe to apply this series to the
mainline as-is because the only filesystem which creates THP today
is tmpfs and it won't call invalidate_inode_pages2_range() (afaics).
I have a followup patch which isn't part of this series which fixes it:

http://git.infradead.org/users/willy/pagecache.git/commitdiff/364283163847d1c106463223b858308c730592a1

There are other similar fixes which are also needed before we get to
allowing THPs to be added to the page cache for normal filesystems,
but I think I'm out of time for this merge window.  My plan is to submit
everything that's in this tree for the next merge window; the page cache
pieces through Andrew and the filesystem/iomap/XFS pieces through Darrick.
With good luck, all of this will be in place for 5.11.  I have about 50
patches in flight for 5.10 and it'll be about another 50 for 5.11.

Reviewer bandwidth is probably the biggest issue right now, and I
really appreciate your thoughtful comments.
