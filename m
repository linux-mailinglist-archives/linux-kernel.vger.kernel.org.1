Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2782A62A3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbgKDKyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:54:06 -0500
Received: from foss.arm.com ([217.140.110.172]:35034 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729519AbgKDKyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:54:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2903113D5;
        Wed,  4 Nov 2020 02:54:02 -0800 (PST)
Received: from [10.57.20.162] (unknown [10.57.20.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 438CB3F718;
        Wed,  4 Nov 2020 02:54:01 -0800 (PST)
Subject: Re: [PATCH v3 10/26] coresight: Convert claim/disclaim operations to
 use access wrappers
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-12-suzuki.poulose@arm.com>
 <20201103183625.GD2855763@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <9d6bedd7-37b3-ff2d-51b1-7fd4d2f7024a@arm.com>
Date:   Wed, 4 Nov 2020 10:54:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103183625.GD2855763@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/20 6:36 PM, Mathieu Poirier wrote:
> On Wed, Oct 28, 2020 at 10:09:29PM +0000, Suzuki K Poulose wrote:
>> Convert the generic CLAIM tag management APIs to use the
>> device access layer abstraction.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-catu.c  |  6 +-
>>   drivers/hwtracing/coresight/coresight-core.c  | 66 +++++++++++--------
>>   .../hwtracing/coresight/coresight-cti-core.c  | 17 +++--
>>   drivers/hwtracing/coresight/coresight-etb10.c |  4 +-
>>   .../coresight/coresight-etm3x-core.c          |  8 ++-
>>   .../coresight/coresight-etm4x-core.c          |  4 +-
>>   .../hwtracing/coresight/coresight-funnel.c    |  6 +-
>>   .../coresight/coresight-replicator.c          | 16 +++--
>>   .../hwtracing/coresight/coresight-tmc-etf.c   | 10 +--
>>   .../hwtracing/coresight/coresight-tmc-etr.c   |  4 +-
>>   include/linux/coresight.h                     | 16 ++---
>>   11 files changed, 95 insertions(+), 62 deletions(-)
>>

>>   }
>>   
>> -static inline void coresight_set_claim_tags(void __iomem *base)
>> +static inline void coresight_set_claim_tags(struct coresight_device *csdev)
>>   {
>> -	writel_relaxed(CORESIGHT_CLAIM_SELF_HOSTED, base + CORESIGHT_CLAIMSET);
>> +	csdev_access_relaxed_write32(&csdev->access, CORESIGHT_CLAIM_SELF_HOSTED,
>> +				  CORESIGHT_CLAIMSET);
> 
> Indentation
> 
>>   	isb();
>>   }
>>   
>> -static inline void coresight_clear_claim_tags(void __iomem *base)
>> +static inline void coresight_clear_claim_tags(struct coresight_device *csdev)
>>   {
>> -	writel_relaxed(CORESIGHT_CLAIM_SELF_HOSTED, base + CORESIGHT_CLAIMCLR);
>> +	csdev_access_relaxed_write32(&csdev->access, CORESIGHT_CLAIM_SELF_HOSTED,
>> +				  CORESIGHT_CLAIMCLR);
> 
> Indentation
> 
>>   	isb();
>>   }
>>   


>> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
>> index fcf25740116c..e35d79e74e30 100644
>> --- a/drivers/hwtracing/coresight/coresight-replicator.c
>> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
>> @@ -45,12 +45,18 @@ struct replicator_drvdata {
>>   
>>   static void dynamic_replicator_reset(struct replicator_drvdata *drvdata)
>>   {
>> +	struct coresight_device *csdev = drvdata->csdev;
>>   	CS_UNLOCK(drvdata->base);
>>   
>> -	if (!coresight_claim_device_unlocked(drvdata->base)) {
>> +	if (WARN_ON(!csdev))
>> +		return;
> 
> I don't see a need for this check. Function replicator_reset() is called from
> probe() where the validity of drvdata->csdev is checked just before.
> 

Correct. We only needed drvdata->base earlier, which was fine. But we
now need csdev for the reset. That check was added to make sure that
we don't break the guarantee. I could take that down.

Cheers
Suzuki
