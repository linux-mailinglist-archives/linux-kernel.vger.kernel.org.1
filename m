Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6FA2B1694
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 08:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgKMHjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 02:39:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:29494 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgKMHjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 02:39:32 -0500
IronPort-SDR: g/EOUGQOh4F/EpLJZ8KwCCMhsvMc0tJ5q+eVaH3WJk/Fy/zPB2D65w5alMgnAeCTDI8jgzVKWP
 BkJpYDN/BE2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="234598819"
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; 
   d="scan'208";a="234598819"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 23:39:31 -0800
IronPort-SDR: OeJS4RuRDltwgNKFLl6vi9iaaXpE8N6cFHBQjoquGyp9i7Z2lxgaM2P6oApP3IUHEL/G92pq0D
 GfBoZNoiNdyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; 
   d="scan'208";a="328791314"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by orsmga006.jf.intel.com with ESMTP; 12 Nov 2020 23:39:27 -0800
Date:   Fri, 13 Nov 2020 15:39:26 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
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
Message-ID: <20201113073926.GB113119@shbuild999.sh.intel.com>
References: <20201102091543.GM31092@shao2-debian>
 <20201102092754.GD22613@dhcp22.suse.cz>
 <82d73ebb-a31e-4766-35b8-82afa85aa047@intel.com>
 <20201102100247.GF22613@dhcp22.suse.cz>
 <bd87e8bd-c918-3f41-0cc5-e2927d91625f@linux.intel.com>
 <20201104081546.GB10052@dhcp22.suse.cz>
 <20201112122844.GA11000@shbuild999.sh.intel.com>
 <20201112141654.GC12240@dhcp22.suse.cz>
 <7e40849b-f9e0-34d4-4254-c2c99dd71f78@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e40849b-f9e0-34d4-4254-c2c99dd71f78@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 11:43:45AM -0500, Waiman Long wrote:
> >>We tried below patch to make the 'page_counter' aligned.
> >>   diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
> >>   index bab7e57..9efa6f7 100644
> >>   --- a/include/linux/page_counter.h
> >>   +++ b/include/linux/page_counter.h
> >>   @@ -26,7 +26,7 @@ struct page_counter {
> >>    	/* legacy */
> >>    	unsigned long watermark;
> >>    	unsigned long failcnt;
> >>   -};
> >>   +} ____cacheline_internodealigned_in_smp;
> >>and with it, the -22.7% peformance change turns to a small -1.7%, which
> >>confirms the performance bump is caused by the change to data alignment.
> >>
> >>After the patch, size of 'page_counter' increases from 104 bytes to 128
> >>bytes, and the size of 'mem_cgroup' increases from 2880 bytes to 3008
> >>bytes(with our kernel config). Another major data structure which
> >>contains 'page_counter' is 'hugetlb_cgroup', whose size will change
> >>from 912B to 1024B.
> >>
> >>Should we make these page_counters aligned to reduce cacheline conflict?
> >I would rather focus on a more effective mem_cgroup layout. It is very
> >likely that we are just stumbling over two counters here.
> >
> >Could you try to add cache alignment of counters after memory and see
> >which one makes the difference? I do not expect memsw to be the one
> >because that one is used together with the main counter. But who knows
> >maybe the way it crosses the cache line has the exact effect. Hard to
> >tell without other numbers.
> >
> >Btw. it would be great to see what the effect is on cgroup v2 as well.
> >
> >Thanks for pursuing this!
> 
> The contention may be in the page counters themselves or it can be in other
> fields below the page counters. The cacheline alignment will cause
> "high_work" just after the page counters to start at a cacheline boundary. I
> will try removing the cacheline alignment in the page counter and add it to
> high_work to see there is any change in performance. If there is no change,
> the performance problem will not be in the page counters.
 
Yes, that's a good spot to check. I even doubt it could be other members of
'struct mem_cgroup', which affects the benchmark, as we've seen some other
performance bump which is possibly related to it too.

Thanks,
Feng
