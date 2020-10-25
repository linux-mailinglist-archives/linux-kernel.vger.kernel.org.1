Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE972984EC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 00:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420440AbgJYXE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 19:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32282 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1419494AbgJYXER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 19:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603667056;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZ61VPZfrTu9duYvMk/2WhirgCweNVgLgvIy9tS4rdY=;
        b=aOsT1ZgykTuFmoHrxPNyA2DV4iT/a1jBWMGHHFfGJ2BhkG//kk6gG9016BWNwdi9aZj5SE
        3kTLR3MZMNzfLZBoXrOLoPDW+3jgp2ry4ka+bc9RzTjtup/Zbu5TPyk0qfG24vmarU9pEg
        xtcczrPUXcx7qPFpZDr2Thi6I+PZdtE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-3PDn1c1fOKu5g9APe2vnVQ-1; Sun, 25 Oct 2020 19:04:14 -0400
X-MC-Unique: 3PDn1c1fOKu5g9APe2vnVQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90C7A8049D0;
        Sun, 25 Oct 2020 23:04:12 +0000 (UTC)
Received: from [10.64.54.35] (vpn2-54-35.bne.redhat.com [10.64.54.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E11AB60BF3;
        Sun, 25 Oct 2020 23:04:10 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 3/3] KVM: arm64: Failback on unsupported huge page sizes
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        will@kernel.org, alexandru.elisei@arm.com
References: <20201025002739.5804-1-gshan@redhat.com>
 <20201025002739.5804-4-gshan@redhat.com> <87y2juoa2s.wl-maz@kernel.org>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <74539016-f41f-c6a0-5c37-034204dc00cc@redhat.com>
Date:   Mon, 26 Oct 2020 10:04:08 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <87y2juoa2s.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 10/25/20 9:48 PM, Marc Zyngier wrote:
> On Sun, 25 Oct 2020 01:27:39 +0100,
> Gavin Shan <gshan@redhat.com> wrote:
>>
>> The huge page could be mapped through multiple contiguous PMDs or PTEs.
>> The corresponding huge page sizes aren't supported by the page table
>> walker currently.
>>
>> This fails the unsupported huge page sizes to the near one. Otherwise,
>> the guest can't boot successfully: CONT_PMD_SHIFT and CONT_PTE_SHIFT
>> fail back to PMD_SHIFT and PAGE_SHIFT separately.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/kvm/mmu.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index 0f51585adc04..81cbdc368246 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -793,12 +793,20 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   		vma_shift = PMD_SHIFT;
>>   #endif
>>   
>> +	if (vma_shift == CONT_PMD_SHIFT)
>> +		vma_shift = PMD_SHIFT;
>> +
>>   	if (vma_shift == PMD_SHIFT &&
>>   	    !fault_supports_stage2_huge_mapping(memslot, hva, PMD_SIZE)) {
>>   		force_pte = true;
>>   		vma_shift = PAGE_SHIFT;
>>   	}
>>   
>> +	if (vma_shift == CONT_PTE_SHIFT) {
>> +		force_pte = true;
>> +		vma_shift = PAGE_SHIFT;
>> +	}
>> +
>>   	vma_pagesize = 1UL << vma_shift;
>>   	if (vma_pagesize == PMD_SIZE || vma_pagesize == PUD_SIZE)
>>   		fault_ipa &= ~(vma_pagesize - 1);
> 
> Yup, nice catch. However, I think we should take this opportunity to
> rationalise the logic here, and catch future discrepancies (should
> someone add contiguous PUD or something similarly silly). How about
> something like this (untested):
> 

Yeah, I started the work to support contiguous PMDs/PTEs, but I'm not
sure when I can post the patches for review as my time becomes a bit
fragmented recently. At least, I need focus on "async page fault" in
the coming weeks :)

Thanks for the suggested code and it worked for me. I'll post v2 to
integrate them. However, I would like to drop PATCH[1] and PATCH[2]
as I really don't have strong reasons to have them.

Thanks,
Gavin

> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index cc323d96c9d4..d9a13a8a82e0 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -787,14 +787,31 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>   		vma_shift = PAGE_SHIFT;
>   	}
>   
> -	if (vma_shift == PUD_SHIFT &&
> -	    !fault_supports_stage2_huge_mapping(memslot, hva, PUD_SIZE))
> -	       vma_shift = PMD_SHIFT;
> +	switch (vma_shift) {
> +	case PUD_SHIFT:
> +		if (fault_supports_stage2_huge_mapping(memslot, hva, PUD_SIZE))
> +			break;
> +		fallthrough;
>   
> -	if (vma_shift == PMD_SHIFT &&
> -	    !fault_supports_stage2_huge_mapping(memslot, hva, PMD_SIZE)) {
> -		force_pte = true;
> +	case CONT_PMD_SHIFT:
> +		vma_shift = PMD_SHIFT;
> +		fallthrough;
> +
> +	case PMD_SHIFT:
> +		if (fault_supports_stage2_huge_mapping(memslot, hva, PMD_SIZE))
> +			break;
> +		fallthrough;
> +
> +	case CONT_PTE_SHIFT:
>   		vma_shift = PAGE_SHIFT;
> +		force_pte = true;
> +		fallthrough;
> +
> +	case PAGE_SHIFT:
> +		break;
> +
> +	default:
> +		WARN_ONCE(1, "Unknown vma_shift %d", vma_shift);
>   	}
>   
>   	vma_pagesize = 1UL << vma_shift;
> 

