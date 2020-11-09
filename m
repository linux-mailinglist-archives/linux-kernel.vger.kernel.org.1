Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105212AB3FE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgKIJvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:51:24 -0500
Received: from foss.arm.com ([217.140.110.172]:36520 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgKIJvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:51:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11BD71042;
        Mon,  9 Nov 2020 01:51:22 -0800 (PST)
Received: from [10.57.23.123] (unknown [10.57.23.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFE863F718;
        Mon,  9 Nov 2020 01:51:20 -0800 (PST)
Subject: Re: [PATCH v3 20/26] coresight: etm4x: Handle ETM architecture
 version
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-22-suzuki.poulose@arm.com>
 <20201106211121.GD3299843@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <992eb5f7-0a23-b47c-ee6d-346d66008b74@arm.com>
Date:   Mon, 9 Nov 2020 09:51:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201106211121.GD3299843@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/20 9:11 PM, Mathieu Poirier wrote:
> On Wed, Oct 28, 2020 at 10:09:39PM +0000, Suzuki K Poulose wrote:
>> We are about to rely on TRCDEVARCH for detecting the ETM
>> and its architecture version, falling back to TRCIDR1 if
>> the former is not implemented (in older broken implementations).
>>
>> Also, we use the architecture version information to do
>> make some decisions. Streamline the architecture version
>> handling by adding helpers.
>>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   .../coresight/coresight-etm4x-core.c          |  2 +-
>>   drivers/hwtracing/coresight/coresight-etm4x.h | 60 ++++++++++++++++++-
>>   2 files changed, 58 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index 308674ab746c..4ef47a2946a4 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -842,7 +842,7 @@ static void etm4_init_arch_data(void *info)
>>   	 * Otherwise for values 0x1 and above the number is N + 1 as per v4.2.
>>   	 */
>>   	drvdata->nr_resource = BMVAL(etmidr4, 16, 19);
>> -	if ((drvdata->arch < ETM4X_ARCH_4V3) || (drvdata->nr_resource > 0))
>> +	if ((drvdata->arch < ETM_ARCH_V4_3) || (drvdata->nr_resource > 0))
>>   		drvdata->nr_resource += 1;
>>   	/*
>>   	 * NUMSSCC, bits[23:20] the number of single-shot
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
>> index f1251ddf1984..fe7107282e54 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
>> @@ -459,7 +459,6 @@
>>   #define ETM_MAX_RES_SEL			32
>>   #define ETM_MAX_SS_CMP			8
>>   
>> -#define ETM_ARCH_V4			0x40
>>   #define ETMv4_SYNC_MASK			0x1F
>>   #define ETM_CYC_THRESHOLD_MASK		0xFFF
>>   #define ETM_CYC_THRESHOLD_DEFAULT       0x100
>> @@ -581,8 +580,63 @@
>>   #define TRCVICTLR_EXLEVEL_S_MASK	(ETM_EXLEVEL_S_MASK << TRCVICTLR_EXLEVEL_S_SHIFT)
>>   #define TRCVICTLR_EXLEVEL_NS_MASK	(ETM_EXLEVEL_NS_MASK << TRCVICTLR_EXLEVEL_NS_SHIFT)
>>   
>> +#define ETM_TRCIDR1_ARCH_MAJOR_SHIFT	8
>> +#define ETM_TRCIDR1_ARCH_MAJOR_MASK	(0xfU << ETM_TRCIDR1_ARCH_MAJOR_SHIFT)
>> +#define ETM_TRCIDR1_ARCH_MAJOR(x)	\
>> +	(((x) & ETM_TRCIDR1_ARCH_MAJOR_MASK) >> ETM_TRCIDR1_ARCH_MAJOR_SHIFT)
>> +#define ETM_TRCIDR1_ARCH_MINOR_SHIFT	4
>> +#define ETM_TRCIDR1_ARCH_MINOR_MASK	(0xfU << ETM_TRCIDR1_ARCH_MINOR_SHIFT)
>> +#define ETM_TRCIDR1_ARCH_MINOR(x)	\
>> +	(((x) & ETM_TRCIDR1_ARCH_MINOR_MASK) >> ETM_TRCIDR1_ARCH_MINOR_SHIFT)
>> +#define ETM_TRCIDR1_ARCH_SHIFT		ETM_TRCIDR1_ARCH_MINOR_SHIFT
>> +#define ETM_TRCIDR1_ARCH_MASK		\
>> +	(ETM_TRCIDR1_ARCH_MAJOR_MASK | ETM_TRCIDR1_ARCH_MINOR_MASK)
>> +
>> +#define ETM_TRCIDR1_ARCH_ETMv4		0x4
>> +
>> +/*
>> + * Driver representation of the ETM architecture.
>> + * The version of an ETM component can be detected from
>> + *
>> + * TRCDEVARCH	- CoreSight architected register
>> + *                - Bits[15:12] - Major version
>> + *                - Bits[19:16] - Minor version
>> + * TRCIDR1	- ETM architected register
>> + *                - Bits[12:8] - Major version
> 
> This should be [11:8], bit 12 is part of RES1.

Well spotted. will fix it.

> 
>> + *                - Bits[7:4]  - Minor version
>> + * We must rely on TRCDEVARCH for the version information,
>> + * however we don't want to break the support for potential
>> + * old implementations which might not implement it. Thus
>> + * we fall back to TRCIDR1 if TRCDEVARCH is not implemented
>> + * for memory mapped components.
>> + * Now to make certain decisions easier based on the version
>> + * we use an internal representation of the version in the
>> + * driver, as follows :
>> + *
>> + * ETM_ARCH_VERSION[7:0], where :
>> + *      Bits[7:4] - Major version
>> + *      Bits[3:0] - Minro version
>> + */
>> +#define ETM_ARCH_VERSION(major, minor)		\
>> +	((((major) & 0xfU) << 4) | (((minor) & 0xfU)))
>> +#define ETM_ARCH_MAJOR_VERSION(arch)	(((arch) >> 4) & 0xfU)
>> +#define ETM_ARCH_MINOR_VERSION(arch)	((arch) & 0xfU)
> 
> There are a few unused defines brought in by this patch.  I trust they will be
> used in subsequent patches.

Yes, they will be used. The reason for adding them here was to introduce
the helpers along with the defintions. This will be also used for
handling future architecture versions.

Suzuki
