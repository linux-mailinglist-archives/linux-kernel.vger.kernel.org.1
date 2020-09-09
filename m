Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7187F2630F4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 17:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbgIIPuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 11:50:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46576 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730495AbgIIPsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599666497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1oqfMDlaydpQd5AtTIWuEzsxi+gdlnBMw7RDhRkoEKs=;
        b=X1Vg7l0oQE7vGzvaWNIAWmZlxnqYdT7I2Z3w7XEVQm3wHPwwVS1bLNBdxIkpsGaNT52wc5
        bXztY/flDhTQ7k6GIKp1/3qEY689bpJ2yL/jUsjgT9QA83Lytubphghvc2aAbJjt3rStXm
        mnuY3oWCeMLM946Zex0+FsBXfKR2gD4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-OokkQgbTOdCgFzIPbszXBQ-1; Wed, 09 Sep 2020 11:48:13 -0400
X-MC-Unique: OokkQgbTOdCgFzIPbszXBQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAE45100670D;
        Wed,  9 Sep 2020 15:48:11 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1461060BEC;
        Wed,  9 Sep 2020 15:48:07 +0000 (UTC)
Date:   Wed, 9 Sep 2020 17:48:04 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Peter Maydell <Peter.Maydell@arm.com>, qemu-devel@nongnu.org,
        Dave Martin <Dave.Martin@arm.com>,
        Juan Quintela <quintela@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] arm64: kvm: Introduce MTE VCPU feature
Message-ID: <20200909154804.mide6szbzgdy7jju@kamzik.brq.redhat.com>
References: <20200904160018.29481-1-steven.price@arm.com>
 <20200904160018.29481-3-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904160018.29481-3-steven.price@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 05:00:18PM +0100, Steven Price wrote:
> Add a new VCPU features 'KVM_ARM_VCPU_MTE' which enables memory tagging
> on a VCPU. When enabled on any VCPU in the virtual machine this causes
> all pages that are faulted into the VM to have the PG_mte_tagged flag
> set (and the tag storage cleared if this is the first use).
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/arm64/include/asm/kvm_emulate.h |  3 +++
>  arch/arm64/include/asm/kvm_host.h    |  5 ++++-
>  arch/arm64/include/uapi/asm/kvm.h    |  1 +
>  arch/arm64/kvm/mmu.c                 | 15 +++++++++++++++
>  arch/arm64/kvm/reset.c               |  8 ++++++++
>  arch/arm64/kvm/sys_regs.c            |  6 +++++-
>  6 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 49a55be2b9a2..0042323a4b7f 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -79,6 +79,9 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
>  	if (cpus_have_const_cap(ARM64_MISMATCHED_CACHE_TYPE) ||
>  	    vcpu_el1_is_32bit(vcpu))
>  		vcpu->arch.hcr_el2 |= HCR_TID2;
> +
> +	if (test_bit(KVM_ARM_VCPU_MTE, vcpu->arch.features))
> +		vcpu->arch.hcr_el2 |= HCR_ATA;
>  }
>  
>  static inline unsigned long *vcpu_hcr(struct kvm_vcpu *vcpu)
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 4f4360dd149e..b1190366242b 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -37,7 +37,7 @@
>  
>  #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS
>  
> -#define KVM_VCPU_MAX_FEATURES 7
> +#define KVM_VCPU_MAX_FEATURES 8
>  
>  #define KVM_REQ_SLEEP \
>  	KVM_ARCH_REQ_FLAGS(0, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
> @@ -110,6 +110,9 @@ struct kvm_arch {
>  	 * supported.
>  	 */
>  	bool return_nisv_io_abort_to_user;
> +
> +	/* If any VCPU has MTE enabled then all memory must be MTE enabled */
> +	bool vcpu_has_mte;

It looks like this is unnecessary as it's only used once, where a feature
check could be used.

>  };
>  
>  struct kvm_vcpu_fault_info {
> diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
> index ba85bb23f060..2677e1ab8c16 100644
> --- a/arch/arm64/include/uapi/asm/kvm.h
> +++ b/arch/arm64/include/uapi/asm/kvm.h
> @@ -106,6 +106,7 @@ struct kvm_regs {
>  #define KVM_ARM_VCPU_SVE		4 /* enable SVE for this CPU */
>  #define KVM_ARM_VCPU_PTRAUTH_ADDRESS	5 /* VCPU uses address authentication */
>  #define KVM_ARM_VCPU_PTRAUTH_GENERIC	6 /* VCPU uses generic authentication */
> +#define KVM_ARM_VCPU_MTE		7 /* VCPU supports Memory Tagging */
>  
>  struct kvm_vcpu_init {
>  	__u32 target;
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index ba00bcc0c884..e8891bacd76f 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1949,6 +1949,21 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	if (vma_pagesize == PAGE_SIZE && !force_pte)
>  		vma_pagesize = transparent_hugepage_adjust(memslot, hva,
>  							   &pfn, &fault_ipa);
> +	if (system_supports_mte() && kvm->arch.vcpu_has_mte && pfn_valid(pfn)) {
> +		/*
> +		 * VM will be able to see the page's tags, so we must ensure
> +		 * they have been initialised.
> +		 */
> +		struct page *page = pfn_to_page(pfn);
> +		long i, nr_pages = compound_nr(page);
> +
> +		/* if PG_mte_tagged is set, tags have already been initialised */
> +		for (i = 0; i < nr_pages; i++, page++) {
> +			if (!test_and_set_bit(PG_mte_tagged, &page->flags))
> +				mte_clear_page_tags(page_address(page));
> +		}
> +	}
> +
>  	if (writable)
>  		kvm_set_pfn_dirty(pfn);
>  
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index ee33875c5c2a..82f3883d717f 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -274,6 +274,14 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>  		}
>  	}
>  
> +	if (test_bit(KVM_ARM_VCPU_MTE, vcpu->arch.features)) {
> +		if (!system_supports_mte()) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		vcpu->kvm->arch.vcpu_has_mte = true;
> +	}

We either need a KVM cap or a new CPU feature probing interface to avoid
making userspace try features one at a time. It's too bad that VCPU_INIT
doesn't clear all offending features from the feature set when returning
EINVAL, because then userspace could create a scratch VCPU with everything
it supports in order to see what KVM also supports in one go.

> +
>  	switch (vcpu->arch.target) {
>  	default:
>  		if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features)) {
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index a655f172b5ad..6a971b201e81 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1132,7 +1132,8 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
>  			val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
>  		val &= ~(0xfUL << ID_AA64PFR0_AMU_SHIFT);
>  	} else if (id == SYS_ID_AA64PFR1_EL1) {
> -		val &= ~(0xfUL << ID_AA64PFR1_MTE_SHIFT);
> +		if (!test_bit(KVM_ARM_VCPU_MTE, vcpu->arch.features))
> +			val &= ~(0xfUL << ID_AA64PFR1_MTE_SHIFT);
>  	} else if (id == SYS_ID_AA64ISAR1_EL1 && !vcpu_has_ptrauth(vcpu)) {
>  		val &= ~((0xfUL << ID_AA64ISAR1_APA_SHIFT) |
>  			 (0xfUL << ID_AA64ISAR1_API_SHIFT) |
> @@ -1394,6 +1395,9 @@ static bool access_mte_regs(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  static unsigned int mte_visibility(const struct kvm_vcpu *vcpu,
>  				   const struct sys_reg_desc *rd)
>  {
> +	if (test_bit(KVM_ARM_VCPU_MTE, vcpu->arch.features))
> +		return 0;
> +
>  	return REG_HIDDEN_USER | REG_HIDDEN_GUEST;
>  }
>  
> -- 
> 2.20.1
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
>

Thanks,
drew

