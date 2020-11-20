Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7274C2BABE3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 15:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgKTOaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 09:30:20 -0500
Received: from mga14.intel.com ([192.55.52.115]:21518 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727728AbgKTOaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 09:30:17 -0500
IronPort-SDR: FJjzDDQtL+KNUZQmzU6K2TH8Ju8lMzIyd0ohI4y0zRom+NnsW27Np2JQjpfJ9FXxVDztqnz22Z
 CHhdx11YhUSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="170699145"
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="170699145"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 06:30:17 -0800
IronPort-SDR: vAHqFy39zYBXU6DqFNfUo+KhZQT4xJB816/VOjYoEvofAmK1ef3i/KUmgS8usaG76IHRSYwc3E
 RQfWC9sa/IUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="360464757"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by fmsmga004.fm.intel.com with ESMTP; 20 Nov 2020 06:30:13 -0800
Date:   Fri, 20 Nov 2020 22:30:12 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Waiman Long <longman@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, zhengjun.xing@intel.com, ying.huang@intel.com
Subject: Re: [LKP] Re: [mm/memcg] bd0b230fe1: will-it-scale.per_process_ops
 -22.7% regression
Message-ID: <20201120143012.GB103521@shbuild999.sh.intel.com>
References: <20201102092754.GD22613@dhcp22.suse.cz>
 <82d73ebb-a31e-4766-35b8-82afa85aa047@intel.com>
 <20201102100247.GF22613@dhcp22.suse.cz>
 <bd87e8bd-c918-3f41-0cc5-e2927d91625f@linux.intel.com>
 <20201104081546.GB10052@dhcp22.suse.cz>
 <20201112122844.GA11000@shbuild999.sh.intel.com>
 <20201112141654.GC12240@dhcp22.suse.cz>
 <20201113073436.GA113119@shbuild999.sh.intel.com>
 <20201120114424.GA103521@shbuild999.sh.intel.com>
 <20201120131944.GP3200@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120131944.GP3200@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 02:19:44PM +0100, Michal Hocko wrote:
> On Fri 20-11-20 19:44:24, Feng Tang wrote:
> > On Fri, Nov 13, 2020 at 03:34:36PM +0800, Feng Tang wrote:
> > > On Thu, Nov 12, 2020 at 03:16:54PM +0100, Michal Hocko wrote:
> > > > > > > I add one phony page_counter after the union and re-test, the regression
> > > > > > > reduced to -1.2%. It looks like the regression caused by the data structure
> > > > > > > layout change.
> > > > > > 
> > > > > > Thanks for double checking. Could you try to cache align the
> > > > > > page_counter struct? If that helps then we should figure which counters
> > > > > > acks against each other by adding the alignement between the respective
> > > > > > counters. 
> > > > > 
> > > > > We tried below patch to make the 'page_counter' aligned.
> > > > >   
> > > > >   diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
> > > > >   index bab7e57..9efa6f7 100644
> > > > >   --- a/include/linux/page_counter.h
> > > > >   +++ b/include/linux/page_counter.h
> > > > >   @@ -26,7 +26,7 @@ struct page_counter {
> > > > >    	/* legacy */
> > > > >    	unsigned long watermark;
> > > > >    	unsigned long failcnt;
> > > > >   -};
> > > > >   +} ____cacheline_internodealigned_in_smp;
> > > > >    
> > > > > and with it, the -22.7% peformance change turns to a small -1.7%, which
> > > > > confirms the performance bump is caused by the change to data alignment.
> > > > > 
> > > > > After the patch, size of 'page_counter' increases from 104 bytes to 128
> > > > > bytes, and the size of 'mem_cgroup' increases from 2880 bytes to 3008
> > > > > bytes(with our kernel config). Another major data structure which
> > > > > contains 'page_counter' is 'hugetlb_cgroup', whose size will change
> > > > > from 912B to 1024B.
> > > > > 
> > > > > Should we make these page_counters aligned to reduce cacheline conflict?
> > > > 
> > > > I would rather focus on a more effective mem_cgroup layout. It is very
> > > > likely that we are just stumbling over two counters here.
> > > > 
> > > > Could you try to add cache alignment of counters after memory and see
> > > > which one makes the difference? I do not expect memsw to be the one
> > > > because that one is used together with the main counter. But who knows
> > > > maybe the way it crosses the cache line has the exact effect. Hard to
> > > > tell without other numbers.
> > > 
> > > I added some alignments change around the 'memsw', but neither of them can
> > > restore the -22.7%. Following are some log showing how the alignments
> > > are:
> > > 
> > > tl: memcg=0x7cd1000 memory=0x7cd10d0 memsw=0x7cd1140 kmem=0x7cd11b0 tcpmem=0x7cd1220
> > > t2: memcg=0x7cd0000 memory=0x7cd00d0 memsw=0x7cd0140 kmem=0x7cd01c0 tcpmem=0x7cd0230
> > > 
> > > So both of the 'memsw' are aligned, but t2's 'kmem' is aligned while
> > > t1's is not.
> > > 
> > > I will check more on the perf data about detailed hotspots.
> > 
> > Some more check updates about it:
> > 
> > Waiman's patch is effectively removing one 'struct page_counter' between
> > 'memory' and "memsw'. And the mem_cgroup is: 
> > 
> > struct mem_cgroup {
> > 
> > 	...
> > 
> > 	struct page_counter memory;		/* Both v1 & v2 */
> > 
> > 	union {
> > 		struct page_counter swap;	/* v2 only */
> > 		struct page_counter memsw;	/* v1 only */
> > 	};
> > 
> > 	/* Legacy consumer-oriented counters */
> > 	struct page_counter kmem;		/* v1 only */
> > 	struct page_counter tcpmem;		/* v1 only */
> > 
> > 	...
> > 	...
> > 
> > 	MEMCG_PADDING(_pad1_);
> > 
> > 	atomic_t		moving_account;
> > 	struct task_struct	*move_lock_task;
> > 	
> > 	...
> > };
> > 
> > 
> > I do experiments by inserting a 'page_counter' between 'memory'
> > and the 'MEMCG_PADDING(_pad1_)', no matter where I put it, the
> > benchmark result can be recovered from 145K to 185K, which is
> > really confusing, as adding a 'page_counter' right before the
> > '_pad1_' doesn't change cache alignment of any members.
> 
> Have you checked the result of pahole before and after your modification
> whether something stands out?

I can not find any abnormal thing. (I attached pahole log for 2 kernels,
one's head commit is Waiman's patch, the other adds a page_counter before
the '_pad1_')

> Btw. is this reproducible an different CPU models?

This is a Haswell 4S platform. I've tried on Cascadelake 2S and 4S , which
has -7.7% and -4.2% regression, though the perf data shows the similar
changing trend.

Thanks,
Feng

>
> -- 
> Michal Hocko
> SUSE Labs
