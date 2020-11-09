Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57FA2AB3BE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgKIJlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:41:03 -0500
Received: from foss.arm.com ([217.140.110.172]:36182 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgKIJlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:41:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB48C1042;
        Mon,  9 Nov 2020 01:41:02 -0800 (PST)
Received: from [10.57.23.123] (unknown [10.57.23.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB8013F718;
        Mon,  9 Nov 2020 01:41:01 -0800 (PST)
Subject: Re: [PATCH v3 17/26] coresight: etm4x: Cleanup secure exception level
 masks
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-19-suzuki.poulose@arm.com>
 <20201105215526.GC3047244@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <ec9006a6-b8cf-c1f0-7250-e61d478b76ff@arm.com>
Date:   Mon, 9 Nov 2020 09:40:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201105215526.GC3047244@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/20 9:55 PM, Mathieu Poirier wrote:
> On Wed, Oct 28, 2020 at 10:09:36PM +0000, Suzuki K Poulose wrote:
>> We rely on the ETM architecture version to decide whether
>> Secure EL2 is available on the CPU for excluding the level
>> for address comparators and viewinst main control register.
>> We must instead use the TRCDIDR3.EXLEVEL_S field to detect
>> the supported levels.
>>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++----------
>>   drivers/hwtracing/coresight/coresight-etm4x.h      |  6 ++++--
>>   2 files changed, 7 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index a12d58a04c5d..6e3f9cb7de3f 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -733,7 +733,6 @@ static void etm4_init_arch_data(void *info)
>>   	 * TRCARCHMAJ, bits[11:8] architecture major versin number
>>   	 */
>>   	drvdata->arch = BMVAL(etmidr1, 4, 11);
>> -	drvdata->config.arch = drvdata->arch;
>>   
>>   	/* maximum size of resources */
>>   	etmidr2 = etm4x_relaxed_read32(csa, TRCIDR2);
>> @@ -749,6 +748,7 @@ static void etm4_init_arch_data(void *info)
>>   	drvdata->ccitmin = BMVAL(etmidr3, 0, 11);
>>   	/* EXLEVEL_S, bits[19:16] Secure state instruction tracing */
>>   	drvdata->s_ex_level = BMVAL(etmidr3, 16, 19);
>> +	drvdata->config.s_ex_level = drvdata->s_ex_level;
>>   	/* EXLEVEL_NS, bits[23:20] Non-secure state instruction tracing */
>>   	drvdata->ns_ex_level = BMVAL(etmidr3, 20, 23);
>>   
>> @@ -920,16 +920,9 @@ static u64 etm4_get_ns_access_type(struct etmv4_config *config)
>>   static u64 etm4_get_access_type(struct etmv4_config *config)
>>   {
>>   	u64 access_type = etm4_get_ns_access_type(config);
>> -	u64 s_hyp = (config->arch & 0x0f) >= 0x4 ? ETM_EXLEVEL_S_HYP : 0;
>>   
>> -	/*
>> -	 * EXLEVEL_S, bits[11:8], don't trace anything happening
>> -	 * in secure state.
>> -	 */
>> -	access_type |= (ETM_EXLEVEL_S_APP	|
>> -			ETM_EXLEVEL_S_OS	|
>> -			s_hyp			|
>> -			ETM_EXLEVEL_S_MON);
>> +	/* All supported secure ELs are excluded */
>> +	access_type |= (u64)config->s_ex_level << TRCACATR_EXLEVEL_SHIFT;
>>   
>>   	return access_type;
>>   }
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
>> index e7f6b7b16fb7..2ac4ecb0af61 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
>> @@ -546,6 +546,8 @@
>>   /* PowerDown Control Register bits */
>>   #define TRCPDCR_PU			BIT(3)
>>   
>> +#define TRCACATR_EXLEVEL_SHIFT		8
>> +
>>   /* secure state access levels - TRCACATRn */
>>   #define ETM_EXLEVEL_S_APP		BIT(8)
>>   #define ETM_EXLEVEL_S_OS		BIT(9)
>> @@ -615,7 +617,7 @@
>>    * @vmid_mask0:	VM ID comparator mask for comparator 0-3.
>>    * @vmid_mask1:	VM ID comparator mask for comparator 4-7.
>>    * @ext_inp:	External input selection.
>> - * @arch:	ETM architecture version (for arch dependent config).
>> + * @s_ex_level: Secure ELs where tracing is supported.
>>    */
>>   struct etmv4_config {
>>   	u32				mode;
>> @@ -659,7 +661,7 @@ struct etmv4_config {
>>   	u32				vmid_mask0;
>>   	u32				vmid_mask1;
>>   	u32				ext_inp;
>> -	u8				arch;
>> +	u8				s_ex_level;
> 
> Instead of making s_ex_level redundant I suggest to pass a struct etmv4_drvdata
> to etm4_get_access_type().

I had given thought about that. But this is called from different
places, e.g, etm4_set_comparator_filter() where the drvdata is not
available. Thus, making that change is quite invasive, going down to
the call stack. Morever, the config->arch was already redundant (also
cached in drvdata), mainly due to this reason. We simply replace the
arch field with the actual supported mask of the ELs for precise
programming.

Please let me know if you would like to make the proposed changes.

Cheers
Suzuki




> 
> More comments to come tomorrow.
> 
> Thanks,
> Mathieu
> 
>>   };
>>   
>>   /**
>> -- 
>> 2.24.1
>>

