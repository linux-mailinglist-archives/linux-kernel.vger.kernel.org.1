Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E98C2FB86A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393125AbhASMcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 07:32:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21005 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404351AbhASM0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 07:26:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611059097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JLgHgXXW0OYFe/fFKF3eEdFG6WD2TIs1rVHSJXUnL3A=;
        b=QaUfCtItly6su5T08mi2bm0wW4G/gwtlkDiaKYIveTcAD8sQTqLdTa+Xr+g/q2c9cG0DgP
        0PI81VZhX6PcBkMH6Uxd6kuoYbbduSDFhrClZ7nizH86RWL4JLq3PlCdUs4quexFhlP0Dz
        +o7U+5LLIJL0SB3xwgyN/fbRvXUQnoI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-Xb9vgP2-Njm-WDN7YklXfw-1; Tue, 19 Jan 2021 07:24:53 -0500
X-MC-Unique: Xb9vgP2-Njm-WDN7YklXfw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5295800D53;
        Tue, 19 Jan 2021 12:24:51 +0000 (UTC)
Received: from [10.36.114.143] (ovpn-114-143.ams2.redhat.com [10.36.114.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2AB3660BF1;
        Tue, 19 Jan 2021 12:24:49 +0000 (UTC)
Subject: Re: [PATCH V3 2/3] arm64/mm: Define arch_get_mappable_range()
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, hca@linux.ibm.com,
        catalin.marinas@arm.com
Cc:     Oscar Salvador <osalvador@suse.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1610975582-12646-1-git-send-email-anshuman.khandual@arm.com>
 <1610975582-12646-3-git-send-email-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <6639d856-665c-7a60-884c-5771a8b805ba@redhat.com>
Date:   Tue, 19 Jan 2021 13:24:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1610975582-12646-3-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.01.21 14:13, Anshuman Khandual wrote:
> This overrides arch_get_mappable_range() on arm64 platform which will be
> used with recently added generic framework. It drops inside_linear_region()
> and subsequent check in arch_add_memory() which are no longer required. It
> also adds a VM_BUG_ON() check that would ensure that memhp_range_allowed()
> has already been called.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/mm/mmu.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index ae0c3d023824..f2e1770c9f29 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1442,16 +1442,19 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
>  	free_empty_tables(start, end, PAGE_OFFSET, PAGE_END);
>  }
>  
> -static bool inside_linear_region(u64 start, u64 size)
> +struct range arch_get_mappable_range(void)
>  {
> +	struct range memhp_range;
> +
>  	/*
>  	 * Linear mapping region is the range [PAGE_OFFSET..(PAGE_END - 1)]
>  	 * accommodating both its ends but excluding PAGE_END. Max physical
>  	 * range which can be mapped inside this linear mapping range, must
>  	 * also be derived from its end points.
>  	 */
> -	return start >= __pa(_PAGE_OFFSET(vabits_actual)) &&
> -	       (start + size - 1) <= __pa(PAGE_END - 1);
> +	memhp_range.start = __pa(_PAGE_OFFSET(vabits_actual));
> +	memhp_range.end =  __pa(PAGE_END - 1);
> +	return memhp_range;
>  }
>  
>  int arch_add_memory(int nid, u64 start, u64 size,
> @@ -1459,11 +1462,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  {
>  	int ret, flags = 0;
>  
> -	if (!inside_linear_region(start, size)) {
> -		pr_err("[%llx %llx] is outside linear mapping region\n", start, start + size);
> -		return -EINVAL;
> -	}
> -
> +	VM_BUG_ON(!memhp_range_allowed(start, size, true));
>  	if (rodata_full || debug_pagealloc_enabled())
>  		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>  
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

