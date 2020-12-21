Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E072DFD75
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 16:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgLUPXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 10:23:13 -0500
Received: from foss.arm.com ([217.140.110.172]:51678 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgLUPXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 10:23:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6AFC1FB;
        Mon, 21 Dec 2020 07:22:26 -0800 (PST)
Received: from [10.57.34.90] (unknown [10.57.34.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4323C3F6CF;
        Mon, 21 Dec 2020 07:22:25 -0800 (PST)
Subject: Re: [PATCH 1/3] iommu/io-pgtable-arm: Prepare for modularization
To:     isaacm@codeaurora.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, joro@8bytes.org, pdaly@codeaurora.org,
        pratikp@codeaurora.org, kernel-team@android.com
References: <1608280722-19841-1-git-send-email-isaacm@codeaurora.org>
 <1608280722-19841-2-git-send-email-isaacm@codeaurora.org>
 <309ff39d-5fc5-83c6-d423-2d66f503c60c@arm.com>
 <34ea1af8569e4115e2dd1de61ae95bb6@codeaurora.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <370f7c90-a3e3-57d9-1830-8abe5134e004@arm.com>
Date:   Mon, 21 Dec 2020 15:22:17 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <34ea1af8569e4115e2dd1de61ae95bb6@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-18 18:59, isaacm@codeaurora.org wrote:
> On 2020-12-18 04:38, Robin Murphy wrote:
>> On 2020-12-18 08:38, Isaac J. Manjarres wrote:
>>> The io-pgtable-arm and io-pgtable-arm-v7s source files will
>>> be compiled as separate modules, along with the io-pgtable
>>> source. Export the symbols for the io-pgtable init function
>>> structures for the io-pgtable module to use.
>>
>> In my current build tree, the io-pgtable glue itself is a whopping 379
>> bytes of code and data - is there really any benefit to all the
>> additional overhead of making that modular? Given the number of
>> different users (including AMD now), I think at this point we should
>> start considering this as part of the IOMMU core, and just tweak the
>> interface such that formats can register their own init_fns
>> dynamically instead of the static array that's always horrible.
>>
>> Robin.
>>
> Thanks for the feedback, Robin. This is an avenue I had explored a bit 
> when modularizing the code. However,
> I came up with a few problems that I couldn't get around.
> 
> 1) If we leave the io-pgtable glue as part of the core kernel, we need 
> to ensure that the io-pgtable format
> modules get loaded prior to any driver that might use them (e.g. IOMMU 
> drivers/other callers of alloc_io_pgtable_ops).
>      a) This can get a bit messy, as there's no symbol dependencies 
> between the callers of the io-pgtable
>         code, and the page table format modules, since everything is 
> through function pointers. This is handled
>         for the IOMMU drivers through the devlink feature, but I don't 
> see how we can leverage something like that
>         here. I guess this isn't too much of a problem when everything 
> is built-in, as the registration can happen
>         in one of the earlier initcall levels.
> 
>      b) If we do run into a scenario where a client of io-pgtable tries 
> to allocate a page table instance prior
>         to the io-pgtable format module being loaded, I couldn't come up 
> with a way of distinguishing between
>         format module is not available at the moment vs  format module 
> will never be available. I don't think
>         returning EPROBE_DEFER would be something nice to do in that case.

Urgh, I see... yes, the current approach does work out as an 
unexpectedly neat way to avoid many of the pitfalls. However I'm not 
sure it actually avoids all of them - say you have a config like this:

IPMMU_VMSA=y
-> IO_PGTABLE_ARM_LPAE=y
    -> IO_PGTABLE=y
MTK_IOMMU=m
-> IO_PGTABLE_ARMV7S=m

won't that still fail to link io-pgtable.o?

> 2) We would have to ensure that the format module cannot be unloaded 
> while other clients are using it. I suppose
> this isn't as big as point #1 though, since it's something that can 
> probably be handled through a similar ref count
> mechanism that we're using for modular IOMMU drivers.

FWIW I think that would come out in the wash from resolving 1b - I'd 
assume there would have to be some sort of module_get() in there 
somewhere. I should probably go and look at how the crypto API handles 
its modular algorithms for more inspiration...

> Given the two reasons above, I went with the current approach, since it 
> avoids both issues by creating symbol dependencies
> between client drivers, the io-pgtable drivers, and the io-pgtable 
> format drivers, so that ensures that they are loaded
> in the correct order, and also prevents them from being removed, unless 
> there aren't any users present.

Having thought all that over, I'm now wondering what we really gain from 
this either way - if vendors can build and ship SoC-tailored configs, 
then they can already turn off formats they don't care about. If the aim 
is to ship a single config everywhere, then you'll still have to 
provision and load all possible formats on any system that needs any one 
of them, thanks to those "convenient" symbol dependencies. The promise 
in the cover letter doesn't seem to materialise :/

Robin.

> 
> Thanks,
> Isaac
>>> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
>>> ---
>>>   drivers/iommu/io-pgtable-arm-v7s.c | 4 ++++
>>>   drivers/iommu/io-pgtable-arm.c     | 8 ++++++++
>>>   2 files changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c 
>>> b/drivers/iommu/io-pgtable-arm-v7s.c
>>> index 1d92ac9..f062c1c 100644
>>> --- a/drivers/iommu/io-pgtable-arm-v7s.c
>>> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
>>> @@ -28,6 +28,7 @@
>>>   #include <linux/iommu.h>
>>>   #include <linux/kernel.h>
>>>   #include <linux/kmemleak.h>
>>> +#include <linux/module.h>
>>>   #include <linux/sizes.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/spinlock.h>
>>> @@ -839,6 +840,7 @@ struct io_pgtable_init_fns 
>>> io_pgtable_arm_v7s_init_fns = {
>>>       .alloc    = arm_v7s_alloc_pgtable,
>>>       .free    = arm_v7s_free_pgtable,
>>>   };
>>> +EXPORT_SYMBOL_GPL(io_pgtable_arm_v7s_init_fns);
>>>     #ifdef CONFIG_IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
>>>   @@ -984,3 +986,5 @@ static int __init arm_v7s_do_selftests(void)
>>>   }
>>>   subsys_initcall(arm_v7s_do_selftests);
>>>   #endif
>>> +
>>> +MODULE_LICENSE("GPL v2");
>>> diff --git a/drivers/iommu/io-pgtable-arm.c 
>>> b/drivers/iommu/io-pgtable-arm.c
>>> index 87def58..2623d57 100644
>>> --- a/drivers/iommu/io-pgtable-arm.c
>>> +++ b/drivers/iommu/io-pgtable-arm.c
>>> @@ -13,6 +13,7 @@
>>>   #include <linux/bitops.h>
>>>   #include <linux/io-pgtable.h>
>>>   #include <linux/kernel.h>
>>> +#include <linux/module.h>
>>>   #include <linux/sizes.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/types.h>
>>> @@ -1047,26 +1048,31 @@ struct io_pgtable_init_fns 
>>> io_pgtable_arm_64_lpae_s1_init_fns = {
>>>       .alloc    = arm_64_lpae_alloc_pgtable_s1,
>>>       .free    = arm_lpae_free_pgtable,
>>>   };
>>> +EXPORT_SYMBOL_GPL(io_pgtable_arm_64_lpae_s1_init_fns);
>>>     struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns = {
>>>       .alloc    = arm_64_lpae_alloc_pgtable_s2,
>>>       .free    = arm_lpae_free_pgtable,
>>>   };
>>> +EXPORT_SYMBOL_GPL(io_pgtable_arm_64_lpae_s2_init_fns);
>>>     struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s1_init_fns = {
>>>       .alloc    = arm_32_lpae_alloc_pgtable_s1,
>>>       .free    = arm_lpae_free_pgtable,
>>>   };
>>> +EXPORT_SYMBOL_GPL(io_pgtable_arm_32_lpae_s1_init_fns);
>>>     struct io_pgtable_init_fns io_pgtable_arm_32_lpae_s2_init_fns = {
>>>       .alloc    = arm_32_lpae_alloc_pgtable_s2,
>>>       .free    = arm_lpae_free_pgtable,
>>>   };
>>> +EXPORT_SYMBOL_GPL(io_pgtable_arm_32_lpae_s2_init_fns);
>>>     struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
>>>       .alloc    = arm_mali_lpae_alloc_pgtable,
>>>       .free    = arm_lpae_free_pgtable,
>>>   };
>>> +EXPORT_SYMBOL_GPL(io_pgtable_arm_mali_lpae_init_fns);
>>>     #ifdef CONFIG_IOMMU_IO_PGTABLE_LPAE_SELFTEST
>>>   @@ -1252,3 +1258,5 @@ static int __init arm_lpae_do_selftests(void)
>>>   }
>>>   subsys_initcall(arm_lpae_do_selftests);
>>>   #endif
>>> +
>>> +MODULE_LICENSE("GPL v2");
>>>
