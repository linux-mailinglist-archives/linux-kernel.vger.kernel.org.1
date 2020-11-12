Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121252B05F2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgKLNF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:05:58 -0500
Received: from foss.arm.com ([217.140.110.172]:49828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727739AbgKLNF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:05:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E43D101E;
        Thu, 12 Nov 2020 05:05:57 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B70873F718;
        Thu, 12 Nov 2020 05:05:55 -0800 (PST)
Subject: Re: [PATCH v5 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET flag
 to reset uclamp
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yun Hsiang <hsiang023167@gmail.com>, linux-kernel@vger.kernel.org,
        qais.yousef@arm.com, patrick.bellasi@matbug.net,
        kernel test robot <lkp@intel.com>
References: <20201103023756.1012088-1-hsiang023167@gmail.com>
 <20201110122108.GG2594@hirez.programming.kicks-ass.net>
 <f3b59aad-3d5d-039b-205d-024308b609a1@arm.com>
 <20201111180441.GJ2628@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <82f26263-a5cd-bd5c-52bd-37b98663a2e5@arm.com>
Date:   Thu, 12 Nov 2020 14:05:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201111180441.GJ2628@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2020 19:04, Peter Zijlstra wrote:
> On Wed, Nov 11, 2020 at 06:41:07PM +0100, Dietmar Eggemann wrote:
>> diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
>> index c852153ddb0d..b9165f17dddc 100644
>> --- a/include/uapi/linux/sched/types.h
>> +++ b/include/uapi/linux/sched/types.h
>> @@ -115,8 +115,8 @@ struct sched_attr {
>>  	__u64 sched_period;
>>  
>>  	/* Utilization hints */
>> -	__u32 sched_util_min;
>> -	__u32 sched_util_max;
>> +	__s32 sched_util_min;
>> +	__s32 sched_util_max;
> 
> So that's UAPI, not sure we can change the type here.

Yes, will remove this chunk. Not needed.

I probably should add some documentation there:

diff --git a/include/uapi/linux/sched/types.h
b/include/uapi/linux/sched/types.h
index c852153ddb0d..f2c4589d4dbf 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -96,6 +96,8 @@ struct sched_param {
  * on a CPU with a capacity big enough to fit the specified value.
  * A task with a max utilization value smaller than 1024 is more likely
  * scheduled on a CPU with no more capacity than the specified value.
+ *
+ * A task utilization boundary can be reset by setting the attribute to -1.
  */
 struct sched_attr {
        __u32 size;

[...]

>> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
>> +		util_max = attr->sched_util_max;
>> +
>> +		if (util_max < -1 || util_max > SCHED_CAPACITY_SCALE)
>> +			return -EINVAL;
>> +	}
> 
> Luckily we can write that range as a single branch like:
> 
> 	if (util_{min,max} + 1 > SCHED_CAPACITY_SCALE+1)
> 
> which assumes u32 :-)

Cool, will change it.

>> +
>> +	if (util_min != -1 && util_max != -1 && util_min > util_max)
>>  		return -EINVAL;
> 
> I think that will compile as is, otherwise write it like ~0u, which is
> the same bit pattern.

Yes, it compiles for me (arm64, gcc 9.2 and arm, gcc 8.3). Started a
0-Day build job to make sure.

Will do some more testing before sending out the updated version.
