Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F1F2B0606
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgKLNJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:09:38 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7886 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgKLNJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:09:37 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CX24M0YWMz75yr;
        Thu, 12 Nov 2020 21:09:23 +0800 (CST)
Received: from [127.0.0.1] (10.65.95.32) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Thu, 12 Nov 2020
 21:09:23 +0800
Subject: Re: [RFC PATCH v2] coresight: etm4x: Modify core-commit of cpu to
 avoid the overflow of HiSilicon ETM
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
References: <1597824397-29894-1-git-send-email-liuqi115@huawei.com>
 <20200827204426.GD22307@xps15> <548c973d-6964-ca5c-4c8d-fbc2386f3349@arm.com>
 <CAJ9a7Vh8r4q8sCJnOdrrONZpM42QNbMpZGiebXs-mGW=MgmM3Q@mail.gmail.com>
 <20200909162605.GB553266@xps15>
 <70f83c48-5a4e-5d4d-734f-105501d21a63@huawei.com>
 <20201111170345.GA3543438@xps15>
CC:     Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, Coresight ML <coresight@lists.linaro.org>
From:   Qi Liu <liuqi115@huawei.com>
Message-ID: <942b216e-9a17-7cc2-aedc-a2e003b00924@huawei.com>
Date:   Thu, 12 Nov 2020 21:09:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20201111170345.GA3543438@xps15>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.95.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/11/12 1:03, Mathieu Poirier wrote:
> On Wed, Nov 11, 2020 at 04:58:23PM +0800, Qi Liu wrote:
>> Hi Mathieu,
>>
>> On 2020/9/10 0:26, Mathieu Poirier wrote:
>>> On Wed, Sep 09, 2020 at 12:30:02PM +0100, Mike Leach wrote:
>>>> Hi,
>>>>
>>>> On Wed, 2 Sep 2020 at 11:36, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>>>> On 08/27/2020 09:44 PM, Mathieu Poirier wrote:
>>>>>> Hi Liu,
>>>>>>
>>>>>> On Wed, Aug 19, 2020 at 04:06:37PM +0800, Qi Liu wrote:
>>>>>>> When too much trace information is generated on-chip, the ETM will
>>>>>>> overflow, and cause data loss. This is a common phenomenon on ETM
>>>>>>> devices.
>>>>>>>
>>>>>>> But sometimes we do not want to lose performance trace data, so we
>>>>>>> suppress the speed of instructions sent from CPU core to ETM to
>>>>>>> avoid the overflow of ETM.
>>>>>>>
>>>>>>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>>>>>>> ---
>>>>>>>
>>>>>>> Changes since v1:
>>>>>>> - ETM on HiSilicon Hip09 platform supports backpressure, so does
>>>>>>> not need to modify core commit.
>>>>>>>
>>>>>>>   drivers/hwtracing/coresight/coresight-etm4x.c | 43 +++++++++++++++++++++++++++
>>>>>>>   1 file changed, 43 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
>>>>>>> index 7797a57..7641f89 100644
>>>>>>> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
>>>>>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
>>>>>>> @@ -43,6 +43,10 @@ MODULE_PARM_DESC(boot_enable, "Enable tracing on boot");
>>>>>>>   #define PARAM_PM_SAVE_NEVER          1 /* never save any state */
>>>>>>>   #define PARAM_PM_SAVE_SELF_HOSTED 2 /* save self-hosted state only */
>>>>>>>
>>>>>>> +#define CORE_COMMIT_CLEAR   0x3000
>>>>>>> +#define CORE_COMMIT_SHIFT   12
>>>>>>> +#define HISI_ETM_AMBA_ID_V1 0x000b6d01
>>>>>>> +
>>>>>>>   static int pm_save_enable = PARAM_PM_SAVE_FIRMWARE;
>>>>>>>   module_param(pm_save_enable, int, 0444);
>>>>>>>   MODULE_PARM_DESC(pm_save_enable,
>>>>>>> @@ -104,11 +108,40 @@ struct etm4_enable_arg {
>>>>>>>      int rc;
>>>>>>>   };
>>>>>>>
>>>>>>> +static void etm4_cpu_actlr1_cfg(void *info)
>>>>>>> +{
>>>>>>> +    struct etm4_enable_arg *arg = (struct etm4_enable_arg *)info;
>>>>>>> +    u64 val;
>>>>>>> +
>>>>>>> +    asm volatile("mrs %0,s3_1_c15_c2_5" : "=r"(val));
>>>>>
>>>>> The ID register (S3_1_C15_c2_5) falls into implementation defined space.
>>>>> See Arm ARM DDI 0487F.a, section "D12.3.2  Reserved encodings for
>>>>> IMPLEMENTATION DEFINED registers".
>>>>>
>>>>> So, please stop calling this "etm4_cpu_actlr1_cfg". Since,
>>>>> 1) actlr1 is not an architected name for the said encoding
>>>>> 2) The id register could mean something else on another CPU.
>>>>>
>>>>> Rather this should indicate platform/CPU specific. e.g,
>>>>>
>>>>> etm4_cpu_hisilicon_config_core_commit()
>>>>>
>>>>>
>>>>>>> +    val &= ~CORE_COMMIT_CLEAR;
>>>>>>> +    val |= arg->rc << CORE_COMMIT_SHIFT;
>>>>>>> +    asm volatile("msr s3_1_c15_c2_5,%0" : : "r"(val));
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void etm4_config_core_commit(int cpu, int val)
>>>>>>> +{
>>>>>>> +    struct etm4_enable_arg arg = {0};
>>>>>>> +
>>>>>>> +    arg.rc = val;
>>>>>>> +    smp_call_function_single(cpu, etm4_cpu_actlr1_cfg, &arg, 1);
>>>>>> Function etm4_enable/disable_hw() are already running on the CPU they are
>>>>>> supposed to so no need to call smp_call_function_single().
>>>>>>
>>>>>>> +}
>>>>>>> +
>>>>>>>   static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>>>>>>>   {
>>>>>>>      int i, rc;
>>>>>>> +    struct amba_device *adev;
>>>>>>>      struct etmv4_config *config = &drvdata->config;
>>>>>>>      struct device *etm_dev = &drvdata->csdev->dev;
>>>>>>> +    struct device *dev = drvdata->csdev->dev.parent;
>>>>>>> +
>>>>>>> +    adev = container_of(dev, struct amba_device, dev);
>>>>>>> +    /*
>>>>>>> +     * If ETM device is HiSilicon ETM device, reduce the
>>>>>>> +     * core-commit to avoid ETM overflow.
>>>>>>> +     */
>>>>>>> +    if (adev->periphid == HISI_ETM_AMBA_ID_V1)
>>>>> Please could you move this check to the function above ?
>>>>> Ideally, it would be good to have something like :
>>>>>
>>>>>         etm4_config_impdef_features();
>>>>>
>>>>> And :
>>>>>
>>>>>         etm4_config_impdef_features(struct etm4_drvdata *drvdata)
>>>>>         {
>>>>>                 etm4_cpu_hisilicon_config_core_commit(drvdata);
>>>>>         }
>>>>>
>>>> In addition to the above, Is it worth having this implementation
>>>> defined code gated in the kernel configuration - like we do for core
>>>> features sometimes?
>>>> i,.e.
>>>> CONFIG_ETM4X_IMPDEF_FEATURE (controls overall impdef support in the driver)
>>>> and
>>>> CONFIG_ETM4X_IMPDEF_HISILICON (depends on CONFIG_ETM4X_IMPDEF_FEATURE )
>>>>
>>>> This way we keep non ETM architectural code off platforms that cannot
>>>> use it / test it.
>>>>
>>> That's a good idea - they do the same for CPU erratas.
>>>  
>> Considering that users sometimes use the same set of code on different platforms, how about
>> using both CONFIG andperiphid to keep core-commit code off the platforms that do not
>> need it?
>> i, .e.
>> CONFIG_ETM4X_IMPDEF_FEATURE ( controls overall impdef support in the driver )
>> periphid ( match impdef code with the target platform )
>>
>> This way we could keep the same set of code working on different platforms, and it could help to
>> ensure compatibility.
> 
> I'm not 100% sure of what you mean by "same set of code working on different
> platforms"...  Up to know the way we have been handling peripheral IDs has
> worked quite well and I don't intend on changing it unless there is a really
> good reason.
> 
Hi Mathieu,

Perhaps I didn't make it clear and here is the code to express what I mean:

#ifdef CONFIG_ETM4X_IMPDEF_FEATURE

#define HISI_HIP08_AMBA_ID		0x000b6d01
#define HISI_HIP08_AMBA_MASK 		0xfffff
static void etm4_enable_arch_specific(struct etmv4_drvdata *drvdata)
{
    struct device *dev = drvdata->csdev->dev.parent;
    struct amba_device *adev = container_of(dev, struct amba_device, dev);

    /*
     * If ETM device is HiSilicon ETM device, reduce the
     * core-commit to avoid ETM overflow.
     */
    if (adev->periphid & HISI_HIP08_AMBA_MASK == HISI_HIP08_AMBA_ID)
        etm4_hisi_config_core_commit(1);
}

#else
static void etm4_enable_arch_specific(struct etmv4_drvdata *drvdata)
{
}

#endif /* CONFIG_ETM4X_IMPDEF_FEATURE */

Thanks
Qi

>> I'll update this patch if this solution is ok : )
>>
>> Thanks!
>> Qi
>>>>>> Do you have any documentation on this back pressure feature?  I doubt this is
>>>>>> specific to Hip09 platform and as such would prefer to have a more generic
>>>>>> approach that works on any platform that supports it.
>>>>>>
>>>>>> Anyone on the CS mailing list that knows what this is about?
>>>>> I believe this is hisilicon specific. May be same across their CPUs, may
>>>>> be a specific one. There is no architectural guarantee.
>>>>>
>>>> This could be an implementation of the feature provided by the
>>>> TRCSTALLCTRL register - which allows PE to be stalled in response to
>>>> the ETM fifos approaching overflow.
>>>> At present we do nothing with this feature as we have yet to see a
>>>> target with it implemented, but if this is the case then it is an
>>>> ETMv4 architectural feature that could be added into the main driver
>>>> code,  with use/access gated by the relevent TRCIDR bit.
>>>>
>>>> Regards
>>>>
>>>> Mike
>>>>
>>>>
>>>>> Cheers
>>>>> Suzuki
>>>>
>>>>
>>>> -- 
>>>> Mike Leach
>>>> Principal Engineer, ARM Ltd.
>>>> Manchester Design Centre. UK
>>> .
>>>
>>
> 
> .
> 

