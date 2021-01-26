Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97EA304059
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbhAZOdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:33:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20311 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392742AbhAZObU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611671394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KHCT0BxIY7k8a9W3GWCwiNnAfNTrj8UuA0m2keYyjt0=;
        b=B0S+JgSKqtwcFAmaY5ezWX2WI7I93rSXGBlM6YmMrvSL+EIC2cH0dtZrI0rD3pTDzmg/Ex
        I2bnqvelhBckGBMPBKFEpJr7ox/PsRzNTRxEoBuXimUCE6Xtq2Q3LqWFAPBw3s8tjN6jP5
        WlMNB2ISiFIlio9w8jwNsWzr+fumLyE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-QDWUiAP3NwK2vxd229R-oQ-1; Tue, 26 Jan 2021 09:29:53 -0500
X-MC-Unique: QDWUiAP3NwK2vxd229R-oQ-1
Received: by mail-ej1-f70.google.com with SMTP id dc21so4982000ejb.19
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 06:29:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KHCT0BxIY7k8a9W3GWCwiNnAfNTrj8UuA0m2keYyjt0=;
        b=HSlu9E4L7yBLWtQK30Hm9687gPRYA2hk+7eVsWd+B44xRaQEIUQqp4+Wt4Fk4O09qo
         QmxYUdgqJ+cRbaBwcRy9rXSIHALUMpuTCrtp2P8MlmAOiJ2+ad2Kj3bKy8/8kefZyIyq
         cwmqB18xpdD4P7920YJ2RbqEZqh0HyiMcC5oz8sPpVtrz5uDEleyuTToHfybe+5i5kb6
         uEBP1DE0wNBabqMcr/qJBLkmpXDM82Wsw7nIWw+uYyg4D+4ncoXQ7Ia/7jkx+f6G946d
         2gXdN8rAgQsRyWyX5FHaK2OY+TbmBdA7Jjl5p+m17/rFPIQKk5SJuVkTtV/4juApqBlK
         MVCA==
X-Gm-Message-State: AOAM530pm0JdzsnOZTPDID2r0TM159hbLFBiGJD5Vbp0YIczHWx8mV3D
        GA4eKaoFgbrUAHuUnSPTgwLQ3zK7tDvT5urePqothccKA51TfSq7BxiBc9hY2qVKsQVXVhQCCfQ
        GH2pJDVWfdDgJr2oo0AauNAgZ
X-Received: by 2002:aa7:d88e:: with SMTP id u14mr4676737edq.72.1611671391339;
        Tue, 26 Jan 2021 06:29:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTZQnmkGRrTjQTffqnedeWve/2GbBxWmqgN+CQlqe8O+YndEJGrNTN+0Hhl0tmmY/VpvK/PA==
X-Received: by 2002:aa7:d88e:: with SMTP id u14mr4676725edq.72.1611671391190;
        Tue, 26 Jan 2021 06:29:51 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id r11sm12517280edt.58.2021.01.26.06.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 06:29:50 -0800 (PST)
Subject: Re: [PATCH 16/24] kvm: mmu: Wrap mmu_lock assertions
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210112181041.356734-1-bgardon@google.com>
 <20210112181041.356734-17-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <feb59127-60cd-d0c9-1520-84232c01c6c9@redhat.com>
Date:   Tue, 26 Jan 2021 15:29:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210112181041.356734-17-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/21 19:10, Ben Gardon wrote:
> Wrap assertions and warnings checking the MMU lock state in a function
> which uses lockdep_assert_held. While the existing checks use a few
> different functions to check the lock state, they are all better off
> using lockdep_assert_held. This will support a refactoring to move the
> mmu_lock to struct kvm_arch so that it can be replaced with an rwlock for
> x86.
> 
> Reviewed-by: Peter Feiner <pfeiner@google.com>
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>   arch/arm64/kvm/mmu.c                     | 2 +-
>   arch/powerpc/include/asm/kvm_book3s_64.h | 7 +++----
>   arch/powerpc/kvm/book3s_hv_nested.c      | 3 +--
>   arch/x86/kvm/mmu/mmu_internal.h          | 4 ++--
>   arch/x86/kvm/mmu/tdp_mmu.c               | 8 ++++----
>   include/linux/kvm_host.h                 | 1 +
>   virt/kvm/kvm_main.c                      | 5 +++++
>   7 files changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 57ef1ec23b56..8b54eb58bf47 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -130,7 +130,7 @@ static void __unmap_stage2_range(struct kvm_s2_mmu *mmu, phys_addr_t start, u64
>   	struct kvm *kvm = mmu->kvm;
>   	phys_addr_t end = start + size;
>   
> -	assert_spin_locked(&kvm->mmu_lock);
> +	kvm_mmu_lock_assert_held(kvm);
>   	WARN_ON(size & ~PAGE_MASK);
>   	WARN_ON(stage2_apply_range(kvm, start, end, kvm_pgtable_stage2_unmap,
>   				   may_block));
> diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
> index 9bb9bb370b53..db2e437cd97c 100644
> --- a/arch/powerpc/include/asm/kvm_book3s_64.h
> +++ b/arch/powerpc/include/asm/kvm_book3s_64.h
> @@ -650,8 +650,8 @@ static inline pte_t *find_kvm_secondary_pte(struct kvm *kvm, unsigned long ea,
>   {
>   	pte_t *pte;
>   
> -	VM_WARN(!spin_is_locked(&kvm->mmu_lock),
> -		"%s called with kvm mmu_lock not held \n", __func__);
> +	kvm_mmu_lock_assert_held(kvm);
> +
>   	pte = __find_linux_pte(kvm->arch.pgtable, ea, NULL, hshift);
>   
>   	return pte;
> @@ -662,8 +662,7 @@ static inline pte_t *find_kvm_host_pte(struct kvm *kvm, unsigned long mmu_seq,
>   {
>   	pte_t *pte;
>   
> -	VM_WARN(!spin_is_locked(&kvm->mmu_lock),
> -		"%s called with kvm mmu_lock not held \n", __func__);
> +	kvm_mmu_lock_assert_held(kvm);
>   
>   	if (mmu_notifier_retry(kvm, mmu_seq))
>   		return NULL;
> diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
> index 18890dca9476..6d5987d1eee7 100644
> --- a/arch/powerpc/kvm/book3s_hv_nested.c
> +++ b/arch/powerpc/kvm/book3s_hv_nested.c
> @@ -767,8 +767,7 @@ pte_t *find_kvm_nested_guest_pte(struct kvm *kvm, unsigned long lpid,
>   	if (!gp)
>   		return NULL;
>   
> -	VM_WARN(!spin_is_locked(&kvm->mmu_lock),
> -		"%s called with kvm mmu_lock not held \n", __func__);
> +	kvm_mmu_lock_assert_held(kvm);
>   	pte = __find_linux_pte(gp->shadow_pgtable, ea, NULL, hshift);
>   
>   	return pte;
> diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
> index 7f599cc64178..cc8268cf28d2 100644
> --- a/arch/x86/kvm/mmu/mmu_internal.h
> +++ b/arch/x86/kvm/mmu/mmu_internal.h
> @@ -101,14 +101,14 @@ void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
>   static inline void kvm_mmu_get_root(struct kvm *kvm, struct kvm_mmu_page *sp)
>   {
>   	BUG_ON(!sp->root_count);
> -	lockdep_assert_held(&kvm->mmu_lock);
> +	kvm_mmu_lock_assert_held(kvm);
>   
>   	++sp->root_count;
>   }
>   
>   static inline bool kvm_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *sp)
>   {
> -	lockdep_assert_held(&kvm->mmu_lock);
> +	kvm_mmu_lock_assert_held(kvm);
>   	--sp->root_count;
>   
>   	return !sp->root_count;
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> index fb911ca428b2..1d7c01300495 100644
> --- a/arch/x86/kvm/mmu/tdp_mmu.c
> +++ b/arch/x86/kvm/mmu/tdp_mmu.c
> @@ -117,7 +117,7 @@ void kvm_tdp_mmu_free_root(struct kvm *kvm, struct kvm_mmu_page *root)
>   {
>   	gfn_t max_gfn = 1ULL << (shadow_phys_bits - PAGE_SHIFT);
>   
> -	lockdep_assert_held(&kvm->mmu_lock);
> +	kvm_mmu_lock_assert_held(kvm);
>   
>   	WARN_ON(root->root_count);
>   	WARN_ON(!root->tdp_mmu_page);
> @@ -425,7 +425,7 @@ static inline void __tdp_mmu_set_spte(struct kvm *kvm, struct tdp_iter *iter,
>   	struct kvm_mmu_page *root = sptep_to_sp(root_pt);
>   	int as_id = kvm_mmu_page_as_id(root);
>   
> -	lockdep_assert_held(&kvm->mmu_lock);
> +	kvm_mmu_lock_assert_held(kvm);
>   
>   	WRITE_ONCE(*iter->sptep, new_spte);
>   
> @@ -1139,7 +1139,7 @@ void kvm_tdp_mmu_clear_dirty_pt_masked(struct kvm *kvm,
>   	struct kvm_mmu_page *root;
>   	int root_as_id;
>   
> -	lockdep_assert_held(&kvm->mmu_lock);
> +	kvm_mmu_lock_assert_held(kvm);
>   	for_each_tdp_mmu_root(kvm, root) {
>   		root_as_id = kvm_mmu_page_as_id(root);
>   		if (root_as_id != slot->as_id)
> @@ -1324,7 +1324,7 @@ bool kvm_tdp_mmu_write_protect_gfn(struct kvm *kvm,
>   	int root_as_id;
>   	bool spte_set = false;
>   
> -	lockdep_assert_held(&kvm->mmu_lock);
> +	kvm_mmu_lock_assert_held(kvm);
>   	for_each_tdp_mmu_root(kvm, root) {
>   		root_as_id = kvm_mmu_page_as_id(root);
>   		if (root_as_id != slot->as_id)
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 6e2773fc406c..022e3522788f 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1499,5 +1499,6 @@ void kvm_mmu_lock(struct kvm *kvm);
>   void kvm_mmu_unlock(struct kvm *kvm);
>   int kvm_mmu_lock_needbreak(struct kvm *kvm);
>   int kvm_mmu_lock_cond_resched(struct kvm *kvm);
> +void kvm_mmu_lock_assert_held(struct kvm *kvm);

Probably better to make this an empty inline if !defined(CONFIG_LOCKDEP).

Paolo

>   #endif
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index b4c49a7e0556..c504f876176b 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -452,6 +452,11 @@ int kvm_mmu_lock_cond_resched(struct kvm *kvm)
>   	return cond_resched_lock(&kvm->mmu_lock);
>   }
>   
> +void kvm_mmu_lock_assert_held(struct kvm *kvm)
> +{
> +	lockdep_assert_held(&kvm->mmu_lock);
> +}
> +
>   #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
>   static inline struct kvm *mmu_notifier_to_kvm(struct mmu_notifier *mn)
>   {
> 

