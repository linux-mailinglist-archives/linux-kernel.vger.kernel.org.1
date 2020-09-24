Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6292277140
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgIXMm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:42:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35065 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727722AbgIXMm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600951344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1oG8raWp9jQLZJ6ZPnSu5CGYjsnTW1Sct0OlPCPovyo=;
        b=SzlGagWv7Z8u3XstQbvMF75iFOQXlADszKM1ncmIL6zDFnmy5qsMvYAGH2ZfptLsflhVxU
        paJZUYIJveTHCxJt5p/wLHrOAgvN/UweRYBm3OFk23cfJF7Of5ZF+uyGmR+dK8ozMO8KNM
        DgpcSPy3ia7EOhoH/NX2s2GSCvUHmck=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-EPADIVuwPSW5HM3iDCR-_g-1; Thu, 24 Sep 2020 08:42:22 -0400
X-MC-Unique: EPADIVuwPSW5HM3iDCR-_g-1
Received: by mail-ed1-f72.google.com with SMTP id r21so1129142eda.20
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=1oG8raWp9jQLZJ6ZPnSu5CGYjsnTW1Sct0OlPCPovyo=;
        b=Kbt/TsN3qE41+FodwYrQTwIur0y7G+J/6HQ45Be//4gXoGZpSBNb3jJUeawHrMQiKZ
         1/RT8dkJ8Jui7C2gWD3DljoiQek3c45IUX98kvz2/jN6VMV8psv6p38YO+S8GK1j25jC
         NITDldaZYc9SJoaEgGzNpcjKQNTnRF8VuGz3deeeN61F8NT3YOblGcC4VZIWetumGUMu
         pRCyRGAyZV11IzAIm8U9mQuz1niH8qq2rRi5IchrrRY4SujgoK7wDYMNoxGgLahAHvHt
         eeyvpsUDukKkigFu8o4nYLowtB45qIhRhGeV9rJQpazZCBbP+vgRizU6HW+905nBAiqP
         kTzQ==
X-Gm-Message-State: AOAM533XxRK6OeQk4kh3powe+grrKOOIYwEc+FiiTMz2S4OYgNG1KzDc
        mGczGedeRxWhINfrxkirI5DfdlwqReyZhESTlJO/+URpzTKp8ZAVStUu0akc7WL0XBZ/HXni9/O
        LXQUrjR43ql3uIJSFZaH4BsXl
X-Received: by 2002:a17:907:394:: with SMTP id ss20mr819244ejb.120.1600951340889;
        Thu, 24 Sep 2020 05:42:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxp8lEE/44Rl5KNBVpGxQ/u4Y3jmeeyLqwhKssEJwf2ePb/11oX3g6CNB50t9lD6awRJ4hdiQ==
X-Received: by 2002:a17:907:394:: with SMTP id ss20mr819224ejb.120.1600951340696;
        Thu, 24 Sep 2020 05:42:20 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u13sm2373819ejn.82.2020.09.24.05.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:42:20 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86/mmu: Stash 'kvm' in a local variable in kvm_mmu_free_roots()
In-Reply-To: <20200923191204.8410-1-sean.j.christopherson@intel.com>
References: <20200923191204.8410-1-sean.j.christopherson@intel.com>
Date:   Thu, 24 Sep 2020 14:42:19 +0200
Message-ID: <875z83e47o.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> To make kvm_mmu_free_roots() a bit more readable, capture 'kvm' in a
> local variable instead of doing vcpu->kvm over and over (and over).
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 76c5826e29a2..cdc498093450 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3603,6 +3603,7 @@ static void mmu_free_root_page(struct kvm *kvm, hpa_t *root_hpa,
>  void kvm_mmu_free_roots(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
>  			ulong roots_to_free)
>  {
> +	struct kvm *kvm = vcpu->kvm;
>  	int i;
>  	LIST_HEAD(invalid_list);
>  	bool free_active_root = roots_to_free & KVM_MMU_ROOT_CURRENT;
> @@ -3620,22 +3621,21 @@ void kvm_mmu_free_roots(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
>  			return;
>  	}
>  
> -	spin_lock(&vcpu->kvm->mmu_lock);
> +	spin_lock(&kvm->mmu_lock);
>  
>  	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
>  		if (roots_to_free & KVM_MMU_ROOT_PREVIOUS(i))
> -			mmu_free_root_page(vcpu->kvm, &mmu->prev_roots[i].hpa,
> +			mmu_free_root_page(kvm, &mmu->prev_roots[i].hpa,
>  					   &invalid_list);
>  
>  	if (free_active_root) {
>  		if (mmu->shadow_root_level >= PT64_ROOT_4LEVEL &&
>  		    (mmu->root_level >= PT64_ROOT_4LEVEL || mmu->direct_map)) {
> -			mmu_free_root_page(vcpu->kvm, &mmu->root_hpa,
> -					   &invalid_list);
> +			mmu_free_root_page(kvm, &mmu->root_hpa, &invalid_list);
>  		} else {
>  			for (i = 0; i < 4; ++i)
>  				if (mmu->pae_root[i] != 0)
> -					mmu_free_root_page(vcpu->kvm,
> +					mmu_free_root_page(kvm,
>  							   &mmu->pae_root[i],
>  							   &invalid_list);
>  			mmu->root_hpa = INVALID_PAGE;
> @@ -3643,8 +3643,8 @@ void kvm_mmu_free_roots(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
>  		mmu->root_pgd = 0;
>  	}
>  
> -	kvm_mmu_commit_zap_page(vcpu->kvm, &invalid_list);
> -	spin_unlock(&vcpu->kvm->mmu_lock);
> +	kvm_mmu_commit_zap_page(kvm, &invalid_list);
> +	spin_unlock(&kvm->mmu_lock);
>  }
>  EXPORT_SYMBOL_GPL(kvm_mmu_free_roots);

What about kvm_mmu_get_page(), make_mmu_pages_available(),
mmu_alloc_root(), kvm_mmu_sync_roots(), direct_page_fault(),
kvm_mmu_pte_write() which seem to be using the same ugly pattern? :-)

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

