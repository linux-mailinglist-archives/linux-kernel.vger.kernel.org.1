Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62BC2CB8D9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgLBJ2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:28:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729019AbgLBJ2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:28:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606901208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HdQhf3f0XYYFLx0KyrpykAdlztXBpPhnQ/LWm5/Hvoo=;
        b=HG1+V40wdpYwoWgJ2F0lmxqfoDaXXoB0X9eVxkxPZjj2shoOiF1d+YfGY9Rnv6clVKgT6m
        JI1Pl/RNjQhm1sl95NTyKI4eGZJlDBFMAGACxGhMH1D3PNGXCt5iDIM9nAnSq6Eb11WOSR
        SRN3nFxpp9LrWg0oHMeii5r9ISTp7QU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-f_OQLGxUMuezZwIbbWr03Q-1; Wed, 02 Dec 2020 04:26:46 -0500
X-MC-Unique: f_OQLGxUMuezZwIbbWr03Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 077AB1926DB5;
        Wed,  2 Dec 2020 09:26:41 +0000 (UTC)
Received: from [10.36.113.108] (ovpn-113-108.ams2.redhat.com [10.36.113.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C57460BFA;
        Wed,  2 Dec 2020 09:26:38 +0000 (UTC)
Subject: Re: [RFC V2 2/3] arm64/mm: Define arch_get_mappable_range()
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <1606706992-26656-1-git-send-email-anshuman.khandual@arm.com>
 <1606706992-26656-3-git-send-email-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <1861413c-fd23-f3e2-14f3-00feec6ff2fb@redhat.com>
Date:   Wed, 2 Dec 2020 10:26:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1606706992-26656-3-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.11.20 04:29, Anshuman Khandual wrote:
> This overrides arch_get_mappable_range() on arm64 platform which will be
> used with recently added generic framework. It drops inside_linear_region()
> and subsequent check in arch_add_memory() which are no longer required.
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
>  arch/arm64/mm/mmu.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index ca692a815731..49ec8f2838f2 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1444,16 +1444,19 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
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
> @@ -1461,11 +1464,6 @@ int arch_add_memory(int nid, u64 start, u64 size,
>  {
>  	int ret, flags = 0;
>  
> -	if (!inside_linear_region(start, size)) {
> -		pr_err("[%llx %llx] is outside linear mapping region\n", start, start + size);
> -		return -EINVAL;
> -	}

As discussed, I think something like a VM_BUG_ON() here might makes
sense, indicating that we require the caller to validate upfront. Same
applies to the s390x variant.

Thanks!

> -
>  	if (rodata_full || debug_pagealloc_enabled())
>  		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>  
> 


-- 
Thanks,

David / dhildenb

