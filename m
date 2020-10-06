Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0F6284625
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 08:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgJFGg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 02:36:26 -0400
Received: from foss.arm.com ([217.140.110.172]:39588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgJFGg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 02:36:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A69381435;
        Mon,  5 Oct 2020 23:36:25 -0700 (PDT)
Received: from [10.163.74.99] (unknown [10.163.74.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 475E03F66B;
        Mon,  5 Oct 2020 23:36:21 -0700 (PDT)
Subject: Re: [PATCH] arm64/mm: Validate hotplug range before creating linear
 mapping
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, Steven Price <steven.price@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <1600332402-30123-1-git-send-email-anshuman.khandual@arm.com>
 <20200928203539.GA12218@willie-the-truck>
 <09266aed-7eef-5b16-5d52-0dcb7dcb7246@arm.com>
 <20200929152221.GA13995@willie-the-truck>
 <f44d34df-8a21-712c-138d-f7f633b0eb6c@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <262f2fd8-2e0c-4eaf-d4ff-f72728049f52@arm.com>
Date:   Tue, 6 Oct 2020 12:05:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f44d34df-8a21-712c-138d-f7f633b0eb6c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/30/2020 01:32 PM, Anshuman Khandual wrote:
> But if __is_lm_address() checks against the effective linear range instead
> i.e [_PAGE_OFFSET(vabits_actual)..(PAGE_END - 1)], it can be used for hot
> plug physical range check there after. Perhaps something like this, though
> not tested properly.
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index afa722504bfd..6da046b479d4 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -238,7 +238,10 @@ static inline const void *__tag_set(const void *addr, u8 tag)
>   * space. Testing the top bit for the start of the region is a
>   * sufficient check and avoids having to worry about the tag.
>   */
> -#define __is_lm_address(addr)  (!(((u64)addr) & BIT(vabits_actual - 1)))
> +static inline bool __is_lm_address(unsigned long addr)
> +{
> +       return ((addr >= _PAGE_OFFSET(vabits_actual)) && (addr <= (PAGE_END - 1)));
> +}
>  
>  #define __lm_to_phys(addr)     (((addr) + physvirt_offset))
>  #define __kimg_to_phys(addr)   ((addr) - kimage_voffset)
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index d59ffabb9c84..5750370a7e8c 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1451,8 +1451,7 @@ static bool inside_linear_region(u64 start, u64 size)
>          * address range mapped by the linear map, the start address should
>          * be calculated using vabits_actual.
>          */
> -       return ((start >= __pa(_PAGE_OFFSET(vabits_actual)))
> -                       && ((start + size) <= __pa(PAGE_END - 1)));
> +       return __is_lm_address(__va(start)) && __is_lm_address(__va(start + size));
>  }
>  
>  int arch_add_memory(int nid, u64 start, u64 size,

Will/Ard,

Any thoughts about this ? __is_lm_address() now checks for a range instead
of a bit. This will be compatible later on, even if linear mapping range
changes from current lower half scheme.

- Anshuman
