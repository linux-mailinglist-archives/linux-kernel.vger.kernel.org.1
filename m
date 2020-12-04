Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4636B2CEEFD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 14:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbgLDNtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 08:49:13 -0500
Received: from mga12.intel.com ([192.55.52.136]:12386 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbgLDNtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 08:49:12 -0500
IronPort-SDR: gcr7abefRjnqAxZkgkDZLOnp5uWj74cSa7bqbG6pqiAZYw/AvkyA2KZe+dL/333wBhbP/vTr/h
 PWAItkhOBpbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="152629183"
X-IronPort-AV: E=Sophos;i="5.78,392,1599548400"; 
   d="scan'208";a="152629183"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 05:47:31 -0800
IronPort-SDR: HKFrPCutvknAwCPutKZjTFkx6BG4NNjKJ/C5v9occZc3p4I0QzvlOCXWrnkUykzi0glEAKGklY
 HUW7PYPNqv7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,392,1599548400"; 
   d="scan'208";a="374350206"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Dec 2020 05:47:29 -0800
Subject: Re: [PATCH 06/10] sched/fair: Clear the target CPU from the cpumask
 of CPUs searched
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
References: <20201203141124.7391-1-mgorman@techsingularity.net>
 <20201203141124.7391-7-mgorman@techsingularity.net>
 <CAKfTPtDm880Rs7D1xUCQd_X9okqzhgrmCJVhwg90Rt3krq9ytg@mail.gmail.com>
 <20201203175204.GY3371@techsingularity.net>
 <CAKfTPtBGsXb0RqE_qs2miZGi_uax4VY1_8y1NGhQ17Q8mBx8dw@mail.gmail.com>
 <20201204113030.GZ3371@techsingularity.net>
 <CAKfTPtDRqwUoX51rU0Xd3H9Dwqf8bLAFBxhoeMF1brKYmAZDJg@mail.gmail.com>
 <CAKfTPtBABBY1QSfFtbhBQ7+a8HOp2YfTyJaMVo07T5GU7sp_MA@mail.gmail.com>
 <3d8a6d19-afac-dc93-127d-da6505402cdf@linux.intel.com>
Message-ID: <c384f484-d74b-a114-2a34-5428b58ca5d2@linux.intel.com>
Date:   Fri, 4 Dec 2020 21:47:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3d8a6d19-afac-dc93-127d-da6505402cdf@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/4 21:40, Li, Aubrey wrote:
> On 2020/12/4 21:17, Vincent Guittot wrote:
>> On Fri, 4 Dec 2020 at 14:13, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>>>
>>> On Fri, 4 Dec 2020 at 12:30, Mel Gorman <mgorman@techsingularity.net> wrote:
>>>>
>>>> On Fri, Dec 04, 2020 at 11:56:36AM +0100, Vincent Guittot wrote:
>>>>>> The intent was that the sibling might still be an idle candidate. In
>>>>>> the current draft of the series, I do not even clear this so that the
>>>>>> SMT sibling is considered as an idle candidate. The reasoning is that if
>>>>>> there are no idle cores then an SMT sibling of the target is as good an
>>>>>> idle CPU to select as any.
>>>>>
>>>>> Isn't the purpose of select_idle_smt ?
>>>>>
>>>>
>>>> Only in part.
>>>>
>>>>> select_idle_core() looks for an idle core and opportunistically saves
>>>>> an idle CPU candidate to skip select_idle_cpu. In this case this is
>>>>> useless loops for select_idle_core() because we are sure that the core
>>>>> is not idle
>>>>>
>>>>
>>>> If select_idle_core() finds an idle candidate other than the sibling,
>>>> it'll use it if there is no idle core -- it picks a busy sibling based
>>>> on a linear walk of the cpumask. Similarly, select_idle_cpu() is not
>>>
>>> My point is that it's a waste of time to loop the sibling cpus of
>>> target in select_idle_core because it will not help to find an idle
>>> core. The sibling  cpus will then be check either by select_idle_cpu
>>> of select_idle_smt
>>
>> also, while looping the cpumask, the sibling cpus of not idle cpu are
>> removed and will not be check
>>
> 
> IIUC, select_idle_core and select_idle_cpu share the same cpumask(select_idle_mask)?
> If the target's sibling is removed from select_idle_mask from select_idle_core(),
> select_idle_cpu() will lose the chance to pick it up?

aha, no, select_idle_mask will be re-assigned in select_idle_cpu() by:

	cpumask_and(cpus, sds_idle_cpus(sd->shared), p->cpus_ptr);

So, yes, I guess we can remove the cpu_smt_mask(target) from select_idle_core() safely.

> 
> Thanks,
> -Aubrey
> 

