Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C5E2CEF6C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 15:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388259AbgLDOJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 09:09:27 -0500
Received: from mga09.intel.com ([134.134.136.24]:33105 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387521AbgLDOJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 09:09:27 -0500
IronPort-SDR: cmnlImSLDkfvBGtOzRA/ct5Hqlp2aRSNhX1TDyUJ45OpMmPv68kGwz8F5rhq5mCv28yiCADZAZ
 YTMC6m8yyTTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="173535101"
X-IronPort-AV: E=Sophos;i="5.78,392,1599548400"; 
   d="scan'208";a="173535101"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 06:07:40 -0800
IronPort-SDR: HYc2YFZuDUXZsax1YtsqoB3hL1pubb2L2WVFYvT4F7/onrViWRARky0b7iuLRWM7Cq/dMn01v0
 WhFI7htq/gJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,392,1599548400"; 
   d="scan'208";a="374356951"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Dec 2020 06:07:14 -0800
Subject: Re: [PATCH 06/10] sched/fair: Clear the target CPU from the cpumask
 of CPUs searched
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        LKML <linux-kernel@vger.kernel.org>,
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
 <CAKfTPtAp+SyjmAsxTpSo5owQq0AeDpBWdo5ds0fVZvDr2OK_iw@mail.gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <a8e972a1-4bc5-e68d-a605-ab7359b1d333@linux.intel.com>
Date:   Fri, 4 Dec 2020 22:07:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtAp+SyjmAsxTpSo5owQq0AeDpBWdo5ds0fVZvDr2OK_iw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/4 21:47, Vincent Guittot wrote:
> On Fri, 4 Dec 2020 at 14:40, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>>
>> On 2020/12/4 21:17, Vincent Guittot wrote:
>>> On Fri, 4 Dec 2020 at 14:13, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>>>>
>>>> On Fri, 4 Dec 2020 at 12:30, Mel Gorman <mgorman@techsingularity.net> wrote:
>>>>>
>>>>> On Fri, Dec 04, 2020 at 11:56:36AM +0100, Vincent Guittot wrote:
>>>>>>> The intent was that the sibling might still be an idle candidate. In
>>>>>>> the current draft of the series, I do not even clear this so that the
>>>>>>> SMT sibling is considered as an idle candidate. The reasoning is that if
>>>>>>> there are no idle cores then an SMT sibling of the target is as good an
>>>>>>> idle CPU to select as any.
>>>>>>
>>>>>> Isn't the purpose of select_idle_smt ?
>>>>>>
>>>>>
>>>>> Only in part.
>>>>>
>>>>>> select_idle_core() looks for an idle core and opportunistically saves
>>>>>> an idle CPU candidate to skip select_idle_cpu. In this case this is
>>>>>> useless loops for select_idle_core() because we are sure that the core
>>>>>> is not idle
>>>>>>
>>>>>
>>>>> If select_idle_core() finds an idle candidate other than the sibling,
>>>>> it'll use it if there is no idle core -- it picks a busy sibling based
>>>>> on a linear walk of the cpumask. Similarly, select_idle_cpu() is not
>>>>
>>>> My point is that it's a waste of time to loop the sibling cpus of
>>>> target in select_idle_core because it will not help to find an idle
>>>> core. The sibling  cpus will then be check either by select_idle_cpu
>>>> of select_idle_smt
>>>
>>> also, while looping the cpumask, the sibling cpus of not idle cpu are
>>> removed and will not be check
>>>
>>
>> IIUC, select_idle_core and select_idle_cpu share the same cpumask(select_idle_mask)?
>> If the target's sibling is removed from select_idle_mask from select_idle_core(),
>> select_idle_cpu() will lose the chance to pick it up?
> 
> This is only relevant for patch 10 which is not to be included IIUC
> what mel said in cover letter : "Patches 9 and 10 are stupid in the
> context of this series."

So the target's sibling can be removed from cpumask in select_idle_core
in patch 6, and need to be added back in select_idle_core in patch 10, :)
