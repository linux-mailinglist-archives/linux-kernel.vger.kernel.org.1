Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0724C27FA06
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 09:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbgJAHRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 03:17:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:51100 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgJAHRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 03:17:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52AF5B203;
        Thu,  1 Oct 2020 07:17:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C839D1E10D0; Thu,  1 Oct 2020 09:17:28 +0200 (CEST)
Date:   Thu, 1 Oct 2020 09:17:28 +0200
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
Message-ID: <20201001071728.GA17860@quack2.suse.cz>
References: <20200914130042.11442-1-willy@infradead.org>
 <20200914130042.11442-13-willy@infradead.org>
 <20200930121512.GT10896@quack2.suse.cz>
 <20200930123637.GP20115@casper.infradead.org>
 <20200930170807.GA15977@quack2.suse.cz>
 <20200930172321.GS20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930172321.GS20115@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30-09-20 18:23:21, Matthew Wilcox wrote:
> On Wed, Sep 30, 2020 at 07:08:07PM +0200, Jan Kara wrote:
> > On Wed 30-09-20 13:36:37, Matthew Wilcox wrote:
> > > On Wed, Sep 30, 2020 at 02:15:12PM +0200, Jan Kara wrote:
> > > > On Mon 14-09-20 14:00:42, Matthew Wilcox (Oracle) wrote:
> > > > > All callers now expect head (and base) pages, and can handle multiple
> > > > > head pages in a single batch, so make find_get_entries() behave that way.
> > > > > Also take the opportunity to make it use the pagevec infrastructure
> > > > > instead of open-coding how pvecs behave.  This has the side-effect of
> > > > > being able to append to a pagevec with existing contents, although we
> > > > > don't make use of that functionality anywhere yet.
> > > > > 
> > > > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > 
> > > > Looks good to me. You can add:
> > > > 
> > > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > > 
> > > > I'm just curious: What has happened to pagevec_lookup_entries() call in
> > > > invalidate_inode_pages2_range()? Your series appears to be based on a tree
> > > > where the call already does not exist...
> > > 
> > > That went away in patch 10 of this series.
> > 
> > Ah, I see. Thanks. Then I'm somewhat wondering is really
> > invalidate_inode_pages2_range() safe for THP head pages? At least the:
> > 
> > 	unmap_mapping_pages(mapping, index, 1, false);
> > 
> > doesn't look adequate for THP head pages... do_launder_page() is also
> > doubtful but probably currently OK because THPs cannot be dirty at this
> > moment. But how about THPs that are partialy inside start-end range? So far
> > the function didn't care because it was operating on page basis so it
> > didn't care but now it is probably relevant... At least it would warrant a
> > comment in some changelog if you are convinced everything is safe.
> 
> You're right, it's inadequate.  It's safe to apply this series to the
> mainline as-is because the only filesystem which creates THP today
> is tmpfs and it won't call invalidate_inode_pages2_range() (afaics).

Yeah, correct.

> I have a followup patch which isn't part of this series which fixes it:
> 
> http://git.infradead.org/users/willy/pagecache.git/commitdiff/364283163847d1c106463223b858308c730592a1

Yeah, that looks good. How about partial THPs? The way you've implemented
it we will now possibly evict more than strictly required. But OTOH
evicting exactly may require THP split which is a bit unfortunate. But
probably still a better option because otherwise we could have pages being
repeatedly brought in and out of cache just because e.g. workload mixes
direct and buffered IO and is not aligned to THP boundary (and although I
find loads mixing buffered and direct IO to the same file badly designed,
I know for a fact that they do exist and if the file ranges are not
overlapping, it is not that insane design).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
