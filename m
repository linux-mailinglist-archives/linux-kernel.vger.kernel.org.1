Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B252D1569
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgLGQBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgLGQBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:01:34 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3060AC061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 08:00:54 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id i3so6833180pfd.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 08:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lM0WuLFezI4DgUVIv9tHFek9mZlL8JVIYtiPTuIe1i8=;
        b=kbfciW8e8c9iyJrhOcz17nhJT7qYBlGk+2u/n/iqhnv89bEa5UC9/Eg7M8JV0AHKtL
         P+22D6mGIRBKQ3E4jVWW+ee2L9iNRiie72mWT3+mnBdbz9J0GNy12tSn/FVTLErdtKSf
         exPhKr/Q13rphwK/XVwASyIhTDokUbrY2sY840Bqc8XgOrjOrik16SQclTjZ++wUBcqI
         amQPV+e2AInJbV+1S3arjvmuxun3mPpOVIA8AnuffExVIz7wFrTCL2lzMwHVZQbyBCV2
         1QLLZfVHpzixCH4AXc79AYhtoTqDqYBOBNgW2Op2NzRn9xkbJATvm1ZVb0Hn5Xy09XBt
         5EWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lM0WuLFezI4DgUVIv9tHFek9mZlL8JVIYtiPTuIe1i8=;
        b=ICW4OgF2vdGpN4YlmKY/+0nxKTGxiq4WOOMBXQCgMXIVQGdMac8gKWfgFuSgrqamlj
         /i75nAxI4+AAnbF2OWg495pXSevq0ZLaincKTt8eioh0NEuNg8F5O+EDhP1ysPccWQFJ
         tnHRWYHQlKVTERiI95pVP9uhweDjpwHGwWSyKUJVwdlYly8ECecykxwQ/jwKIX7gs2Kv
         VbyWmsVUm8yN4TFuKXBJ2VSwAJWmCasn1U+3VlHAtvN5BhKSpVNwMpAoYIG0Lo9sWC+E
         /H747BdawM7V1cMmLVmluj7EwwvdPOgIRqgqKORDfpSXhOZu2xJZAlU83+5A/Lw0HcGU
         0DVg==
X-Gm-Message-State: AOAM530oD6319B7xZO7ZrhlK4ZEgsgvxp+OHWEOKd5HD65E7ZepLHLGZ
        VRjtNnsxSgJJJYYmQHYJqApPZQ==
X-Google-Smtp-Source: ABdhPJyV4rYEnm55TXN93aP5Cqfz+sqaDms9fAkSfQdIJHYDMAGBBvylNH/P/lbMQZrVW+9O8adjjA==
X-Received: by 2002:a62:b50f:0:b029:19e:2974:b7a4 with SMTP id y15-20020a62b50f0000b029019e2974b7a4mr3023076pfe.61.1607356853504;
        Mon, 07 Dec 2020 08:00:53 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id gm2sm11296944pjb.35.2020.12.07.08.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 08:00:52 -0800 (PST)
Date:   Mon, 7 Dec 2020 09:00:51 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mike.leach@linaro.org
Subject: Re: [PATCH v5] coresight: etm4x: Modify core-commit of cpu to avoid
 the overflow of HiSilicon ETM
Message-ID: <20201207160051.GA1506562@xps15>
References: <1606397670-15657-1-git-send-email-liuqi115@huawei.com>
 <20201204185551.GB1424711@xps15>
 <448eb009-da3e-b918-984d-cf563a64f31d@huawei.com>
 <07243eef-dbcf-6500-a66b-5c0e1689ece9@arm.com>
 <0e56f56e-157e-ecf2-bb21-74b79ffdf2ac@huawei.com>
 <d82f1200-c31f-1040-a630-57e132cabf1b@arm.com>
 <6078c05c-273d-a9cb-6dcb-68009260a581@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6078c05c-273d-a9cb-6dcb-68009260a581@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 07:32:21PM +0800, Qi Liu wrote:
> 
> 
> On 2020/12/7 19:27, Suzuki K Poulose wrote:
> > On 12/7/20 11:21 AM, Qi Liu wrote:
> >>
> >> Hi Suzuki,
> >> On 2020/12/7 18:38, Suzuki K Poulose wrote:
> >>> On 12/7/20 2:08 AM, Qi Liu wrote:
> >>>> Hi Mathieu,
> >>>>
> >>>> On 2020/12/5 2:55, Mathieu Poirier wrote:
> >>>>> On Thu, Nov 26, 2020 at 09:34:30PM +0800, Qi Liu wrote:
> >>>>>> The ETM device can't keep up with the core pipeline when cpu core
> >>>>>> is at full speed. This may cause overflow within core and its ETM.
> >>>>>> This is a common phenomenon on ETM devices.
> >>>>>>
> >>>>>> On HiSilicon Hip08 platform, a specific feature is added to set
> >>>>>> core pipeline. So commit rate can be reduced manually to avoid ETM
> >>>>>> overflow.
> >>>>>>
> >>>>>> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> >>>>>> ---
> >>>>>> Change since v1:
> >>>>>> - add CONFIG_ETM4X_IMPDEF_FEATURE and CONFIG_ETM4X_IMPDEF_HISILICON
> >>>>>>     to keep specific feature off platforms which don't use it.
> >>>>>> Change since v2:
> >>>>>> - remove some unused variable.
> >>>>>> Change since v3:
> >>>>>> - use read/write_sysreg_s() to access register.
> >>>>>> Change since v4:
> >>>>>> - rename the call back function to a more generic name, and fix some
> >>>>>>     compile warnings.
> >>>>>>
> >>>>>>    drivers/hwtracing/coresight/Kconfig                |  9 +++
> >>>>>>    drivers/hwtracing/coresight/coresight-etm4x-core.c | 88 ++++++++++++++++++++++
> >>>>>>    drivers/hwtracing/coresight/coresight-etm4x.h      |  8 ++
> >>>>>>    3 files changed, 105 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> >>>>>> index c119824..1cc3601 100644
> >>>>>> --- a/drivers/hwtracing/coresight/Kconfig
> >>>>>> +++ b/drivers/hwtracing/coresight/Kconfig
> >>>>>> @@ -110,6 +110,15 @@ config CORESIGHT_SOURCE_ETM4X
> >>>>>>          To compile this driver as a module, choose M here: the
> >>>>>>          module will be called coresight-etm4x.
> >>>>>>
> >>>>>> +config ETM4X_IMPDEF_FEATURE
> >>>>>> +    bool "Control overflow impdef support in CoreSight ETM 4.x driver "
> >>>>>> +    depends on CORESIGHT_SOURCE_ETM4X
> >>>>>> +    help
> >>>>>> +      This control provides overflow implement define for CoreSight
> >>>>>> +      ETM 4.x tracer module which could not reduce commit race
> >>>>>> +      automatically, and could avoid overflow within ETM tracer module
> >>>>>> +      and its cpu core.
> >>>>>> +
> >>>>>>    config CORESIGHT_STM
> >>>>>>        tristate "CoreSight System Trace Macrocell driver"
> >>>>>>        depends on (ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64
> >>>>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >>>>>> index abd706b..fcee27a 100644
> >>>>>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >>>>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >>>>>> @@ -3,6 +3,7 @@
> >>>>>>     * Copyright (c) 2014, The Linux Foundation. All rights reserved.
> >>>>>>     */
> >>>>>>
> >>>>>> +#include <linux/bitops.h>
> >>>>>>    #include <linux/kernel.h>
> >>>>>>    #include <linux/moduleparam.h>
> >>>>>>    #include <linux/init.h>
> >>>>>> @@ -28,7 +29,9 @@
> >>>>>>    #include <linux/perf_event.h>
> >>>>>>    #include <linux/pm_runtime.h>
> >>>>>>    #include <linux/property.h>
> >>>>>> +
> >>>>>>    #include <asm/sections.h>
> >>>>>> +#include <asm/sysreg.h>
> >>>>>>    #include <asm/local.h>
> >>>>>>    #include <asm/virt.h>
> >>>>>>
> >>>>>> @@ -103,6 +106,87 @@ struct etm4_enable_arg {
> >>>>>>        int rc;
> >>>>>>    };
> >>>>>>
> >>>>>> +#ifdef CONFIG_ETM4X_IMPDEF_FEATURE
> >>>>>> +
> >>>>>> +#define HISI_HIP08_AMBA_ID        0x000b6d01
> >>>>>> +#define ETM4_AMBA_MASK            0xfffff
> >>>>>> +#define HISI_HIP08_CORE_COMMIT_CLEAR    0x3000
> >>>>>
> >>>>> Here bit 12 and 13 are cleared but in etm4_hisi_config_core_commit() only bit 12
> >>>>> is set - is this intentional?  What is bit 13 for?
> >>>>>
> >>>> bit 12 and 13 are used together to set core-commit, 2'b00 means cpu is at full speed,
> >>>> 2'b01, 2'b10, 2'b11 means reduce the speed of cpu pipeline, and 2'b01 means speed is
> >>>> reduced to minimum value. So bit 12 and 13 should be cleared together in
> >>>> etm4_hisi_config_core_commit().
> >>>
> >>> Please could you document this in the function.
> >>>
> >> of course, thanks.
> >>>>
> >>>> Qi
> >>>>
> >>>>>> +#define HISI_HIP08_CORE_COMMIT_SHIFT    12
> >>>>>> +#define HISI_HIP08_CORE_COMMIT_REG    sys_reg(3, 1, 15, 2, 5)
> >>>>>> +
> >>>>>> +struct etm4_arch_features {
> >>>>>> +    void (*arch_callback)(bool enable);
> >>>>>> +};
> >>>>>> +
> >>>>>> +static bool etm4_hisi_match_pid(unsigned int id)
> >>>>>> +{
> >>>>>> +    return (id & ETM4_AMBA_MASK) == HISI_HIP08_AMBA_ID;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void etm4_hisi_config_core_commit(bool enable)
> >>>>>> +{
> >>>>>> +    u64 val;
> >>>>>> +
> >>>>>> +    val = read_sysreg_s(HISI_HIP08_CORE_COMMIT_REG);
> >>>>>> +    val &= ~HISI_HIP08_CORE_COMMIT_CLEAR;
> >>>>>> +    val |= enable << HISI_HIP08_CORE_COMMIT_SHIFT;
> >>>
> >>> I would use the explicitly masked values when you update
> >>> a register.
> >>>
> >> ok, how about changing these code to this:
> >> val &= ~GENMASK(12, 13);
> > 
> > I would do :
> > 
> > // Rename the HISI_HIP08_CORE_COMMIT_CLEAR to HISI_HIP08_CORE_COMMIT_MASK
> > // above.
> > #define HISI_HIP08_CORE_COMMIT_MASK        0x3000
> > 
> > #define HISI_HIP08_CORE_COMMIT_FULL        0b00
> > #define HISI_HIP08_CORE_COMMIT_LVL_1        0b01
> > 
> > 
> > u8 commit = enable ? HISI_HIP08_CORE_COMMIT_LVL_1 : HISI_HIP08_CORE_COMMIT_FULL;
> > 
> > ...
> > 
> > val |= commit << HISI_HIP08_CORE_COMMIT_SHIFT;
> > 
> > ..
> > 
> > 
> > Suzuki
> > 
> > .
> ok, I'll send a new version. :)
> 

Please do so by tomorrow morning (North America time) if you want to see this
going in the v5.11 merge window.  Otherwise it will be another 3 months.

> Thanks
> Qi
> > 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
