Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02FF2C55DF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390220AbgKZNi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:38:29 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8415 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390138AbgKZNi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:38:29 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Chf2z68Skz74DG;
        Thu, 26 Nov 2020 21:38:03 +0800 (CST)
Received: from [127.0.0.1] (10.65.95.32) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Thu, 26 Nov 2020
 21:38:16 +0800
Subject: Re: [PATCH] coresight: etm4x: Modify core-commit of cpu to avoid the
 overflow of HiSilicon ETM
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        <mathieu.poirier@linaro.org>, <mike.leach@linaro.org>
References: <1606138167-8076-1-git-send-email-liuqi115@huawei.com>
 <cfa91a72-6e01-85ce-583a-9a49093a875b@arm.com>
CC:     <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>
From:   Qi Liu <liuqi115@huawei.com>
Message-ID: <4acd7b82-74db-4df6-a7af-26f8434de45f@huawei.com>
Date:   Thu, 26 Nov 2020 21:38:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <cfa91a72-6e01-85ce-583a-9a49093a875b@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.95.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/11/23 22:12, Suzuki K Poulose wrote:
> Hi Qi
> 
> Thanks for the changes. Mostly looks good to me, except for the
> name of the call back.
> 
> 
Hi Suzuki,
ok, I'll send a new patch to change the name of call back.

Thanks
Qi
> On 11/23/20 1:29 PM, Qi Liu wrote:
>> The ETM device can't keep up with the core pipeline when cpu core
>> is at full speed. This may cause overflow within core and its ETM.
>> This is a common phenomenon on ETM devices.
>>
>> On HiSilicon Hip08 platform, a specific feature is added to set
>> core pipeline. So commit rate can be reduced manually to avoid ETM
>> overflow.
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> 
> 
>> ---
>> Change since v1:
>> - add CONFIG_ETM4X_IMPDEF_FEATURE and CONFIG_ETM4X_IMPDEF_HISILICON
>>    to keep specific feature off platforms which don't use it.
>> Change since v2:
>> - remove some unused variable.
>> Change since v3:
>> - use read/write_sysreg_s() to access register.
>>
>>   drivers/hwtracing/coresight/Kconfig                |  9 +++
>>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 84 ++++++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-etm4x.h      | 12 ++++
>>   3 files changed, 105 insertions(+)
>>
> 
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
>> index eefc737..1784975 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
>> @@ -8,6 +8,7 @@
>>
>>   #include <asm/local.h>
>>   #include <linux/spinlock.h>
>> +#include <linux/types.h>
>>   #include "coresight-priv.h"
>>
>>   /*
>> @@ -203,6 +204,11 @@
>>   /* Interpretation of resource numbers change at ETM v4.3 architecture */
>>   #define ETM4X_ARCH_4V3    0x43
>>
>> +enum etm_impdef_type {
>> +    ETM4_IMPDEF_HISI_CORE_COMMIT,
>> +    ETM4_IMPDEF_FEATURE_MAX,
>> +};
>> +
>>   /**
>>    * struct etmv4_config - configuration information related to an ETMv4
>>    * @mode:    Controls various modes supported by this ETM.
>> @@ -415,6 +421,7 @@ struct etmv4_save_state {
>>    * @state_needs_restore: True when there is context to restore after PM exit
>>    * @skip_power_up: Indicates if an implementation can skip powering up
>>    *           the trace unit.
>> + * @arch_features: Bitmap of arch features of etmv4 devices.
>>    */
>>   struct etmv4_drvdata {
>>       void __iomem            *base;
>> @@ -463,6 +470,11 @@ struct etmv4_drvdata {
>>       struct etmv4_save_state        *save_state;
>>       bool                state_needs_restore;
>>       bool                skip_power_up;
>> +    DECLARE_BITMAP(arch_features, ETM4_IMPDEF_FEATURE_MAX);
>> +};
>> +
>> +struct etm4_arch_features {
>> +    void (*set_commit)(bool enable);
> 
> The set_commit is too hisilicon specific :-). Could we please rename
> this to soemthing more generic. The callback for hisilicon etms, could still
> be xx_commit". May be simply call it
> 
>     callback() ?
> 
> or may be even
>     arch_callback() ?
> 
> 
>>   };
> 
> nit: This need not be part of the header file, as it is not used
> outside the etm4x-core.c
> 
> Suzuki
> 
> .
> 

