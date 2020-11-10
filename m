Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1BA2AD41F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbgKJKup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:50:45 -0500
Received: from foss.arm.com ([217.140.110.172]:53788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbgKJKuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:50:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10A0B11D4;
        Tue, 10 Nov 2020 02:50:44 -0800 (PST)
Received: from [10.57.23.123] (unknown [10.57.23.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34C3C3F6CF;
        Tue, 10 Nov 2020 02:50:43 -0800 (PST)
Subject: Re: [PATCH v3 25/26] coresight: etm4x: Add support for sysreg only
 devices
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-27-suzuki.poulose@arm.com>
 <20201109204657.GD3396611@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <9566bf8c-3e05-7a81-d487-647a057ae4f1@arm.com>
Date:   Tue, 10 Nov 2020 10:50:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201109204657.GD3396611@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/20 8:46 PM, Mathieu Poirier wrote:
> On Wed, Oct 28, 2020 at 10:09:44PM +0000, Suzuki K Poulose wrote:
>> Add support for devices with system instruction access only.
>> They don't have a memory mapped interface and thus are not
>> AMBA devices.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   .../coresight/coresight-etm4x-core.c          | 50 +++++++++++++++++--
>>   1 file changed, 45 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index 25fab5513604..50a574228866 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -26,6 +26,7 @@
>>   #include <linux/seq_file.h>
>>   #include <linux/uaccess.h>
>>   #include <linux/perf_event.h>
>> +#include <linux/platform_device.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/property.h>
>>   #include <asm/sections.h>
>> @@ -1623,9 +1624,6 @@ static int etm4_probe(struct device *dev, void __iomem *base)
>>   			return -ENOMEM;
>>   	}
>>   
>> -	if (fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
>> -		drvdata->skip_power_up = true;
>> -
>>   	drvdata->base = base;
>>   
>>   	spin_lock_init(&drvdata->spinlock);
>> @@ -1648,6 +1646,11 @@ static int etm4_probe(struct device *dev, void __iomem *base)
>>   	if (!drvdata->arch)
>>   		return -EINVAL;
>>   
>> +	/* Skip programming TRCPDCR for system instructions. */
> 
> It would be nice to mention that TRCPDCR is not available in system instruction
> mode.

Sure.

> 
>> +	if (!desc.access.io_mem ||
>> +	    fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
>> +		drvdata->skip_power_up = true;
>> +
>>   	etm4_init_trace_id(drvdata);
>>   	etm4_set_default(&drvdata->config);
>>   
>> @@ -1706,6 +1709,20 @@ static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
>>   	return ret;
>>   }
>>   
>> +static int etm4_probe_platform_dev(struct platform_device *pdev)
>> +{
>> +	int ret;
>> +
>> +	pm_runtime_get_noresume(&pdev->dev);
>> +	pm_runtime_set_active(&pdev->dev);
>> +	pm_runtime_enable(&pdev->dev);
>> +
>> +	ret = etm4_probe(&pdev->dev, NULL);
>> +
>> +	pm_runtime_put(&pdev->dev);
>> +	return ret;
>> +}
>> +
>>   static struct amba_cs_uci_id uci_id_etm4[] = {
>>   	{
>>   		/*  ETMv4 UCI data */
>> @@ -1781,6 +1798,20 @@ static struct amba_driver etm4x_amba_driver = {
>>   	.id_table	= etm4_ids,
>>   };
>>   
>> +static const struct of_device_id etm_sysreg_match[] = {
> 
> s/etm_sysreg_match/etm4_sysreg_match
> 
>> +	{ .compatible	= "arm,coresight-etm-sysreg" },
> 
> See my comment in the next patch.
> 
> With the above:
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 

Thanks

Suzuki
