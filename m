Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AD02FE1DB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 06:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbhAUFjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 00:39:08 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:54105 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbhAUFgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 00:36:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611207384; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=7hTcsh6VwdzeIl6FzoodGR9AkDCN6wS1KCZTwdlDUj4=;
 b=wVwq6wxkccd88oUL8Zdg8ZSWszDx8TznzANECSmeMp+Z+/gu+kZHpYjGbr8fDoMe5kxmzCOP
 k8lrxPPpJGN5asx7ra9ctG6aTcSa4JROMi/+8YYYjKiRX2ZAAUID6/pBmkcA8XLMn4Y72ZRV
 NR3v4cOzy8KIxa8yXrHdI7crLlQ=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 600912b95677aca7bd7b261b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 21 Jan 2021 05:35:53
 GMT
Sender: sudaraja=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4EAEBC43469; Thu, 21 Jan 2021 05:35:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sudaraja)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AFE72C433CA;
        Thu, 21 Jan 2021 05:35:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Jan 2021 21:35:51 -0800
From:   Sudarshan Rajagopalan <sudaraja@codeaurora.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, david@redhat.com,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/1] arm64: reduce section size for sparsemem
In-Reply-To: <d28433e3-3b04-dbab-2fd3-957a373d032c@arm.com>
References: <cover.1610146597.git.sudaraja@codeaurora.org>
 <15cf9a2359197fee0168f820c5c904650d07939e.1610146597.git.sudaraja@codeaurora.org>
 <d28433e3-3b04-dbab-2fd3-957a373d032c@arm.com>
Message-ID: <f4dac5af2821f07428e62b607444d40d@codeaurora.org>
X-Sender: sudaraja@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-11 03:09, Anshuman Khandual wrote:
> + Catalin
> 
> Hello Sudershan,
> 
> Could you please change the subject line above as follows for
> better classifications and clarity.
> 
> arm64/sparsemem: Reduce SECTION_SIZE_BITS
> 
> On 1/9/21 4:46 AM, Sudarshan Rajagopalan wrote:
>> Reducing the section size helps reduce wastage of reserved memory
>> for huge memory holes in sparsemem model. But having a much smaller
> 
> There are two distinct benefits of reducing SECTION_SIZE_BITS.
> 
> - Improve memory hotplug granularity
> - Reduce reserved memory wastage for vmmemmap mappings for sections
>   with large memory holes
> 
>> section size bits could break PMD mappings for vmemmap and wouldn't
>> accomodate the highest order page for certain page size granule 
>> configs.
> 
> There are constrains in reducing SECTION_SIZE_BIT like
> 
> - Should accommodate highest order page for a given config
> - Should not break PMD mapping in vmemmap for 4K pages
> - Should not consume too many page->flags bits reducing space for other 
> info
> 
> Both benefits and constraints should be described in the commit message
> for folks to understand the rationale clearly at a later point in time.
> 
>> It is determined that SECTION_SIZE_BITS of 27 (128MB) could be ideal
> 
> Probably needs some description how we arrived here.
> 
>> default value for 4K_PAGES that gives least section size without 
>> breaking
>> PMD based vmemmap mappings. For simplicity, 16K_PAGES could follow the
>> same as 4K_PAGES. And the least SECTION_SIZE_BITS for 64K_PAGES is 29
>> that could accomodate MAX_ORDER.
> 
> Did not see this patch earlier and hence ended up writing yet another 
> one.
> Here is the draft commit message from that patch, please feel free to 
> use
> in part or full. But please do include the benefits, the constraints 
> and
> the rationale for arriving at these figures.
> 
>     ---------
>     memory_block_size_bytes() determines the memory hotplug granularity 
> i.e the
>     amount of memory which can be hot added or hot removed from the 
> kernel. The
>     generic value here being MIN_MEMORY_BLOCK_SIZE (1UL << 
> SECTION_SIZE_BITS)
>     for memory_block_size_bytes() on platforms like arm64 that does
> not override.
> 
>     Current SECTION_SIZE_BITS is 30 i.e 1GB which is large and a 
> reduction here
>     increases memory hotplug granularity, thus improving its agility. A 
> reduced
>     section size also reduces memory wastage in vmemmmap mapping for 
> sections
>     with large memory holes. A section size bits selection must follow.
> 
>     (MAX_ORDER - 1 + PAGE_SHIFT) <= SECTION_SIZE_BITS
> 
>     CONFIG_FORCE_MAX_ZONEORDER is always defined on arm64 and just 
> following it
>     would help achieve the smallest section size.
> 
>     SECTION_SIZE_BITS = (CONFIG_FORCE_MAX_ZONEORDER - 1 + PAGE_SHIFT)
> 
>     SECTION_SIZE_BITS = 22 (11 - 1 + 12) i.e 4MB   for 4K pages
>     SECTION_SIZE_BITS = 24 (11 - 1 + 14) i.e 16MB  for 16K pages 
> without THP
>     SECTION_SIZE_BITS = 25 (12 - 1 + 14) i.e 32MB  for 16K pages with 
> THP
>     SECTION_SIZE_BITS = 26 (11 - 1 + 16) i.e 64MB  for 64K pages 
> without THP
>     SECTION_SIZE_BITS = 29 (14 - 1 + 16) i.e 512MB for 64K pages with 
> THP
> 
>     But there are other problems. Reducing the section size too much 
> would over
>     populate /sys/devices/system/memory/ and also consume too many 
> page->flags
>     bits in the !vmemmap case. Also section size needs to be multiple 
> of 128MB
>     to have PMD based vmemmap mapping with CONFIG_ARM64_4K_PAGES.
> 
>     Given these constraints, lets just reduce the section size to 128MB 
> for 4K
>     and 16K base page size configs and to 512MB for 64K base page size 
> config.
>     -------------
> 
>> 
>> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Mike Rapoport <rppt@linux.ibm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Suren Baghdasaryan <surenb@google.com>
> A nit. Please add all relevant mailing lists like LAKML, MM along
> with other developers here in the CC list, so that it would never
> be missed.
> 
>> ---
>>  arch/arm64/include/asm/sparsemem.h | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/arm64/include/asm/sparsemem.h 
>> b/arch/arm64/include/asm/sparsemem.h
>> index 1f43fcc79738..ff08ff6b677c 100644
>> --- a/arch/arm64/include/asm/sparsemem.h
>> +++ b/arch/arm64/include/asm/sparsemem.h
>> @@ -7,7 +7,13 @@
>> 
>>  #ifdef CONFIG_SPARSEMEM
>>  #define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
>> -#define SECTION_SIZE_BITS	30
>> -#endif
>> +
>> +#if defined(CONFIG_ARM64_4K_PAGES) || defined(CONFIG_ARM64_16K_PAGES)
> 
> Please add a comment, something like
> 
> /*
>  * Section size must be at least 128MB for 4K base
>  * page size config. Otherwise PMD based huge page
>  * entries could not be created for vmemmap mappings.
>  * 16K follows 4K for simplicity.
>  */
> 
>> +#define SECTION_SIZE_BITS 27
>> +#else
> 
> Please add a comment, something like
> 
> /*
>  * Section size must be at least 512MB for 64K base
>  * page size config. Otherwise it will be less than
>  * (MAX_ORDER - 1) and the build process will fail.
>  */
> 
>> +#define SECTION_SIZE_BITS 29
>> +#endif /* CONFIG_ARM64_4K_PAGES || CONFIG_ARM64_16K_PAGES */
> 
> This condition here can be flipped (#ifdef CONFIG_ARM64_64K_PAGES) to
> be bit cleaner and possibly to reduce the code.
> 
>> +
>> +#endif /* CONFIG_SPARSEMEM*/
>> 
>>  #endif
>> 
> 
> - Anshuman

Thanks Anshuman for the comments and suggestions. I have used the 
excerpt you had provided before for the commit message with slight 
modifications. I have pushed the new patch with your comments addressed 
-
https://lore.kernel.org/lkml/43843c5e092bfe3ec4c41e3c8c78a7ee35b69bb0.1611206601.git.sudaraja@codeaurora.org/

Sudarshan

--
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
