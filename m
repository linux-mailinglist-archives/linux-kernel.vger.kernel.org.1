Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71FA26767B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 01:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgIKXSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 19:18:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:21440 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbgIKXQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 19:16:42 -0400
IronPort-SDR: mbmj6P8M4iZ6m8zvdLwuAuMMgNLgk8o/xdg3Oh2TGUQF3dnNCaOWq3WzR+6GTRk52N5kBYDXKb
 MGckNZhOZtqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="158906377"
X-IronPort-AV: E=Sophos;i="5.76,418,1592895600"; 
   d="scan'208";a="158906377"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 16:16:40 -0700
IronPort-SDR: pemPjNftCRhiQAcLvWelSaAVY/HSVBPRiHJBEw6b4wkTHwmAdyjZinT/3l1YT0CbVpJYVVoIUU
 0KC1unBvij9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,418,1592895600"; 
   d="scan'208";a="329951001"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.135]) ([10.239.161.135])
  by fmsmga004.fm.intel.com with ESMTP; 11 Sep 2020 16:16:37 -0700
Subject: Re: [RFC PATCH v1 1/1] sched/fair: select idle cpu from idle cpumask
 in sched domain
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
To:     Qais Yousef <qais.yousef@arm.com>, Aubrey Li <aubrey.li@intel.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        valentin.schneider@arm.com, tim.c.chen@linux.intel.com,
        linux-kernel@vger.kernel.org
References: <20200910054203.525420-1-aubrey.li@intel.com>
 <20200910054203.525420-2-aubrey.li@intel.com>
 <20200911162853.xldy6fvvqph2lahj@e107158-lin.cambridge.arm.com>
 <3f1571ea-b74c-fc40-2696-39ef3fe8b968@linux.intel.com>
Message-ID: <8a853369-c8f0-b9e8-f4cb-481d73abefaf@linux.intel.com>
Date:   Sat, 12 Sep 2020 07:16:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3f1571ea-b74c-fc40-2696-39ef3fe8b968@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/9/12 7:04, Li, Aubrey wrote:
> On 2020/9/12 0:28, Qais Yousef wrote:
>> On 09/10/20 13:42, Aubrey Li wrote:
>>> Added idle cpumask to track idle cpus in sched domain. When a CPU
>>> enters idle, its corresponding bit in the idle cpumask will be set,
>>> and when the CPU exits idle, its bit will be cleared.
>>>
>>> When a task wakes up to select an idle cpu, scanning idle cpumask
>>> has low cost than scanning all the cpus in last level cache domain,
>>> especially when the system is heavily loaded.
>>>
>>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
>>> ---
>>>  include/linux/sched/topology.h | 13 +++++++++++++
>>>  kernel/sched/fair.c            |  4 +++-
>>>  kernel/sched/topology.c        |  2 +-
>>>  3 files changed, 17 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
>>> index fb11091129b3..43a641d26154 100644
>>> --- a/include/linux/sched/topology.h
>>> +++ b/include/linux/sched/topology.h
>>> @@ -65,8 +65,21 @@ struct sched_domain_shared {
>>>  	atomic_t	ref;
>>>  	atomic_t	nr_busy_cpus;
>>>  	int		has_idle_cores;
>>> +	/*
>>> +	 * Span of all idle CPUs in this domain.
>>> +	 *
>>> +	 * NOTE: this field is variable length. (Allocated dynamically
>>> +	 * by attaching extra space to the end of the structure,
>>> +	 * depending on how many CPUs the kernel has booted up with)
>>> +	 */
>>> +	unsigned long	idle_cpus_span[];
>>
>> Can't you use cpumask_var_t and zalloc_cpumask_var() instead?
> 
> I can use the existing free code. Do we have a problem of this?
> 
>>
>> The patch looks useful. Did it help you with any particular workload? It'd be
>> good to expand on that in the commit message.
>>
> Odd, that included in patch v1 0/1, did you receive it?

I found it at here:

https://lkml.org/lkml/2020/9/11/645

> 
> Thanks,
> -Aubrey
> 

