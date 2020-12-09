Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D032D40B6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbgLILJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:09:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:56178 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730293AbgLILJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:09:00 -0500
IronPort-SDR: UDTqgdOxXc+t/5S6EaxgMaQTJF//wo/FjidutNXliAqPNoVM05qkj7cCdsIBqV7FnMxHYiwntf
 sTrDFpp6YcGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="161820012"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="161820012"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 03:07:13 -0800
IronPort-SDR: yZa7ZtHtUe6//RozZZ56tglrZmSEcywDG+CV72UCg22NMhAhNUbteiTiJ8aaK3Dy0oNI6oXlw9
 WOtCH0LUz+Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="368145092"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by fmsmga004.fm.intel.com with ESMTP; 09 Dec 2020 03:07:11 -0800
Subject: Re: [PATCH 2/4] sched/fair: Move avg_scan_cost calculations under
 SIS_PROP
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
References: <20201208153501.1467-1-mgorman@techsingularity.net>
 <20201208153501.1467-3-mgorman@techsingularity.net>
 <CAKfTPtBGghbKimO17UTPUHQGZc=GkY849HFrkqqojirPhJKFoQ@mail.gmail.com>
 <3255625e-fa92-dc09-9fab-5621122f4af0@linux.intel.com>
 <20201209090507.GM3371@techsingularity.net>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <14963d1e-02ea-c298-d6b4-2db637913ee3@linux.intel.com>
Date:   Wed, 9 Dec 2020 19:07:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201209090507.GM3371@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/9 17:05, Mel Gorman wrote:
> On Wed, Dec 09, 2020 at 01:28:11PM +0800, Li, Aubrey wrote:
>>>>                         nr = div_u64(span_avg, avg_cost);
>>>>                 else
>>>>                         nr = 4;
>>>> -       }
>>>> -
>>>> -       time = cpu_clock(this);
>>>>
>>>> -       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>>>> +               time = cpu_clock(this);
>>>> +       }
>>>>
>>>>         for_each_cpu_wrap(cpu, cpus, target) {
>>>>                 if (!--nr)
>>
>> nr is the key of this throttling mechanism, need to be placed under sched_feat(SIS_PROP) as well.
>>
> 
> It isn't necessary as nr in initialised to INT_MAX if !SIS_PROP.
>If !SIS_PROP, nr need to -1 then tested in the loop, instead of testing directly.
But with SIS_PROP, need adding a test in the loop.
Since SIS_PROP is default true, I think it's okay to keep the current way.

Thanks,
-Aubrey
