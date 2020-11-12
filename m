Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA3E2B04C1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 13:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgKLMMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 07:12:14 -0500
Received: from mga12.intel.com ([192.55.52.136]:14178 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728003AbgKLMMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 07:12:10 -0500
IronPort-SDR: OPpR/SqyXNCcPjMVGvsrhzXZhJgwS83izM+ZqGVJe73xOgV+pWAqs4MjsAf4v1HcmNgG+ENGGR
 7sRW5XpOuLDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="149571167"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="149571167"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 04:12:09 -0800
IronPort-SDR: ZVifTGtvj6pJEdIfU1GbY7kG3uxdgSNjKDLOF0TFGlG58gJbKs7bKM9RcGAW9ZETIt/gl5TbLL
 2x0PcyHDjmfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="366315954"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Nov 2020 04:12:02 -0800
Subject: Re: [RFC PATCH v3] sched/fair: select idle cpu from idle cpumask for
 task wakeup
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        valentin.schneider@arm.com, tim.c.chen@linux.intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@intel.com>,
        Jiang Biao <benbjiang@gmail.com>
References: <20201021150335.1103231-1-aubrey.li@linux.intel.com>
 <20201112105713.xz3f52tcvjhk7si5@e107158-lin.cambridge.arm.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <713b4681-3bdb-b25c-9afb-5896ca255309@linux.intel.com>
Date:   Thu, 12 Nov 2020 20:12:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201112105713.xz3f52tcvjhk7si5@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/12 18:57, Qais Yousef wrote:
> On 10/21/20 23:03, Aubrey Li wrote:
>> From: Aubrey Li <aubrey.li@intel.com>
>>
>> Added idle cpumask to track idle cpus in sched domain. When a CPU
>> enters idle, its corresponding bit in the idle cpumask will be set,
>> and when the CPU exits idle, its bit will be cleared.
>>
>> When a task wakes up to select an idle cpu, scanning idle cpumask
>> has low cost than scanning all the cpus in last level cache domain,
>> especially when the system is heavily loaded.
>>
>> v2->v3:
>> - change setting idle cpumask to every idle entry, otherwise schbench
>>   has a regression of 99th percentile latency.
>> - change clearing idle cpumask to nohz_balancer_kick(), so updating
>>   idle cpumask is ratelimited in the idle exiting path.
>> - set SCHED_IDLE cpu in idle cpumask to allow it as a wakeup target.
>>
>> v1->v2:
>> - idle cpumask is updated in the nohz routines, by initializing idle
>>   cpumask with sched_domain_span(sd), nohz=off case remains the original
>>   behavior.
> 
> Did you intend to put the patch version history in the commit message?
> 
> I started looking at this last week but got distracted. I see you already got
> enough reviews, so my 2p is that I faced some compilation issues:
> 
> 	aarch64-linux-gnu-ld: kernel/sched/idle.o: in function `set_next_task_idle':
> 	/mnt/data/src/linux/kernel/sched/idle.c:405: undefined reference to `update_idle_cpumask'
> 	aarch64-linux-gnu-ld: kernel/sched/fair.o: in function `nohz_balancer_kick':
> 	/mnt/data/src/linux/kernel/sched/fair.c:10150: undefined reference to `update_idle_cpumask'
> 	aarch64-linux-gnu-ld: /mnt/data/src/linux/kernel/sched/fair.c:10148: undefined reference to `update_idle_cpumask'
> 
> Because of the missing CONFIG_SCHED_SMT in my .config. I think
> update_idle_cpumask() should be defined unconditionally.

Thanks to point this out timely, :), I'll fix it in the next version.

-Aubrey
