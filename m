Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC5B2A6132
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgKDKHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:07:17 -0500
Received: from foss.arm.com ([217.140.110.172]:34216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbgKDKHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:07:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FF311474;
        Wed,  4 Nov 2020 02:07:13 -0800 (PST)
Received: from [10.57.20.162] (unknown [10.57.20.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37B203F66E;
        Wed,  4 Nov 2020 02:07:12 -0800 (PST)
Subject: Re: [PATCH v3 07/26] coresight: Introduce device access abstraction
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-9-suzuki.poulose@arm.com>
 <20201103171417.GA2854467@xps15> <20201103172544.GA2855763@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <5e322dc6-de2b-8e24-2aad-b7f7a3fbe172@arm.com>
Date:   Wed, 4 Nov 2020 10:07:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103172544.GA2855763@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/20 5:25 PM, Mathieu Poirier wrote:
> On Tue, Nov 03, 2020 at 10:14:17AM -0700, Mathieu Poirier wrote:
>> Hi Suzuki,
>>
>> On Wed, Oct 28, 2020 at 10:09:26PM +0000, Suzuki K Poulose wrote:
>>> We are about to introduce support for sysreg access to ETMv4.4+
>>> component. Since there are generic routines that access the
>>> registers (e.g, CS_LOCK/UNLOCK , claim/disclaim operations, timeout)
>>> and in order to preserve the logic of these operations at a
>>> single place we introduce an abstraction layer for the accesses
>>> to a given device.
>>>
>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Cc: Mike Leach <mike.leach@linaro.org>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-catu.c  |   1 +
>>>   drivers/hwtracing/coresight/coresight-core.c  |  49 +++++
>>>   .../hwtracing/coresight/coresight-cti-core.c  |   1 +
>>>   drivers/hwtracing/coresight/coresight-etb10.c |   1 +
>>>   .../coresight/coresight-etm3x-core.c          |   1 +
>>>   .../coresight/coresight-etm4x-core.c          |   1 +
>>>   .../hwtracing/coresight/coresight-funnel.c    |   1 +
>>>   .../coresight/coresight-replicator.c          |   1 +
>>>   drivers/hwtracing/coresight/coresight-stm.c   |   1 +
>>>   .../hwtracing/coresight/coresight-tmc-core.c  |   1 +
>>>   drivers/hwtracing/coresight/coresight-tpiu.c  |   1 +
>>>   include/linux/coresight.h                     | 197 ++++++++++++++++++
>>>   12 files changed, 256 insertions(+)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
>>> index 99430f6cf5a5..5baf29510f1b 100644
>>> --- a/drivers/hwtracing/coresight/coresight-catu.c
>>> +++ b/drivers/hwtracing/coresight/coresight-catu.c
>>> @@ -551,6 +551,7 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
>>>   	dev->platform_data = pdata;
>>>   
>>>   	drvdata->base = base;
>>> +	catu_desc.access = CSDEV_ACCESS_IOMEM(base);
>>
>> Ok for those
>>
>>>   	catu_desc.pdata = pdata;
>>>   	catu_desc.dev = dev;
>>>   	catu_desc.groups = catu_groups;
>>> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
>>> index cc9e8025c533..e96deaca8cab 100644
>>> --- a/drivers/hwtracing/coresight/coresight-core.c
>>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>>> @@ -1452,6 +1452,54 @@ int coresight_timeout(void __iomem *addr, u32 offset, int position, int value)
>>>   }
>>>   EXPORT_SYMBOL_GPL(coresight_timeout);
>>>   
>>> +u32 coresight_relaxed_read32(struct coresight_device *csdev, u32 offset)
>>> +{
>>> +	return csdev_access_relaxed_read32(&csdev->access, offset);
>>
>> This really doesn't give us much other than another jump.  I would give function
>> csdev_access_relaxed_read32() a coresight_device argument instead of a csdev_access
>> and rename it to coresight_relaxed_read32().  The same for the other access functions.
>>
> 
> Ignore the above, TPIU just gave me the logic behind what you did.

Thanks Mathieu, will address your comments in the next version.

Suzuki
