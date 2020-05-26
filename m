Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED07F1E2041
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 12:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388793AbgEZK6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 06:58:16 -0400
Received: from foss.arm.com ([217.140.110.172]:49196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388501AbgEZK6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 06:58:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1942F31B;
        Tue, 26 May 2020 03:58:13 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 358A93F6C4;
        Tue, 26 May 2020 03:58:10 -0700 (PDT)
Date:   Tue, 26 May 2020 11:58:07 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, will@kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com,
        suzuki.poulose@arm.com, drjones@redhat.com, eric.auger@redhat.com,
        aarcange@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH RFCv2 6/9] kvm/arm64: Export kvm_handle_user_mem_abort()
 with prefault mode
Message-ID: <20200526105807.GE1363@C02TD0UTHF1T.local>
References: <20200508032919.52147-1-gshan@redhat.com>
 <20200508032919.52147-7-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508032919.52147-7-gshan@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 01:29:16PM +1000, Gavin Shan wrote:
> This renames user_mem_abort() to kvm_handle_user_mem_abort(), and
> then export it. The function will be used in asynchronous page fault
> to populate a page table entry once the corresponding page is populated
> from the backup device (e.g. swap partition):
> 
>    * Parameter @fault_status is replace by @esr.
>    * The parameters are reorder based on their importance.

It seems like multiple changes are going on here, and it would be
clearer with separate patches.

Passing the ESR rather than the extracted fault status seems fine, but
for clarirty it's be nicer to do this in its own patch.

Why is it necessary to re-order the function parameters? Does that align
with other function prototypes?

What exactly is the `prefault` parameter meant to do? It doesn't do
anything currently, so it'd be better to introduce it later when logic
using it is instroduced, or where callers will pass distinct values.

Thanks,
Mark.

> 
> This shouldn't cause any functional changes.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/include/asm/kvm_host.h |  4 ++++
>  virt/kvm/arm/mmu.c                | 14 ++++++++------
>  2 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 32c8a675e5a4..f77c706777ec 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -437,6 +437,10 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
>  			      struct kvm_vcpu_events *events);
>  
>  #define KVM_ARCH_WANT_MMU_NOTIFIER
> +int kvm_handle_user_mem_abort(struct kvm_vcpu *vcpu, unsigned int esr,
> +			      struct kvm_memory_slot *memslot,
> +			      phys_addr_t fault_ipa, unsigned long hva,
> +			      bool prefault);
>  int kvm_unmap_hva_range(struct kvm *kvm,
>  			unsigned long start, unsigned long end);
>  int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index e462e0368fd9..95aaabb2b1fc 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1656,12 +1656,12 @@ static bool fault_supports_stage2_huge_mapping(struct kvm_memory_slot *memslot,
>  	       (hva & ~(map_size - 1)) + map_size <= uaddr_end;
>  }
>  
> -static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
> -			  struct kvm_memory_slot *memslot, unsigned long hva,
> -			  unsigned long fault_status)
> +int kvm_handle_user_mem_abort(struct kvm_vcpu *vcpu, unsigned int esr,
> +			      struct kvm_memory_slot *memslot,
> +			      phys_addr_t fault_ipa, unsigned long hva,
> +			      bool prefault)
>  {
> -	int ret;
> -	u32 esr = kvm_vcpu_get_esr(vcpu);
> +	unsigned int fault_status = kvm_vcpu_trap_get_fault_type(esr);
>  	bool write_fault, writable, force_pte = false;
>  	bool exec_fault, needs_exec;
>  	unsigned long mmu_seq;
> @@ -1674,6 +1674,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	pgprot_t mem_type = PAGE_S2;
>  	bool logging_active = memslot_is_logging(memslot);
>  	unsigned long vma_pagesize, flags = 0;
> +	int ret;
>  
>  	write_fault = kvm_is_write_fault(esr);
>  	exec_fault = kvm_vcpu_trap_is_iabt(esr);
> @@ -1995,7 +1996,8 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu, struct kvm_run *run)
>  		goto out_unlock;
>  	}
>  
> -	ret = user_mem_abort(vcpu, fault_ipa, memslot, hva, fault_status);
> +	ret = kvm_handle_user_mem_abort(vcpu, esr, memslot,
> +					fault_ipa, hva, false);
>  	if (ret == 0)
>  		ret = 1;
>  out:
> -- 
> 2.23.0
> 
