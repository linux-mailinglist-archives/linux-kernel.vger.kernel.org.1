Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF962A8A11
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 23:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732397AbgKEWro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 17:47:44 -0500
Received: from foss.arm.com ([217.140.110.172]:45282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgKEWrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:47:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 208BD1474;
        Thu,  5 Nov 2020 14:47:43 -0800 (PST)
Received: from [10.57.20.162] (unknown [10.57.20.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11EA43F718;
        Thu,  5 Nov 2020 14:47:41 -0800 (PST)
Subject: Re: [PATCH v3 14/26] coresight: etm4x: Add sysreg access helpers
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-16-suzuki.poulose@arm.com>
 <20201105205248.GA3047244@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <fa21ee02-a000-9d39-2e0c-850f63354272@arm.com>
Date:   Thu, 5 Nov 2020 22:47:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201105205248.GA3047244@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 11/5/20 8:52 PM, Mathieu Poirier wrote:
> On Wed, Oct 28, 2020 at 10:09:33PM +0000, Suzuki K Poulose wrote:
>> ETMv4.4 architecture defines the system instructions for accessing
>> ETM via register accesses. Add basic support for accessing a given
>> register via system instructions.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   .../coresight/coresight-etm4x-core.c          |  39 ++
>>   drivers/hwtracing/coresight/coresight-etm4x.h | 348 ++++++++++++++++--
>>   2 files changed, 365 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index 4af7d45dfe63..90b80982c615 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -56,6 +56,45 @@ static u64 etm4_get_access_type(struct etmv4_config *config);
>>   
>>   static enum cpuhp_state hp_online;
>>   
>> +u64 etm4x_sysreg_read(struct csdev_access *csa,
>> +		      u32 offset,
>> +		      bool _relaxed,
>> +		      bool _64bit)
> 
> Please fix the stacking.
> 

Sure.


>> +
>> +void etm4x_sysreg_write(struct csdev_access *csa,
>> +			u64 val,
>> +			u32 offset,
>> +			bool _relaxed,
>> +			bool _64bit)
> 
> Here too.

Sure.


>>   	/* Writing 0 to TRCOSLAR unlocks the trace registers */
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
>> index 510828c73db6..5cf71b30a652 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.

>> +
>> +#define ETM4x_READ_CASES(res)	CASE_LIST(READ, (res))
>> +#define ETM4x_WRITE_CASES(val)	CASE_LIST(WRITE, (val))
>> +
>> +#define read_etm4x_sysreg_offset(csa, offset, _64bit)				\
>> +	({									\
>> +		u64 __val;							\
>> +										\
>> +		if (__builtin_constant_p((offset)))				\
> 
> Neat trick - I wonder how you stumbled on that one.
> 

:-). There are plenty of uses in the kernel and glibc.

> 
>> +			__val = read_etm4x_sysreg_const_offset((offset));	\
>> +		else								\
>> +			__val = etm4x_sysreg_read((csa), (offset),		\
>> +						  true, _64bit);		\
>> +		__val;								\
>> +	 })
>> +
>> +#define write_etm4x_sysreg_offset(csa, val, offset, _64bit)		\
>> +	do {								\
>> +		if (__builtin_constant_p((offset)))			\
>> +			write_etm4x_sysreg_const_offset((val),		\
>> +							(offset));	\
>> +		else							\
>> +			etm4x_sysreg_write((csa), (val), (offset),	\
>> +						true, _64bit);		\
>> +	} while (0)
>> +
>> +
>> +#define etm4x_relaxed_read32(csa, offset)				\
>> +	((u32)((csa)->io_mem ?						\
>> +		 readl_relaxed((csa)->base + (offset)) :		\
>> +		 read_etm4x_sysreg_offset((csa), (offset), false)))
> 
> Please add an extra new line - otherwise it is very hard to read.
> 

Sure

>> +#define etm4x_relaxed_read64(csa, offset)				\
>> +	((u64)((csa)->io_mem ?						\
>> +		 readq_relaxed((csa)->base + (offset)) :		\
>> +		 read_etm4x_sysreg_offset((csa), (offset), true)))
> 
> Here too.
> 

sure

>> +#define etm4x_read32(csa, offset)					\
>> +	({								\
>> +		u32 __val = etm4x_relaxed_read32((csa), (offset));	\
>> +		__iormb(__val);						\
>> +		__val;							\
>> +	 })
>> +
>> +#define etm4x_read64(csa, offset)					\
>> +	({								\
>> +		u64 __val = etm4x_relaxed_read64((csa), (offset));	\
>> +		__iormb(__val);						\
>> +		__val;							\
>> +	 })
>> +
>> +#define etm4x_relaxed_write32(csa, val, offset)				\
>> +	do {								\
>> +		if ((csa)->io_mem)					\
>> +			writel_relaxed((val), (csa)->base + (offset));	\
>> +		else							\
>> +			write_etm4x_sysreg_offset((csa), (val),	\
>> +						    (offset), false);	\
> 
> Why using an if/else statement and above the '?' condition marker?  I would
> really like a uniform approach.  Otherwise the reader keeps looking for
> something subtle when there isn't.

The write variants do not return a result, unlike the read.
So, we cant use the '?'

> 
>> +	} while (0)
>> +
>> +#define etm4x_relaxed_write64(csa, val, offset)				\
>> +	do {								\
>> +		if ((csa)->io_mem)					\
>> +			writeq_relaxed((val), (csa)->base + (offset));	\
>> +		else							\
>> +			write_etm4x_sysreg_offset((csa), (val),	\
>> +						    (offset), true);	\
>> +	} while (0)
>> +
>> +#define etm4x_write32(csa, val, offset)					\
>> +	do {								\
>> +		__iowmb();						\
>> +		etm4x_relaxed_write32((csa), (val), (offset));		\
>> +	} while (0)
>> +
>> +#define etm4x_write64(csa, val, offset)					\
>> +	do {								\
>> +		__iowmb();						\
>> +		etm4x_relaxed_write64((csa), (val), (offset));		\
>> +	} while (0)
>>   
>> -#define etm4x_write64(csa, val, offset)			\
>> -	writeq((val), (csa)->base + (offset))
>>   
>>   /* ETMv4 resources */
>>   #define ETM_MAX_NR_PE			8
>> @@ -512,4 +806,14 @@ enum etm_addr_ctxtype {
>>   
>>   extern const struct attribute_group *coresight_etmv4_groups[];
>>   void etm4_config_trace_mode(struct etmv4_config *config);
>> +
>> +u64 etm4x_sysreg_read(struct csdev_access *csa,
>> +		      u32 offset,
>> +		      bool _relaxed,
>> +		      bool _64bit);
>> +void etm4x_sysreg_write(struct csdev_access *csa,
>> +			u64 val,
>> +			u32 offset,
>> +			bool _relaxed,
>> +			bool _64bit);
> 
> With the above:
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks !

> 
> This patch holds together well.  I commend you on rendering something that is
> quite complex into a manageable implementation.  That being said it will impact
> Mike's complex configuration patchset (or Mike's complex configuration patchset
> will have an impact on this).

I understand. Will see when we get to it.

Cheers
Suzuki
