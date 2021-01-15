Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8682F7653
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbhAOKLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 05:11:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60077 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726484AbhAOKKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 05:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610705363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gm92MUKhkCOz/gm7SwDV9j1IMVrCL///0RyjllYTsvQ=;
        b=HAJDV4FMzrkyKxRXKQF5cQOF3lag3FQU6T0kTz5SPGxw4YI+sY6NUD4gJA2cgWzMpX0NFL
        RjGOYqnMJCrh0Gs5806SIwlC/tEQDkP8nFk6SF8qvSJXLYOarcCIQhFL2HBQbuImuj4+j8
        HaE2UTk5TtLvUy6etPe6ExqB08IEjUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-7PlKNMoLMWCvHk_8xQUq0A-1; Fri, 15 Jan 2021 05:09:19 -0500
X-MC-Unique: 7PlKNMoLMWCvHk_8xQUq0A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 790B48018A3;
        Fri, 15 Jan 2021 10:09:17 +0000 (UTC)
Received: from [10.36.112.11] (ovpn-112-11.ams2.redhat.com [10.36.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43FB160C6D;
        Fri, 15 Jan 2021 10:09:13 +0000 (UTC)
Subject: Re: [PATCH 2/2] x86/setup: merge several reservations of start of the
 memory
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
 <20210115083255.12744-3-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <b893d24a-51f8-5dd8-fd34-053e413a245b@redhat.com>
Date:   Fri, 15 Jan 2021 11:09:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210115083255.12744-3-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.01.21 09:32, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Currently the first several pages are reserved both to avoid leaking their
> contents on systems with L1TF and to avoid corrupting BIOS memory.
> 
> Merge the two memory reservations.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/x86/kernel/setup.c | 29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 32cd2e790a0a..3f2fd67240f8 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -715,20 +715,6 @@ static int __init parse_reservelow(char *p)
>  
>  early_param("reservelow", parse_reservelow);
>  
> -static void __init trim_low_memory_range(void)
> -{
> -	/*
> -	 * A special case is the first 4Kb of memory;
> -	 * This is a BIOS owned area, not kernel ram, but generally
> -	 * not listed as such in the E820 table.
> -	 *
> -	 * This typically reserves additional memory (64KiB by default)
> -	 * since some BIOSes are known to corrupt low memory.  See the
> -	 * Kconfig help text for X86_RESERVE_LOW.
> -	 */
> -	memblock_reserve(0, ALIGN(reserve_low, PAGE_SIZE));
> -}
> -
>  static void __init early_reserve_memory(void)
>  {
>  	/*
> @@ -741,10 +727,18 @@ static void __init early_reserve_memory(void)
>  			 (unsigned long)__end_of_kernel_reserve - (unsigned long)_text);
>  
>  	/*
> -	 * Make sure page 0 is always reserved because on systems with
> -	 * L1TF its contents can be leaked to user processes.
> +	 * The first 4Kb of memory is a BIOS owned area, but generally it is
> +	 * not listed as such in the E820 table.
> +	 *
> +	 * Reserve the first memory page and typically some additional
> +	 * memory (64KiB by default) since some BIOSes are known to corrupt
> +	 * low memory. See the Kconfig help text for X86_RESERVE_LOW.
> +	 *
> +	 * In addition, we must make sure page 0 is always reserved because
> +	 * on systems with L1TF its contents can be leaked to user
> +	 * processes.
>  	 */
> -	memblock_reserve(0, PAGE_SIZE);
> +	memblock_reserve(0, ALIGN(reserve_low, PAGE_SIZE));
>  
>  	early_reserve_initrd();
>  
> @@ -757,7 +751,6 @@ static void __init early_reserve_memory(void)
>  	reserve_bios_regions();
>  
>  	trim_platform_memory_ranges();
> -	trim_low_memory_range();
>  }
>  
>  /*
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

