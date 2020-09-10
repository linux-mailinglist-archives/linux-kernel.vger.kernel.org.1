Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99401263D89
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 08:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgIJGqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 02:46:03 -0400
Received: from foss.arm.com ([217.140.110.172]:55528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgIJGqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:46:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A78731B;
        Wed,  9 Sep 2020 23:46:00 -0700 (PDT)
Received: from [10.163.71.250] (unknown [10.163.71.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 663D33F66E;
        Wed,  9 Sep 2020 23:45:57 -0700 (PDT)
Subject: Re: [PATCH] arm64/mm: add fallback option to allocate virtually
 contiguous memory
To:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>
References: <01010174769e2b68-a6f3768e-aef8-43c7-b357-a8cb1e17d3eb-000000@us-west-2.amazonses.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <0475e813-cb95-0992-39e4-593bfd5cdbf8@arm.com>
Date:   Thu, 10 Sep 2020 12:15:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <01010174769e2b68-a6f3768e-aef8-43c7-b357-a8cb1e17d3eb-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sudarshan,

On 09/10/2020 11:35 AM, Sudarshan Rajagopalan wrote:
> When section mappings are enabled, we allocate vmemmap pages from physically
> continuous memory of size PMD_SZIE using vmemmap_alloc_block_buf(). Section> mappings are good to reduce TLB pressure. But when system is highly fragmented
> and memory blocks are being hot-added at runtime, its possible that such
> physically continuous memory allocations can fail. Rather than failing the

Did you really see this happen on a system ?

> memory hot-add procedure, add a fallback option to allocate vmemmap pages from
> discontinuous pages using vmemmap_populate_basepages().

Which could lead to a mixed page size mapping in the VMEMMAP area.
Allocation failure in vmemmap_populate() should just cleanly fail
the memory hot add operation, which can then be retried. Why the
retry has to be offloaded to kernel ?

> 
> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Steven Price <steven.price@arm.com>
> ---
>  arch/arm64/mm/mmu.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 75df62f..a46c7d4 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1100,6 +1100,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  	p4d_t *p4dp;
>  	pud_t *pudp;
>  	pmd_t *pmdp;
> +	int ret = 0;
>  
>  	do {
>  		next = pmd_addr_end(addr, end);
> @@ -1121,15 +1122,23 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  			void *p = NULL;
>  
>  			p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
> -			if (!p)
> -				return -ENOMEM;
> +			if (!p) {
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +				vmemmap_free(start, end, altmap);
> +#endif

The mapping was never created in the first place, as the allocation
failed. vmemmap_free() here will free an unmapped area !

> +				ret = -ENOMEM;
> +				break;
> +			}
>  
>  			pmd_set_huge(pmdp, __pa(p), __pgprot(PROT_SECT_NORMAL));
>  		} else
>  			vmemmap_verify((pte_t *)pmdp, node, addr, next);
>  	} while (addr = next, addr != end);
>  
> -	return 0;
> +	if (ret)
> +		return vmemmap_populate_basepages(start, end, node, altmap);
> +	else
> +		return ret;
>  }
>  #endif	/* !ARM64_SWAPPER_USES_SECTION_MAPS */
>  void vmemmap_free(unsigned long start, unsigned long end,
> 
