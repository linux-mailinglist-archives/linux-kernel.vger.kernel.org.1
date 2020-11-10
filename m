Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32512AD40C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgKJKsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:48:03 -0500
Received: from foss.arm.com ([217.140.110.172]:53744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgKJKsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:48:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E46911D4;
        Tue, 10 Nov 2020 02:48:02 -0800 (PST)
Received: from [10.57.23.123] (unknown [10.57.23.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40EC03F6CF;
        Tue, 10 Nov 2020 02:48:01 -0800 (PST)
Subject: Re: [PATCH v3 19/26] coresight: etm4x: Detect access early on the
 target CPU
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-21-suzuki.poulose@arm.com>
 <20201106204649.GC3299843@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <61d7e897-3e83-7e95-033c-d43847cfeb09@arm.com>
Date:   Tue, 10 Nov 2020 10:47:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201106204649.GC3299843@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/20 8:46 PM, Mathieu Poirier wrote:
> On Wed, Oct 28, 2020 at 10:09:38PM +0000, Suzuki K Poulose wrote:
>> In preparation to detect the support for system instruction
>> support, move the detection of the device access to the target
>> CPU.
>>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   .../coresight/coresight-etm4x-core.c          | 45 ++++++++++++++++---
>>   1 file changed, 40 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index f038bb10bc78..308674ab746c 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -56,6 +56,11 @@ static u64 etm4_get_access_type(struct etmv4_config *config);
>>   
>>   static enum cpuhp_state hp_online;
>>   
>> +struct etm_init_arg {
>> +	struct etmv4_drvdata	*drvdata;
>> +	struct csdev_access	*csa;
>> +};
>> +
>>   u64 etm4x_sysreg_read(struct csdev_access *csa,
>>   		      u32 offset,
>>   		      bool _relaxed,
>> @@ -669,6 +674,22 @@ static const struct coresight_ops etm4_cs_ops = {
>>   	.source_ops	= &etm4_source_ops,
>>   };
>>   
>> +static bool etm_init_iomem_access(struct etmv4_drvdata *drvdata,
>> +				  struct csdev_access *csa)
>> +{
>> +	*csa = CSDEV_ACCESS_IOMEM(drvdata->base);
>> +	return true;
>> +}
>> +
>> +static bool etm_init_csdev_access(struct etmv4_drvdata *drvdata,
>> +				  struct csdev_access *csa)
>> +{
>> +	if (drvdata->base)
>> +		return etm_init_iomem_access(drvdata, csa);
>> +
>> +	return false;
>> +}
> 
> I would also prefix the above two functions with "etm4_" rather than "etm_" to
> follow what is already done in this file.

sure, will do.

suzuki
