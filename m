Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B583E2B1684
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 08:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgKMHeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 02:34:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:5675 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgKMHeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 02:34:44 -0500
IronPort-SDR: jfvWP1gre8yybNfusGXdRzLexlhNsyg8fsDdoBc/1KzUz6GzivQbKbi5U3FdTC68R5D2kgi/xf
 Fjl5i893/ZuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="158216693"
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; 
   d="scan'208";a="158216693"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 23:34:41 -0800
IronPort-SDR: sQokg6Hx0MJz/Qpl4kQ0X6r+3xMgUTOGei0UkMY5FdtEADGTOybbLM7NZWtUmG1yH0qj7lA0V4
 +tuV/X/S5ggA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; 
   d="scan'208";a="532475822"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by fmsmga005.fm.intel.com with ESMTP; 12 Nov 2020 23:34:37 -0800
Date:   Fri, 13 Nov 2020 15:34:36 +0800
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
Message-ID: <20201113073436.GA113119@shbuild999.sh.intel.com>
References: <20201102091543.GM31092@shao2-debian>
 <20201102092754.GD22613@dhcp22.suse.cz>
 <82d73ebb-a31e-4766-35b8-82afa85aa047@intel.com>
 <20201102100247.GF22613@dhcp22.suse.cz>
 <bd87e8bd-c918-3f41-0cc5-e2927d91625f@linux.intel.com>
 <20201104081546.GB10052@dhcp22.suse.cz>
 <20201112122844.GA11000@shbuild999.sh.intel.com>
 <20201112141654.GC12240@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112141654.GC12240@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 03:16:54PM +0100, Michal Hocko wrote:
> On Thu 12-11-20 20:28:44, Feng Tang wrote:
> > Hi Michal,
> > 
> > On Wed, Nov 04, 2020 at 09:15:46AM +0100, Michal Hocko wrote:
> > > > > > Hi Michal,
> > > > > > 
> > > > > > We used the default configure of cgroups, not sure what configuration you
> > > > > > want,
> > > > > > could you give me more details? and here is the cgroup info of will-it-scale
> > > > > > process:
> > > > > > 
> > > > > > $ cat /proc/3042/cgroup
> > > > > > 12:hugetlb:/
> > > > > > 11:memory:/system.slice/lkp-bootstrap.service
> > > > > 
> > > > > OK, this means that memory controler is enabled and in use. Btw. do you
> > > > > get the original performance if you add one phony page_counter after the
> > > > > union?
> > > > > 
> > > > I add one phony page_counter after the union and re-test, the regression
> > > > reduced to -1.2%. It looks like the regression caused by the data structure
> > > > layout change.
> > > 
> > > Thanks for double checking. Could you try to cache align the
> > > page_counter struct? If that helps then we should figure which counters
> > > acks against each other by adding the alignement between the respective
> > > counters. 
> > 
> > We tried below patch to make the 'page_counter' aligned.
> >   
> >   diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
> >   index bab7e57..9efa6f7 100644
> >   --- a/include/linux/page_counter.h
> >   +++ b/include/linux/page_counter.h
> >   @@ -26,7 +26,7 @@ struct page_counter {
> >    	/* legacy */
> >    	unsigned long watermark;
> >    	unsigned long failcnt;
> >   -};
> >   +} ____cacheline_internodealigned_in_smp;
> >    
> > and with it, the -22.7% peformance change turns to a small -1.7%, which
> > confirms the performance bump is caused by the change to data alignment.
> > 
> > After the patch, size of 'page_counter' increases from 104 bytes to 128
> > bytes, and the size of 'mem_cgroup' increases from 2880 bytes to 3008
> > bytes(with our kernel config). Another major data structure which
> > contains 'page_counter' is 'hugetlb_cgroup', whose size will change
> > from 912B to 1024B.
> > 
> > Should we make these page_counters aligned to reduce cacheline conflict?
> 
> I would rather focus on a more effective mem_cgroup layout. It is very
> likely that we are just stumbling over two counters here.
> 
> Could you try to add cache alignment of counters after memory and see
> which one makes the difference? I do not expect memsw to be the one
> because that one is used together with the main counter. But who knows
> maybe the way it crosses the cache line has the exact effect. Hard to
> tell without other numbers.

I added some alignments change around the 'memsw', but neither of them can
restore the -22.7%. Following are some log showing how the alignments
are:

tl: memcg=0x7cd1000 memory=0x7cd10d0 memsw=0x7cd1140 kmem=0x7cd11b0 tcpmem=0x7cd1220
t2: memcg=0x7cd0000 memory=0x7cd00d0 memsw=0x7cd0140 kmem=0x7cd01c0 tcpmem=0x7cd0230

So both of the 'memsw' are aligned, but t2's 'kmem' is aligned while
t1's is not.

I will check more on the perf data about detailed hotspots.

Thanks,
Feng

> Btw. it would be great to see what the effect is on cgroup v2 as well.
> 
> Thanks for pursuing this!
> -- 
> Michal Hocko
> SUSE Labs
