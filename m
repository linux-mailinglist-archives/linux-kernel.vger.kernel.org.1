Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1222C85DB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgK3NuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:50:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgK3NuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:50:00 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07A69206F9;
        Mon, 30 Nov 2020 13:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606744160;
        bh=2uoGPoXnC43iKsKDzv0Q4KMQ6DR5H912lU9Q1Pz8A8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cy/lP/cz+FfYPEDMpjaPKxh8M17ujOWAxcr5T0nWw5/JG3bMoJTpN28mYnBtCi3wZ
         xdKj8xVHwldOmrftM3xBuDX9aABurLhy9odovdz2DnQrumhGDGC0QHErsIcGqrkP1n
         LeSSFWAH6e7YnCuCHBYe4Uzm4hQ1WGwbnXbaGrlU=
Date:   Mon, 30 Nov 2020 13:49:13 +0000
From:   Will Deacon <will@kernel.org>
To:     Yanan Wang <wangyanan55@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        Quentin Perret <qperret@google.com>,
        wanghaibin.wang@huawei.com, yezengruan@huawei.com,
        zhukeqian1@huawei.com, yuzenghui@huawei.com,
        jiangkunkun@huawei.com, wangjingyi11@huawei.com,
        lushenming@huawei.com
Subject: Re: [RFC PATCH 3/3] KVM: arm64: Add usage of stage 2 fault lookup
 level in user_mem_abort()
Message-ID: <20201130134913.GC24837@willie-the-truck>
References: <20201130121847.91808-1-wangyanan55@huawei.com>
 <20201130121847.91808-4-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130121847.91808-4-wangyanan55@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 08:18:47PM +0800, Yanan Wang wrote:
> If we get a FSC_PERM fault, just using (logging_active && writable) to determine
> calling kvm_pgtable_stage2_map(). There will be two more cases we should consider.
> 
> (1) After logging_active is configged back to false from true. When we get a
> FSC_PERM fault with write_fault and adjustment of hugepage is needed, we should
> merge tables back to a block entry. This case is ignored by still calling
> kvm_pgtable_stage2_relax_perms(), which will lead to an endless loop and guest
> panic due to soft lockup.
> 
> (2) We use (FSC_PERM && logging_active && writable) to determine collapsing
> a block entry into a table by calling kvm_pgtable_stage2_map(). But sometimes
> we may only need to relax permissions when trying to write to a page other than
> a block. In this condition, using kvm_pgtable_stage2_relax_perms() will be fine.
> 
> The ISS filed bit[1:0] in ESR_EL2 regesiter indicates the stage2 lookup level
> at which a D-abort or I-abort occured. By comparing granule of the fault lookup
> level with vma_pagesize, we can strictly distinguish conditions of calling
> kvm_pgtable_stage2_relax_perms() or kvm_pgtable_stage2_map(), and the above
> two cases will be well considered.
> 
> Suggested-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> ---
>  arch/arm64/include/asm/esr.h         |  1 +
>  arch/arm64/include/asm/kvm_emulate.h |  5 +++++
>  arch/arm64/kvm/mmu.c                 | 11 +++++++++--
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> index 22c81f1edda2..85a3e49f92f4 100644
> --- a/arch/arm64/include/asm/esr.h
> +++ b/arch/arm64/include/asm/esr.h
> @@ -104,6 +104,7 @@
>  /* Shared ISS fault status code(IFSC/DFSC) for Data/Instruction aborts */
>  #define ESR_ELx_FSC		(0x3F)
>  #define ESR_ELx_FSC_TYPE	(0x3C)
> +#define ESR_ELx_FSC_LEVEL	(0x03)
>  #define ESR_ELx_FSC_EXTABT	(0x10)
>  #define ESR_ELx_FSC_SERROR	(0x11)
>  #define ESR_ELx_FSC_ACCESS	(0x08)
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 5ef2669ccd6c..2e0e8edf6306 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -350,6 +350,11 @@ static __always_inline u8 kvm_vcpu_trap_get_fault_type(const struct kvm_vcpu *vc
>  	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_FSC_TYPE;
>  }
>  
> +static __always_inline u8 kvm_vcpu_trap_get_fault_level(const struct kvm_vcpu *vcpu)
> +{
> +	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_FSC_LEVEL;
> +{
> +
>  static __always_inline bool kvm_vcpu_abt_issea(const struct kvm_vcpu *vcpu)
>  {
>  	switch (kvm_vcpu_trap_get_fault(vcpu)) {
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 1a01da9fdc99..75814a02d189 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -754,10 +754,12 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	gfn_t gfn;
>  	kvm_pfn_t pfn;
>  	bool logging_active = memslot_is_logging(memslot);
> -	unsigned long vma_pagesize;
> +	unsigned long fault_level = kvm_vcpu_trap_get_fault_level(vcpu);
> +	unsigned long vma_pagesize, fault_granule;
>  	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
>  	struct kvm_pgtable *pgt;
>  
> +	fault_granule = 1UL << ARM64_HW_PGTABLE_LEVEL_SHIFT(fault_level);

I like the idea, but is this macro reliable for stage-2 page-tables, given
that we could have a concatenated pgd?

Will
