Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DDF2AF71D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 18:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbgKKRDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 12:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgKKRDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 12:03:49 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEC7C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 09:03:48 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id ie6so997082pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 09:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VnerPPbUmuZFnp4YYpn03IqKxLwo6asabfmmClFT9fk=;
        b=WV+GTPvFQ7e3vbRuV5ZZANRijLqIYm0YiHShoPdzRxVt1Lmzk7j5RUVtHq+Wcy/B5h
         Uc/q0OUxmcoVWNMYBEXrzSvGznyzTH5HLSZsZqDT0NG22F97q2gkH5/W/lgnjvsHruYK
         kI74xkK0HhKAW57v750IM4SHmk2uZMjgKpwJKt0E7RfVQIZoG5lJQ0MlrrNUBkX3PpCr
         QFIE7mhirI3rMItUo+KrUg48K1QjuYBd+2zjVrGtSNNCXmZ2GVwmpXiJa0zOdp6D7jcI
         vdFWFei2dcaVg+B4TloKPhQ3zSp3dCJFHah0jVZTTstXWuBvFkMiYH5SCuudtnxm01Bs
         u88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VnerPPbUmuZFnp4YYpn03IqKxLwo6asabfmmClFT9fk=;
        b=iDcnZVeLb6ewRvpDmgoRXOuAW16TPv8QKBvtniXJFk/6DLTqUkLTrLqfxJlihfvLoY
         XIWWTFLIRLtmOHRkbLM4fwMcDG52SO4btjEmxTevmN32XrPyW3yl2U3QtQOqYrSNB8iH
         fZOuFGZWyVlAXXHEkYAKgPVDVisNGj2hfcgKSk+Xi5koDWZ9V0LRL+fISr42EMusJATL
         qzT1iQBT5FF4CYekQPGKUUkmJohh264Y/9UlqG4m3oxM3ftefN8IAsMb43WS9Jg3kLjB
         1forBdyaHMcCJudVstGvYS6qcs/iviy67CB3ZH7yzltocBI0D2nncXF8GZj/4d6Jmaq2
         61Og==
X-Gm-Message-State: AOAM5320DAqJ/nbJw1ou53uxU4KdtrUFwYCLRP7LWCdUVIm0+098cioG
        h7ufK3RtUB/nfg+90wamwUaM8UQS46Odkw==
X-Google-Smtp-Source: ABdhPJzMIueM3OdQv8L2EhKMPoPcWp2op5c3osuDjN0EKyHBe2PUm5Sv7oENl27mjVONM0KVpHjIMQ==
X-Received: by 2002:a17:902:d90d:b029:d6:ecf9:c1dd with SMTP id c13-20020a170902d90db02900d6ecf9c1ddmr21742544plz.13.1605114228419;
        Wed, 11 Nov 2020 09:03:48 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z16sm3317771pfq.179.2020.11.11.09.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 09:03:47 -0800 (PST)
Date:   Wed, 11 Nov 2020 10:03:45 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxarm@huawei.com, Coresight ML <coresight@lists.linaro.org>
Subject: Re: [RFC PATCH v2] coresight: etm4x: Modify core-commit of cpu to
 avoid the overflow of HiSilicon ETM
Message-ID: <20201111170345.GA3543438@xps15>
References: <1597824397-29894-1-git-send-email-liuqi115@huawei.com>
 <20200827204426.GD22307@xps15>
 <548c973d-6964-ca5c-4c8d-fbc2386f3349@arm.com>
 <CAJ9a7Vh8r4q8sCJnOdrrONZpM42QNbMpZGiebXs-mGW=MgmM3Q@mail.gmail.com>
 <20200909162605.GB553266@xps15>
 <70f83c48-5a4e-5d4d-734f-105501d21a63@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70f83c48-5a4e-5d4d-734f-105501d21a63@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 04:58:23PM +0800, Qi Liu wrote:
> Hi Mathieu,
> 
> On 2020/9/10 0:26, Mathieu Poirier wrote:
> > On Wed, Sep 09, 2020 at 12:30:02PM +0100, Mike Leach wrote:
> >> Hi,
> >>
> >> On Wed, 2 Sep 2020 at 11:36, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >>> On 08/27/2020 09:44 PM, Mathieu Poirier wrote:
> >>>> Hi Liu,
> >>>>
> >>>> On Wed, Aug 19, 2020 at 04:06:37PM +0800, Qi Liu wrote:
> >>>>> When too much trace information is generated on-chip, the ETM will
> >>>>> overflow, and cause data loss. This is a common phenomenon on ETM
> >>>>> devices.
> >>>>>
> >>>>> But sometimes we do not want to lose performance trace data, so we
> >>>>> suppress the speed of instructions sent from CPU core to ETM to
> >>>>> avoid the overflow of ETM.
> >>>>>
> >>>>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> >>>>> ---
> >>>>>
> >>>>> Changes since v1:
> >>>>> - ETM on HiSilicon Hip09 platform supports backpressure, so does
> >>>>> not need to modify core commit.
> >>>>>
> >>>>>   drivers/hwtracing/coresight/coresight-etm4x.c | 43 +++++++++++++++++++++++++++
> >>>>>   1 file changed, 43 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> >>>>> index 7797a57..7641f89 100644
> >>>>> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> >>>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> >>>>> @@ -43,6 +43,10 @@ MODULE_PARM_DESC(boot_enable, "Enable tracing on boot");
> >>>>>   #define PARAM_PM_SAVE_NEVER          1 /* never save any state */
> >>>>>   #define PARAM_PM_SAVE_SELF_HOSTED 2 /* save self-hosted state only */
> >>>>>
> >>>>> +#define CORE_COMMIT_CLEAR   0x3000
> >>>>> +#define CORE_COMMIT_SHIFT   12
> >>>>> +#define HISI_ETM_AMBA_ID_V1 0x000b6d01
> >>>>> +
> >>>>>   static int pm_save_enable = PARAM_PM_SAVE_FIRMWARE;
> >>>>>   module_param(pm_save_enable, int, 0444);
> >>>>>   MODULE_PARM_DESC(pm_save_enable,
> >>>>> @@ -104,11 +108,40 @@ struct etm4_enable_arg {
> >>>>>      int rc;
> >>>>>   };
> >>>>>
> >>>>> +static void etm4_cpu_actlr1_cfg(void *info)
> >>>>> +{
> >>>>> +    struct etm4_enable_arg *arg = (struct etm4_enable_arg *)info;
> >>>>> +    u64 val;
> >>>>> +
> >>>>> +    asm volatile("mrs %0,s3_1_c15_c2_5" : "=r"(val));
> >>>
> >>> The ID register (S3_1_C15_c2_5) falls into implementation defined space.
> >>> See Arm ARM DDI 0487F.a, section "D12.3.2  Reserved encodings for
> >>> IMPLEMENTATION DEFINED registers".
> >>>
> >>> So, please stop calling this "etm4_cpu_actlr1_cfg". Since,
> >>> 1) actlr1 is not an architected name for the said encoding
> >>> 2) The id register could mean something else on another CPU.
> >>>
> >>> Rather this should indicate platform/CPU specific. e.g,
> >>>
> >>> etm4_cpu_hisilicon_config_core_commit()
> >>>
> >>>
> >>>>> +    val &= ~CORE_COMMIT_CLEAR;
> >>>>> +    val |= arg->rc << CORE_COMMIT_SHIFT;
> >>>>> +    asm volatile("msr s3_1_c15_c2_5,%0" : : "r"(val));
> >>>>> +}
> >>>>> +
> >>>>> +static void etm4_config_core_commit(int cpu, int val)
> >>>>> +{
> >>>>> +    struct etm4_enable_arg arg = {0};
> >>>>> +
> >>>>> +    arg.rc = val;
> >>>>> +    smp_call_function_single(cpu, etm4_cpu_actlr1_cfg, &arg, 1);
> >>>> Function etm4_enable/disable_hw() are already running on the CPU they are
> >>>> supposed to so no need to call smp_call_function_single().
> >>>>
> >>>>> +}
> >>>>> +
> >>>>>   static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
> >>>>>   {
> >>>>>      int i, rc;
> >>>>> +    struct amba_device *adev;
> >>>>>      struct etmv4_config *config = &drvdata->config;
> >>>>>      struct device *etm_dev = &drvdata->csdev->dev;
> >>>>> +    struct device *dev = drvdata->csdev->dev.parent;
> >>>>> +
> >>>>> +    adev = container_of(dev, struct amba_device, dev);
> >>>>> +    /*
> >>>>> +     * If ETM device is HiSilicon ETM device, reduce the
> >>>>> +     * core-commit to avoid ETM overflow.
> >>>>> +     */
> >>>>> +    if (adev->periphid == HISI_ETM_AMBA_ID_V1)
> >>> Please could you move this check to the function above ?
> >>> Ideally, it would be good to have something like :
> >>>
> >>>         etm4_config_impdef_features();
> >>>
> >>> And :
> >>>
> >>>         etm4_config_impdef_features(struct etm4_drvdata *drvdata)
> >>>         {
> >>>                 etm4_cpu_hisilicon_config_core_commit(drvdata);
> >>>         }
> >>>
> >> In addition to the above, Is it worth having this implementation
> >> defined code gated in the kernel configuration - like we do for core
> >> features sometimes?
> >> i,.e.
> >> CONFIG_ETM4X_IMPDEF_FEATURE (controls overall impdef support in the driver)
> >> and
> >> CONFIG_ETM4X_IMPDEF_HISILICON (depends on CONFIG_ETM4X_IMPDEF_FEATURE )
> >>
> >> This way we keep non ETM architectural code off platforms that cannot
> >> use it / test it.
> >>
> > That's a good idea - they do the same for CPU erratas.
> >  
> Considering that users sometimes use the same set of code on different platforms, how about
> using both CONFIG andperiphid to keep core-commit code off the platforms that do not
> need it?
> i, .e.
> CONFIG_ETM4X_IMPDEF_FEATURE ( controls overall impdef support in the driver )
> periphid ( match impdef code with the target platform )
> 
> This way we could keep the same set of code working on different platforms, and it could help to
> ensure compatibility.

I'm not 100% sure of what you mean by "same set of code working on different
platforms"...  Up to know the way we have been handling peripheral IDs has
worked quite well and I don't intend on changing it unless there is a really
good reason.

> I'll update this patch if this solution is ok : )
> 
> Thanks!
> Qi
> >>>> Do you have any documentation on this back pressure feature?  I doubt this is
> >>>> specific to Hip09 platform and as such would prefer to have a more generic
> >>>> approach that works on any platform that supports it.
> >>>>
> >>>> Anyone on the CS mailing list that knows what this is about?
> >>> I believe this is hisilicon specific. May be same across their CPUs, may
> >>> be a specific one. There is no architectural guarantee.
> >>>
> >> This could be an implementation of the feature provided by the
> >> TRCSTALLCTRL register - which allows PE to be stalled in response to
> >> the ETM fifos approaching overflow.
> >> At present we do nothing with this feature as we have yet to see a
> >> target with it implemented, but if this is the case then it is an
> >> ETMv4 architectural feature that could be added into the main driver
> >> code,  with use/access gated by the relevent TRCIDR bit.
> >>
> >> Regards
> >>
> >> Mike
> >>
> >>
> >>> Cheers
> >>> Suzuki
> >>
> >>
> >> -- 
> >> Mike Leach
> >> Principal Engineer, ARM Ltd.
> >> Manchester Design Centre. UK
> > .
> >
> 
