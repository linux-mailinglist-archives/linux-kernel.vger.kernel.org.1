Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820E22D207A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 03:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgLHCIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 21:08:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:50515 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgLHCIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:08:25 -0500
IronPort-SDR: Z5eIp2rArFljrypTy6Z4rdk1YiqjlPxf4pu79/TRoPOA5d4KKgosZRti+ueQ5/kaPpHGRkC+RK
 /jWRLqkJWERQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="153054075"
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; 
   d="scan'208";a="153054075"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 18:06:40 -0800
IronPort-SDR: mRW2hLrS8WIzcV5YaJ+awzzv8yiTvuX95femrWkLHoMumS/7GTNyL1ZRvtOFarpzodmL85wQa0
 KUxFVqnkOIxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; 
   d="scan'208";a="375689516"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Dec 2020 18:06:38 -0800
Subject: Re: [RFC PATCH 0/4] Reduce worst-case scanning of runqueues in
 select_idle_sibling
To:     Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
References: <20201207091516.24683-1-mgorman@techsingularity.net>
 <CAKfTPtC9At0Oej+u6-mtBdV6_vhFiNJGPQ-BFQc7RpUtDDixVA@mail.gmail.com>
 <20201207154216.GE3371@techsingularity.net>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <895d0c8a-5039-e569-80f3-a8a6f87380bd@linux.intel.com>
Date:   Tue, 8 Dec 2020 10:06:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201207154216.GE3371@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/7 23:42, Mel Gorman wrote:
> On Mon, Dec 07, 2020 at 04:04:41PM +0100, Vincent Guittot wrote:
>> On Mon, 7 Dec 2020 at 10:15, Mel Gorman <mgorman@techsingularity.net> wrote:
>>>
>>> This is a minimal series to reduce the amount of runqueue scanning in
>>> select_idle_sibling in the worst case.
>>>
>>> Patch 1 removes SIS_AVG_CPU because it's unused.
>>>
>>> Patch 2 improves the hit rate of p->recent_used_cpu to reduce the amount
>>>         of scanning. It should be relatively uncontroversial
>>>
>>> Patch 3-4 scans the runqueues in a single pass for select_idle_core()
>>>         and select_idle_cpu() so runqueues are not scanned twice. It's
>>>         a tradeoff because it benefits deep scans but introduces overhead
>>>         for shallow scans.
>>>
>>> Even if patch 3-4 is rejected to allow more time for Aubrey's idle cpu mask
>>
>> patch 3 looks fine and doesn't collide with Aubrey's work. But I don't
>> like patch 4  which manipulates different cpumask including
>> load_balance_mask out of LB and I prefer to wait for v6 of Aubrey's
>> patchset which should fix the problem of possibly  scanning twice busy
>> cpus in select_idle_core and select_idle_cpu
>>
> 
> Seems fair, we can see where we stand after V6 of Aubrey's work.  A lot
> of the motivation for patch 4 would go away if we managed to avoid calling
> select_idle_core() unnecessarily. As it stands, we can call it a lot from
> hackbench even though the chance of getting an idle core are minimal.
> 

Sorry for the delay, I sent v6 out just now. Comparing to v5, v6 followed Vincent's
suggestion to decouple idle cpumask update from stop_tick signal, that is, the
CPU is set in idle cpumask every time the CPU enters idle, this should address
Peter's concern about the facebook trail-latency workload, as I didn't see
any regression in schbench workload 99.0000th latency report.

However, I also didn't see any significant benefit so far, probably I should
put more load on the system. I'll do more characterization of uperf workload
to see if I can find anything.

Thanks,
-Aubrey
