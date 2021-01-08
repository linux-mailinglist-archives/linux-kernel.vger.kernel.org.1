Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925CD2EEAAA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 02:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbhAHBCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 20:02:36 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:10177 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729465AbhAHBCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 20:02:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610067729; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=dbsm8/aih8VCnhwROeQT2N7lmz3pLdZStOCEwis9cyU=;
 b=cE9pZVxnDPlEKt6gOMvp+aUdI+Ywgu2TjOqGAFgK3Ovp947e5bz/Dr/+ZMQ2cVPsBd0YX6t6
 +ecdRXK4bgjHv1VDIAL706BPOiMGV6WlCyFP/lJNeWKjyVO8J7I+Xc8D+PeWJHbmh5G619T8
 WUQ77Gk85+BE4ZGto2ZMbr0Tqfs=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5ff7aef4b95fc5932684ff12 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 08 Jan 2021 01:01:40
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C4631C43461; Fri,  8 Jan 2021 01:01:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 07AAFC433CA;
        Fri,  8 Jan 2021 01:01:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 07 Jan 2021 17:01:38 -0800
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Pratik Patel <pratikp@codeaurora.org>
Subject: Re: [PATCH 1/1] arm64: make section size configurable for memory
 hotplug
In-Reply-To: <055b0aca-af60-12ad-cd68-e15440ade64b@arm.com>
References: <cover.1609895500.git.sudaraja@codeaurora.org>
 <66f79b0c06602c22df4da8ff4a5c2b97c9275250.1609895500.git.sudaraja@codeaurora.org>
 <055b0aca-af60-12ad-cd68-e15440ade64b@arm.com>
Message-ID: <02c46a213b2a1eb6f86c83145f37fd2a@codeaurora.org>
X-Sender: sudaraja@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-05 22:11, Anshuman Khandual wrote:

Hello Anshuman, thanks for your response.


(+ Will)

> Hi Sudershan,
> 
> This patch (and the cover letter) does not copy LAKML even though the
> entire change here is arm64 specific. Please do copy all applicable
> mailing lists for a given patch.

I used ./scripts/get_maintainer.pl patch.patch to get the maintainers 
list. It somehow didn't mention LAKML. I've added the mailing list to 
this thread.

> 
> On 1/6/21 6:58 AM, Sudarshan Rajagopalan wrote:
>> Currently on arm64, memory section size is hard-coded to 1GB.
>> Make this configurable if memory-hotplug is enabled, to support
>> more finer granularity for hotplug-able memory.
> 
> Section size has always been decided by the platform. It cannot be a
> configurable option because the user would not know the constraints
> for memory representation on the platform and besides it also cannot
> be trusted.
> 
>> 
>> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
>> ---
>>  arch/arm64/Kconfig                 | 11 +++++++++++
>>  arch/arm64/include/asm/sparsemem.h |  4 ++++
>>  2 files changed, 15 insertions(+)
>> 
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 6d232837cbee..34124eee65da 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -294,6 +294,17 @@ config ARCH_ENABLE_MEMORY_HOTREMOVE
>>  config SMP
>>  	def_bool y
>> 
>> +config HOTPLUG_SIZE_BITS
>> +	int "Memory hotplug block size(29 => 512MB 30 => 1GB)"
>> +	depends on SPARSEMEM
>> +	depends on MEMORY_HOTPLUG
>> +	range 28 30
> 
> 28 would not work for 64K pages.
> 
>> +	default 30
>> +	help
>> +	 Selects granularity of hotplug memory. Block size for
>> +	 memory hotplug is represent as a power of 2.
>> +	 If unsure, stick with default value.
>> +
>>  config KERNEL_MODE_NEON
>>  	def_bool y
>> 
>> diff --git a/arch/arm64/include/asm/sparsemem.h 
>> b/arch/arm64/include/asm/sparsemem.h
>> index 1f43fcc79738..3d5310f3aad5 100644
>> --- a/arch/arm64/include/asm/sparsemem.h
>> +++ b/arch/arm64/include/asm/sparsemem.h
>> @@ -7,7 +7,11 @@
>> 
>>  #ifdef CONFIG_SPARSEMEM
>>  #define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
>> +#ifndef CONFIG_MEMORY_HOTPLUG
>>  #define SECTION_SIZE_BITS	30
>> +#else
>> +#define SECTION_SIZE_BITS	CONFIG_HOTPLUG_SIZE_BITS
>> +#endif
>>  #endif
>> 
>>  #endif
>> 
> 
> There was an inconclusive discussion regarding this last month.
> 
> https://lore.kernel.org/linux-arm-kernel/20201204014443.43329-1-liwei213@huawei.com/

Thanks for pointing out this thread. Looking into all the comments, 
major concern with reducing the section size seems to be risk of running 
out of bits in the page flags. And while SECTION_SIZE must be greater or 
equal to highest order page in the buddy, it must also satisfy cases for 
4K page size where it doesn't break PMD mapping for vmemmap - and hence 
SECTION_SIZE_BITS of 27 could be set for 4K page size that could allow 
2MB PMD mappings for each 128M(2^27) block size.

While this is the least value that can be set (27 for 4K_PAGE, 
MAX_ZONEORDER - 1 + PAGE_SHIFT for 16K or 64K_PAGE), are there any 
concerns with setting higher values (but <= 30bits). It seems like any 
arbitrary number between this range could be applied that wouldn't break 
vmemmaps. That's why we were thinking of letting the user configure it 
since this directly impacts memory hotplug about the granularity or 
least size that can be hot (up)plugged. The current setting of 1GB for 
arm64 does poses a lot of challenges in utilizing memory hotplug via a 
driver, esp. for low RAM targets. I agree its sub-optimal in some sense 
but wanted to know the maintainers opinion on this.

Also, the patch introduced in that thread does seem to help reduce 
vmemmap memory if there are large holes. So there is some merit in 
reducing the section size along with memory hotplug leveraging it.

> 
> I have been wondering if this would solve the problem for 4K page size
> config which requires PMD mapping for the vmemmap mapping while making
> section size bits dependent on max order. But this has not been tested
> properly.
> 
> diff --git a/arch/arm64/include/asm/sparsemem.h
> b/arch/arm64/include/asm/sparsemem.h
> index 1f43fcc79738..fe4353cb1dce 100644
> --- a/arch/arm64/include/asm/sparsemem.h
> +++ b/arch/arm64/include/asm/sparsemem.h
> @@ -7,7 +7,18 @@
> 
>  #ifdef CONFIG_SPARSEMEM
>  #define MAX_PHYSMEM_BITS       CONFIG_ARM64_PA_BITS
> -#define SECTION_SIZE_BITS      30
> -#endif
> +
> +#ifdef CONFIG_ARM64_4K_PAGES
> +#define SECTION_SIZE_BITS 27
> +#else
> +#ifdef CONFIG_FORCE_MAX_ZONEORDER
> +#define SECTION_SIZE_BITS (CONFIG_FORCE_MAX_ZONEORDER - 1 + 
> PAGE_SHIFT)
> +#else
> +#define SECTION_SIZE_BITS 30
> +#endif /* CONFIG_FORCE_MAX_ZONEORDER */
> +
> +#endif /* CONFIG_ARM64_4K_PAGES */
> +
> +#endif /* CONFIG_SPARSEMEM*/
> 
>  #endif

SECTION_SIZE_BITS of 27 for 4K_PAGES should be fine for us. Would you 
know if there's possibility of this patch above being applied in 
upstream anytime soon? This is in regards with Generic Kernel Image 
(GKI) that we are working with Google. If this patch would positively 
end up in upstream, we could apply it in aosp kernel.


Sudarshan

--
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
