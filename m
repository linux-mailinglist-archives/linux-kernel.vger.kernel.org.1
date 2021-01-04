Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D1D2E8F7D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 03:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbhADCx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 21:53:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:55778 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727964AbhADCx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 21:53:58 -0500
IronPort-SDR: EL7rW25yNVCqukI/p+1S8EQ44hWaINtqaZp4cVpxy9QyEAZZIGjwtt73PKtBpehjMXdKm6qH1L
 3jIiNNpoGkEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9853"; a="174326074"
X-IronPort-AV: E=Sophos;i="5.78,472,1599548400"; 
   d="scan'208";a="174326074"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2021 18:53:18 -0800
IronPort-SDR: TJjiJPoulMMq1bRpGIFoxY7M2vriaAK6CdxUuoHMVonCT1jOif92MMjo9JIwwERUXPFlBCcasd
 gsJ20CIoYBpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,472,1599548400"; 
   d="scan'208";a="378242151"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by orsmga008.jf.intel.com with ESMTP; 03 Jan 2021 18:53:15 -0800
Date:   Mon, 4 Jan 2021 10:53:14 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH 2/2] mm: memcg: add a new MEMCG_UPDATE_BATCH
Message-ID: <20210104025314.GA32269@shbuild999.sh.intel.com>
References: <1609252514-27795-1-git-send-email-feng.tang@intel.com>
 <1609252514-27795-2-git-send-email-feng.tang@intel.com>
 <20201229171327.GB371241@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229171327.GB371241@carbon.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

On Tue, Dec 29, 2020 at 09:13:27AM -0800, Roman Gushchin wrote:
> On Tue, Dec 29, 2020 at 10:35:14PM +0800, Feng Tang wrote:
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
> > fio:				 +2.0% ~  +6.8%
> > will-it-scale/malloc:		 -0.9% ~  +6.2%
> > will-it-scale/page_fault1:	 no change
> > will-it-scale/page_fault2:	+13.7% ~ +26.2%
> 
> I wonder if there are any wins noticeable in the real world?
> Lowering the accuracy of statistics makes harder to interpret it,
> so it should be very well justified.

This is a valid concern. I only had test results for fio, 
will-it-scale and vm-scalability (mostly impovements) so far, 
and I will try to run on some Redis/RockDB like workload. I have
seen hotspots related with memcg statistics counting in some
customers' report, which is part of the motivation of the patch. 

> 512 * nr_cpus is a large number.

I also tested 128, 256, 2048, 4096, which all show similar gains
with the benchmarks above, and 512 is chosed for 2MB pages. 128
could be less harmful for accuracy.

> > 
> > One thought is it could be dynamically calculated according to
> > memcg limit and number of CPUs, and another is to add a periodic
> > syncing of the data for accuracy reason similar to vmstat, as
> > suggested by Ying.
> 
> It sounds good to me, but it's quite tricky to implement properly,
> given that thee number of cgroups can be really big. It makes the
> traversing of the whole cgroup tree and syncing stats quite expensive,
> so it will not be easy to find a good balance.

Agreed. Also could you shed some light about how these statistics
data are used, so that we can better understand the usage.

Thanks again for the valuable feedback! 

- Feng

> Thanks!
