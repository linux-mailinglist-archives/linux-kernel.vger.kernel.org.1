Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A27275E23
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 19:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIWRCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 13:02:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51998 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726342AbgIWRCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600880571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wh8ZSulQnN1Zj4DNTEW6JJd0xzaPcYkEfvdxXHeAev8=;
        b=CvIB/meMokjYBcwbtZoPgPl3kctoTZ7WbTjQYDGu+dRMPXJeWxqHJ6kIBgsG6vSd4XmfGv
        exbAGhJ0+5RBz53x+01Vux/cDcVYizdkqUclvwN5v91V1RG4xJZezZiN3VEfBgo2SwWSaw
        5n/iMCtpWTkbV7Ms4OP0x7dIo+o1iU4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-tENGgg_FNrSnDnuStt61tA-1; Wed, 23 Sep 2020 13:02:49 -0400
X-MC-Unique: tENGgg_FNrSnDnuStt61tA-1
Received: by mail-wm1-f69.google.com with SMTP id a25so164629wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 10:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wh8ZSulQnN1Zj4DNTEW6JJd0xzaPcYkEfvdxXHeAev8=;
        b=hNO3Q99fMggmeMp+lV98cLIjV7ULoJg12JAVlzODx9yEyp74gzdaRGyoxvO5YbBj7K
         gyVczMuso8rDq9bFXN3W9J+FakMAFZyzwzGy4C4+JSV1GH45bdxwsditu45t9XZZKcQi
         6ROU/arrMR4gk4y0VNMJCm7ISnS9LoB3XWcTmtze1n9sM7qtCXDcLQ7my0Z/feIJ6IGi
         z3+beyQDWECcY5qF/wyv9ncSvtY5VO3V3hDrbitBq2A9v5dJkPoxlRRw5ZKvjzOu72VO
         5BSfkr3CHbzXcBsgTgXjXcyGfN3j907ieZh70DKLes8wmLKK9zD4ghRc9TjLLcM2X6td
         Z/0g==
X-Gm-Message-State: AOAM531sQBTmDztVAjVZKAHuYlt+4IdZrju45A8mNy7W472nUnl3B6Y4
        T0UfFg2oLXvf7G7tbk6azyVuh91Zow6Bll6X2kLTlsr08t3f3P4EEikuC6LIR3W1az58uv+d3cp
        R1VcZ2drBiA9mBpdM6nN6FC59
X-Received: by 2002:a7b:c959:: with SMTP id i25mr532801wml.39.1600880567942;
        Wed, 23 Sep 2020 10:02:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQEms+v2XPzjI+yTDNOtuowwjrFIgRvbOnHL8okDQ1x8MM4BVX6RRR+HIiTftDIxYMCyn7AA==
X-Received: by 2002:a7b:c959:: with SMTP id i25mr532778wml.39.1600880567699;
        Wed, 23 Sep 2020 10:02:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:15f1:648d:7de6:bad9? ([2001:b07:6468:f312:15f1:648d:7de6:bad9])
        by smtp.gmail.com with ESMTPSA id z19sm422712wmi.3.2020.09.23.10.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 10:02:47 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86/mmu: Move individual kvm_mmu initialization into
 common helper
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200923163314.8181-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <815dfaef-54e3-f0e8-9641-8a87f8910b74@redhat.com>
Date:   Wed, 23 Sep 2020 19:02:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923163314.8181-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/20 18:33, Sean Christopherson wrote:
> Move initialization of 'struct kvm_mmu' fields into alloc_mmu_pages() to
> consolidate code, and rename the helper to __kvm_mmu_create().
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 76c5826e29a2..a2c4c71ce5f2 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5682,11 +5682,17 @@ static void free_mmu_pages(struct kvm_mmu *mmu)
>  	free_page((unsigned long)mmu->lm_root);
>  }
>  
> -static int alloc_mmu_pages(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu)
> +static int __kvm_mmu_create(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu)
>  {
>  	struct page *page;
>  	int i;
>  
> +	mmu->root_hpa = INVALID_PAGE;
> +	mmu->root_pgd = 0;
> +	mmu->translate_gpa = translate_gpa;
> +	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
> +		mmu->prev_roots[i] = KVM_MMU_ROOT_INFO_INVALID;
> +
>  	/*
>  	 * When using PAE paging, the four PDPTEs are treated as 'root' pages,
>  	 * while the PDP table is a per-vCPU construct that's allocated at MMU
> @@ -5712,7 +5718,6 @@ static int alloc_mmu_pages(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu)
>  
>  int kvm_mmu_create(struct kvm_vcpu *vcpu)
>  {
> -	uint i;
>  	int ret;
>  
>  	vcpu->arch.mmu_pte_list_desc_cache.kmem_cache = pte_list_desc_cache;
> @@ -5726,25 +5731,13 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
>  	vcpu->arch.mmu = &vcpu->arch.root_mmu;
>  	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
>  
> -	vcpu->arch.root_mmu.root_hpa = INVALID_PAGE;
> -	vcpu->arch.root_mmu.root_pgd = 0;
> -	vcpu->arch.root_mmu.translate_gpa = translate_gpa;
> -	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
> -		vcpu->arch.root_mmu.prev_roots[i] = KVM_MMU_ROOT_INFO_INVALID;
> -
> -	vcpu->arch.guest_mmu.root_hpa = INVALID_PAGE;
> -	vcpu->arch.guest_mmu.root_pgd = 0;
> -	vcpu->arch.guest_mmu.translate_gpa = translate_gpa;
> -	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
> -		vcpu->arch.guest_mmu.prev_roots[i] = KVM_MMU_ROOT_INFO_INVALID;
> -
>  	vcpu->arch.nested_mmu.translate_gpa = translate_nested_gpa;
>  
> -	ret = alloc_mmu_pages(vcpu, &vcpu->arch.guest_mmu);
> +	ret = __kvm_mmu_create(vcpu, &vcpu->arch.guest_mmu);
>  	if (ret)
>  		return ret;
>  
> -	ret = alloc_mmu_pages(vcpu, &vcpu->arch.root_mmu);
> +	ret = __kvm_mmu_create(vcpu, &vcpu->arch.root_mmu);
>  	if (ret)
>  		goto fail_allocate_root;
>  
> 

Queued, thanks.

Paolo

