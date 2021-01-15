Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5EB2F7659
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbhAOKMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 05:12:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39805 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727296AbhAOKMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 05:12:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610705484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M8f92STotiD6I/XoQza9Cr/w6W7PSu+oQ6v52INCE8s=;
        b=PvJw7fcs1H7imXNd31GzrROulS4RhxmsW+1d//T+BbnlBjYmcC7O7XbzT4Z4d3fgQny3Pm
        RA6+wpQsnej3vCTyUbIMgNnPd1T+1dbDbmAKZNvyZQ8JkJvCiguzqVj5mH/XeuALoCgL6J
        DVrhI3w0s4Det7cr6RStloe6BY4S06Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-1OrCzmMmPXK8tDDQH526tg-1; Fri, 15 Jan 2021 05:11:13 -0500
X-MC-Unique: 1OrCzmMmPXK8tDDQH526tg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33C15806660;
        Fri, 15 Jan 2021 10:10:59 +0000 (UTC)
Received: from [10.36.112.11] (ovpn-112-11.ams2.redhat.com [10.36.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FA7B5C1A3;
        Fri, 15 Jan 2021 10:10:56 +0000 (UTC)
Subject: Re: [PATCH 1/2] x86/setup: consolidate early memory reservations
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
References: <20210115083255.12744-1-rppt@kernel.org>
 <20210115083255.12744-2-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <40adfd60-98da-b415-0108-dd3c15deea03@redhat.com>
Date:   Fri, 15 Jan 2021 11:10:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210115083255.12744-2-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.01.21 09:32, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The early reservations of memory areas used by the firmware, bootloader,
> kernel text and data are spread over setup_arch(). Moreover, some of them
> happen *after* memblock allocations, e.g trim_platform_memory_ranges() and
> trim_low_memory_range() are called after reserve_real_mode() that allocates
> memory.
> 
> We did not observe corruption of these memory regions because memblock
> always allocates memory either from the end of memory (in top-down mode) or
> above the kernel image (in bottom-up mode). However, the bottom up mode is
> going to be updated to span the entire memory [1] to avoid limitations
> caused by KASLR.
> 
> Consolidate early memory reservations in a dedicated function to improve
> robustness against future changes. Having the early reservations in one
> place also makes it clearer what memory must be reserved before we allow
> memblock allocations.
> 
> [1] https://lore.kernel.org/lkml/20201217201214.3414100-2-guro@fb.com
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/x86/kernel/setup.c | 80 ++++++++++++++++++++++-------------------
>  1 file changed, 44 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 3412c4595efd..32cd2e790a0a 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -728,7 +728,38 @@ static void __init trim_low_memory_range(void)
>  	 */
>  	memblock_reserve(0, ALIGN(reserve_low, PAGE_SIZE));
>  }
> -	
> +
> +static void __init early_reserve_memory(void)
> +{
> +	/*
> +	 * Reserve the memory occupied by the kernel between _text and
> +	 * __end_of_kernel_reserve symbols. Any kernel sections after the
> +	 * __end_of_kernel_reserve symbol must be explicitly reserved with a
> +	 * separate memblock_reserve() or they will be discarded.
> +	 */
> +	memblock_reserve(__pa_symbol(_text),
> +			 (unsigned long)__end_of_kernel_reserve - (unsigned long)_text);
> +
> +	/*
> +	 * Make sure page 0 is always reserved because on systems with
> +	 * L1TF its contents can be leaked to user processes.
> +	 */
> +	memblock_reserve(0, PAGE_SIZE);
> +
> +	early_reserve_initrd();
> +
> +	if (efi_enabled(EFI_BOOT))
> +		efi_memblock_x86_reserve_range();
> +
> +	memblock_x86_reserve_range_setup_data();
> +
> +	reserve_ibft_region();
> +	reserve_bios_regions();
> +
> +	trim_platform_memory_ranges();
> +	trim_low_memory_range();
> +}
> +
>  /*
>   * Dump out kernel offset information on panic.
>   */
> @@ -763,29 +794,6 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
>  
>  void __init setup_arch(char **cmdline_p)
>  {
> -	/*
> -	 * Reserve the memory occupied by the kernel between _text and
> -	 * __end_of_kernel_reserve symbols. Any kernel sections after the
> -	 * __end_of_kernel_reserve symbol must be explicitly reserved with a
> -	 * separate memblock_reserve() or they will be discarded.
> -	 */
> -	memblock_reserve(__pa_symbol(_text),
> -			 (unsigned long)__end_of_kernel_reserve - (unsigned long)_text);
> -
> -	/*
> -	 * Make sure page 0 is always reserved because on systems with
> -	 * L1TF its contents can be leaked to user processes.
> -	 */
> -	memblock_reserve(0, PAGE_SIZE);
> -
> -	early_reserve_initrd();
> -
> -	/*
> -	 * At this point everything still needed from the boot loader
> -	 * or BIOS or kernel text should be early reserved or marked not
> -	 * RAM in e820. All other memory is free game.
> -	 */
> -
>  #ifdef CONFIG_X86_32
>  	memcpy(&boot_cpu_data, &new_cpu_data, sizeof(new_cpu_data));
>  
> @@ -909,8 +917,18 @@ void __init setup_arch(char **cmdline_p)
>  
>  	parse_early_param();
>  
> -	if (efi_enabled(EFI_BOOT))
> -		efi_memblock_x86_reserve_range();
> +	/*
> +	 * Do some memory reservations *before* memory is added to
> +	 * memblock, so memblock allocations won't overwrite it.
> +	 * Do it after early param, so we could get (unlikely) panic from
> +	 * serial.
> +	 *
> +	 * After this point everything still needed from the boot loader or
> +	 * firmware or kernel text should be early reserved or marked not
> +	 * RAM in e820. All other memory is free game.
> +	 */
> +	early_reserve_memory();
> +
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  	/*
>  	 * Memory used by the kernel cannot be hot-removed because Linux
> @@ -937,9 +955,6 @@ void __init setup_arch(char **cmdline_p)
>  
>  	x86_report_nx();
>  
> -	/* after early param, so could get panic from serial */
> -	memblock_x86_reserve_range_setup_data();
> -
>  	if (acpi_mps_check()) {
>  #ifdef CONFIG_X86_LOCAL_APIC
>  		disable_apic = 1;
> @@ -1031,8 +1046,6 @@ void __init setup_arch(char **cmdline_p)
>  	 */
>  	find_smp_config();
>  
> -	reserve_ibft_region();
> -
>  	early_alloc_pgt_buf();
>  
>  	/*
> @@ -1053,8 +1066,6 @@ void __init setup_arch(char **cmdline_p)
>  	 */
>  	sev_setup_arch();
>  
> -	reserve_bios_regions();
> -
>  	efi_fake_memmap();
>  	efi_find_mirror();
>  	efi_esrt_init();
> @@ -1080,9 +1091,6 @@ void __init setup_arch(char **cmdline_p)
>  
>  	reserve_real_mode();
>  
> -	trim_platform_memory_ranges();
> -	trim_low_memory_range();
> -
>  	init_mem_mapping();
>  
>  	idt_setup_early_pf();
> 

Did not fully review for side-effects, but looks like a reasonable thing
to do!

-- 
Thanks,

David / dhildenb

