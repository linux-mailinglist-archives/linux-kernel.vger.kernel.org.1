Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729242A6266
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgKDKm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:42:59 -0500
Received: from foss.arm.com ([217.140.110.172]:34728 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbgKDKm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:42:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0E9813D5;
        Wed,  4 Nov 2020 02:42:57 -0800 (PST)
Received: from [10.57.20.162] (unknown [10.57.20.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAEEE3F66E;
        Wed,  4 Nov 2020 02:42:56 -0800 (PST)
Subject: Re: [PATCH v3 09/26] coresight: Convert coresight_timeout to use
 access abstraction
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-11-suzuki.poulose@arm.com>
 <20201103180329.GB2855763@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b1323f88-d6b8-5525-4d2f-d001236f8860@arm.com>
Date:   Wed, 4 Nov 2020 10:42:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103180329.GB2855763@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/20 6:03 PM, Mathieu Poirier wrote:
> On Wed, Oct 28, 2020 at 10:09:28PM +0000, Suzuki K Poulose wrote:
>> Convert the generic routines to use the new access abstraction layer
>> gradually, starting with coresigth_timeout.
>>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---



>> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
>> index 5baf29510f1b..34c74b05c542 100644
>> --- a/drivers/hwtracing/coresight/coresight-catu.c
>> +++ b/drivers/hwtracing/coresight/coresight-catu.c
>> @@ -401,8 +401,9 @@ static const struct attribute_group *catu_groups[] = {
>>   
>>   static inline int catu_wait_for_ready(struct catu_drvdata *drvdata)
>>   {
>> -	return coresight_timeout(drvdata->base,
>> -				 CATU_STATUS, CATU_STATUS_READY, 1);
>> +	struct csdev_access *csa = &drvdata->csdev->access;
>> +
>> +	return coresight_timeout(csa, CATU_STATUS, CATU_STATUS_READY, 1);
>>   }
>>   
>>   static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
>> index e96deaca8cab..42ba989a6b5e 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -1412,23 +1412,26 @@ static void coresight_remove_conns(struct coresight_device *csdev)
>>   }
>>   
>>   /**
>> - * coresight_timeout - loop until a bit has changed to a specific state.
>> - * @addr: base address of the area of interest.
>> - * @offset: address of a register, starting from @addr.
>> + * coresight_timeout - loop until a bit has changed to a specific register
>> + *			state.
>> + * @csa: coresight device access for the device
>> + * @offset: Offset of the register from the base of the device.
>>    * @position: the position of the bit of interest.
>>    * @value: the value the bit should have.
>>    *
>>    * Return: 0 as soon as the bit has taken the desired state or -EAGAIN if
>>    * TIMEOUT_US has elapsed, which ever happens first.
>>    */
>> -
>> -int coresight_timeout(void __iomem *addr, u32 offset, int position, int value)
>> +int coresight_timeout(struct csdev_access *csa,
>> +		      u32 offset,
>> +		      int position,
>> +		      int value)
> 
> There is no need for stacking, please maximise the 80 characters.  The function
> stubs in coresight.h should also be revised.
> 
>>   {
>>   	int i;
>>   	u32 val;
>>   
>>   	for (i = TIMEOUT_US; i > 0; i--) {
>> -		val = __raw_readl(addr + offset);
>> +		val = csdev_access_read32(csa, offset);
> 
> I vaguely remember commenting on this, or perhaps it was on some othe patch you
> wrote...  Anyways, I think it is a good thing to go from an unordered access to
> an ordered access for the timeout function.

Yes, you did mention it in the v1.

> 
> With the above:
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks, will address the comments.

Suzuki
