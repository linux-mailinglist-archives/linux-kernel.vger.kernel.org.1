Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B704212657
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 16:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbgGBOdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 10:33:01 -0400
Received: from foss.arm.com ([217.140.110.172]:58042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728179AbgGBOdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:33:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCF8531B;
        Thu,  2 Jul 2020 07:33:00 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E25243F68F;
        Thu,  2 Jul 2020 07:32:59 -0700 (PDT)
References: <20200701190656.10126-1-valentin.schneider@arm.com> <20200701190656.10126-4-valentin.schneider@arm.com> <20200702142042.GI4817@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com
Subject: Re: [PATCH v3 3/7] sched/topology: Verify SD_* flags setup when sched_debug is on
In-reply-to: <20200702142042.GI4817@hirez.programming.kicks-ass.net>
Date:   Thu, 02 Jul 2020 15:32:57 +0100
Message-ID: <jhjimf67zs6.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/07/20 15:20, Peter Zijlstra wrote:
> On Wed, Jul 01, 2020 at 08:06:51PM +0100, Valentin Schneider wrote:
>
>> @@ -29,6 +29,7 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
>>                                struct cpumask *groupmask)
>>  {
>>      struct sched_group *group = sd->groups;
>> +	int flags = sd->flags;
>
>       unsigned long flags = sd->flags;
>
>>
>>      cpumask_clear(groupmask);
>>
>> @@ -43,6 +44,22 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
>>              printk(KERN_ERR "ERROR: domain->groups does not contain CPU%d\n", cpu);
>>      }
>>
>> +	for (; flags; flags &= flags - 1) {
>> +		unsigned int idx = __ffs(flags);
>
>       for_each_set_bit(idx, &flags, SD_MAX_BIT) {
>
> Yes, it's a bit yuck, but far more readable imo.
>

Much better than homegrown stuff, thanks!

>> +		unsigned int flag = BIT(idx);
>> +		unsigned int meta_flags = sd_flag_debug[idx].meta_flags;
>> +
>> +		if ((meta_flags & SDF_SHARED_CHILD) && sd->child &&
>> +		    !(sd->child->flags & flag))
>> +			printk(KERN_ERR "ERROR: flag %s set here but not in child\n",
>> +			       sd_flag_debug[idx].name);
>> +
>> +		if ((meta_flags & SDF_SHARED_PARENT) && sd->parent &&
>> +		    !(sd->parent->flags & flag))
>> +			printk(KERN_ERR "ERROR: flag %s set here but not in parent\n",
>> +			       sd_flag_debug[idx].name);
>> +	}
>> +
>>      printk(KERN_DEBUG "%*s groups:", level + 1, "");
>>      do {
>>              if (!group) {
>> --
>> 2.27.0
>>
