Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CAA2E0399
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 01:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgLVAzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 19:55:55 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:39613 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLVAzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 19:55:55 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608598534; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=YK/eYV9zEDRtsog1iTnXgmXquyS/SZNGMqbSGrb3cWg=;
 b=LZ6C9/StismQA03aG1kc9tJEv9Up2D0usPVobPpkfiPuSn9JpQgEd4K5qcO99N1uhsybqF+8
 oORSCKqkYMXbVUZz6sY6kXWOwT0TEDUukw3SwGHvKZf2euIYpEJKVG7F7yg9trEKaFMT/OKF
 rVqSpaYcCyTXwmhIoRHrR27EEyo=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5fe143de6d2f42c6668f2590 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Dec 2020 00:54:54
 GMT
Sender: isaacm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8B7A8C43463; Tue, 22 Dec 2020 00:54:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 09C31C433CA;
        Tue, 22 Dec 2020 00:54:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 21 Dec 2020 16:54:52 -0800
From:   isaacm@codeaurora.org
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, joro@8bytes.org, pdaly@codeaurora.org,
        pratikp@codeaurora.org, kernel-team@android.com
Subject: Re: [PATCH 1/3] iommu/io-pgtable-arm: Prepare for modularization
In-Reply-To: <370f7c90-a3e3-57d9-1830-8abe5134e004@arm.com>
References: <1608280722-19841-1-git-send-email-isaacm@codeaurora.org>
 <1608280722-19841-2-git-send-email-isaacm@codeaurora.org>
 <309ff39d-5fc5-83c6-d423-2d66f503c60c@arm.com>
 <34ea1af8569e4115e2dd1de61ae95bb6@codeaurora.org>
 <370f7c90-a3e3-57d9-1830-8abe5134e004@arm.com>
Message-ID: <c35a517f25d88212ef4a14fdbef5f035@codeaurora.org>
X-Sender: isaacm@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-21 07:22, Robin Murphy wrote:
> On 2020-12-18 18:59, isaacm@codeaurora.org wrote:
>> On 2020-12-18 04:38, Robin Murphy wrote:
>>> On 2020-12-18 08:38, Isaac J. Manjarres wrote:
>>>> The io-pgtable-arm and io-pgtable-arm-v7s source files will
>>>> be compiled as separate modules, along with the io-pgtable
>>>> source. Export the symbols for the io-pgtable init function
>>>> structures for the io-pgtable module to use.
>>> 
>>> In my current build tree, the io-pgtable glue itself is a whopping 
>>> 379
>>> bytes of code and data - is there really any benefit to all the
>>> additional overhead of making that modular? Given the number of
>>> different users (including AMD now), I think at this point we should
>>> start considering this as part of the IOMMU core, and just tweak the
>>> interface such that formats can register their own init_fns
>>> dynamically instead of the static array that's always horrible.
>>> 
>>> Robin.
>>> 
>> Thanks for the feedback, Robin. This is an avenue I had explored a bit 
>> when modularizing the code. However,
>> I came up with a few problems that I couldn't get around.
>> 
>> 1) If we leave the io-pgtable glue as part of the core kernel, we need 
>> to ensure that the io-pgtable format
>> modules get loaded prior to any driver that might use them (e.g. IOMMU 
>> drivers/other callers of alloc_io_pgtable_ops).
>>      a) This can get a bit messy, as there's no symbol dependencies 
>> between the callers of the io-pgtable
>>         code, and the page table format modules, since everything is 
>> through function pointers. This is handled
>>         for the IOMMU drivers through the devlink feature, but I don't 
>> see how we can leverage something like that
>>         here. I guess this isn't too much of a problem when everything 
>> is built-in, as the registration can happen
>>         in one of the earlier initcall levels.
>> 
>>      b) If we do run into a scenario where a client of io-pgtable 
>> tries to allocate a page table instance prior
>>         to the io-pgtable format module being loaded, I couldn't come 
>> up with a way of distinguishing between
>>         format module is not available at the moment vs  format module 
>> will never be available. I don't think
>>         returning EPROBE_DEFER would be something nice to do in that 
>> case.
> 
> Urgh, I see... yes, the current approach does work out as an
> unexpectedly neat way to avoid many of the pitfalls. However I'm not
> sure it actually avoids all of them - say you have a config like this:
> 
> IPMMU_VMSA=y
> -> IO_PGTABLE_ARM_LPAE=y
>    -> IO_PGTABLE=y
> MTK_IOMMU=m
> -> IO_PGTABLE_ARMV7S=m
> 
> won't that still fail to link io-pgtable.o?
> 
Yes, you are correct, that would be problematic.
>> 2) We would have to ensure that the format module cannot be unloaded 
>> while other clients are using it. I suppose
>> this isn't as big as point #1 though, since it's something that can 
>> probably be handled through a similar ref count
>> mechanism that we're using for modular IOMMU drivers.
> 
> FWIW I think that would come out in the wash from resolving 1b - I'd
> assume there would have to be some sort of module_get() in there
> somewhere. I should probably go and look at how the crypto API handles
> its modular algorithms for more inspiration...
So I looked through the crypto dir, and it seems like they--along with a 
few other kernel drivers--are using MODULE_SOFTDEP()
to sort out these dependencies.
> 
>> Given the two reasons above, I went with the current approach, since 
>> it avoids both issues by creating symbol dependencies
>> between client drivers, the io-pgtable drivers, and the io-pgtable 
>> format drivers, so that ensures that they are loaded
>> in the correct order, and also prevents them from being removed, 
>> unless there aren't any users present.
> 
> Having thought all that over, I'm now wondering what we really gain
> from this either way - if vendors can build and ship SoC-tailored
> configs, then they can already turn off formats they don't care about.
> If the aim is to ship a single config everywhere, then you'll still
> have to provision and load all possible formats on any system that
> needs any one of them, thanks to those "convenient" symbol
> dependencies. The promise in the cover letter doesn't seem to
> materialise :/
> 
> Robin.
> 
Given the feedback, this makes sense. I've come up with a second version 
of the patches that leaves
the io-pgtable code in the kernel, and allows the formats to be modules, 
which better achieves what
the cover-letter is trying to express :) I believe that with the second 
patch, we should be able to
get to a place where the kernel just needs to provide io-pgtable, while 
vendors can provide either
io-pgtable-arm or io-pgtable-arm-v7s or both, as needed.
Here are the patches: 
https://lore.kernel.org/linux-iommu/1608597876-32367-1-git-send-email-isaacm@codeaurora.org/T/#t

Thanks,
Isaac
>> 
>> Thanks,
>> Isaac
>>>> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
>>>> ---
>>>>   drivers/iommu/io-pgtable-arm-v7s.c | 4 ++++
>>>>   drivers/iommu/io-pgtable-arm.c     | 8 ++++++++
>>>>   2 files changed, 12 insertions(+)
>>>> 
>>>> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c 
>>>> b/drivers/iommu/io-pgtable-arm-v7s.c
>>>> index 1d92ac9..f062c1c 100644
>>>> --- a/drivers/iommu/io-pgtable-arm-v7s.c
>>>> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
>>>> @@ -28,6 +28,7 @@
>>>>   #include <linux/iommu.h>
>>>>   #include <linux/kernel.h>
>>>>   #include <linux/kmemleak.h>
>>>> +#include <linux/module.h>
>>>>   #include <linux/sizes.h>
>>>>   #include <linux/slab.h>
>>>>   #include <linux/spinlock.h>
>>>> @@ -839,6 +840,7 @@ struct io_pgtable_init_fns 
>>>> io_pgtable_arm_v7s_init_fns = {
>>>>       .alloc    = arm_v7s_alloc_pgtable,
>>>>       .free    = arm_v7s_free_pgtable,
>>>>   };
>>>> +EXPORT_SYMBOL_GPL(io_pgtable_arm_v7s_init_fns);
>>>>     #ifdef CONFIG_IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
>>>>   @@ -984,3 +986,5 @@ static int __init arm_v7s_do_selftests(void)
>>>>   }
>>>>   subsys_initcall(arm_v7s_do_selftests);
>>>>   #endif
>>>> +
>>>> +MODULE_LICENSE("GPL v2");
>>>> diff --git a/drivers/iommu/io-pgtable-arm.c 
>>>> b/drivers/iommu/io-pgtable-arm.c
>>>> index 87def58..2623d57 100644
>>>> --- a/drivers/iommu/io-pgtable-arm.c
>>>> +++ b/drivers/iommu/io-pgtable-arm.c
>>>> @@ -13,6 +13,7 @@
>>>>   #include <linux/bitops.h>
>>>>   #include <linux/io-pgtable.h>
>>>>   #include <linux/kernel.h>
>>>> +#include <linux/module.h>
>>>>   #include <linux/sizes.h>
>>>>   #include <linux/slab.h>
>>>>   #include <linux/types.h>
>>>> @@ -1047,26 +1048,31 @@ struct io_pgtable_init_fns 
>>>> io_pgtable_arm_64_lpae_s1_init_fns = {
>>>>       .alloc    = arm_64_lpae_alloc_pgtable_s1,
>>>>       .free    = arm_lpae_free_pgtable,
>>>>   };
>>>> +EXPORT_SYMBOL_GPL(io_pgtable_arm_64_lpae_s1_init_fns);
>>>>     struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns = 
>>>> {
>>>>       .alloc    = arm_64_lpae_alloc_pgtable_s2,
>>>>       .free    = arm_lpae_free_pgtable,
>>>>   };
>>>> +EXPORT_SYMBOL_GPL(io_pgtable_arm_64_lpae_s2_init_fns);
>>>>     struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s1_init_fns = 
>>>> {
>>>>       .alloc    = arm_32_lpae_alloc_pgtable_s1,
>>>>       .free    = arm_lpae_free_pgtable,
>>>>   };
>>>> +EXPORT_SYMBOL_GPL(io_pgtable_arm_32_lpae_s1_init_fns);
>>>>     struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s2_init_fns = 
>>>> {
>>>>       .alloc    = arm_32_lpae_alloc_pgtable_s2,
>>>>       .free    = arm_lpae_free_pgtable,
>>>>   };
>>>> +EXPORT_SYMBOL_GPL(io_pgtable_arm_32_lpae_s2_init_fns);
>>>>     struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
>>>>       .alloc    = arm_mali_lpae_alloc_pgtable,
>>>>       .free    = arm_lpae_free_pgtable,
>>>>   };
>>>> +EXPORT_SYMBOL_GPL(io_pgtable_arm_mali_lpae_init_fns);
>>>>     #ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST
>>>>   @@ -1252,3 +1258,5 @@ static int __init 
>>>> arm_lpae_do_selftests(void)
>>>>   }
>>>>   subsys_initcall(arm_lpae_do_selftests);
>>>>   #endif
>>>> +
>>>> +MODULE_LICENSE("GPL v2");
>>>> 
