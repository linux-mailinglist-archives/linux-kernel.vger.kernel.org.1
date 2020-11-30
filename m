Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D3E2C859A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgK3NfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:35:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:58670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbgK3NfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:35:09 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BAD720870;
        Mon, 30 Nov 2020 13:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606743268;
        bh=lc+QhqwU7aPlngAV30FSRSh9frD9YFy1xiMIDEc7/ek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dLD0NeIKHfj3LKCzVj4ECu0YXu14LGj4tF3/fVOTM020EOYxI1Txtk987QZoYlVBq
         kggtg2/rFgP3M0oiF3Zj5q0z1/RKvpA111kLJUdRbY2B9vFbDGWa8wOubYBO8JH0EC
         p7wl2iZz9g4ZGJibeuO6fdU1Hd90R0+G/2Ze8W6Y=
Date:   Mon, 30 Nov 2020 13:34:21 +0000
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
Subject: Re: [RFC PATCH 2/3] KVM: arm64: Fix handling of merging tables into
 a block entry
Message-ID: <20201130133421.GB24837@willie-the-truck>
References: <20201130121847.91808-1-wangyanan55@huawei.com>
 <20201130121847.91808-3-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130121847.91808-3-wangyanan55@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 08:18:46PM +0800, Yanan Wang wrote:
> In dirty logging case(logging_active == True), we need to collapse a block
> entry into a table if necessary. After dirty logging is canceled, when merging
> tables back into a block entry, we should not only free the non-huge page
> tables but also unmap the non-huge mapping for the block. Without the unmap,
> inconsistent TLB entries for the pages in the the block will be created.
> 
> We could also use unmap_stage2_range API to unmap the non-huge mapping,
> but this could potentially free the upper level page-table page which
> will be useful later.
> 
> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> ---
>  arch/arm64/kvm/hyp/pgtable.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index 696b6aa83faf..fec8dc9f2baa 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -500,6 +500,9 @@ static int stage2_map_walk_table_pre(u64 addr, u64 end, u32 level,
>  	return 0;
>  }
>  
> +static void stage2_flush_dcache(void *addr, u64 size);
> +static bool stage2_pte_cacheable(kvm_pte_t pte);
> +
>  static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
>  				struct stage2_map_data *data)
>  {
> @@ -507,9 +510,17 @@ static int stage2_map_walk_leaf(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
>  	struct page *page = virt_to_page(ptep);
>  
>  	if (data->anchor) {
> -		if (kvm_pte_valid(pte))
> +		if (kvm_pte_valid(pte)) {
> +			kvm_set_invalid_pte(ptep);
> +			kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu,
> +				     addr, level);
>  			put_page(page);

This doesn't make sense to me: the page-table pages we're walking when the
anchor is set are not accessible to the hardware walker because we unhooked
the entire sub-table in stage2_map_walk_table_pre(), which has the necessary
TLB invalidation.

Are you seeing a problem in practice here?

> +			if (stage2_pte_cacheable(pte))
> +				stage2_flush_dcache(kvm_pte_follow(pte),
> +						    kvm_granule_size(level));

I don't understand the need for the flush either, as we're just coalescing
existing entries into a larger block mapping.

Will
