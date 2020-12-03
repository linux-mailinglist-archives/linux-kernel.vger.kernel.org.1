Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515812CCF0B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgLCGSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:18:22 -0500
Received: from mga06.intel.com ([134.134.136.31]:44405 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgLCGSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:18:21 -0500
IronPort-SDR: nWnIsqfyKQBTAHngGp+IJcnMihzlwxH+bEaAqlm9+qTaLvISfxY2Jc18OmpQ7bFMo2OCw5JTXG
 EC8vd6jXuuGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="234746606"
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="234746606"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 22:16:40 -0800
IronPort-SDR: GN97xz7zz5hG86qKUjh4I1g4AvS8u+wqV7hMxmg5Y34w9DjViNC6skdgvv0dTkYhhESLUbDTTZ
 XRcDWXmDEneg==
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="550370055"
Received: from hongyuni-mobl1.ccr.corp.intel.com (HELO [10.238.1.49]) ([10.238.1.49])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 22:16:30 -0800
Subject: Re: [PATCH -tip 00/32] Core scheduling (v9)
To:     Joel Fernandes <joel@joelfernandes.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        Alexander Graf <graf@amazon.com>, konrad.wilk@oracle.com,
        Dario Faggioli <dfaggioli@suse.com>,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>,
        Jiang Biao <benbjiang@tencent.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        OWeisse@umich.edu, Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ben Segall <bsegall@google.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <CAKfTPtCWPL9=5crDT8LxQh6RrEi3cbwwTAy7GK2qG83JkiLVgg@mail.gmail.com>
 <CAEXW_YR2Tr=vVcbuChzxDGN3JwtTD1Oy9KcbuCsPRDmd_bx6iw@mail.gmail.com>
From:   "Ning, Hongyu" <hongyu.ning@linux.intel.com>
Message-ID: <2aa08e37-c938-c98b-8212-556d63eb730f@linux.intel.com>
Date:   Thu, 3 Dec 2020 14:16:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAEXW_YR2Tr=vVcbuChzxDGN3JwtTD1Oy9KcbuCsPRDmd_bx6iw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/24 23:08, Joel Fernandes wrote:
>>>
>>> Core-Scheduling
>>> ===============
>>> Enclosed is series v9 of core scheduling.
>>> v9 is rebased on tip/master (fe4adf6f92c4 ("Merge branch 'irq/core'"))..
>>> I hope that this version is acceptable to be merged (pending any new review
>>> comments that arise) as the main issues in the past are all resolved:
>>>  1. Vruntime comparison.
>>>  2. Documentation updates.
>>>  3. CGroup and per-task interface developed by Google and Oracle.
>>>  4. Hotplug fixes.
>>> Almost all patches also have Reviewed-by or Acked-by tag. See below for full
>>> list of changes in v9.
>>>
>>> Introduction of feature
>>> =======================
>>> Core scheduling is a feature that allows only trusted tasks to run
>>> concurrently on cpus sharing compute resources (eg: hyperthreads on a
>>> core). The goal is to mitigate the core-level side-channel attacks
>>> without requiring to disable SMT (which has a significant impact on
>>> performance in some situations). Core scheduling (as of v7) mitigates
>>> user-space to user-space attacks and user to kernel attack when one of
>>> the siblings enters the kernel via interrupts or system call.
>>>
>>> By default, the feature doesn't change any of the current scheduler
>>> behavior. The user decides which tasks can run simultaneously on the
>>> same core (for now by having them in the same tagged cgroup). When a tag
>>> is enabled in a cgroup and a task from that cgroup is running on a
>>> hardware thread, the scheduler ensures that only idle or trusted tasks
>>> run on the other sibling(s). Besides security concerns, this feature can
>>> also be beneficial for RT and performance applications where we want to
>>> control how tasks make use of SMT dynamically.
>>>
>>> Both a CGroup and Per-task interface via prctl(2) are provided for configuring
>>> core sharing. More details are provided in documentation patch.  Kselftests are
>>> provided to verify the correctness/rules of the interface.
>>>
>>> Testing
>>> =======
>>> ChromeOS testing shows 300% improvement in keypress latency on a Google
>>> docs key press with Google hangout test (the maximum latency drops from 150ms
>>> to 50ms for keypresses).
>>>
>>> Julien: TPCC tests showed improvements with core-scheduling as below. With kernel
>>> protection enabled, it does not show any regression. Possibly ASI will improve
>>> the performance for those who choose kernel protection (can be toggled through
>>> sched_core_protect_kernel sysctl).
>>>                                 average         stdev           diff
>>> baseline (SMT on)               1197.272        44.78312824
>>> core sched (   kernel protect)  412.9895        45.42734343     -65.51%
>>> core sched (no kernel protect)  686.6515        71.77756931     -42.65%
>>> nosmt                           408.667         39.39042872     -65.87%
>>> (Note these results are from v8).
>>>
>>> Vineeth tested sysbench and does not see any regressions.
>>> Hong and Aubrey tested v9 and see results similar to v8. There is a known issue
>>> with uperf that does regress. This appears to be because of ksoftirq heavily
>>> contending with other tasks on the core. The consensus is this can be improved
>>> in the future.
>>>
>>> Changes in v9
>>> =============
>>> - Note that the vruntime snapshot change is written in 2 patches to show the
>>>   progression of the idea and prevent merge conflicts:
>>>     sched/fair: Snapshot the min_vruntime of CPUs on force idle
>>>     sched: Improve snapshotting of min_vruntime for CGroups
>>>   Same with the RT priority inversion change:
>>>     sched: Fix priority inversion of cookied task with sibling
>>>     sched: Improve snapshotting of min_vruntime for CGroups
>>> - Disable coresched on certain AMD HW.
>>>

Adding workloads and negative case test results for core scheduling v9 posted: 

- kernel under test: 
	-- coresched community v9 posted from https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/log/?h=sched/coresched-v9-posted (tag: sched/coresched-v9-posted)
	-- latest commit: d48636e429de (HEAD -> coresched-v9-posted, tag: sched/coresched-v9-posted) sched: Debug bits...
	-- coresched=on kernel parameter applied
- workloads: 
	-- A. sysbench cpu (192 threads) + sysbench cpu (192 threads)
	-- B. sysbench cpu (192 threads) + sysbench mysql (192 threads, mysqld forced into the same cgroup)
	-- C. uperf netperf.xml (192 threads over TCP or UDP protocol separately)
	-- D. will-it-scale context_switch via pipe (192 threads)
- negative case:
	-- A. continuously toggle cpu.core_tag, during full loading uperf workload running with cs_on
	-- B. continuously toggle smt setting via /sys/devices/system/cpu/smt/control, during full loading uperf workload running with cs_on
	-- C. continuously cgroup switch between cs_on cgroup and cs_off cgroup via cgclassify, during full loading uperf workload running
- test machine setup: 
	CPU(s):              192
	On-line CPU(s) list: 0-191
	Thread(s) per core:  2
	Core(s) per socket:  48
	Socket(s):           2
	NUMA node(s):        4
- test results of workloads, no obvious performance drop compared to community v8 build:
	-- workload A:
	+----------------------+------+----------------------+------------------------+
	| workloads            | **   | sysbench cpu * 192   | sysbench cpu * 192     |
	+======================+======+======================+========================+
	| cgroup               | **   | cg_sysbench_cpu_0    | cg_sysbench_cpu_1      |
	+----------------------+------+----------------------+------------------------+
	| record_item          | **   | Tput_avg (events/s)  | Tput_avg (events/s)    |
	+----------------------+------+----------------------+------------------------+
	| coresched_normalized | **   | 0.97                 | 1.02                   |
	+----------------------+------+----------------------+------------------------+
	| default_normalized   | **   | 1.00                 | 1.00                   |
	+----------------------+------+----------------------+------------------------+
	| smtoff_normalized    | **   | 0.60                 | 0.60                   |
	+----------------------+------+----------------------+------------------------+

	-- workload B:
	+----------------------+------+----------------------+------------------------+
	| workloads            | **   | sysbench cpu * 192   | sysbench mysql * 192   |
	+======================+======+======================+========================+
	| cgroup               | **   | cg_sysbench_cpu_0    | cg_sysbench_mysql_0    |
	+----------------------+------+----------------------+------------------------+
	| record_item          | **   | Tput_avg (events/s)  | Tput_avg (events/s)    |
	+----------------------+------+----------------------+------------------------+
	| coresched_normalized | **   | 0.94                 | 0.88                   |
	+----------------------+------+----------------------+------------------------+
	| default_normalized   | **   | 1.00                 | 1.00                   |
	+----------------------+------+----------------------+------------------------+
	| smtoff_normalized    | **   | 0.56                 | 0.84                   |
	+----------------------+------+----------------------+------------------------+

	-- workload C:
	+----------------------+------+---------------------------+---------------------------+
	| workloads            | **   | uperf netperf TCP * 192   | uperf netperf UDP * 192   |
	+======================+======+===========================+===========================+
	| cgroup               | **   | cg_uperf                  | cg_uperf                  |
	+----------------------+------+---------------------------+---------------------------+
	| record_item          | **   | Tput_avg (Gb/s)           | Tput_avg (Gb/s)           |
	+----------------------+------+---------------------------+---------------------------+
	| coresched_normalized | **   | 0.64                      | 0.68                      |
	+----------------------+------+---------------------------+---------------------------+
	| default_normalized   | **   | 1.00                      | 1.00                      |
	+----------------------+------+---------------------------+---------------------------+
	| smtoff_normalized    | **   | 0.92                      | 0.89                      |
	+----------------------+------+---------------------------+---------------------------+

	-- workload D:
	+----------------------+------+-------------------------------+
	| workloads            | **   | will-it-scale  * 192          |
	|                      |      | (pipe based context_switch)   |
	+======================+======+===============================+
	| cgroup               | **   | cg_will-it-scale              |
	+----------------------+------+-------------------------------+
	| record_item          | **   | threads_avg                   |
	+----------------------+------+-------------------------------+
	| coresched_normalized | **   | 0.30                          |
	+----------------------+------+-------------------------------+
	| default_normalized   | **   | 1.00                          |
	+----------------------+------+-------------------------------+
	| smtoff_normalized    | **   | 0.87                          |
	+----------------------+------+-------------------------------+

	-- notes on record_item:
	* coresched_normalized: smton, cs enabled, test result normalized by default value
	* default_normalized: smton, cs disabled, test result normalized by default value
	* smtoff_normalized: smtoff, test result normalized by default value

- test results of negative case, all as expected, no kernel panic or system hang observed

Hongyu
