Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCAB29339E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 05:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgJTDYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 23:24:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:60181 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729465AbgJTDYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 23:24:32 -0400
IronPort-SDR: dXzpkTWv80qlebdTP+s2dzkv1A5eQD+c3ugFTo9XEUyKS5M+pL9C+VoYMkyXIjns4utzs0Yj19
 kgprpUIk1YYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="167238033"
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="scan'208";a="167238033"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 20:24:29 -0700
IronPort-SDR: CkMnhQ7SUHOq66eAovhaW1JX0Leekf+ZHqrmhCENY1E+hn+UtZ3oMeMO1Ckzs11c8Mfqoh4gB5
 IcFUTA4kD29Q==
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="scan'208";a="532875707"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.68]) ([10.238.4.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 20:24:26 -0700
Subject: Re: [LKP] Re: [sched] bdfcae1140: will-it-scale.per_thread_ops -37.0%
 regression
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Rong Chen <rong.a.chen@intel.com>,
        Anton Blanchard <anton@au.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        0day robot <lkp@intel.com>, lkp@lists.01.org,
        zhengjun xing <zhengjun.xing@intel.com>,
        aubrey li <aubrey.li@linux.intel.com>,
        yu c chen <yu.c.chen@intel.com>
References: <20201002083311.GK393@shao2-debian>
 <1183082664.11002.1602082242482.JavaMail.zimbra@efficios.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <7131f8f9-68d1-0277-c770-c10f98a062ec@linux.intel.com>
Date:   Tue, 20 Oct 2020 11:24:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1183082664.11002.1602082242482.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/7/2020 10:50 PM, Mathieu Desnoyers wrote:
> ----- On Oct 2, 2020, at 4:33 AM, Rong Chen rong.a.chen@intel.com wrote:
> 
>> Greeting,
>>
>> FYI, we noticed a -37.0% regression of will-it-scale.per_thread_ops due to
>> commit:
>>
>>
>> commit: bdfcae11403e5099769a7c8dc3262e3c4193edef ("[RFC PATCH 2/3] sched:
>> membarrier: cover kthread_use_mm (v3)")
>> url:
>> https://github.com/0day-ci/linux/commits/Mathieu-Desnoyers/Membarrier-updates/20200925-012549
>> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git
>> 848785df48835eefebe0c4eb5da7690690b0a8b7
>>
>> in testcase: will-it-scale
>> on test machine: 104 threads Skylake with 192G memory
>> with following parameters:
>>
>> 	nr_task: 50%
>> 	mode: thread
>> 	test: context_switch1
>> 	cpufreq_governor: performance
>> 	ucode: 0x2006906
>>
>> test-description: Will It Scale takes a testcase and runs it from 1 through to n
>> parallel copies to see if the testcase will scale. It builds both a process and
>> threads based test in order to see any differences between the two.
>> test-url: https://github.com/antonblanchard/will-it-scale
>>
> 
> Hi,
> 
> I would like to report what I suspect is a random thread placement issue in the
> context_switch1 test used by the 0day bot when running on a machine with hyperthread
> enabled.
> 
> AFAIU the test code uses hwloc for thread placement which should theoretically ensure
> that each thread is placed on same processing unit, core and numa node between runs.
> 
> We can find the test code here:
> 
> https://github.com/antonblanchard/will-it-scale/blob/master/tests/context_switch1.c
> 
> And the main file containing thread setup is here:
> 
> https://github.com/antonblanchard/will-it-scale/blob/master/main.c
> 
> AFAIU, the test is started without the "-m" switch, which therefore affinitizes
> tasks on cores rather than on processing units (SMT threads).
> 
> When testcase() creates the child thread with new_task(), it basically issues:
> 
>    pthread_create(&threads[nr_threads++], NULL, func, arg);
> 
> passing a NULL pthread_attr_t, and not executing any pre_trampoline on the child.
> The pre_trampoline would have issued hwloc_set_thread_cpubind if it were executed on
> the child, but it's not. Therefore, we expect the cpu affinity mask of the parent to
> be copied on clone and used by the child.
> 
> A quick test on a machine with hyperthreading enabled shows that the cpu affinity mask
> for the parent and child has two bits set:
> 
> taskset -p 1868607
> pid 1868607's current affinity mask: 10001
> taskset -p 1868606
> pid 1868606's current affinity mask: 10001
> 
> So AFAIU the placement of the parent and child will be random on either the same
> processing unit, or on separate processing units within the same core.
> 
> I suspect this randomness can significantly affect the performance number between
> runs, and trigger unwarranted performance regression warnings.
> 
> Thanks,
> 
> Mathieu
> 
Yes, the randomness may happen in some special cases.  But in 0-day, we 
test multi times (>=3), the report is the average number.
For this case, we test 4 times, it is stable, the wave is ±  2%.
So I don't think the -37.0% regression is caused by the randomness.

0/stats.json:  "will-it-scale.per_thread_ops": 105228,
1/stats.json:  "will-it-scale.per_thread_ops": 100443,
2/stats.json:  "will-it-scale.per_thread_ops": 98786,
3/stats.json:  "will-it-scale.per_thread_ops": 102821,

c2daff748f0ea954 bdfcae11403e5099769a7c8dc32
---------------- ---------------------------
          %stddev     %change         %stddev
              \          |                \
     161714 ±  2%     -37.0%     101819 ±  2%  will-it-scale.per_thread_ops


-- 
Zhengjun Xing
