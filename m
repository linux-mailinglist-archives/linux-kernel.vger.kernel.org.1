Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E472F4BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 14:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbhAMM6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:58:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56007 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725770AbhAMM6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610542615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7nsO2Z05lgvOVyM24wIVwTlc9VT/JvRNyy+q3CKB1bM=;
        b=gOp8+xp7e9x3n4c9c+W01d285BTXjK8yqsGsNeO9LrsV4oTYb9e2xG/dIQYThD7KJQkCvG
        0B8gCvEdhyhaO5VJwN4tmrjc4x/K7ksAbqRjZCczB5uA1zn9LNn5abekf7XF+NwHKujLpp
        aqI67r81f9VFuWyO8lomjSoGfCB9jtk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-QH7rhcI_NJy5ppwsNlzcaA-1; Wed, 13 Jan 2021 07:56:51 -0500
X-MC-Unique: QH7rhcI_NJy5ppwsNlzcaA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71B12107ACFB;
        Wed, 13 Jan 2021 12:56:49 +0000 (UTC)
Received: from [10.36.114.135] (ovpn-114-135.ams2.redhat.com [10.36.114.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 121505D6A8;
        Wed, 13 Jan 2021 12:56:45 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] x86/setup: don't remove E820_TYPE_RAM for pfn 0
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
References: <20210111194017.22696-1-rppt@kernel.org>
 <20210111194017.22696-2-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <6ba6bde3-1520-5cd0-f987-32d543f0b79f@redhat.com>
Date:   Wed, 13 Jan 2021 13:56:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210111194017.22696-2-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.01.21 20:40, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The first 4Kb of memory is a BIOS owned area and to avoid its allocation
> for the kernel it was not listed in e820 tables as memory. As the result,
> pfn 0 was never recognised by the generic memory management and it is not a
> part of neither node 0 nor ZONE_DMA.
> 
> If set_pfnblock_flags_mask() would be ever called for the pageblock
> corresponding to the first 2Mbytes of memory, having pfn 0 outside of
> ZONE_DMA would trigger
> 
> 	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
> 
> Along with reserving the first 4Kb in e820 tables, several first pages are
> reserved with memblock in several places during setup_arch(). These
> reservations are enough to ensure the kernel does not touch the BIOS area
> and it is not necessary to remove E820_TYPE_RAM for pfn 0.
> 
> Remove the update of e820 table that changes the type of pfn 0 and move the
> comment describing why it was done to trim_low_memory_range() that reserves
> the beginning of the memory.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/x86/kernel/setup.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 740f3bdb3f61..3412c4595efd 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -660,17 +660,6 @@ static void __init trim_platform_memory_ranges(void)
>  
>  static void __init trim_bios_range(void)
>  {
> -	/*
> -	 * A special case is the first 4Kb of memory;
> -	 * This is a BIOS owned area, not kernel ram, but generally
> -	 * not listed as such in the E820 table.
> -	 *
> -	 * This typically reserves additional memory (64KiB by default)
> -	 * since some BIOSes are known to corrupt low memory.  See the
> -	 * Kconfig help text for X86_RESERVE_LOW.
> -	 */
> -	e820__range_update(0, PAGE_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
> -
>  	/*
>  	 * special case: Some BIOSes report the PC BIOS
>  	 * area (640Kb -> 1Mb) as RAM even though it is not.
> @@ -728,6 +717,15 @@ early_param("reservelow", parse_reservelow);
>  
>  static void __init trim_low_memory_range(void)
>  {
> +	/*
> +	 * A special case is the first 4Kb of memory;
> +	 * This is a BIOS owned area, not kernel ram, but generally
> +	 * not listed as such in the E820 table.
> +	 *
> +	 * This typically reserves additional memory (64KiB by default)
> +	 * since some BIOSes are known to corrupt low memory.  See the
> +	 * Kconfig help text for X86_RESERVE_LOW.
> +	 */
>  	memblock_reserve(0, ALIGN(reserve_low, PAGE_SIZE));
>  }
>  	
> 

The only somewhat-confusing thing is that in-between
e820__memblock_setup() and trim_low_memory_range(), we already have
memblock allocations. So [0..4095] might look like ordinary memory until
we reserve it later on.

E.g., reserve_real_mode() does a

mem = memblock_find_in_range(0, 1<<20, size, PAGE_SIZE);
...
memblock_reserve(mem, size);
set_real_mode_mem(mem);

which looks kind of suspicious to me. Most probably I am missing
something, just wanted to point that out. We might want to do such
trimming/adjustments before any kind of allocations.

-- 
Thanks,

David / dhildenb

