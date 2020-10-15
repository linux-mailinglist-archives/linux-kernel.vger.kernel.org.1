Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1B528EF30
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 11:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbgJOJNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 05:13:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:55662 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgJOJNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:13:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 07073AF44;
        Thu, 15 Oct 2020 09:13:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5B8AC1E1338; Thu, 15 Oct 2020 11:12:54 +0200 (CEST)
Date:   Thu, 15 Oct 2020 11:12:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     NeilBrown <neilb@suse.de>
Cc:     Jan Kara <jack@suse.cz>, kernel test robot <rong.a.chen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [mm/writeback] 8d92890bd6: will-it-scale.per_process_ops -15.3%
 regression
Message-ID: <20201015091254.GB7037@quack2.suse.cz>
References: <20201014084706.GB11647@shao2-debian>
 <20201014101904.GA11144@quack2.suse.cz>
 <87pn5kfply.fsf@notabene.neil.brown.name>
 <20201015090843.GA7037@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20201015090843.GA7037@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu 15-10-20 11:08:43, Jan Kara wrote:
> On Thu 15-10-20 08:46:01, NeilBrown wrote:
> > On Wed, Oct 14 2020, Jan Kara wrote:
> > 
> > > On Wed 14-10-20 16:47:06, kernel test robot wrote:
> > >> Greeting,
> > >> 
> > >> FYI, we noticed a -15.3% regression of will-it-scale.per_process_ops due
> > >> to commit:
> > >> 
> > >> commit: 8d92890bd6b8502d6aee4b37430ae6444ade7a8c ("mm/writeback: discard
> > >> NR_UNSTABLE_NFS, use NR_WRITEBACK instead")
> > >> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > >
> > > Thanks for report but it doesn't quite make sense to me. If we omit
> > > reporting & NFS changes in that commit (which is code not excercised by
> > > this benchmark), what remains are changes like:
> > >
> > >         nr_pages += node_page_state(pgdat, NR_FILE_DIRTY);
> > > -       nr_pages += node_page_state(pgdat, NR_UNSTABLE_NFS);
> > >         nr_pages += node_page_state(pgdat, NR_WRITEBACK);
> > > ...
> > > -               nr_reclaimable = global_node_page_state(NR_FILE_DIRTY) +
> > > -                                       global_node_page_state(NR_UNSTABLE_NFS);
> > > +               nr_reclaimable = global_node_page_state(NR_FILE_DIRTY);
> > > ...
> > > -       gdtc->dirty = global_node_page_state(NR_FILE_DIRTY) +
> > > -                     global_node_page_state(NR_UNSTABLE_NFS);
> > > +       gdtc->dirty = global_node_page_state(NR_FILE_DIRTY);
> > >
> > > So if there's any negative performance impact of these changes, they're
> > > likely due to code alignment changes or something like that... So I don't
> > > think there's much to do here since optimal code alignment is highly specific
> > > to a particular CPU etc.
> > 
> > I agree, it seems odd.
> > 
> > Removing NR_UNSTABLE_NFS from enum node_stat_item would renumber all the
> > following value and would, I think, change NR_DIRTIED from 32 to 31.
> > Might that move something to a different cache line and change some
> > contention?
> 
> Interesting theory, it could be possible.
> 
> > That would be easy enough to test: just re-add NR_UNSTABLE_NFS.
> 
> Yeah, easy enough to test. Patch for this is attached. 0-day people, can
> you check whether applying this patch changes anything in your perf
> numbers?

Forgot the patch. Attached now.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--DocE+STaALJfprDB
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-mm-Add-NR_UNSTABLE_NFS-stat-item.patch"

From 011b4cea33dd251f94e03ff58b0f52b688f747e1 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 15 Oct 2020 10:56:30 +0200
Subject: [PATCH] mm: Add NR_UNSTABLE_NFS stat item

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/mmzone.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0f7a4ff4b059..9ac48bb749f4 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -196,6 +196,7 @@ enum node_stat_item {
 	NR_FILE_THPS,
 	NR_FILE_PMDMAPPED,
 	NR_ANON_THPS,
+	NR_UNSTABLE_NFS,
 	NR_VMSCAN_WRITE,
 	NR_VMSCAN_IMMEDIATE,	/* Prioritise for reclaim when writeback ends */
 	NR_DIRTIED,		/* page dirtyings since bootup */
-- 
2.16.4


--DocE+STaALJfprDB--
