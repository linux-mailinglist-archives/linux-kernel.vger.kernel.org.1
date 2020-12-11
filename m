Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146502D7315
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 10:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392569AbgLKJup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 04:50:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:33320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405694AbgLKJuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 04:50:12 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 149FF23F2A;
        Fri, 11 Dec 2020 09:49:31 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1knf3I-000Ps4-Uz; Fri, 11 Dec 2020 09:49:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 11 Dec 2020 09:49:28 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Yanan Wang <wangyanan55@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        Quentin Perret <qperret@google.com>,
        wanghaibin.wang@huawei.com, yezengruan@huawei.com,
        zhukeqian1@huawei.com, yuzenghui@huawei.com,
        jiangkunkun@huawei.com, wangjingyi11@huawei.com,
        lushenming@huawei.com
Subject: Re: [RFC PATCH] KVM: arm64: Add prejudgement for relaxing permissions
 only case in stage2 translation fault handler
In-Reply-To: <20201211080115.21460-2-wangyanan55@huawei.com>
References: <20201211080115.21460-1-wangyanan55@huawei.com>
 <20201211080115.21460-2-wangyanan55@huawei.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <8d006755e5afce7e49b03993316c4fcc@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: wangyanan55@huawei.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, gshan@redhat.com, qperret@google.com, wanghaibin.wang@huawei.com, yezengruan@huawei.com, zhukeqian1@huawei.com, yuzenghui@huawei.com, jiangkunkun@huawei.com, wangjingyi11@huawei.com, lushenming@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yanan,

On 2020-12-11 08:01, Yanan Wang wrote:
> In dirty-logging, or dirty-logging-stopped time, even normal running
> time of a guest configed with huge mappings and numbers of vCPUs,
> translation faults by different vCPUs on the same GPA could occur
> successively almost at the same time. There are two reasons for it.
> 
> (1) If there are some vCPUs accessing the same GPA at the same time
> and the leaf PTE is not set yet, then they will all cause translation
> faults and the first vCPU holding mmu_lock will set valid leaf PTE,
> and the others will later choose to update the leaf PTE or not.
> 
> (2) When changing a leaf entry or a table entry with break-before-make,
> if there are some vCPUs accessing the same GPA just catch the moment
> when the target PTE is set invalid in a BBM procedure coincidentally,
> they will all cause translation faults and will later choose to update
> the leaf PTE or not.
> 
> The worst case can be like this: some vCPUs cause translation faults
> on the same GPA with different prots, they will fight each other by
> changing back access permissions of the PTE with break-before-make.
> And the BBM-invalid moment might trigger more unnecessary translation
> faults. As a result, some useless small loops will occur, which could
> lead to vCPU stuck.
> 
> To avoid unnecessary update and small loops, add prejudgement in the
> translation fault handler: Skip updating the valid leaf PTE if we are
> trying to recreate exactly the same mapping or to reduce access
> permissions only(such as RW-->RO). And update the valid leaf PTE 
> without
> break-before-make if we are trying to add more permissions only.

I'm a bit perplexed with this: why are you skipping the update if the
permissions need to be reduced? Even more, how can we reduce the
permissions from a vCPU fault? I can't really think of a scenario where
that happens.

Or are you describing a case where two vcpus fault simultaneously with
conflicting permissions:

- Both vcpus fault on translation fault
- vcpu A wants W access
- vpcu B wants R access

and 'A' gets in first, set the permissions to RW (because R is
implicitly added to W), followed by 'B' which downgrades it to RO?

If that's what you are describing, then I agree we could do better.

> 
> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> ---
>  arch/arm64/kvm/hyp/pgtable.c | 73 +++++++++++++++++++++++++-----------
>  1 file changed, 52 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/pgtable.c 
> b/arch/arm64/kvm/hyp/pgtable.c
> index 23a01dfcb27a..f8b3248cef1c 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -45,6 +45,8 @@
> 
>  #define KVM_PTE_LEAF_ATTR_HI_S2_XN	BIT(54)
> 
> +#define KVM_PTE_LEAF_ATTR_PERMS	(GENMASK(7, 6) | BIT(54))
> +
>  struct kvm_pgtable_walk_data {
>  	struct kvm_pgtable		*pgt;
>  	struct kvm_pgtable_walker	*walker;
> @@ -170,10 +172,9 @@ static void kvm_set_table_pte(kvm_pte_t *ptep,
> kvm_pte_t *childp)
>  	smp_store_release(ptep, pte);
>  }
> 
> -static bool kvm_set_valid_leaf_pte(kvm_pte_t *ptep, u64 pa, kvm_pte_t 
> attr,
> -				   u32 level)
> +static kvm_pte_t kvm_init_valid_leaf_pte(u64 pa, kvm_pte_t attr, u32 
> level)
>  {
> -	kvm_pte_t old = *ptep, pte = kvm_phys_to_pte(pa);
> +	kvm_pte_t pte = kvm_phys_to_pte(pa);
>  	u64 type = (level == KVM_PGTABLE_MAX_LEVELS - 1) ? KVM_PTE_TYPE_PAGE 
> :
>  							   KVM_PTE_TYPE_BLOCK;
> 
> @@ -181,12 +182,7 @@ static bool kvm_set_valid_leaf_pte(kvm_pte_t
> *ptep, u64 pa, kvm_pte_t attr,
>  	pte |= FIELD_PREP(KVM_PTE_TYPE, type);
>  	pte |= KVM_PTE_VALID;
> 
> -	/* Tolerate KVM recreating the exact same mapping. */
> -	if (kvm_pte_valid(old))
> -		return old == pte;
> -
> -	smp_store_release(ptep, pte);
> -	return true;
> +	return pte;
>  }
> 
>  static int kvm_pgtable_visitor_cb(struct kvm_pgtable_walk_data *data, 
> u64 addr,
> @@ -341,12 +337,17 @@ static int hyp_map_set_prot_attr(enum
> kvm_pgtable_prot prot,
>  static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>  				    kvm_pte_t *ptep, struct hyp_map_data *data)
>  {
> +	kvm_pte_t new, old = *ptep;
>  	u64 granule = kvm_granule_size(level), phys = data->phys;
> 
>  	if (!kvm_block_mapping_supported(addr, end, phys, level))
>  		return false;
> 
> -	WARN_ON(!kvm_set_valid_leaf_pte(ptep, phys, data->attr, level));
> +	/* Tolerate KVM recreating the exact same mapping. */
> +	new = kvm_init_valid_leaf_pte(phys, data->attr, level);
> +	if (old != new && !WARN_ON(kvm_pte_valid(old)))
> +		smp_store_release(ptep, new);
> +
>  	data->phys += granule;
>  	return true;
>  }
> @@ -461,25 +462,56 @@ static int stage2_map_set_prot_attr(enum
> kvm_pgtable_prot prot,
>  	return 0;
>  }
> 
> +static bool stage2_set_valid_leaf_pte_pre(u64 addr, u32 level,
> +					  kvm_pte_t *ptep, kvm_pte_t new,
> +					  struct stage2_map_data *data)
> +{
> +	kvm_pte_t old = *ptep, old_attr, new_attr;
> +
> +	if ((old ^ new) & (~KVM_PTE_LEAF_ATTR_PERMS))
> +		return false;
> +
> +	/*
> +	 * Skip updating if we are trying to recreate exactly the same 
> mapping
> +	 * or to reduce the access permissions only. And update the valid 
> leaf
> +	 * PTE without break-before-make if we are trying to add more access
> +	 * permissions only.
> +	 */
> +	old_attr = (old & KVM_PTE_LEAF_ATTR_PERMS) ^ 
> KVM_PTE_LEAF_ATTR_HI_S2_XN;
> +	new_attr = (new & KVM_PTE_LEAF_ATTR_PERMS) ^ 
> KVM_PTE_LEAF_ATTR_HI_S2_XN;
> +	if (new_attr <= old_attr)
> +		return true;
> +
> +	WRITE_ONCE(*ptep, new);
> +	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, level);

I think what bothers me the most here is that we are turning a mapping 
into
a permission update, which makes the code really hard to read, and mixes
two things that were so far separate.

I wonder whether we should instead abort the update and simply take the 
fault
again, if we ever need to do it.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
