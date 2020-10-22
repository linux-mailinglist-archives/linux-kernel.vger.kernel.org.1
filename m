Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A2829563C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 03:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894869AbgJVByu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 21:54:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:61916 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2894809AbgJVByu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 21:54:50 -0400
IronPort-SDR: GirQjLl85IG4OBk3DZW7zU7JptNutVZTKb07aNOI4HKC10yX4I4lc1Os3Hd5/FqosKfmMZ+AE0
 Cx/9+l/hJ7gw==
X-IronPort-AV: E=McAfee;i="6000,8403,9781"; a="164865240"
X-IronPort-AV: E=Sophos;i="5.77,402,1596524400"; 
   d="scan'208";a="164865240"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 18:54:48 -0700
IronPort-SDR: MWlCrGFNE1oFrwUWBbZScek+rBFuFrvLPOF1pN9sOOpBA3fgRaEcqvRm1Udojlc25efblk3PLo
 OXhkPHC0BAzA==
X-IronPort-AV: E=Sophos;i="5.77,402,1596524400"; 
   d="scan'208";a="533759096"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.68]) ([10.238.4.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 18:54:44 -0700
Subject: Re: [LKP] Re: [sched] bdfcae1140: will-it-scale.per_thread_ops -37.0%
 regression
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        Anton Blanchard <anton@au.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        0day robot <lkp@intel.com>, lkp <lkp@lists.01.org>,
        zhengjun xing <zhengjun.xing@intel.com>,
        aubrey li <aubrey.li@linux.intel.com>,
        yu c chen <yu.c.chen@intel.com>
References: <20201002083311.GK393@shao2-debian>
 <1183082664.11002.1602082242482.JavaMail.zimbra@efficios.com>
 <7131f8f9-68d1-0277-c770-c10f98a062ec@linux.intel.com>
 <510309749.29852.1603199662203.JavaMail.zimbra@efficios.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <e2eb8ed0-1075-3c5d-207e-d218a59c2a9f@linux.intel.com>
Date:   Thu, 22 Oct 2020 09:54:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <510309749.29852.1603199662203.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2020 9:14 PM, Mathieu Desnoyers wrote:
> ----- On Oct 19, 2020, at 11:24 PM, Xing Zhengjun zhengjun.xing@linux.intel.com wrote:
> 
>> On 10/7/2020 10:50 PM, Mathieu Desnoyers wrote:
>>> ----- On Oct 2, 2020, at 4:33 AM, Rong Chen rong.a.chen@intel.com wrote:
>>>
>>>> Greeting,
>>>>
>>>> FYI, we noticed a -37.0% regression of will-it-scale.per_thread_ops due to
>>>> commit:
>>>>
>>>>
>>>> commit: bdfcae11403e5099769a7c8dc3262e3c4193edef ("[RFC PATCH 2/3] sched:
>>>> membarrier: cover kthread_use_mm (v3)")
>>>> url:
>>>> https://github.com/0day-ci/linux/commits/Mathieu-Desnoyers/Membarrier-updates/20200925-012549
>>>> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git
>>>> 848785df48835eefebe0c4eb5da7690690b0a8b7
>>>>
>>>> in testcase: will-it-scale
>>>> on test machine: 104 threads Skylake with 192G memory
>>>> with following parameters:
>>>>
>>>> 	nr_task: 50%
>>>> 	mode: thread
>>>> 	test: context_switch1
>>>> 	cpufreq_governor: performance
>>>> 	ucode: 0x2006906
>>>>
>>>> test-description: Will It Scale takes a testcase and runs it from 1 through to n
>>>> parallel copies to see if the testcase will scale. It builds both a process and
>>>> threads based test in order to see any differences between the two.
>>>> test-url: https://github.com/antonblanchard/will-it-scale
>>>>
>>>
>>> Hi,
>>>
>>> I would like to report what I suspect is a random thread placement issue in the
>>> context_switch1 test used by the 0day bot when running on a machine with
>>> hyperthread
>>> enabled.
>>>
>>> AFAIU the test code uses hwloc for thread placement which should theoretically
>>> ensure
>>> that each thread is placed on same processing unit, core and numa node between
>>> runs.
>>>
>>> We can find the test code here:
>>>
>>> https://github.com/antonblanchard/will-it-scale/blob/master/tests/context_switch1.c
>>>
>>> And the main file containing thread setup is here:
>>>
>>> https://github.com/antonblanchard/will-it-scale/blob/master/main.c
>>>
>>> AFAIU, the test is started without the "-m" switch, which therefore affinitizes
>>> tasks on cores rather than on processing units (SMT threads).
>>>
>>> When testcase() creates the child thread with new_task(), it basically issues:
>>>
>>>     pthread_create(&threads[nr_threads++], NULL, func, arg);
>>>
>>> passing a NULL pthread_attr_t, and not executing any pre_trampoline on the
>>> child.
>>> The pre_trampoline would have issued hwloc_set_thread_cpubind if it were
>>> executed on
>>> the child, but it's not. Therefore, we expect the cpu affinity mask of the
>>> parent to
>>> be copied on clone and used by the child.
>>>
>>> A quick test on a machine with hyperthreading enabled shows that the cpu
>>> affinity mask
>>> for the parent and child has two bits set:
>>>
>>> taskset -p 1868607
>>> pid 1868607's current affinity mask: 10001
>>> taskset -p 1868606
>>> pid 1868606's current affinity mask: 10001
>>>
>>> So AFAIU the placement of the parent and child will be random on either the same
>>> processing unit, or on separate processing units within the same core.
>>>
>>> I suspect this randomness can significantly affect the performance number
>>> between
>>> runs, and trigger unwarranted performance regression warnings.
>>>
>>> Thanks,
>>>
>>> Mathieu
>>>
>> Yes, the randomness may happen in some special cases.  But in 0-day, we
>> test multi times (>=3), the report is the average number.
>> For this case, we test 4 times, it is stable, the wave is ±  2%.
>> So I don't think the -37.0% regression is caused by the randomness.
>>
>> 0/stats.json:  "will-it-scale.per_thread_ops": 105228,
>> 1/stats.json:  "will-it-scale.per_thread_ops": 100443,
>> 2/stats.json:  "will-it-scale.per_thread_ops": 98786,
>> 3/stats.json:  "will-it-scale.per_thread_ops": 102821,
>>
>> c2daff748f0ea954 bdfcae11403e5099769a7c8dc32
>> ---------------- ---------------------------
>>           %stddev     %change         %stddev
>>               \          |                \
>>      161714 ±  2%     -37.0%     101819 ±  2%  will-it-scale.per_thread_ops
> 
> Arguing whether this specific instance of the test is indeed a performance
> regression or not is not relevant to this discussion.
> 
> What I am pointing out here is that the test needs fixing because it generates
> noise due to a random thread placement configuration. This issue is about whether
> we can trust the results of those tests as kernel maintainers.
> 
> So on one hand, you can fix the test. This is simple to do: make sure the thread
> affinity does not allow for this randomness on SMT.
> 
> But you seem to argue that the test does not need to be fixed, because the 0day
> infrastructure in which it runs will cover for this randomness. I really doubt
> about this.
> 
> If you indeed choose to argue that the test does not need fixing, then here is the
> statistical analysis I am looking for:
> 
> - With the 4 runs, what are the odds that the average result for one class significantly
>    differs from the other class due to this randomness. It may be small, but it is certainly
>    not zero,

If 4 runs are not enough, how many times' run do you think is OK? In 
fact, I have re-test it for more than 10 times, the test result is 
almost the same.
=========================================================================================
tbox_group/testcase/rootfs/kconfig/compiler/nr_task/mode/test/cpufreq_governor/ucode/debug-setup:
 
lkp-skl-fpga01/will-it-scale/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-9/50%/thread/context_switch1/performance/0x2006906/test2

commit:
   c2daff748f0ea954746e8e3465998b1090be7c30
   bdfcae11403e5099769a7c8dc3262e3c4193edef

c2daff748f0ea954 bdfcae11403e5099769a7c8dc32
---------------- ---------------------------
          %stddev     %change         %stddev
              \          |                \
     161582           -37.2%     101435        will-it-scale.per_thread_ops
    8402288           -37.2%    5274649        will-it-scale.workload


> - Based on those odds, and on the number of performance regression tests performed by 0day
>    each year, how frequently does 0day end up spamming kernel developers with random results
>    because of this randomness ?
> 
> That being said, I would really find more productive that we work together on fixing the
> test rather than justifying why it can stay broken. Let me know if you have specific
> questions on how to fix the test, and I'll be happy to help out.
> 
> Thanks,
> 
> Mathieu
> 
In fact, 0-day just copy the will-it-scale benchmark from the GitHub, if 
you think the will-it-scale benchmark has some issues, you can 
contribute your idea and help to improve it, later we will update the 
will-it-scale benchmark to the new version.
For this test case, if we bind the workload to a specific CPU, then it 
will hide the scheduler balance issue. In the real world, we seldom bind 
the CPU...

-- 
Zhengjun Xing
