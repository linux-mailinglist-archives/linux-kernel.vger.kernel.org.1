Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7322A9730
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 14:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgKFNn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 08:43:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:48162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727214AbgKFNn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 08:43:28 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1AB02065D;
        Fri,  6 Nov 2020 13:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604670207;
        bh=jefm49eVzblLQeGn6k0KezjqjqWh7T9kQPj0dNWlfP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gZeuOyvdifyKP28jzDCw6ogVkHhnk+aDcw3QHZF03dtuaynqZ/ZSQ3ngXcG2nJ/vC
         /05ThmAr/P4yqBqffIIF5J5yXnp/1Du4hTNdsohhA7XwjAyXjsdwkKSHBUFIPg936k
         3DqM7mnX/AYM4M1qqpywBP/9FINKDRwY2m8Hzjlk=
Date:   Fri, 6 Nov 2020 13:43:22 +0000
From:   Will Deacon <will@kernel.org>
To:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gavin Shan <gshan@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v4] arm64/mm: add fallback option to allocate virtually
 contiguous memory
Message-ID: <20201106134321.GA10981@willie-the-truck>
References: <cover.1602722808.git.sudaraja@codeaurora.org>
 <d6c06f2ef39bbe6c715b2f6db76eb16155fdcee6.1602722808.git.sudaraja@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6c06f2ef39bbe6c715b2f6db76eb16155fdcee6.1602722808.git.sudaraja@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 11:56:56AM -0700, Sudarshan Rajagopalan wrote:
> When section mappings are enabled, we allocate vmemmap pages from
> physically continuous memory of size PMD_SIZE using
> vmemmap_alloc_block_buf(). Section mappings are good to reduce TLB
> pressure. But when system is highly fragmented and memory blocks are
> being hot-added at runtime, its possible that such physically continuous
> memory allocations can fail. Rather than failing the memory hot-add
> procedure, add a fallback option to allocate vmemmap pages from
> discontinuous pages using vmemmap_populate_basepages().
> 
> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Steven Price <steven.price@arm.com>
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

Looks fine to me:

Acked-by: Will Deacon <will@kernel.org>

Will
