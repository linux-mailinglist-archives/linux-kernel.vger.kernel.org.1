Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D272A0666
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 14:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgJ3N1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 09:27:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:35681 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgJ3N1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:27:01 -0400
IronPort-SDR: yJz0c4uOHc50Fzi8RRsmxYZPxMfVlhsCEGl1KwyiWIgu5l64FVYGiOmry+4Hn5np98koOZdhDV
 4zPFOSNzVtSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="230239273"
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="230239273"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:26:47 -0700
IronPort-SDR: kTDs6bhQ19GnYzeRDHBurIHELzMfPdHRfv6UzJPKqehLr5LgsZeD0jeE5vNY0/TMjWJdNlWwed
 UrSnaP9E/Ddw==
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="537065493"
Received: from hongyuni-mobl1.ccr.corp.intel.com (HELO [10.254.208.214]) ([10.254.208.214])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:26:38 -0700
Subject: Re: [PATCH v8 -tip 00/26] Core scheduling
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
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
        chris.hyser@oracle.com, Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
From:   "Ning, Hongyu" <hongyu.ning@linux.intel.com>
Message-ID: <f7fc588b-12cf-95a8-6142-e4d112fb1689@linux.intel.com>
Date:   Fri, 30 Oct 2020 21:26:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201020014336.2076526-1-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/10/20 9:43, Joel Fernandes (Google) wrote:
> Eighth iteration of the Core-Scheduling feature.
> 
> Core scheduling is a feature that allows only trusted tasks to run
> concurrently on cpus sharing compute resources (eg: hyperthreads on a
> core). The goal is to mitigate the core-level side-channel attacks
> without requiring to disable SMT (which has a significant impact on
> performance in some situations). Core scheduling (as of v7) mitigates
> user-space to user-space attacks and user to kernel attack when one of
> the siblings enters the kernel via interrupts or system call.
> 
> By default, the feature doesn't change any of the current scheduler
> behavior. The user decides which tasks can run simultaneously on the
> same core (for now by having them in the same tagged cgroup). When a tag
> is enabled in a cgroup and a task from that cgroup is running on a
> hardware thread, the scheduler ensures that only idle or trusted tasks
> run on the other sibling(s). Besides security concerns, this feature can
> also be beneficial for RT and performance applications where we want to
> control how tasks make use of SMT dynamically.
> 
> This iteration focuses on the the following stuff:
> - Redesigned API.
> - Rework of Kernel Protection feature based on Thomas's entry work.
> - Rework of hotplug fixes.
> - Address review comments in v7
> 
> Joel: Both a CGroup and Per-task interface via prctl(2) are provided for
> configuring core sharing. More details are provided in documentation patch.
> Kselftests are provided to verify the correctness/rules of the interface.
> 
> Julien: TPCC tests showed improvements with core-scheduling. With kernel
> protection enabled, it does not show any regression. Possibly ASI will improve
> the performance for those who choose kernel protection (can be toggled through
> sched_core_protect_kernel sysctl). Results:
> v8				average		stdev		diff
> baseline (SMT on)		1197.272	44.78312824	
> core sched (   kernel protect)	412.9895	45.42734343	-65.51%
> core sched (no kernel protect)	686.6515	71.77756931	-42.65%
> nosmt				408.667		39.39042872	-65.87%
> 
> v8 is rebased on tip/master.
> 
> Future work
> ===========
> - Load balancing/Migration fixes for core scheduling.
>   With v6, Load balancing is partially coresched aware, but has some
>   issues w.r.t process/taskgroup weights:
>   https://lwn.net/ml/linux-kernel/20200225034438.GA617271@z...
> - Core scheduling test framework: kselftests, torture tests etc
> 
> Changes in v8
> =============
> - New interface/API implementation
>   - Joel
> - Revised kernel protection patch
>   - Joel
> - Revised Hotplug fixes
>   - Joel
> - Minor bug fixes and address review comments
>   - Vineeth
> 

> create mode 100644 tools/testing/selftests/sched/config
> create mode 100644 tools/testing/selftests/sched/test_coresched.c
> 

Adding 4 workloads test results for Core Scheduling v8: 

- kernel under test: coresched community v8 from https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/log/?h=coresched-v5.9
- workloads: 
	-- A. sysbench cpu (192 threads) + sysbench cpu (192 threads)
	-- B. sysbench cpu (192 threads) + sysbench mysql (192 threads, mysqld forced into the same cgroup)
	-- C. uperf netperf.xml (192 threads over TCP or UDP protocol separately)
	-- D. will-it-scale context_switch via pipe (192 threads)
- test machine setup: 
	CPU(s):              192
	On-line CPU(s) list: 0-191
	Thread(s) per core:  2
	Core(s) per socket:  48
	Socket(s):           2
	NUMA node(s):        4
- test results:
	-- workload A, no obvious performance drop in cs_on:
	+----------------------+------+----------------------+------------------------+
	|                      | **   | sysbench cpu * 192   | sysbench mysql * 192   |
	+======================+======+======================+========================+
	| cgroup               | **   | cg_sysbench_cpu_0    | cg_sysbench_mysql_0    |
	+----------------------+------+----------------------+------------------------+
	| record_item          | **   | Tput_avg (events/s)  | Tput_avg (events/s)    |
	+----------------------+------+----------------------+------------------------+
	| coresched_normalized | **   | 1.01                 | 0.87                   |
	+----------------------+------+----------------------+------------------------+
	| default_normalized   | **   | 1                    | 1                      |
	+----------------------+------+----------------------+------------------------+
	| smtoff_normalized    | **   | 0.59                 | 0.82                   |
	+----------------------+------+----------------------+------------------------+

	-- workload B, no obvious performance drop in cs_on:
	+----------------------+------+----------------------+------------------------+
	|                      | **   | sysbench cpu * 192   | sysbench cpu * 192     |
	+======================+======+======================+========================+
	| cgroup               | **   | cg_sysbench_cpu_0    | cg_sysbench_cpu_1      |
	+----------------------+------+----------------------+------------------------+
	| record_item          | **   | Tput_avg (events/s)  | Tput_avg (events/s)    |
	+----------------------+------+----------------------+------------------------+
	| coresched_normalized | **   | 1.01                 | 0.98                   |
	+----------------------+------+----------------------+------------------------+
	| default_normalized   | **   | 1                    | 1                      |
	+----------------------+------+----------------------+------------------------+
	| smtoff_normalized    | **   | 0.6                  | 0.6                    |
	+----------------------+------+----------------------+------------------------+

	-- workload C, known performance drop in cs_on since Core Scheduling v6:
	+----------------------+------+---------------------------+---------------------------+
	|                      | **   | uperf netperf TCP * 192   | uperf netperf UDP * 192   |
	+======================+======+===========================+===========================+
	| cgroup               | **   | cg_uperf                  | cg_uperf                  |
	+----------------------+------+---------------------------+---------------------------+
	| record_item          | **   | Tput_avg (Gb/s)           | Tput_avg (Gb/s)           |
	+----------------------+------+---------------------------+---------------------------+
	| coresched_normalized | **   | 0.46                      | 0.48                      |
	+----------------------+------+---------------------------+---------------------------+
	| default_normalized   | **   | 1                         | 1                         |
	+----------------------+------+---------------------------+---------------------------+
	| smtoff_normalized    | **   | 0.82                      | 0.79                      |
	+----------------------+------+---------------------------+---------------------------+

	-- workload D, new added syscall workload, performance drop in cs_on:
	+----------------------+------+-------------------------------+
	|                      | **   | will-it-scale  * 192          |
	|                      |      | (pipe based context_switch)   |
	+======================+======+===============================+
	| cgroup               | **   | cg_will-it-scale              |
	+----------------------+------+-------------------------------+
	| record_item          | **   | threads_avg                   |
	+----------------------+------+-------------------------------+
	| coresched_normalized | **   | 0.2                           |
	+----------------------+------+-------------------------------+
	| default_normalized   | **   | 1                             |
	+----------------------+------+-------------------------------+
	| smtoff_normalized    | **   | 0.89                          |
	+----------------------+------+-------------------------------+

	comments: per internal analyzing, suspected huge amount of spin_lock contention in cs_on, may lead to significant performance drop

- notes on test results record_item:
	* coresched_normalized: smton, cs enabled, test result normalized by default value
	* default_normalized: smton, cs disabled, test result normalized by default value
	* smtoff_normalized: smtoff, test result normalized by default value
