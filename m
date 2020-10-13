Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A4C28CCAA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgJMLjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:39:39 -0400
Received: from foss.arm.com ([217.140.110.172]:57236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbgJMLjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:39:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B34DF1FB;
        Tue, 13 Oct 2020 04:39:38 -0700 (PDT)
Received: from [10.163.75.237] (unknown [10.163.75.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A619F3F719;
        Tue, 13 Oct 2020 04:39:35 -0700 (PDT)
Subject: Re: [PATCH v3] arm64/mm: add fallback option to allocate virtually
 contiguous memory
To:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Gavin Shan <gshan@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>
References: <cover.1602542734.git.sudaraja@codeaurora.org>
 <339118202d0a4741ec22f215830dc8d9ba1ccd49.1602542734.git.sudaraja@codeaurora.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <bbc27422-7057-2859-56d3-ccbff49e0d43@arm.com>
Date:   Tue, 13 Oct 2020 17:08:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <339118202d0a4741ec22f215830dc8d9ba1ccd49.1602542734.git.sudaraja@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/2020 04:35 AM, Sudarshan Rajagopalan wrote:
> When section mappings are enabled, we allocate vmemmap pages from physically
> continuous memory of size PMD_SIZE using vmemmap_alloc_block_buf(). Section
> mappings are good to reduce TLB pressure. But when system is highly fragmented
> and memory blocks are being hot-added at runtime, its possible that such
> physically continuous memory allocations can fail. Rather than failing the
> memory hot-add procedure, add a fallback option to allocate vmemmap pages from
> discontinuous pages using vmemmap_populate_basepages().

There is a checkpatch warning here, which could be fixed while merging ?

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#7: 
When section mappings are enabled, we allocate vmemmap pages from physically

total: 0 errors, 1 warnings, 13 lines checked

> 
> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Steven Price <steven.price@arm.com>

Nonetheless, this looks fine. Did not see any particular problem
while creating an experimental vmemmap with interleaving section
and base page mapping.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  arch/arm64/mm/mmu.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 75df62fea1b6..44486fd0e883 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1121,8 +1121,11 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  			void *p = NULL;
>  
>  			p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
> -			if (!p)
> -				return -ENOMEM;
> +			if (!p) {
> +				if (vmemmap_populate_basepages(addr, next, node, altmap))
> +					return -ENOMEM;
> +				continue;
> +			}
>  
>  			pmd_set_huge(pmdp, __pa(p), __pgprot(PROT_SECT_NORMAL));
>  		} else
>
