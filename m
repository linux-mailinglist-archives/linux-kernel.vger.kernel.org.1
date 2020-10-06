Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA50284452
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 05:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgJFDgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 23:36:55 -0400
Received: from foss.arm.com ([217.140.110.172]:36820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgJFDgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 23:36:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DDDB113E;
        Mon,  5 Oct 2020 20:36:54 -0700 (PDT)
Received: from [10.163.74.99] (unknown [10.163.74.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7045B3F71F;
        Mon,  5 Oct 2020 20:36:51 -0700 (PDT)
Subject: Re: [PATCH v3] arm64/mm: add fallback option to allocate virtually
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
References: <cover.1601582954.git.sudaraja@codeaurora.org>
 <9e6178d2828e9c36275487263c5842c688e5b731.1601582954.git.sudaraja@codeaurora.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <49dd60a7-25f4-8dc1-b905-088dff2a84fb@arm.com>
Date:   Tue, 6 Oct 2020 09:06:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9e6178d2828e9c36275487263c5842c688e5b731.1601582954.git.sudaraja@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/02/2020 01:46 AM, Sudarshan Rajagopalan wrote:
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
>  arch/arm64/mm/mmu.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 75df62f..11f8639 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1121,8 +1121,15 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  			void *p = NULL;
>  
>  			p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
> -			if (!p)
> -				return -ENOMEM;
> +			if (!p) {
> +				/*
> +				 * fallback allocating with virtually
> +				 * contiguous memory for this section
> +				 */

Mapping is always virtually contiguous with or without huge pages.
Please drop this comment here, as it's obvious.

> +				if (vmemmap_populate_basepages(addr, next, node, NULL))
> +					return -ENOMEM;

Please send in the 'altmap' instead of NULL for allocation from
device memory if and when requested.
