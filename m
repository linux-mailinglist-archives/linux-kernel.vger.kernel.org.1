Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A45E2C88DF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgK3QCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:02:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:49238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbgK3QCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:02:08 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 287A320659;
        Mon, 30 Nov 2020 16:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606752087;
        bh=AJw4vWeiUmjVdPrXFfXWymHhQkdX3rroVJei2MKvnPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iW4rNUNTz5yBlbL4ymBzBDD3iYfBW4R4mXjd/R8Y6X9Hf951cjxFcYgX7RdhhgpEt
         2U/O27yoIfW7rzDgCSZ1CgkkoCdoRU41ItBwMmUxcFN+Ff/C9EF4Pp2SHK+UyGhcMO
         9z2Ric/1jW7ut1fIdE1dfr53JzGsZgK17FWm+M40=
Date:   Mon, 30 Nov 2020 16:01:20 +0000
From:   Will Deacon <will@kernel.org>
To:     "wangyanan (Y)" <wangyanan55@huawei.com>
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
Subject: Re: [RFC PATCH 2/3] KVM: arm64: Fix handling of merging tables into
 a block entry
Message-ID: <20201130160119.GA25051@willie-the-truck>
References: <20201130121847.91808-1-wangyanan55@huawei.com>
 <20201130121847.91808-3-wangyanan55@huawei.com>
 <20201130133421.GB24837@willie-the-truck>
 <67e9e393-1836-eca7-4235-6f4a19fed652@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67e9e393-1836-eca7-4235-6f4a19fed652@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Cheers for the quick reply. See below for more questions...

On Mon, Nov 30, 2020 at 11:24:19PM +0800, wangyanan (Y) wrote:
> On 2020/11/30 21:34, Will Deacon wrote:
> > On Mon, Nov 30, 2020 at 08:18:46PM +0800, Yanan Wang wrote:
> > > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > > index 696b6aa83faf..fec8dc9f2baa 100644
> > > --- a/arch/arm64/kvm/hyp/pgtable.c
> > > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > > @@ -500,6 +500,9 @@ static int stage2_map_walk_table_pre(u64 addr, u64 end, u32 level,
> > >   	return 0;
> > >   }
> > > +static void stage2_flush_dcache(void *addr, u64 size);
> > > +static bool stage2_pte_cacheable(kvm_pte_t pte);
> > > +
> > >   static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
> > >   				struct stage2_map_data *data)
> > >   {
> > > @@ -507,9 +510,17 @@ static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
> > >   	struct page *page = virt_to_page(ptep);
> > >   	if (data->anchor) {
> > > -		if (kvm_pte_valid(pte))
> > > +		if (kvm_pte_valid(pte)) {
> > > +			kvm_set_invalid_pte(ptep);
> > > +			kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu,
> > > +				     addr, level);
> > >   			put_page(page);
> > This doesn't make sense to me: the page-table pages we're walking when the
> > anchor is set are not accessible to the hardware walker because we unhooked
> > the entire sub-table in stage2_map_walk_table_pre(), which has the necessary
> > TLB invalidation.
> > 
> > Are you seeing a problem in practice here?
> 
> Yes, I indeed find a problem in practice.
> 
> When the migration was cancelled, a TLB conflic abort  was found in guest.
> 
> This problem is fixed before rework of the page table code, you can have a
> look in the following two links:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3c3736cd32bf5197aed1410ae826d2d254a5b277
> 
> https://lists.cs.columbia.edu/pipermail/kvmarm/2019-March/035031.html

Ok, let's go through this, because I still don't see the bug. Please correct
me if you spot any mistakes:

  1. We have a block mapping for X => Y
  2. Dirty logging is enabled, so the block mapping is write-protected and
     ends up being split into page mappings
  3. Dirty logging is disabled due to a failed migration.

--- At this point, I think we agree that the state of the MMU is alright ---

  4. We take a stage-2 fault and want to reinstall the block mapping:

     a. kvm_pgtable_stage2_map() is invoked to install the block mapping
     b. stage2_map_walk_table_pre() finds a table where we would like to
        install the block:

	i.   The anchor is set to point at this entry
	ii.  The entry is made invalid
	iii. We invalidate the TLB for the input address. This is
	     TLBI IPAS2SE1IS without level hint and then TLBI VMALLE1IS.

	*** At this point, the page-table pointed to by the old table entry
	    is not reachable to the hardware walker ***

     c. stage2_map_walk_leaf() is called for each leaf entry in the
        now-unreachable subtree, dropping page-references for each valid
	entry it finds.
     d. stage2_map_walk_table_post() is eventually called for the entry
        which we cleared back in b.ii, so we install the new block mapping.

You are proposing to add additional TLB invalidation to (c), but I don't
think that is necessary, thanks to the invalidation already performed in
b.iii. What am I missing here?

> > > +			if (stage2_pte_cacheable(pte))
> > > +				stage2_flush_dcache(kvm_pte_follow(pte),
> > > +						    kvm_granule_size(level));
> > I don't understand the need for the flush either, as we're just coalescing
> > existing entries into a larger block mapping.
> 
> In my opinion, after unmapping, it is necessary to ensure the cache
> coherency, because it is unknown whether the future mapping memory attribute
> is changed or not (cacheable -> non_cacheable) theoretically.

But in this case we're just changing the structure of the page-tables,
not the pages which are mapped, are we?

Will
