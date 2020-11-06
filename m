Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCD62A8D46
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgKFC7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:59:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:12346 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgKFC7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:59:10 -0500
IronPort-SDR: oKyiTANZ6X7908vz3dW6nY99hi7NrRVn1Q/8sfSem7hkXw7rkmLh4jlsc6kSUkCfTo5Xt+JrzU
 YRsBjqhtBgEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="156495491"
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="156495491"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 18:59:09 -0800
IronPort-SDR: XfdkN1AQgkS3t3otqTu8VZYnJ4jfLqhei14ecc9sV2BgV7tkm0LbcszQq2Il6bYUwYEz52grAu
 8mbIbOBIrj6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,454,1596524400"; 
   d="scan'208";a="353237036"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.135]) ([10.239.161.135])
  by orsmga008.jf.intel.com with ESMTP; 05 Nov 2020 18:58:59 -0800
Subject: Re: [PATCH v8 -tip 00/26] Core scheduling
To:     "Ning, Hongyu" <hongyu.ning@linux.intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <f7fc588b-12cf-95a8-6142-e4d112fb1689@linux.intel.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <bf2ee997-1f53-0eef-40ad-1e98274da587@linux.intel.com>
Date:   Fri, 6 Nov 2020 10:58:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <f7fc588b-12cf-95a8-6142-e4d112fb1689@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/10/30 21:26, Ning, Hongyu wrote:
> On 2020/10/20 9:43, Joel Fernandes (Google) wrote:
>> Eighth iteration of the Core-Scheduling feature.
>>
>> Core scheduling is a feature that allows only trusted tasks to run
>> concurrently on cpus sharing compute resources (eg: hyperthreads on a
>> core). The goal is to mitigate the core-level side-channel attacks
>> without requiring to disable SMT (which has a significant impact on
>> performance in some situations). Core scheduling (as of v7) mitigates
>> user-space to user-space attacks and user to kernel attack when one of
>> the siblings enters the kernel via interrupts or system call.
>>
>> By default, the feature doesn't change any of the current scheduler
>> behavior. The user decides which tasks can run simultaneously on the
>> same core (for now by having them in the same tagged cgroup). When a tag
>> is enabled in a cgroup and a task from that cgroup is running on a
>> hardware thread, the scheduler ensures that only idle or trusted tasks
>> run on the other sibling(s). Besides security concerns, this feature can
>> also be beneficial for RT and performance applications where we want to
>> control how tasks make use of SMT dynamically.
>>
>> This iteration focuses on the the following stuff:
>> - Redesigned API.
>> - Rework of Kernel Protection feature based on Thomas's entry work.
>> - Rework of hotplug fixes.
>> - Address review comments in v7
>>
>> Joel: Both a CGroup and Per-task interface via prctl(2) are provided for
>> configuring core sharing. More details are provided in documentation patch.
>> Kselftests are provided to verify the correctness/rules of the interface.
>>
>> Julien: TPCC tests showed improvements with core-scheduling. With kernel
>> protection enabled, it does not show any regression. Possibly ASI will improve
>> the performance for those who choose kernel protection (can be toggled through
>> sched_core_protect_kernel sysctl). Results:
>> v8				average		stdev		diff
>> baseline (SMT on)		1197.272	44.78312824	
>> core sched (   kernel protect)	412.9895	45.42734343	-65.51%
>> core sched (no kernel protect)	686.6515	71.77756931	-42.65%
>> nosmt				408.667		39.39042872	-65.87%
>>
>> v8 is rebased on tip/master.
>>
>> Future work
>> ===========
>> - Load balancing/Migration fixes for core scheduling.
>>   With v6, Load balancing is partially coresched aware, but has some
>>   issues w.r.t process/taskgroup weights:
>>   https://lwn.net/ml/linux-kernel/20200225034438.GA617271@z...
>> - Core scheduling test framework: kselftests, torture tests etc
>>
>> Changes in v8
>> =============
>> - New interface/API implementation
>>   - Joel
>> - Revised kernel protection patch
>>   - Joel
>> - Revised Hotplug fixes
>>   - Joel
>> - Minor bug fixes and address review comments
>>   - Vineeth
>>
> 
>> create mode 100644 tools/testing/selftests/sched/config
>> create mode 100644 tools/testing/selftests/sched/test_coresched.c
>>
> 
> Adding 4 workloads test results for Core Scheduling v8: 
> 
> - kernel under test: coresched community v8 from https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/log/?h=coresched-v5.9
> - workloads: 
> 	-- A. sysbench cpu (192 threads) + sysbench cpu (192 threads)
> 	-- B. sysbench cpu (192 threads) + sysbench mysql (192 threads, mysqld forced into the same cgroup)
> 	-- C. uperf netperf.xml (192 threads over TCP or UDP protocol separately)
> 	-- D. will-it-scale context_switch via pipe (192 threads)
> - test machine setup: 
> 	CPU(s):              192
> 	On-line CPU(s) list: 0-191
> 	Thread(s) per core:  2
> 	Core(s) per socket:  48
> 	Socket(s):           2
> 	NUMA node(s):        4
> - test results:
> 	-- workload A, no obvious performance drop in cs_on:
> 	+----------------------+------+----------------------+------------------------+
> 	|                      | **   | sysbench cpu * 192   | sysbench mysql * 192   |
> 	+======================+======+======================+========================+
> 	| cgroup               | **   | cg_sysbench_cpu_0    | cg_sysbench_mysql_0    |
> 	+----------------------+------+----------------------+------------------------+
> 	| record_item          | **   | Tput_avg (events/s)  | Tput_avg (events/s)    |
> 	+----------------------+------+----------------------+------------------------+
> 	| coresched_normalized | **   | 1.01                 | 0.87                   |
> 	+----------------------+------+----------------------+------------------------+
> 	| default_normalized   | **   | 1                    | 1                      |
> 	+----------------------+------+----------------------+------------------------+
> 	| smtoff_normalized    | **   | 0.59                 | 0.82                   |
> 	+----------------------+------+----------------------+------------------------+
> 
> 	-- workload B, no obvious performance drop in cs_on:
> 	+----------------------+------+----------------------+------------------------+
> 	|                      | **   | sysbench cpu * 192   | sysbench cpu * 192     |
> 	+======================+======+======================+========================+
> 	| cgroup               | **   | cg_sysbench_cpu_0    | cg_sysbench_cpu_1      |
> 	+----------------------+------+----------------------+------------------------+
> 	| record_item          | **   | Tput_avg (events/s)  | Tput_avg (events/s)    |
> 	+----------------------+------+----------------------+------------------------+
> 	| coresched_normalized | **   | 1.01                 | 0.98                   |
> 	+----------------------+------+----------------------+------------------------+
> 	| default_normalized   | **   | 1                    | 1                      |
> 	+----------------------+------+----------------------+------------------------+
> 	| smtoff_normalized    | **   | 0.6                  | 0.6                    |
> 	+----------------------+------+----------------------+------------------------+
> 
> 	-- workload C, known performance drop in cs_on since Core Scheduling v6:
> 	+----------------------+------+---------------------------+---------------------------+
> 	|                      | **   | uperf netperf TCP * 192   | uperf netperf UDP * 192   |
> 	+======================+======+===========================+===========================+
> 	| cgroup               | **   | cg_uperf                  | cg_uperf                  |
> 	+----------------------+------+---------------------------+---------------------------+
> 	| record_item          | **   | Tput_avg (Gb/s)           | Tput_avg (Gb/s)           |
> 	+----------------------+------+---------------------------+---------------------------+
> 	| coresched_normalized | **   | 0.46                      | 0.48                      |
> 	+----------------------+------+---------------------------+---------------------------+
> 	| default_normalized   | **   | 1                         | 1                         |
> 	+----------------------+------+---------------------------+---------------------------+
> 	| smtoff_normalized    | **   | 0.82                      | 0.79                      |
> 	+----------------------+------+---------------------------+---------------------------+

This is known that when coresched is on, uperf offloads softirq service to
ksoftirqd, and the cookie of ksoftirqd is different from the cookie of uperf.
As a result, ksoftirqd can run concurrently with uperf previous but not now.

> 
> 	-- workload D, new added syscall workload, performance drop in cs_on:
> 	+----------------------+------+-------------------------------+
> 	|                      | **   | will-it-scale  * 192          |
> 	|                      |      | (pipe based context_switch)   |
> 	+======================+======+===============================+
> 	| cgroup               | **   | cg_will-it-scale              |
> 	+----------------------+------+-------------------------------+
> 	| record_item          | **   | threads_avg                   |
> 	+----------------------+------+-------------------------------+
> 	| coresched_normalized | **   | 0.2                           |
> 	+----------------------+------+-------------------------------+
> 	| default_normalized   | **   | 1                             |
> 	+----------------------+------+-------------------------------+
> 	| smtoff_normalized    | **   | 0.89                          |
> 	+----------------------+------+-------------------------------+

will-it-scale may be a very extreme case. The story here is,
- On one sibling reader/writer gets blocked and tries to schedule another reader/writer in.
- The other sibling tries to wake up reader/writer.

Both CPUs are acquiring rq->__lock,

So when coresched off, they are two different locks, lock stat(1 second delta) below:

class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
&rq->__lock:          210            210           0.10           3.04         180.87           0.86            797       79165021           0.03          20.69    60650198.34           0.77

But when coresched on, they are actually one same lock, lock stat(1 second delta) below:

class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
&rq->__lock:      6479459        6484857           0.05         216.46    60829776.85           9.38        8346319       15399739           0.03          95.56    81119515.38           5.27

This nature of core scheduling may degrade the performance of similar workloads with frequent context switching.

Any thoughts?

Thanks,
-Aubrey
