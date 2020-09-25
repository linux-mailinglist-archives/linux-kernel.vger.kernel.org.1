Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5242783DC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgIYJVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:21:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:21174 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgIYJVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:21:51 -0400
IronPort-SDR: TcM1JbTTnu6ZYnD5l+OtPaw+YAa9E/SUT1P6n8eTzDwdhIErHnxdmeJS8afsv96H6alYSKXhzG
 pMt9YbW2BTag==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="225627852"
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; 
   d="scan'208";a="225627852"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 02:21:50 -0700
IronPort-SDR: GnWlVXH2COUlTOYI4xducBox4WNW9rWVYgmi7FqIRxFRXZW+ofpe1R2j1Axh1oHmcUGz0nMmJ0
 n908P0xnvLbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; 
   d="scan'208";a="336532486"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.135]) ([10.239.161.135])
  by fmsmga004.fm.intel.com with ESMTP; 25 Sep 2020 02:21:47 -0700
Subject: Re: [RFC PATCH v2] sched/fair: select idle cpu from idle cpumask in
 sched domain
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Jiang Biao <benbjiang@gmail.com>
References: <20200916043103.606132-1-aubrey.li@linux.intel.com>
 <20200916110039.GG3117@suse.de>
 <78d608f2-b974-e940-da32-b37777bc405a@linux.intel.com>
 <CAKfTPtAVkg081VEGp3Hx3i7D+jxRJcyBi2=NJypvHH6HVJ8Nwg@mail.gmail.com>
 <CAKfTPtA2yE_sFfP5MFN=K+ph7rqpYUhapUdDBJ5hFLxnQPktJw@mail.gmail.com>
 <af0237e0-1451-9d11-2ee2-1468a8bb6180@linux.intel.com>
 <CAKfTPtD71z-n2dVTpZk5tLwy5OZjkju9v5vJ-3QNHhw8Grhc_Q@mail.gmail.com>
 <8a86b085-b445-b1c2-9b46-6346d923abf0@linux.intel.com>
 <CAKfTPtB-L3uM34N1w5ELzceuJxiMdkwXV5nQcqWitBAhsLoMhQ@mail.gmail.com>
 <eb1c4c84-e361-d5a7-d071-b0dd7310eab4@linux.intel.com>
 <CAKfTPtBYmAauUi1-bKpN1UmMTWEQL-TZqQJxtkVFnYjo-E1mRg@mail.gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <aff0c293-cf4d-9770-cd54-fc0d06662f09@linux.intel.com>
Date:   Fri, 25 Sep 2020 17:21:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBYmAauUi1-bKpN1UmMTWEQL-TZqQJxtkVFnYjo-E1mRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vicent,

On 2020/9/24 21:09, Vincent Guittot wrote:
>>>>
>>>> Would you mind share uperf(netperf load) result on your side? That's the
>>>> workload I have seen the most benefit this patch contributed under heavy
>>>> load level.
>>>
>>> with uperf, i've got the same kind of result as sched pipe
>>> tip/sched/core: Throughput 24.83Mb/s (+/- 0.09%)
>>> with this patch:  Throughput 19.02Mb/s (+/- 0.71%) which is a 23%
>>> regression as for sched pipe
>>>
>> In case this is caused by the logic error in this patch(sorry again), did
>> you see any improvement in patch V2? Though it does not helps for nohz=off
>> case, just want to know if it helps or does not help at all on arm platform.
> 
> With the v2 which rate limit the update of the cpumask (but doesn't
> support sched_idle stask),  I don't see any performance impact:

I agree we should go the way with cpumask update rate limited.

And I think no performance impact for sched-pipe is expected, as this workload
has only 2 threads and the platform has 8 cores, so mostly previous cpu is
returned, and even if select_idle_sibling is called, select_idle_core is hit
and rarely call select_idle_cpu.

But I'm more curious why there is 23% performance penalty? So for this patch, if
you revert this change but keep cpumask updated, is 23% penalty still there?

-       cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+       cpumask_and(cpus, sds_idle_cpus(sd->shared), p->cpus_ptr);

I just wonder if it's caused by the atomic ops as you have two cache domains with
sd_llc(?). Do you have a x86 machine to make a comparison? It's hard for me to find
an ARM machine but I'll try.

Also, for uperf(task thread num = cpu num) workload, how is it on patch v2? no any
performance impact?

Thanks,
-Aubrey
