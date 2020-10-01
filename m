Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A91827F6C4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 02:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732074AbgJAAb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 20:31:28 -0400
Received: from foss.arm.com ([217.140.110.172]:47488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730873AbgJAAb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 20:31:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 915E631B;
        Wed, 30 Sep 2020 17:31:27 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A8CE3F6CF;
        Wed, 30 Sep 2020 17:31:24 -0700 (PDT)
Subject: Re: [PATCH v2] arm64/mm: add fallback option to allocate virtually
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
References: <cover.1601506266.git.sudaraja@codeaurora.org>
 <a2d91c1b5874a1217e473ffd33cd4f765a0e78b7.1601506266.git.sudaraja@codeaurora.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <eda84c3d-fc3d-1b9a-c79a-ef91668f3feb@arm.com>
Date:   Thu, 1 Oct 2020 06:00:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a2d91c1b5874a1217e473ffd33cd4f765a0e78b7.1601506266.git.sudaraja@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/01/2020 04:43 AM, Sudarshan Rajagopalan wrote:
> When section mappings are enabled, we allocate vmemmap pages from physically
> continuous memory of size PMD_SIZE using vmemmap_alloc_block_buf(). Section
> mappings are good to reduce TLB pressure. But when system is highly fragmented
> and memory blocks are being hot-added at runtime, its possible that such
> physically continuous memory allocations can fail. Rather than failing the
> memory hot-add procedure, add a fallback option to allocate vmemmap pages from
> discontinuous pages using vmemmap_populate_basepages().
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
>  arch/arm64/mm/mmu.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 75df62f..9edbbb8 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1121,8 +1121,18 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  			void *p = NULL;
>  
>  			p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
> -			if (!p)
> -				return -ENOMEM;
> +			if (!p) {
> +				if (altmap)
> +					return -ENOMEM;	/* no fallback */

Why ? If huge pages inside a vmemmap section might have been allocated
from altmap, the base page could also fallback on altmap. If this patch
has just followed the existing x86 semantics, it was written [1] long
back before vmemmap_populate_basepages() supported altmap allocation.
While adding that support [2] recently, it was deliberate not to change 
x86 semantics as it was a platform decision. Nonetheless, it makes sense
to fallback on altmap bases pages if and when required.

[1] 4b94ffdc4163 (x86, mm: introduce vmem_altmap to augment vmemmap_populate())
[2] 1d9cfee7535c (mm/sparsemem: enable vmem_altmap support in vmemmap_populate_basepages())
