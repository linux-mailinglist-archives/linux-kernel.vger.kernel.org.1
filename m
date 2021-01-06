Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE582EB7FB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 03:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbhAFCM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 21:12:59 -0500
Received: from mga03.intel.com ([134.134.136.65]:3721 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbhAFCM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 21:12:59 -0500
IronPort-SDR: X6Yiu3MDyITW6aCy1tH/PIbE+66IdGQYWiFEYajVEug+IEgH5Rkqpg2Cww+GrlOHHblkNCXaA7
 ma5A71Gi8LmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="177314920"
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400"; 
   d="scan'208";a="177314920"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 18:12:17 -0800
IronPort-SDR: i6BjHQCTGiTSbmJTLNZuZdyY3yWoZJj4nMQ3V/KInbUW0o6BZgXm9/5F+amNJieJDlhGsQHt0x
 xp5mYDTGjwiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400"; 
   d="scan'208";a="402536536"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Jan 2021 18:12:14 -0800
Date:   Wed, 6 Jan 2021 10:12:13 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, andi.kleen@intel.com,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Huang Ying <ying.huang@intel.com>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH 2/2] mm: memcg: add a new MEMCG_UPDATE_BATCH
Message-ID: <20210106021213.GD101866@shbuild999.sh.intel.com>
References: <1609252514-27795-1-git-send-email-feng.tang@intel.com>
 <1609252514-27795-2-git-send-email-feng.tang@intel.com>
 <CALvZod5ir6F6BkJiVoXztNu6CancqJ2sNusg_hwTPcEssYkDdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5ir6F6BkJiVoXztNu6CancqJ2sNusg_hwTPcEssYkDdQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shakeel,

On Tue, Jan 05, 2021 at 04:47:33PM -0800, Shakeel Butt wrote:
> On Tue, Dec 29, 2020 at 6:35 AM Feng Tang <feng.tang@intel.com> wrote:
> >
> > When profiling memory cgroup involved benchmarking, status update
> > sometimes take quite some CPU cycles. Current MEMCG_CHARGE_BATCH
> > is used for both charging and statistics/events updating, and is
> > set to 32, which may be good for accuracy of memcg charging, but
> > too small for stats update which causes concurrent access to global
> > stats data instead of per-cpu ones.
> >
> > So handle them differently, by adding a new bigger batch number
> > for stats updating, while keeping the value for charging (though
> > comments in memcontrol.h suggests to consider a bigger value too)
> >
> > The new batch is set to 512, which considers 2MB huge pages (512
> > pages), as the check logic mostly is:
> >
> >     if (x > BATCH), then skip updating global data
> >
> > so it will save 50% global data updating for 2MB pages
> >
> > Following are some performance data with the patch, against
> > v5.11-rc1, on several generations of Xeon platforms. Each category
> > below has several subcases run on different platform, and only the
> > worst and best scores are listed:
> >
> > fio:                             +2.0% ~  +6.8%
> > will-it-scale/malloc:            -0.9% ~  +6.2%
> > will-it-scale/page_fault1:       no change
> > will-it-scale/page_fault2:      +13.7% ~ +26.2%
> >
> > One thought is it could be dynamically calculated according to
> > memcg limit and number of CPUs, and another is to add a periodic
> > syncing of the data for accuracy reason similar to vmstat, as
> > suggested by Ying.
> >
> 
> I am going to push back on this change. On a large system where jobs
> can run on any available cpu, this will totally mess up the stats
> (which is actually what happens on our production servers). These
> stats are used for multiple purposes like debugging or understanding
> the memory usage of the job or doing data analysis.

Thanks for sharing the usage case, and I agree  it will bring more
trouble for debugging and analyzing.

Though we lack real world load, but the micro benchmarks do show
obvious benefits, 0day rebot reported a 43.4% improvement for
vm-scalability lru-shm case, and it is up to +60% against 5.11-rc1.

The memory cgroup stats updating hotspots has been on our radar
for a long time, which could be seen in the perf profile data.

So I am wondering if we could make the batch a configurable knob,
so that it can benefit workload without need for accurate stats.

One further thought is, there are quite some "BATCH" number in
kernel for perf-cpu/global data updating, maybe we can add a
global flag 'sysctl_need_accurate_stats' for
	if (sysctl_need_accurate_stats)
		batch = SMALLER_BATCH
	else
		batch = BIGGER_BATCH


Thanks,
Feng


