Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E87279215
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgIYUdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:33:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726348AbgIYUYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:24:36 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601065474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=01ndKfa+GCpznGQ+xNkSEDCqzBhgr3SNm6LzFG9u5Yg=;
        b=Tdm9+iZchv8VCKMBgaya2Q1uWntwy4Cp+hxyQQGn/sKlnkamyOmh+n/e53Rv6g4gmwqbjI
        9cswsc98IcapuVXLOzh3rAyQ9TRcADNHkoLDuFhozhxC/g1NGIV/lsfQyfP0QeLxUcn84g
        oCQx0n+bnW8cLin2SRE0TaSnDmSvofQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-vqUQZtyyNIiOZn3kZCpeTQ-1; Fri, 25 Sep 2020 16:24:32 -0400
X-MC-Unique: vqUQZtyyNIiOZn3kZCpeTQ-1
Received: by mail-wr1-f71.google.com with SMTP id 33so1505392wrk.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 13:24:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=01ndKfa+GCpznGQ+xNkSEDCqzBhgr3SNm6LzFG9u5Yg=;
        b=KlGWicTryMdlELih1U9f91pSYDe5WINP+Z+NUHqxHnCUSHIT6iO8FQes0xcCx54Oi5
         I3YOrmbCT73SbnVc2zf8cvsiWXHWeTLIR7/lmXJb773MPs8cyTnzehhzC0pMVVO7yW/5
         oEEoGl3EfVwWbmzQtV8gK+WZ1LXdUNpYi2HfZYR/vPoAIoDuaZBg0X7UZbYzai+VQwmF
         82NnhJ2XJ8+A2VuhOG3JaS/e0wcDEjjYN1SLJiN+4FanM1JgHYmeEOs1znZjfyutxg7w
         mOkiDuIhnemIBTA7COA+ckG+o3XA5x3vbvZIxFjJCBXy9c533XAKFdsEzMDFSQ6J6/fY
         qdMw==
X-Gm-Message-State: AOAM5324aLETPjKLdyqklqG7+GfNQGMc0D+qZAu8NGm4Ji599yrD5jTu
        Eu2mL/rDxI1cl2xXsSrEpGecFf+zPl/ZRqvZaMzEaGUvFhuztyD0UOmd7Mo8qpPeEHAGd+y4xTA
        Qjbx8xCsG8tXz/uauqLKN4IFA
X-Received: by 2002:a5d:6547:: with SMTP id z7mr6208961wrv.322.1601065471444;
        Fri, 25 Sep 2020 13:24:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaQPODIezVDHXXWdfc2VVPnz/e845Ud7GS+vwdoI3SF/yRDmnPzuPoZlSWH536vc4TF+RGSQ==
X-Received: by 2002:a5d:6547:: with SMTP id z7mr6208948wrv.322.1601065471178;
        Fri, 25 Sep 2020 13:24:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf? ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
        by smtp.gmail.com with ESMTPSA id l5sm188279wmf.10.2020.09.25.13.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 13:24:30 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86/mmu: Stash 'kvm' in a local variable in
 kvm_mmu_free_roots()
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200923191204.8410-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b9c04020-3bd9-05f4-9306-4e24e7587740@redhat.com>
Date:   Fri, 25 Sep 2020 22:24:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923191204.8410-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/20 21:12, Sean Christopherson wrote:
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
>  
> 

Queued this one, for now.

Paolo

