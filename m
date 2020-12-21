Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3E52E0196
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 21:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgLUUeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 15:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgLUUef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 15:34:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8680CC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 12:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=svHUSZk5HMLOnxfZuTOKhV6ACJTRHDtRJGgoNjeyLZw=; b=TJ5meZBoscN7n7EiyZoHyvlFRv
        v9bnaBfzB4tGOLXG1T1AeOo2WdM3yJx1VlCf3nXIX8k7D1DeMKTpTv7G6uAxF/fV+2MTMvcdqL5XF
        8hXHrMQPUwr8Lj0AiG1Zb/IRyj0SqCGkplI0vyAMD5XDepl2FLNpnODALZ442CENEGgJ+nJpXKkt2
        tJpl4n86sTxuz1MlDJSdFzSdZyGDbbDOaoP4J5aYnJdPjuBYQcoURQZ/ksEGgpys/u41YXCTqKCkw
        iHkd6fVD9iRQHDbO73a/oGhXQj7sQBkWaNPt9OcHug2vt2DscVmOHDBjAc8+T1MLhQcbKzP3VlmPh
        dDHCMOEw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krRsG-0000PC-Ck; Mon, 21 Dec 2020 20:33:44 +0000
Date:   Mon, 21 Dec 2020 20:33:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+e5a33e700b1dd0da20a2@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>,
        Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: INFO: task can't die in shrink_inactive_list (2)
Message-ID: <20201221203344.GG874@casper.infradead.org>
References: <0000000000000340a105b49441d3@google.com>
 <20201123195452.8ecd01b1fc2ce287dfd6a0d5@linux-foundation.org>
 <alpine.LSU.2.11.2012211128480.2302@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2012211128480.2302@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 11:56:36AM -0800, Hugh Dickins wrote:
> On Mon, 23 Nov 2020, Andrew Morton wrote:
> > On Fri, 20 Nov 2020 17:55:22 -0800 syzbot <syzbot+e5a33e700b1dd0da20a2@syzkaller.appspotmail.com> wrote:
> > 
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    03430750 Add linux-next specific files for 20201116
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=13f80e5e500000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=a1c4c3f27041fdb8
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=e5a33e700b1dd0da20a2
> > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f7bc5a500000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10934cf2500000
> > 
> > Alex, your series "per memcg lru lock" changed the vmscan code rather a
> > lot.  Could you please take a look at that reproducer?
> 
> Andrew, I promised I'd take a look at this syzreport too (though I think
> we're agreed by now that it has nothing to do with per-memcg lru_lock).
> 
> I did try, but (unlike Alex) did not manage to get the reproducer to
> reproduce it.  No doubt I did not try hard enough: I did rather lose
> interest after seeing that it appears to involve someone with
> CAP_SYS_ADMIN doing an absurdly large ioctl(BLKFRASET) on /dev/nullb0
> ("Null test block driver" enabled via CONFIG_BLK_DEV_NULL_BLK=y: that I
> did enable) and faulting from it: presumably triggering an absurd amount
> of readahead.
> 
> Cc'ing Matthew since he has a particular interest in readahead, and
> might be inspired to make some small safe change that would fix this,
> and benefit realistic cases too; but on the whole it didn't look worth
> worrying about - or at least not by me.

Oh, interesting.  Thanks for looping me in, I hadn't looked at this one
at all.  Building on the debugging you did, this is the interesting
part of the backtrace to me:

> > >  try_to_free_pages+0x29f/0x720 mm/vmscan.c:3264
> > >  __perform_reclaim mm/page_alloc.c:4360 [inline]
> > >  __alloc_pages_direct_reclaim mm/page_alloc.c:4381 [inline]
> > >  __alloc_pages_slowpath.constprop.0+0x917/0x2510 mm/page_alloc.c:4785
> > >  __alloc_pages_nodemask+0x5f0/0x730 mm/page_alloc.c:4995
> > >  alloc_pages_current+0x191/0x2a0 mm/mempolicy.c:2271
> > >  alloc_pages include/linux/gfp.h:547 [inline]
> > >  __page_cache_alloc mm/filemap.c:977 [inline]
> > >  __page_cache_alloc+0x2ce/0x360 mm/filemap.c:962
> > >  page_cache_ra_unbounded+0x3a1/0x920 mm/readahead.c:216
> > >  do_page_cache_ra+0xf9/0x140 mm/readahead.c:267
> > >  do_sync_mmap_readahead mm/filemap.c:2721 [inline]
> > >  filemap_fault+0x19d0/0x2940 mm/filemap.c:2809

So ra_pages has been set to something ridiculously large, and as
a result, we call do_page_cache_ra() asking to read more memory than
is available in the machine.  Funny thing, we actually have a function
to prevent this kind of situation, and it's force_page_cache_ra().

So this might fix the problem.  I only tested that it compiles.  I'll
be happy to write up a proper changelog and sign-off for it if it works ...
it'd be good to get it some soak testing on a variety of different
workloads; changing this stuff is enormously subtle.

As a testament to that, I think Fengguang got it wrong in commit
2cbea1d3ab11 -- async_size should have been 3 * ra_pages / 4, not ra_pages
/ 4 (because we read-behind by half the range, so we're looking for a
page fault to happen a quarter of the way behind this fault ...)

This is partially Roman's fault, see commit 600e19afc5f8.

diff --git a/mm/filemap.c b/mm/filemap.c
index d5e7c2029d16..43fe0f0ae3bb 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2632,7 +2632,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	ra->size = ra->ra_pages;
 	ra->async_size = ra->ra_pages / 4;
 	ractl._index = ra->start;
-	do_page_cache_ra(&ractl, ra->size, ra->async_size);
+	force_page_cache_ra(&ractl, ra, ra->size);
 	return fpin;
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index c43ccdddb0f6..5664b4b91340 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -49,8 +49,6 @@ void unmap_page_range(struct mmu_gather *tlb,
 			     unsigned long addr, unsigned long end,
 			     struct zap_details *details);
 
-void do_page_cache_ra(struct readahead_control *, unsigned long nr_to_read,
-		unsigned long lookahead_size);
 void force_page_cache_ra(struct readahead_control *, struct file_ra_state *,
 		unsigned long nr);
 static inline void force_page_cache_readahead(struct address_space *mapping,
diff --git a/mm/readahead.c b/mm/readahead.c
index c5b0457415be..f344c894c26a 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -246,7 +246,7 @@ EXPORT_SYMBOL_GPL(page_cache_ra_unbounded);
  * behaviour which would occur if page allocations are causing VM writeback.
  * We really don't want to intermingle reads and writes like that.
  */
-void do_page_cache_ra(struct readahead_control *ractl,
+static void do_page_cache_ra(struct readahead_control *ractl,
 		unsigned long nr_to_read, unsigned long lookahead_size)
 {
 	struct inode *inode = ractl->mapping->host;
