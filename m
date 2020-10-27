Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D090029AA00
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418647AbgJ0Krx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:47:53 -0400
Received: from foss.arm.com ([217.140.110.172]:38104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1418632AbgJ0KrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:47:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA5F730E;
        Tue, 27 Oct 2020 03:47:19 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D1C63F66E;
        Tue, 27 Oct 2020 03:47:18 -0700 (PDT)
References: <1603769572-8193-1-git-send-email-xuewen.yan94@gmail.com> <69257e98-2d93-673a-5dac-e11b6d5610be@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Xuewen Yan <xuewen.yan94@gmail.com>, xuewen.yan@unisoc.com,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: sched_domain fix highest_flag_domain function
In-reply-to: <69257e98-2d93-673a-5dac-e11b6d5610be@arm.com>
Date:   Tue, 27 Oct 2020 10:47:13 +0000
Message-ID: <jhjo8koosi6.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/10/20 09:57, Dietmar Eggemann wrote:
> On 27/10/2020 04:32, Xuewen Yan wrote:
>> the highest_flag_domain is to search the highest sched_domain
>> containing flag, but if the lower sched_domain didn't contain
>> the flag, but the higher sched_domain contains the flag, the
>> function will return NULL instead of the higher sched_domain.
>>
>> For example:
>> In MC domain : no SD_ASYM_CPUCAPACITY flag;
>> In DIE domain : containing SD_ASYM_CPUCAPACITY flag;
>> the "highest_flag_domain(cpu, SD_ASYM_CPUCAPACITY)" will return NULL.
>>
>> Signed-off-by: Xuewen Yan <xuewen.yan94@gmail.com>
>> ---
>>  kernel/sched/sched.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 28709f6..2c7c566 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -1427,7 +1427,7 @@ static inline struct sched_domain *highest_flag_domain(int cpu, int flag)
>>
>>      for_each_domain(cpu, sd) {
>>              if (!(sd->flags & flag))
>> -			break;
>> +			continue;
>>              hsd = sd;
>>      }
>
> We distinguish between SDF_SHARED_PARENT and SDF_SHARED_CHILD SD flags.
>
> 1 SD_FLAG(*SD_ASYM_CPUCAPACITY*, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
> 2 SD_FLAG(SD_SERIALIZE, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
> 3 SD_FLAG(SD_OVERLAP, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
> 4 SD_FLAG(SD_NUMA, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
>
> 1 SD_FLAG(SD_BALANCE_NEWIDLE, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
> 2 SD_FLAG(SD_BALANCE_EXEC, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
> 3 SD_FLAG(SD_BALANCE_FORK, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
> 4 SD_FLAG(SD_BALANCE_WAKE, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
> 5 82 SD_FLAG(SD_WAKE_AFFINE, SDF_SHARED_CHILD)
> 6 SD_FLAG(SD_SHARE_CPUCAPACITY, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
> 7 SD_FLAG(SD_SHARE_PKG_RESOURCES, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
> 8 SD_FLAG(SD_ASYM_PACKING, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
>
> We call lowest_flag_domain() on SDF_SHARED_PARENT and
> highest_flag_domain() on SDF_SHARED_CHILD SD flags.
>
> 1 sd = lowest_flag_domain(cpu, SD_NUMA);
> 2 sd = lowest_flag_domain(cpu, *SD_ASYM_CPUCAPACITY*);
>
> 1 sd = highest_flag_domain(cpu, SD_SHARE_PKG_RESOURCES);
> 2 sd = highest_flag_domain(cpu, SD_ASYM_PACKING);

Spot on!

In some of my earliest instrumentation patches I had a SCHED_WARN_ON() for
when highest_flag_domain() is passed an SDF_SHARED_PARENT flag (for some
reason I don't have the equivalent for lowest_flag_domain() in that
branch). I had ditched that as it didn't seem that useful, but perhaps that
wasn't so accurate :)
