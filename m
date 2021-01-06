Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723292EB906
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 05:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbhAFEqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 23:46:35 -0500
Received: from mga06.intel.com ([134.134.136.31]:11318 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbhAFEqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 23:46:34 -0500
IronPort-SDR: QgGR8L3RTTc1FTb+8TZtKZeAZLq+f//Py4kK/eTFjcBMekEdalUaxsVRUcEIFS+kZXt8k7gK8M
 IR4D0+FdQeyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="238777854"
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="238777854"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 20:45:53 -0800
IronPort-SDR: 1dFXjE8Uz9vBuNBcfiNT3fvqJvx8WsbzyCNMuMOHgCYhpf3S32eKLMrH0nyGVu2Kq14rlNSyk0
 +hn6t/PQBBDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="398088495"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.98])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jan 2021 20:45:50 -0800
Date:   Wed, 6 Jan 2021 12:45:50 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Chris Down <chris@chrisdown.name>, Roman Gushchin <guro@fb.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, andi.kleen@intel.com,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 2/2] mm: memcg: add a new MEMCG_UPDATE_BATCH
Message-ID: <20210106044550.GA3184@shbuild999.sh.intel.com>
References: <1609252514-27795-1-git-send-email-feng.tang@intel.com>
 <1609252514-27795-2-git-send-email-feng.tang@intel.com>
 <CALvZod5ir6F6BkJiVoXztNu6CancqJ2sNusg_hwTPcEssYkDdQ@mail.gmail.com>
 <20210106021213.GD101866@shbuild999.sh.intel.com>
 <X/Ux6CT6EsP+QQ8S@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/Ux6CT6EsP+QQ8S@chrisdown.name>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Wed, Jan 06, 2021 at 03:43:36AM +0000, Chris Down wrote:
> Feng Tang writes:
> >One further thought is, there are quite some "BATCH" number in
> >kernel for perf-cpu/global data updating, maybe we can add a
> >global flag 'sysctl_need_accurate_stats' for
> >	if (sysctl_need_accurate_stats)
> >		batch = SMALLER_BATCH
> >	else
> >		batch = BIGGER_BATCH
> 
> Moving decisions like this to the system administrator is not really a
> solution to the problem -- inclusion should at least be contingent on either
> having "correct-ish" stats exported to userspace. Displaying broken stats to
> the user -- even with a configuration knob -- is less than ideal and is
> likely to confuse and confound issues in future.
> 
> I would also like to see numbers from more real-world workloads.

Sure. Roman also mentioned this. Do you have some suggestions for the
workload or benchmarks? I don't have much knowledge on this, and have
only leveraged some of 0day's benchmarking systems.

Thanks,
Feng

> MEMCG_CHARGE_BATCH is certainly fairly arbitrary as-is, but if it is going
> to be changed, the reason for that change and its implications (positive and
> negative) for real-world workloads must be well understood, and I'm not sure
> we're there yet.
