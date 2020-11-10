Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E552AE3E9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 00:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbgKJXQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 18:16:08 -0500
Received: from foss.arm.com ([217.140.110.172]:36140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbgKJXQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 18:16:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE14C1396;
        Tue, 10 Nov 2020 15:16:07 -0800 (PST)
Received: from [10.57.23.123] (unknown [10.57.23.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9687B3F718;
        Tue, 10 Nov 2020 15:16:06 -0800 (PST)
Subject: Re: [PATCH v3 18/26] coresight: etm4x: Clean up exception level masks
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-20-suzuki.poulose@arm.com>
 <20201106185241.GA3299843@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <80b0933d-ef0a-2937-bf47-daf9fefebf3f@arm.com>
Date:   Tue, 10 Nov 2020 23:15:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201106185241.GA3299843@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/20 6:52 PM, Mathieu Poirier wrote:
> Good morning,
> 
> On Wed, Oct 28, 2020 at 10:09:37PM +0000, Suzuki K Poulose wrote:
>> etm4_get_access_type() calculates the exception level bits
>> for use in address comparator registers. This is also used
>> by the TRCVICTLR register by shifting to the required position.
>>
>> This patch cleans up the logic to make etm4_get_access_type()
>> calcualte a generic mask which can be used by all users by
>> shifting to their field.
>>
>> No functional changes, only code cleanups.
>>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>> Changes since previous version:
>>    - Fix the duplicate shift. More commentary
>> ---


>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
>> index 2ac4ecb0af61..f1251ddf1984 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
>> @@ -548,24 +548,38 @@
>>   
>>   #define TRCACATR_EXLEVEL_SHIFT		8
>>   
>> -/* secure state access levels - TRCACATRn */
>> -#define ETM_EXLEVEL_S_APP		BIT(8)
>> -#define ETM_EXLEVEL_S_OS		BIT(9)
>> -#define ETM_EXLEVEL_S_HYP		BIT(10)
>> -#define ETM_EXLEVEL_S_MON		BIT(11)
>> -/* non-secure state access levels - TRCACATRn */
>> -#define ETM_EXLEVEL_NS_APP		BIT(12)
>> -#define ETM_EXLEVEL_NS_OS		BIT(13)
>> -#define ETM_EXLEVEL_NS_HYP		BIT(14)
>> -#define ETM_EXLEVEL_NS_NA		BIT(15)
>> -
>> -/* access level control in TRCVICTLR - same bits as TRCACATRn but shifted */
>> -#define ETM_EXLEVEL_LSHIFT_TRCVICTLR	8
>> +/*
>> + * Exception level mask for Secure and Non-Secure ELs.
>> + * ETM defines the bits for EL control (e.g, TRVICTLR, TRCACTRn).
>> + * The Secure and Non-Secure ELs are always to gether.
>> + * Non-secure EL3 is never implemented.
>> + * We use the following generic mask as they appear in different
>> + * registers and this can be shifted for the appropriate
>> + * fields.
>> + */
>> +#define ETM_EXLEVEL_S_APP		BIT(0)	/* Secure EL0		*/
>> +#define ETM_EXLEVEL_S_OS		BIT(1)	/* Secure EL1		*/
>> +#define ETM_EXLEVEL_S_HYP		BIT(2)	/* Secure EL2		*/
>> +#define ETM_EXLEVEL_S_MON		BIT(3)	/* Secure EL3/Montor	*/
> 
> s/Montor/Monitor
> 
>> +#define ETM_EXLEVEL_NS_APP		BIT(4)	/* NonSecure EL0	*/
>> +#define ETM_EXLEVEL_NS_OS		BIT(5)	/* NonSecure EL1	*/
>> +#define ETM_EXLEVEL_NS_HYP		BIT(6)	/* NonSecure EL2	*/
>> +
>> +#define ETM_EXLEVEL_MASK		(GENMASK(6, 0))
> 
> Not used.
> 

I have updated the patch to use this for creating the TRCVICTLR_EXLEVEL_MASK
(see below), which is used to clear all the EXLEVEL bits from TRCVICTLR.

>> +#define ETM_EXLEVEL_S_MASK		(GENMASK(3, 0))
>> +#define ETM_EXLEVEL_NS_MASK		(GENMASK(6, 4))
> 
> This needs to be GENMASK(2, 0) in order TRCVICTLR_EXLEVEL_NS_SHIFT to be 20.
> Otherwise the resulting mask is 4 bit off to the left.

I have retained the ETM_EXLEVEL_NS_MASK as it is above, to keep the defintions
above consistent. I have fixed the problem by using TRCVICTLR_EXLEVEL_SHIFT whenever
we use ETM_EXLEVEL_*_MASK.

And TRCVICTLR_EXLEVEL_*_SHIFT is used when we set a given value from the sysfs, respectively.
e.g :

@@ -795,10 +795,10 @@ static ssize_t ns_exlevel_vinst_store(struct device *dev,

         spin_lock(&drvdata->spinlock);
         /* clear EXLEVEL_NS bits  */
-       config->vinst_ctrl &= ~(ETM_EXLEVEL_NS_VICTLR_MASK);
+       config->vinst_ctrl &= ~(TRCVICTLR_EXLEVEL_NS_MASK);
         /* enable instruction tracing for corresponding exception level */
         val &= drvdata->ns_ex_level;
-       config->vinst_ctrl |= (val << 20);
+       config->vinst_ctrl |= (val << TRCVICTLR_EXLEVEL_NS_SHIFT);
         spin_unlock(&drvdata->spinlock);
         return size;
  }

> 
>> +
>> +/* access level controls in TRCACATRn */
>> +#define TRCACATR_EXLEVEL_SHIFT		8
>> +
>> +/* access level control in TRCVICTLR */
>> +#define TRCVICTLR_EXLEVEL_SHIFT		16
>> +#define TRCVICTLR_EXLEVEL_S_SHIFT	16
>> +#define TRCVICTLR_EXLEVEL_NS_SHIFT	20
>>   
>>   /* secure / non secure masks - TRCVICTLR, IDR3 */
>> -#define ETM_EXLEVEL_S_VICTLR_MASK	GENMASK(19, 16)
>> -/* NS MON (EL3) mode never implemented */
>> -#define ETM_EXLEVEL_NS_VICTLR_MASK	GENMASK(22, 20)
>> +#define TRCVICTLR_EXLEVEL_S_MASK	(ETM_EXLEVEL_S_MASK << TRCVICTLR_EXLEVEL_S_SHIFT)
>> +#define TRCVICTLR_EXLEVEL_NS_MASK	(ETM_EXLEVEL_NS_MASK << TRCVICTLR_EXLEVEL_NS_SHIFT)

And the above has been updated to :

+#define TRCVICTLR_EXLEVEL_MASK         (ETM_EXLEVEL_MASK << TRCVICTLR_EXLEVEL_SHIFT)
+#define TRCVICTLR_EXLEVEL_S_MASK       (ETM_EXLEVEL_S_MASK << TRCVICTLR_EXLEVEL_SHIFT)
+#define TRCVICTLR_EXLEVEL_NS_MASK      (ETM_EXLEVEL_NS_MASK << TRCVICTLR_EXLEVEL_SHIFT)

Suzuki
