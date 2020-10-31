Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7FE2A14FA
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 10:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgJaJwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 05:52:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6715 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgJaJwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:52:12 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CNZGG6bcYzkbX5;
        Sat, 31 Oct 2020 17:52:06 +0800 (CST)
Received: from [127.0.0.1] (10.65.95.32) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Sat, 31 Oct 2020
 17:52:00 +0800
Subject: Re: [PATCH v3] coresight: etm4x: Modify core-commit of cpu to avoid
 the overflow of HiSilicon ETM
To:     Suzuki Poulose <suzuki.poulose@arm.com>,
        <mathieu.poirier@linaro.org>, <Al.Grant@arm.com>,
        <mike.leach@linaro.org>
References: <1603448595-22615-1-git-send-email-liuqi115@huawei.com>
 <b9a26650-c0fe-51a5-77a1-e5ae81901f8a@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>
From:   Qi Liu <liuqi115@huawei.com>
Message-ID: <8f02ccd2-5593-398d-a2cb-c3b476465ea9@huawei.com>
Date:   Sat, 31 Oct 2020 17:51:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <b9a26650-c0fe-51a5-77a1-e5ae81901f8a@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.95.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 2020/10/23 18:40, Suzuki Poulose wrote:
> On 10/23/20 11:23 AM, Qi Liu wrote:
>> The ETM device can't keep up with the core pipeline when cpu core
>> is at full speed. This may cause overflow within core and its ETM.
>> This is a common phenomenon on ETM devices.
>>
>> On HiSilicon Hip08 platform, a specific feature is added to set
>> core pipeline. So commit rate can be reduced manually to avoid ETM
>> overflow.
>>
>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>> ---
>> Change since v1:
>> - add CONFIG_ETM4X_IMPDEF_FEATURE and CONFIG_ETM4X_IMPDEF_HISILICON
>>    to keep specific feature off platforms which don't use it.
>> Change since v2:
>> - remove some unused variable.
>>
>>   drivers/hwtracing/coresight/Kconfig                | 18 ++++++++
>>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 50 ++++++++++++++++++++++
>>   2 files changed, 68 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
>> index c119824..9665d70 100644
>> --- a/drivers/hwtracing/coresight/Kconfig
>> +++ b/drivers/hwtracing/coresight/Kconfig
>> @@ -110,6 +110,24 @@ config CORESIGHT_SOURCE_ETM4X
>>         To compile this driver as a module, choose M here: the
>>         module will be called coresight-etm4x.
>>
>> +config ETM4X_IMPDEF_FEATURE
>> +    bool "Control overflow impdef support in CoreSight ETM 4.x driver "
>> +    depends on CORESIGHT_SOURCE_ETM4X
>> +    help
>> +      This control provides overflow implement define for CoreSight
>> +      ETM 4.x tracer module which could not reduce commit race
>> +      automatically, and could avoid overflow within ETM tracer module
>> +      and its cpu core.
>> +
>> +config ETM4X_IMPDEF_HISILICON
>> +    bool "Control overflow impdef support in HiSilicon ETM 4.x driver "
>> +    depends on ETM4X_IMPDEF_FEATURE
>> +    help
>> +      This control provides overflow implement define for HiSilicon
>> +      ETM 4.x tracer module of Hip08 platform. Overflow within ETM
>> +      tracer module and its cpu core can be avoided by reducing core
>> +      commit manually.
>> +
>>   config CORESIGHT_STM
>>       tristate "CoreSight System Trace Macrocell driver"
>>       depends on (ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index abd706b..35f4333 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -103,12 +103,61 @@ struct etm4_enable_arg {
>>       int rc;
>>   };
>>
>> +#ifdef CONFIG_ETM4X_IMPDEF_FEATURE
>> +
>> +#ifdef CONFIG_ETM4X_IMPDEF_HISILICON
>> +
>> +#define HISI_HIP08_CORE_COMMIT_CLEAR    0x3000
>> +#define HISI_HIP08_CORE_COMMIT_SHIFT    12
>> +static void etm4_hisi_config_core_commit(int flag)
>
> nit: s/int flag/bool enable ?
thanks, bool is better to use here, will fix this.
>
>> +{
>> +    u64 val;
>> +
>> +    asm volatile("mrs %0,s3_1_c15_c2_5" : "=r"(val));
>> +    val &= ~HISI_HIP08_CORE_COMMIT_CLEAR;
>> +    val |= flag << HISI_HIP08_CORE_COMMIT_SHIFT;
>> +    asm volatile("msr s3_1_c15_c2_5,%0" : : "r"(val));
>
> Sorry for missing this out. We don't encourage the above encodings
> as it will break on legacy toolchain. So, please could you follow what
> we do normally, by using sys_reg() macros to define the encoding and use
> read/write_sysreg_s() instead. See arch/arm64/include/asm/sysreg.h
>

ok, I'll use sys_reg() macro here, and send a new version latter, thanks : )
>
>> +}
>> +#else
>> +static void etm4_hisi_config_core_commit(int flag)
>> +{
>> +}
>> +#endif /* CONFIG_ETM4X_IMPDEF_HISILICON */
>> +
>> +static void etm4_enable_arch_specific(void)
>> +{
>> +    /*
>> +     * If ETM device is HiSilicon ETM device, reduce the
>> +     * core-commit to avoid ETM overflow.
>> +     */
>> +    etm4_hisi_config_core_commit(1);
>> +}
>> +
>> +static void etm4_disable_arch_specific(void)
>> +{
>> +    /*
>> +     * If ETM device is HiSilicon ETM device, resume the
>> +     * core-commit after ETM trace is complete.
>> +     */
>> +    etm4_hisi_config_core_commit(0);
>> +}
>> +#else
>> +static void etm4_enable_arch_specific(void)
>> +{
>> +}
>> +
>> +static void etm4_disable_arch_specific(void)
>> +{
>> +}
>> +#endif /* CONFIG_ETM4X_IMPDEF_FEATURE */
>> +
>>   static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>>   {
>>       int i, rc;
>>       struct etmv4_config *config = &drvdata->config;
>>       struct device *etm_dev = &drvdata->csdev->dev;
>>
>> +    etm4_enable_arch_specific();
>>       CS_UNLOCK(drvdata->base);
>
> Please could we move the enable_arch_specific() after the CS_UNLOCK ?
> That way any potential code could do something with the ETM4x registers.
>
ok, will fix it.
>>
>>       etm4_os_unlock(drvdata);
>> @@ -475,6 +524,7 @@ static void etm4_disable_hw(void *info)
>>       struct device *etm_dev = &drvdata->csdev->dev;
>>       int i;
>>
>> +    etm4_disable_arch_specific();
>>       CS_UNLOCK(drvdata->base);
>>
>
> Same here
>
> Suzuki
>
> .
>


