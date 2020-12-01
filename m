Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1630B2CA4F9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391541AbgLAOFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:05:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387669AbgLAOFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:05:47 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C45AE206A5;
        Tue,  1 Dec 2020 14:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606831505;
        bh=sVWKqoSDTG/AKOKDXjY6B+lnWemeNPbp3wjvaWpZDws=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RbQVq0ct1lmZonYKd6NwVxnExkYjlOtbuRkJeWMx32mpoiG7j/UYImzNh2HrXbLKC
         W5ZgG+kR6ShOEjec0OsnOoqts1r9/k6neOqwxIqLiixJ7HoMWyFhO+TTF/mU8xEPda
         tacJAdLLMSx4VobtAiP+tnwEZpYdeF1RE6nPMGkw=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kk6H9-00F3yX-Kw; Tue, 01 Dec 2020 14:05:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 01 Dec 2020 14:05:03 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     "wangyanan (Y)" <wangyanan55@huawei.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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
Subject: Re: [RFC PATCH 2/3] KVM: arm64: Fix handling of merging tables into a
 block entry
In-Reply-To: <20201201134606.GB26973@willie-the-truck>
References: <20201130121847.91808-1-wangyanan55@huawei.com>
 <20201130121847.91808-3-wangyanan55@huawei.com>
 <20201130133421.GB24837@willie-the-truck>
 <67e9e393-1836-eca7-4235-6f4a19fed652@huawei.com>
 <20201130160119.GA25051@willie-the-truck>
 <868a4403-10d3-80f3-4ae1-a490813c55e2@huawei.com>
 <20201201134606.GB26973@willie-the-truck>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <03ab1bdd8459831ad05993807e39e5bd@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, wangyanan55@huawei.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, gshan@redhat.com, qperret@google.com, wanghaibin.wang@huawei.com, yezengruan@huawei.com, zhukeqian1@huawei.com, yuzenghui@huawei.com, jiangkunkun@huawei.com, wangjingyi11@huawei.com, lushenming@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-01 13:46, Will Deacon wrote:
> On Tue, Dec 01, 2020 at 10:30:41AM +0800, wangyanan (Y) wrote:
>> On 2020/12/1 0:01, Will Deacon wrote:
>> > On Mon, Nov 30, 2020 at 11:24:19PM +0800, wangyanan (Y) wrote:
>> > > On 2020/11/30 21:34, Will Deacon wrote:
>> > > > On Mon, Nov 30, 2020 at 08:18:46PM +0800, Yanan Wang wrote:
>> > > > > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
>> > > > > index 696b6aa83faf..fec8dc9f2baa 100644
>> > > > > --- a/arch/arm64/kvm/hyp/pgtable.c
>> > > > > +++ b/arch/arm64/kvm/hyp/pgtable.c
>> > > > > @@ -500,6 +500,9 @@ static int stage2_map_walk_table_pre(u64 addr, u64 end, u32 level,
>> > > > >    	return 0;
>> > > > >    }
>> > > > > +static void stage2_flush_dcache(void *addr, u64 size);
>> > > > > +static bool stage2_pte_cacheable(kvm_pte_t pte);
>> > > > > +
>> > > > >    static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
>> > > > >    				struct stage2_map_data *data)
>> > > > >    {
>> > > > > @@ -507,9 +510,17 @@ static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
>> > > > >    	struct page *page = virt_to_page(ptep);
>> > > > >    	if (data->anchor) {
>> > > > > -		if (kvm_pte_valid(pte))
>> > > > > +		if (kvm_pte_valid(pte)) {
>> > > > > +			kvm_set_invalid_pte(ptep);
>> > > > > +			kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu,
>> > > > > +				     addr, level);
>> > > > >    			put_page(page);
>> > > > This doesn't make sense to me: the page-table pages we're walking when the
>> > > > anchor is set are not accessible to the hardware walker because we unhooked
>> > > > the entire sub-table in stage2_map_walk_table_pre(), which has the necessary
>> > > > TLB invalidation.
>> > > >
>> > > > Are you seeing a problem in practice here?
>> > > Yes, I indeed find a problem in practice.
>> > >
>> > > When the migration was cancelled, a TLB conflic abort  was found in guest.
>> > >
>> > > This problem is fixed before rework of the page table code, you can have a
>> > > look in the following two links:
>> > >
>> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3c3736cd32bf5197aed1410ae826d2d254a5b277
>> > >
>> > > https://lists.cs.columbia.edu/pipermail/kvmarm/2019-March/035031.html
>> > Ok, let's go through this, because I still don't see the bug. Please correct
>> > me if you spot any mistakes:
>> >
>> >    1. We have a block mapping for X => Y
>> >    2. Dirty logging is enabled, so the block mapping is write-protected and
>> >       ends up being split into page mappings
>> >    3. Dirty logging is disabled due to a failed migration.
>> >
>> > --- At this point, I think we agree that the state of the MMU is alright ---
>> >
>> >    4. We take a stage-2 fault and want to reinstall the block mapping:
>> >
>> >       a. kvm_pgtable_stage2_map() is invoked to install the block mapping
>> >       b. stage2_map_walk_table_pre() finds a table where we would like to
>> >          install the block:
>> >
>> > 	i.   The anchor is set to point at this entry
>> > 	ii.  The entry is made invalid
>> > 	iii. We invalidate the TLB for the input address. This is
>> > 	     TLBI IPAS2SE1IS without level hint and then TLBI VMALLE1IS.
>> >
>> > 	*** At this point, the page-table pointed to by the old table entry
>> > 	    is not reachable to the hardware walker ***
>> >
>> >       c. stage2_map_walk_leaf() is called for each leaf entry in the
>> >          now-unreachable subtree, dropping page-references for each valid
>> > 	entry it finds.
>> >       d. stage2_map_walk_table_post() is eventually called for the entry
>> >          which we cleared back in b.ii, so we install the new block mapping.
>> >
>> > You are proposing to add additional TLB invalidation to (c), but I don't
>> > think that is necessary, thanks to the invalidation already performed in
>> > b.iii. What am I missing here?
>> 
>> The point is at b.iii where the TLBI is not enough. There are many 
>> page
>> mappings that we need to merge into a block mapping.
>> 
>> We invalidate the TLB for the input address without level hint at 
>> b.iii, but
>> this operation just flush TLB for one page mapping, there
>> 
>> are still some TLB entries for the other page mappings in the cache, 
>> the MMU
>> hardware walker can still hit these entries next time.
> 
> Ah, yes, I see. Thanks. I hadn't considered the case where there are 
> table
> entries beneath the anchor. So how about the diff below?
> 
> Will
> 
> --->8
> 
> diff --git a/arch/arm64/kvm/hyp/pgtable.c 
> b/arch/arm64/kvm/hyp/pgtable.c
> index 0271b4a3b9fe..12526d8c7ae4 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -493,7 +493,7 @@ static int stage2_map_walk_table_pre(u64 addr, u64
> end, u32 level,
>  		return 0;
> 
>  	kvm_set_invalid_pte(ptep);
> -	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, 0);
> +	/* TLB invalidation is deferred until the _post handler */
>  	data->anchor = ptep;
>  	return 0;
>  }
> @@ -547,11 +547,21 @@ static int stage2_map_walk_table_post(u64 addr,
> u64 end, u32 level,
>  				      struct stage2_map_data *data)
>  {
>  	int ret = 0;
> +	kvm_pte_t pte = *ptep;
> 
>  	if (!data->anchor)
>  		return 0;
> 
> -	free_page((unsigned long)kvm_pte_follow(*ptep));
> +	kvm_set_invalid_pte(ptep);
> +
> +	/*
> +	 * Invalidate the whole stage-2, as we may have numerous leaf
> +	 * entries below us which would otherwise need invalidating
> +	 * individually.
> +	 */
> +	kvm_call_hyp(__kvm_tlb_flush_vmid, data->mmu);

That's a big hammer, and we so far have been pretty careful not to
over-invalidate. Is the block-replacing-table *without* an unmap
in between the only case where this triggers?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
