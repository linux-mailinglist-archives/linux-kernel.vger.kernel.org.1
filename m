Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789A72B18B8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 11:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgKMKBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 05:01:53 -0500
Received: from mga18.intel.com ([134.134.136.126]:17052 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgKMKBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 05:01:53 -0500
IronPort-SDR: d0yd8z+ciaYSwwUcs9ejf2C5ArouuyOFC2yBO4Yh5wQAiqmRKpLwtuRZSDuLBVBrUzdPNI8ekX
 4dPyrinsEfdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="158228983"
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; 
   d="scan'208";a="158228983"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 02:01:52 -0800
IronPort-SDR: zVNtaYvNbSRKYFq0lSxuzBxzBVD575uVHvRiOQaX+AJLcq8wduSMoEyZF7mncTIKxFOUzHHdR3
 g5Jxl2kvxvyw==
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; 
   d="scan'208";a="542604272"
Received: from hongyuni-mobl1.ccr.corp.intel.com (HELO [10.238.1.49]) ([10.238.1.49])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 02:01:42 -0800
Subject: Re: [RFT for v9] (Was Re: [PATCH v8 -tip 00/26] Core scheduling)
From:   "Ning, Hongyu" <hongyu.ning@linux.intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>,
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
 <20201106205506.GA3109656@google.com>
 <60912adc-81e8-8dc9-98cb-2aefed4e36e6@linux.intel.com>
Message-ID: <04463650-fa84-7e6e-d3f6-5ec34eb44433@linux.intel.com>
Date:   Fri, 13 Nov 2020 18:01:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <60912adc-81e8-8dc9-98cb-2aefed4e36e6@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/13 17:22, Ning, Hongyu wrote:
> On 2020/11/7 4:55, Joel Fernandes wrote:
>> All,
>>
>> I am getting ready to send the next v9 series based on tip/master
>> branch. Could you please give the below tree a try and report any results in
>> your testing?
>> git tree:
>> https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (branch coresched)
>> git log:
>> https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/log/?h=coresched
>>
>> The major changes in this series are the improvements:
>> (1)
>> "sched: Make snapshotting of min_vruntime more CGroup-friendly"
>> https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=coresched-v9-for-test&id=9a20a6652b3c50fd51faa829f7947004239a04eb
>>
>> (2)
>> "sched: Simplify the core pick loop for optimized case"
>> https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=coresched-v9-for-test&id=0370117b4fd418cdaaa6b1489bfc14f305691152
>>
>> And a bug fix:
>> (1)
>> "sched: Enqueue task into core queue only after vruntime is updated"
>> https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=coresched-v9-for-test&id=401dad5536e7e05d1299d0864e6fc5072029f492
>>
>> There are also 2 more bug fixes that I squashed-in related to kernel
>> protection and a crash seen on the tip/master branch.
>>
>> Hoping to send the series next week out to the list.
>>
>> Have a great weekend, and Thanks!
>>
>>  - Joel
>>
>>
>> On Mon, Oct 19, 2020 at 09:43:10PM -0400, Joel Fernandes (Google) wrote:
> 
> Adding 4 workloads test results for core scheduling v9 candidate: 
> 
> - kernel under test: 
> 	-- coresched community v9 candidate from https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (branch coresched)
> 	-- latest commit: 2e8591a330ff (HEAD -> coresched, origin/coresched) NEW: sched: Add a coresched command line option
> 	-- coresched=on kernel parameter applied
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
> - test results, no obvious performance drop compared to community v8 build:
> 	-- workload A:
> 	+----------------------+------+----------------------+------------------------+
> 	|                      | **   | sysbench cpu * 192   | sysbench cpu * 192     |
> 	+======================+======+======================+========================+
> 	| cgroup               | **   | cg_sysbench_cpu_0    | cg_sysbench_cpu_1      |
> 	+----------------------+------+----------------------+------------------------+
> 	| record_item          | **   | Tput_avg (events/s)  | Tput_avg (events/s)    |
> 	+----------------------+------+----------------------+------------------------+
> 	| coresched_normalized | **   | 0.98                 | 1.01                   |
> 	+----------------------+------+----------------------+------------------------+
> 	| default_normalized   | **   | 1                    | 1                      |
> 	+----------------------+------+----------------------+------------------------+
> 	| smtoff_normalized    | **   | 0.59                 | 0.6                    |
> 	+----------------------+------+----------------------+------------------------+
> 
> 	-- workload B:
> 	+----------------------+------+----------------------+------------------------+
> 	|                      | **   | sysbench cpu * 192   | sysbench mysql * 192   |
> 	+======================+======+======================+========================+
> 	| cgroup               | **   | cg_sysbench_cpu_0    | cg_sysbench_mysql_0    |
> 	+----------------------+------+----------------------+------------------------+
> 	| record_item          | **   | Tput_avg (events/s)  | Tput_avg (events/s)    |
> 	+----------------------+------+----------------------+------------------------+
> 	| coresched_normalized | **   | 1.02                 | 0.78                   |
> 	+----------------------+------+----------------------+------------------------+
> 	| default_normalized   | **   | 1                    | 1                      |
> 	+----------------------+------+----------------------+------------------------+
> 	| smtoff_normalized    | **   | 0.59                 | 0.75                   |
> 	+----------------------+------+----------------------+------------------------+
> 
> 	-- workload C:
> 	+----------------------+------+---------------------------+---------------------------+
> 	|                      | **   | uperf netperf TCP * 192   | uperf netperf UDP * 192   |
> 	+======================+======+===========================+===========================+
> 	| cgroup               | **   | cg_uperf                  | cg_uperf                  |
> 	+----------------------+------+---------------------------+---------------------------+
> 	| record_item          | **   | Tput_avg (Gb/s)           | Tput_avg (Gb/s)           |
> 	+----------------------+------+---------------------------+---------------------------+
> 	| coresched_normalized | **   | 0.65                      | 0.67                      |
> 	+----------------------+------+---------------------------+---------------------------+
> 	| default_normalized   | **   | 1                         | 1                         |
> 	+----------------------+------+---------------------------+---------------------------+
> 	| smtoff_normalized    | **   | 0.83                      | 0.91                      |
> 	+----------------------+------+---------------------------+---------------------------+
> 
> 	-- workload D:
> 	+----------------------+------+-------------------------------+
> 	|                      | **   | will-it-scale  * 192          |
> 	|                      |      | (pipe based context_switch)   |
> 	+======================+======+===============================+
> 	| cgroup               | **   | cg_will-it-scale              |
> 	+----------------------+------+-------------------------------+
> 	| record_item          | **   | threads_avg                   |
> 	+----------------------+------+-------------------------------+
> 	| coresched_normalized | **   | 0.29                          |
> 	+----------------------+------+-------------------------------+
> 	| default_normalized   | **   | 1.00                          |
> 	+----------------------+------+-------------------------------+
> 	| smtoff_normalized    | **   | 0.87                          |
> 	+----------------------+------+-------------------------------+
> 
> - notes on test results record_item:
> 	* coresched_normalized: smton, cs enabled, test result normalized by default value
> 	* default_normalized: smton, cs disabled, test result normalized by default value
> 	* smtoff_normalized: smtoff, test result normalized by default value
> 
> 
> Hongyu
> 

Add 2 more negative test case:

- continuously toggle cpu.core_tag, during workload running with cs_on
- continuously toggle smt setting via /sys/devices/system/cpu/smt/control, during workload running with cs_on

no kernel panic or platform hang observed.
