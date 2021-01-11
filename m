Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF35B2F10D8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbhAKLJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:09:32 -0500
Received: from foss.arm.com ([217.140.110.172]:53790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727143AbhAKLJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:09:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F47A31B;
        Mon, 11 Jan 2021 03:08:46 -0800 (PST)
Received: from [10.163.88.153] (unknown [10.163.88.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 938FB3F719;
        Mon, 11 Jan 2021 03:08:43 -0800 (PST)
Subject: Re: [PATCH 1/1] arm64: reduce section size for sparsemem
To:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, david@redhat.com
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <cover.1610146597.git.sudaraja@codeaurora.org>
 <15cf9a2359197fee0168f820c5c904650d07939e.1610146597.git.sudaraja@codeaurora.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d28433e3-3b04-dbab-2fd3-957a373d032c@arm.com>
Date:   Mon, 11 Jan 2021 16:39:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <15cf9a2359197fee0168f820c5c904650d07939e.1610146597.git.sudaraja@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Catalin

Hello Sudershan,

Could you please change the subject line above as follows for
better classifications and clarity.

arm64/sparsemem: Reduce SECTION_SIZE_BITS

On 1/9/21 4:46 AM, Sudarshan Rajagopalan wrote:
> Reducing the section size helps reduce wastage of reserved memory
> for huge memory holes in sparsemem model. But having a much smaller

There are two distinct benefits of reducing SECTION_SIZE_BITS.

- Improve memory hotplug granularity
- Reduce reserved memory wastage for vmmemmap mappings for sections
  with large memory holes

> section size bits could break PMD mappings for vmemmap and wouldn't
> accomodate the highest order page for certain page size granule configs.

There are constrains in reducing SECTION_SIZE_BIT like

- Should accommodate highest order page for a given config
- Should not break PMD mapping in vmemmap for 4K pages
- Should not consume too many page->flags bits reducing space for other info

Both benefits and constraints should be described in the commit message
for folks to understand the rationale clearly at a later point in time.

> It is determined that SECTION_SIZE_BITS of 27 (128MB) could be ideal

Probably needs some description how we arrived here.

> default value for 4K_PAGES that gives least section size without breaking
> PMD based vmemmap mappings. For simplicity, 16K_PAGES could follow the
> same as 4K_PAGES. And the least SECTION_SIZE_BITS for 64K_PAGES is 29
> that could accomodate MAX_ORDER.

Did not see this patch earlier and hence ended up writing yet another one.
Here is the draft commit message from that patch, please feel free to use
in part or full. But please do include the benefits, the constraints and
the rationale for arriving at these figures.

    ---------
    memory_block_size_bytes() determines the memory hotplug granularity i.e the
    amount of memory which can be hot added or hot removed from the kernel. The
    generic value here being MIN_MEMORY_BLOCK_SIZE (1UL << SECTION_SIZE_BITS)
    for memory_block_size_bytes() on platforms like arm64 that does not override.
    
    Current SECTION_SIZE_BITS is 30 i.e 1GB which is large and a reduction here
    increases memory hotplug granularity, thus improving its agility. A reduced
    section size also reduces memory wastage in vmemmmap mapping for sections
    with large memory holes. A section size bits selection must follow.
    
    (MAX_ORDER - 1 + PAGE_SHIFT) <= SECTION_SIZE_BITS
    
    CONFIG_FORCE_MAX_ZONEORDER is always defined on arm64 and just following it
    would help achieve the smallest section size.
    
    SECTION_SIZE_BITS = (CONFIG_FORCE_MAX_ZONEORDER - 1 + PAGE_SHIFT)
    
    SECTION_SIZE_BITS = 22 (11 - 1 + 12) i.e 4MB   for 4K pages
    SECTION_SIZE_BITS = 24 (11 - 1 + 14) i.e 16MB  for 16K pages without THP
    SECTION_SIZE_BITS = 25 (12 - 1 + 14) i.e 32MB  for 16K pages with THP
    SECTION_SIZE_BITS = 26 (11 - 1 + 16) i.e 64MB  for 64K pages without THP
    SECTION_SIZE_BITS = 29 (14 - 1 + 16) i.e 512MB for 64K pages with THP
    
    But there are other problems. Reducing the section size too much would over
    populate /sys/devices/system/memory/ and also consume too many page->flags
    bits in the !vmemmap case. Also section size needs to be multiple of 128MB
    to have PMD based vmemmap mapping with CONFIG_ARM64_4K_PAGES.
    
    Given these constraints, lets just reduce the section size to 128MB for 4K
    and 16K base page size configs and to 512MB for 64K base page size config.
    -------------

> 
> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
A nit. Please add all relevant mailing lists like LAKML, MM along
with other developers here in the CC list, so that it would never
be missed.

> ---
>  arch/arm64/include/asm/sparsemem.h | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
> index 1f43fcc79738..ff08ff6b677c 100644
> --- a/arch/arm64/include/asm/sparsemem.h
> +++ b/arch/arm64/include/asm/sparsemem.h
> @@ -7,7 +7,13 @@
>  
>  #ifdef CONFIG_SPARSEMEM
>  #define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
> -#define SECTION_SIZE_BITS	30
> -#endif
> +
> +#if defined(CONFIG_ARM64_4K_PAGES) || defined(CONFIG_ARM64_16K_PAGES)

Please add a comment, something like

/*
 * Section size must be at least 128MB for 4K base
 * page size config. Otherwise PMD based huge page
 * entries could not be created for vmemmap mappings.
 * 16K follows 4K for simplicity. 
 */

> +#define SECTION_SIZE_BITS 27
> +#else

Please add a comment, something like

/*
 * Section size must be at least 512MB for 64K base
 * page size config. Otherwise it will be less than
 * (MAX_ORDER - 1) and the build process will fail.
 */

> +#define SECTION_SIZE_BITS 29
> +#endif /* CONFIG_ARM64_4K_PAGES || CONFIG_ARM64_16K_PAGES */

This condition here can be flipped (#ifdef CONFIG_ARM64_64K_PAGES) to
be bit cleaner and possibly to reduce the code.

> +
> +#endif /* CONFIG_SPARSEMEM*/
>  
>  #endif
> 

- Anshuman
