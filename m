Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225692B18F4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 11:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgKMKWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 05:22:50 -0500
Received: from foss.arm.com ([217.140.110.172]:35626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgKMKWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 05:22:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B6131042;
        Fri, 13 Nov 2020 02:22:48 -0800 (PST)
Received: from [10.57.23.123] (unknown [10.57.23.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 704FD3F6CF;
        Fri, 13 Nov 2020 02:22:46 -0800 (PST)
Subject: Re: [RFC PATCH v2] coresight: etm4x: Modify core-commit of cpu to
 avoid the overflow of HiSilicon ETM
To:     Qi Liu <liuqi115@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Mike Leach <mike.leach@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxarm@huawei.com, Coresight ML <coresight@lists.linaro.org>
References: <1597824397-29894-1-git-send-email-liuqi115@huawei.com>
 <20200827204426.GD22307@xps15> <548c973d-6964-ca5c-4c8d-fbc2386f3349@arm.com>
 <CAJ9a7Vh8r4q8sCJnOdrrONZpM42QNbMpZGiebXs-mGW=MgmM3Q@mail.gmail.com>
 <20200909162605.GB553266@xps15>
 <70f83c48-5a4e-5d4d-734f-105501d21a63@huawei.com>
 <20201111170345.GA3543438@xps15>
 <942b216e-9a17-7cc2-aedc-a2e003b00924@huawei.com>
 <93a2b528-ef4f-6217-e3ed-afd4a8eef179@arm.com>
 <6fc3f71b-80b9-b28d-b39c-ecd001191927@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <2e4f318d-ad02-6f7c-834b-4cf92d174c25@arm.com>
Date:   Fri, 13 Nov 2020 10:22:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <6fc3f71b-80b9-b28d-b39c-ecd001191927@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/20 10:18 AM, Qi Liu wrote:
> 
> 
> On 2020/11/12 22:03, Suzuki K Poulose wrote:
>> On 11/12/20 1:09 PM, Qi Liu wrote:
>>>
>>>
>>> On 2020/11/12 1:03, Mathieu Poirier wrote:
>>>> On Wed, Nov 11, 2020 at 04:58:23PM +0800, Qi Liu wrote:
>>>>> Hi Mathieu,
>>>>>
>>>>> On 2020/9/10 0:26, Mathieu Poirier wrote:
>>>>>> On Wed, Sep 09, 2020 at 12:30:02PM +0100, Mike Leach wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Wed, 2 Sep 2020 at 11:36, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>>>>>>> On 08/27/2020 09:44 PM, Mathieu Poirier wrote:
>>>>>>>>> Hi Liu,
>>>>>>>>>
>>>>>>>>> On Wed, Aug 19, 2020 at 04:06:37PM +0800, Qi Liu wrote:
>>>>>>>>>> When too much trace information is generated on-chip, the ETM will
>>>>>>>>>> overflow, and cause data loss. This is a common phenomenon on ETM
>>>>>>>>>> devices.
>>>>>>>>>>
>>>>>>>>>> But sometimes we do not want to lose performance trace data, so we
>>>>>>>>>> suppress the speed of instructions sent from CPU core to ETM to
>>>>>>>>>> avoid the overflow of ETM.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
>>>>>>>>>> ---
>>>>>>>>>>
>>>>>>>>>> Changes since v1:
>>>>>>>>>> - ETM on HiSilicon Hip09 platform supports backpressure, so does
>>>>>>>>>> not need to modify core commit.
>>>>>>>>>>
>>>>>>>>>>     drivers/hwtracing/coresight/coresight-etm4x.c | 43 +++++++++++++++++++++++++++
>>>>>>>>>>     1 file changed, 43 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
>>>>>>>>>> index 7797a57..7641f89 100644
>>>>>>>>>> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
>>>>>>>>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
>>>>>>>>>> @@ -43,6 +43,10 @@ MODULE_PARM_DESC(boot_enable, "Enable tracing on boot");
>>>>>>>>>>     #define PARAM_PM_SAVE_NEVER          1 /* never save any state */
>>>>>>>>>>     #define PARAM_PM_SAVE_SELF_HOSTED 2 /* save self-hosted state only */
>>>>>>>>>>
>>>>>>>>>> +#define CORE_COMMIT_CLEAR   0x3000
>>>>>>>>>> +#define CORE_COMMIT_SHIFT   12
>>>>>>>>>> +#define HISI_ETM_AMBA_ID_V1 0x000b6d01
>>>>>>>>>> +
>>>>>>>>>>     static int pm_save_enable = PARAM_PM_SAVE_FIRMWARE;
>>>>>>>>>>     module_param(pm_save_enable, int, 0444);
>>>>>>>>>>     MODULE_PARM_DESC(pm_save_enable,
>>>>>>>>>> @@ -104,11 +108,40 @@ struct etm4_enable_arg {
>>>>>>>>>>        int rc;
>>>>>>>>>>     };
>>>>>>>>>>
>>>>>>>>>> +static void etm4_cpu_actlr1_cfg(void *info)
>>>>>>>>>> +{
>>>>>>>>>> +    struct etm4_enable_arg *arg = (struct etm4_enable_arg *)info;
>>>>>>>>>> +    u64 val;
>>>>>>>>>> +
>>>>>>>>>> +    asm volatile("mrs %0,s3_1_c15_c2_5" : "=r"(val));
>>>>>>>>
>>>>>>>> The ID register (S3_1_C15_c2_5) falls into implementation defined space.
>>>>>>>> See Arm ARM DDI 0487F.a, section "D12.3.2  Reserved encodings for
>>>>>>>> IMPLEMENTATION DEFINED registers".
>>>>>>>>
>>>>>>>> So, please stop calling this "etm4_cpu_actlr1_cfg". Since,
>>>>>>>> 1) actlr1 is not an architected name for the said encoding
>>>>>>>> 2) The id register could mean something else on another CPU.
>>>>>>>>
>>>>>>>> Rather this should indicate platform/CPU specific. e.g,
>>>>>>>>
>>>>>>>> etm4_cpu_hisilicon_config_core_commit()
>>>>>>>>
>>>>>>>>
>>>>>>>>>> +    val &= ~CORE_COMMIT_CLEAR;
>>>>>>>>>> +    val |= arg->rc << CORE_COMMIT_SHIFT;
>>>>>>>>>> +    asm volatile("msr s3_1_c15_c2_5,%0" : : "r"(val));
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +static void etm4_config_core_commit(int cpu, int val)
>>>>>>>>>> +{
>>>>>>>>>> +    struct etm4_enable_arg arg = {0};
>>>>>>>>>> +
>>>>>>>>>> +    arg.rc = val;
>>>>>>>>>> +    smp_call_function_single(cpu, etm4_cpu_actlr1_cfg, &arg, 1);
>>>>>>>>> Function etm4_enable/disable_hw() are already running on the CPU they are
>>>>>>>>> supposed to so no need to call smp_call_function_single().
>>>>>>>>>
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>>     static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>>>>>>>>>>     {
>>>>>>>>>>        int i, rc;
>>>>>>>>>> +    struct amba_device *adev;
>>>>>>>>>>        struct etmv4_config *config = &drvdata->config;
>>>>>>>>>>        struct device *etm_dev = &drvdata->csdev->dev;
>>>>>>>>>> +    struct device *dev = drvdata->csdev->dev.parent;
>>>>>>>>>> +
>>>>>>>>>> +    adev = container_of(dev, struct amba_device, dev);
>>>>>>>>>> +    /*
>>>>>>>>>> +     * If ETM device is HiSilicon ETM device, reduce the
>>>>>>>>>> +     * core-commit to avoid ETM overflow.
>>>>>>>>>> +     */
>>>>>>>>>> +    if (adev->periphid == HISI_ETM_AMBA_ID_V1)
>>>>>>>> Please could you move this check to the function above ?
>>>>>>>> Ideally, it would be good to have something like :
>>>>>>>>
>>>>>>>>           etm4_config_impdef_features();
>>>>>>>>
>>>>>>>> And :
>>>>>>>>
>>>>>>>>           etm4_config_impdef_features(struct etm4_drvdata *drvdata)
>>>>>>>>           {
>>>>>>>>                   etm4_cpu_hisilicon_config_core_commit(drvdata);
>>>>>>>>           }
>>>>>>>>
>>>>>>> In addition to the above, Is it worth having this implementation
>>>>>>> defined code gated in the kernel configuration - like we do for core
>>>>>>> features sometimes?
>>>>>>> i,.e.
>>>>>>> CONFIG_ETM4X_IMPDEF_FEATURE (controls overall impdef support in the driver)
>>>>>>> and
>>>>>>> CONFIG_ETM4X_IMPDEF_HISILICON (depends on CONFIG_ETM4X_IMPDEF_FEATURE )
>>>>>>>
>>>>>>> This way we keep non ETM architectural code off platforms that cannot
>>>>>>> use it / test it.
>>>>>>>
>>>>>> That's a good idea - they do the same for CPU erratas.
>>>>>>    
>>>>> Considering that users sometimes use the same set of code on different platforms, how about
>>>>> using both CONFIG andperiphid to keep core-commit code off the platforms that do not
>>>>> need it?
>>>>> i, .e.
>>>>> CONFIG_ETM4X_IMPDEF_FEATURE ( controls overall impdef support in the driver )
>>>>> periphid ( match impdef code with the target platform )
>>>>>
>>>>> This way we could keep the same set of code working on different platforms, and it could help to
>>>>> ensure compatibility.
>>>>
>>>> I'm not 100% sure of what you mean by "same set of code working on different
>>>> platforms"...  Up to know the way we have been handling peripheral IDs has
>>>> worked quite well and I don't intend on changing it unless there is a really
>>>> good reason.
>>>>
>>> Hi Mathieu,
>>>
>>> Perhaps I didn't make it clear and here is the code to express what I mean:
>>>
>>> #ifdef CONFIG_ETM4X_IMPDEF_FEATURE
>>>
>>> #define HISI_HIP08_AMBA_ID        0x000b6d01
>>> #define HISI_HIP08_AMBA_MASK         0xfffff
>>> static void etm4_enable_arch_specific(struct etmv4_drvdata *drvdata)
>>> {
>>>       struct device *dev = drvdata->csdev->dev.parent;
>>>       struct amba_device *adev = container_of(dev, struct amba_device, dev);
>>
>> There is no guarantee that this is always an "AMBA" device, with this
>> patchset (which is still under review). Also, doing this check at
>> every time we enable/disable the ETM is not idea..
>>
>> May be we should add a concept of "features" and use a bit mask instead,
>> which can be set at probe time, where we do have this information.
>>
>> #define ETM4x_IMPDEF_HISILICON_CORE_COMMIT    0
>> #define ETM4x_IMPDEF_ARCH_N_FEATS        1
>>
>> struct etmv4_drvdata {
>>
>>      ...
>>      DECALRE_BITMAP(arch_features, ETM4x_IMPDEF_ARCH_FEAT_MAX);
>> }
>>
>> struct etm4x_arch_feature {
>>      void (*callback)(struct etmv4_drdvata *, bool enable);
>> };
>>
>> static struct etm4x_arch_features[] = {
>>      [ETM4x_IMPDEF_HISILICON_CORE_COMMIT] = {
>>          .callback = etm4x_hisilicon_core_commit,
>>      },
>>      {}
>> };
>>
>> static void etm4_enable_arch_specific(struct etmv4_drvdata *drvdata)
>> {
>>      for_each_set_bit(i, &drvdata->arch_features) {
>>          struct etm4x_arch_feature *ftr = &etm4x_arch_features[i];
>>
>>          if (ftr->callback)
>>              ftr->callback(drvdata, true);
>>      }
>> }
>>
>> etm4x_check_arch_features() {
>>      if (hisilicon_etm4x_match_pid)
>>          set_bit(drvdata->arch_features, ETM4x_IMPDEF_HISILICON_CORE_COMMIT);
>> }
>>
>> etm4x_probe() {
>>
>>      etm4x_check_arch_features();
>> }
>>
>> Suzuki
> 
> Hi Suzuki,
> 
> Add a check in probe is a good idea, and perhaps we could also add CONFIG_ETM4X_IMPDEF_FEATURE
> here, like:
>   etm4x_probe() {
>   ...
>   #ifdef CONFIG_ETM4X_IMPDEF_FEATURE
>       etm4x_check_arch_features();
>   #endif

Please make this unconditional and define the function conditionally, as below.


	etm4x_check_arch_features();
>   }

and :

#ifdef CONFIG_ETM4X_IMPDEF_FEATURE
static void etm4x_check_arch_features(struct etmv4_drvdata *drvdata, struct device *dev)
{

}

static void etm4x_enable_arch_specific(...)
{
.... do arch specific setup ...
}

#else
static inline void etm4x_check_arch_features(..)
{}
static void etm4x_enable_arch_specific(...)
{}
#endif


> 
> Thanks
> Qi
>>
>> .
>>
> 

