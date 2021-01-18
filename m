Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9477B2FA7B0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 18:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407193AbhARRjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 12:39:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41091 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407161AbhARRiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610991387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C4BIvijtTCFRInD8sJaPxioj3tsQhQdD1h715mh0AJ8=;
        b=bYpHVs3rL7/Uiv6l3NxJX2BonYe0NkcVJEDBj9m4kh3nyvwy8Y1Cooelfq/pdJDq+XCNVx
        IXrLObvvlNsuopk3Ahay0H47pnyQAZY/4MpK8mgXzoWhe1nrZPWSuxQLqb2/JOv59wNiXF
        d7CMtBerlWzzJAVqQMPOhrS4rBYmyC0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-lc1TQiYKPXGu6c6GnoLeIw-1; Mon, 18 Jan 2021 12:36:26 -0500
X-MC-Unique: lc1TQiYKPXGu6c6GnoLeIw-1
Received: by mail-wm1-f69.google.com with SMTP id k64so1269217wmb.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 09:36:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C4BIvijtTCFRInD8sJaPxioj3tsQhQdD1h715mh0AJ8=;
        b=I9C5VTTzhj4LF7xIGcGRoU2jKYydZTIgXEs6ZEYisvn+s3gZPqQWSUpWZ/S1wjRW9S
         9IpU1HsZeTf6Bx6XbHPJBGxb2ika1w1YjwBjAbCWwr/2V+eilBzWMzxxfYT3ATHwee12
         moPUMgzr0NPLV34FtCF30+S+muDJQRBVY3w5mCf6uKnXskMDn0KLZpQZQUK033xcykV5
         n3vQGabLUw7jB7DVDFir5AtbMQFqW659a7AfFIhzBwcysA1B/j1Edpg34XEHNoZmqKFF
         BMssoHD0DNFhQTkTulEpPaKg+ZlPMHqWUzZ2fsInSoAEt8tbPxB/MDofuAe5g/rF7OaH
         qTgg==
X-Gm-Message-State: AOAM531ytTaQ3BUc11gK7YWXi+5YLwKy5IHw/AHKdCTZiClXA4UNup8M
        wyAJyok20Liiu3/sIrwiDXeHbq3OIzgs+QnVWwzOWdloJNJ7RbBc5yYpwdkOdDakwURIZX6tc2v
        Op6GD+JQOF1glW77VmdkvQ8Hj
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr519921wrw.379.1610991384797;
        Mon, 18 Jan 2021 09:36:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+LGjMN1uLF9Y+lKiDjEKBGjUmYUd0Ct0zvbGZ0sHTBvcsr4Imp7l+pN796MGkXLgrw71alA==
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr519911wrw.379.1610991384626;
        Mon, 18 Jan 2021 09:36:24 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id z6sm32525165wrw.58.2021.01.18.09.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 09:36:23 -0800 (PST)
Subject: Re: [PATCH] KVM: x86/mmu: Remove the defunct update_pte() paging hook
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu Zhang <yu.c.zhang@intel.com>
References: <20210115004051.4099250-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <05e9d3e7-d72e-e972-aeb8-2189c39fc904@redhat.com>
Date:   Mon, 18 Jan 2021 18:36:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210115004051.4099250-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/21 01:40, Sean Christopherson wrote:
> Remove the update_pte() shadow paging logic, which was obsoleted by
> commit 4731d4c7a077 ("KVM: MMU: out of sync shadow core"), but never
> removed.  As pointed out by Yu, KVM never write protects leaf page
> tables for the purposes of shadow paging, and instead marks their
> associated shadow page as unsync so that the guest can write PTEs at
> will.
> 
> The update_pte() path, which predates the unsync logic, optimizes COW
> scenarios by refreshing leaf SPTEs when they are written, as opposed to
> zapping the SPTE, restarting the guest, and installing the new SPTE on
> the subsequent fault.  Since KVM no longer write-protects leaf page
> tables, update_pte() is unreachable and can be dropped.
> 
> Reported-by: Yu Zhang <yu.c.zhang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/include/asm/kvm_host.h |  3 --
>   arch/x86/kvm/mmu/mmu.c          | 49 ++-------------------------------
>   arch/x86/kvm/x86.c              |  1 -
>   3 files changed, 2 insertions(+), 51 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 3d6616f6f6ef..ed575c5655dd 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -358,8 +358,6 @@ struct kvm_mmu {
>   	int (*sync_page)(struct kvm_vcpu *vcpu,
>   			 struct kvm_mmu_page *sp);
>   	void (*invlpg)(struct kvm_vcpu *vcpu, gva_t gva, hpa_t root_hpa);
> -	void (*update_pte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
> -			   u64 *spte, const void *pte);
>   	hpa_t root_hpa;
>   	gpa_t root_pgd;
>   	union kvm_mmu_role mmu_role;
> @@ -1031,7 +1029,6 @@ struct kvm_arch {
>   struct kvm_vm_stat {
>   	ulong mmu_shadow_zapped;
>   	ulong mmu_pte_write;
> -	ulong mmu_pte_updated;
>   	ulong mmu_pde_zapped;
>   	ulong mmu_flooded;
>   	ulong mmu_recycled;
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 6d16481aa29d..3a2c25852b1f 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -1723,13 +1723,6 @@ static int nonpaging_sync_page(struct kvm_vcpu *vcpu,
>   	return 0;
>   }
>   
> -static void nonpaging_update_pte(struct kvm_vcpu *vcpu,
> -				 struct kvm_mmu_page *sp, u64 *spte,
> -				 const void *pte)
> -{
> -	WARN_ON(1);
> -}
> -
>   #define KVM_PAGE_ARRAY_NR 16
>   
>   struct kvm_mmu_pages {
> @@ -3813,7 +3806,6 @@ static void nonpaging_init_context(struct kvm_vcpu *vcpu,
>   	context->gva_to_gpa = nonpaging_gva_to_gpa;
>   	context->sync_page = nonpaging_sync_page;
>   	context->invlpg = NULL;
> -	context->update_pte = nonpaging_update_pte;
>   	context->root_level = 0;
>   	context->shadow_root_level = PT32E_ROOT_LEVEL;
>   	context->direct_map = true;
> @@ -4395,7 +4387,6 @@ static void paging64_init_context_common(struct kvm_vcpu *vcpu,
>   	context->gva_to_gpa = paging64_gva_to_gpa;
>   	context->sync_page = paging64_sync_page;
>   	context->invlpg = paging64_invlpg;
> -	context->update_pte = paging64_update_pte;
>   	context->shadow_root_level = level;
>   	context->direct_map = false;
>   }
> @@ -4424,7 +4415,6 @@ static void paging32_init_context(struct kvm_vcpu *vcpu,
>   	context->gva_to_gpa = paging32_gva_to_gpa;
>   	context->sync_page = paging32_sync_page;
>   	context->invlpg = paging32_invlpg;
> -	context->update_pte = paging32_update_pte;
>   	context->shadow_root_level = PT32E_ROOT_LEVEL;
>   	context->direct_map = false;
>   }
> @@ -4506,7 +4496,6 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu)
>   	context->page_fault = kvm_tdp_page_fault;
>   	context->sync_page = nonpaging_sync_page;
>   	context->invlpg = NULL;
> -	context->update_pte = nonpaging_update_pte;
>   	context->shadow_root_level = kvm_mmu_get_tdp_level(vcpu);
>   	context->direct_map = true;
>   	context->get_guest_pgd = get_cr3;
> @@ -4678,7 +4667,6 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
>   	context->gva_to_gpa = ept_gva_to_gpa;
>   	context->sync_page = ept_sync_page;
>   	context->invlpg = ept_invlpg;
> -	context->update_pte = ept_update_pte;
>   	context->root_level = level;
>   	context->direct_map = false;
>   	context->mmu_role.as_u64 = new_role.as_u64;
> @@ -4826,19 +4814,6 @@ void kvm_mmu_unload(struct kvm_vcpu *vcpu)
>   }
>   EXPORT_SYMBOL_GPL(kvm_mmu_unload);
>   
> -static void mmu_pte_write_new_pte(struct kvm_vcpu *vcpu,
> -				  struct kvm_mmu_page *sp, u64 *spte,
> -				  const void *new)
> -{
> -	if (sp->role.level != PG_LEVEL_4K) {
> -		++vcpu->kvm->stat.mmu_pde_zapped;
> -		return;
> -        }
> -
> -	++vcpu->kvm->stat.mmu_pte_updated;
> -	vcpu->arch.mmu->update_pte(vcpu, sp, spte, new);
> -}
> -
>   static bool need_remote_flush(u64 old, u64 new)
>   {
>   	if (!is_shadow_present_pte(old))
> @@ -4954,22 +4929,6 @@ static u64 *get_written_sptes(struct kvm_mmu_page *sp, gpa_t gpa, int *nspte)
>   	return spte;
>   }
>   
> -/*
> - * Ignore various flags when determining if a SPTE can be immediately
> - * overwritten for the current MMU.
> - *  - level: explicitly checked in mmu_pte_write_new_pte(), and will never
> - *    match the current MMU role, as MMU's level tracks the root level.
> - *  - access: updated based on the new guest PTE
> - *  - quadrant: handled by get_written_sptes()
> - *  - invalid: always false (loop only walks valid shadow pages)
> - */
> -static const union kvm_mmu_page_role role_ign = {
> -	.level = 0xf,
> -	.access = 0x7,
> -	.quadrant = 0x3,
> -	.invalid = 0x1,
> -};
> -
>   static void kvm_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t gpa,
>   			      const u8 *new, int bytes,
>   			      struct kvm_page_track_notifier_node *node)
> @@ -5020,14 +4979,10 @@ static void kvm_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t gpa,
>   
>   		local_flush = true;
>   		while (npte--) {
> -			u32 base_role = vcpu->arch.mmu->mmu_role.base.word;
> -
>   			entry = *spte;
>   			mmu_page_zap_pte(vcpu->kvm, sp, spte, NULL);
> -			if (gentry &&
> -			    !((sp->role.word ^ base_role) & ~role_ign.word) &&
> -			    rmap_can_add(vcpu))
> -				mmu_pte_write_new_pte(vcpu, sp, spte, &gentry);
> +			if (gentry && sp->role.level != PG_LEVEL_4K)
> +				++vcpu->kvm->stat.mmu_pde_zapped;
>   			if (need_remote_flush(entry, *spte))
>   				remote_flush = true;
>   			++spte;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a480804ae27a..d9f5d9acccc1 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -233,7 +233,6 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
>   	VCPU_STAT("halt_poll_fail_ns", halt_poll_fail_ns),
>   	VM_STAT("mmu_shadow_zapped", mmu_shadow_zapped),
>   	VM_STAT("mmu_pte_write", mmu_pte_write),
> -	VM_STAT("mmu_pte_updated", mmu_pte_updated),
>   	VM_STAT("mmu_pde_zapped", mmu_pde_zapped),
>   	VM_STAT("mmu_flooded", mmu_flooded),
>   	VM_STAT("mmu_recycled", mmu_recycled),
> 

Queued, thanks.

Paolo

