Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32902C8500
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgK3NWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:22:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbgK3NWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:22:21 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48334206F9;
        Mon, 30 Nov 2020 13:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606742500;
        bh=gp/c1E7Z/fJDz9MSxVD5z46kbUzUAVwzY3qc3WzdfAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o1NC+rnv0ct8v2OvLOXV/3bHWyPXa1peKB6ER4KOtm7UqFOxIhAhpuXKIqRi8NAdb
         pMM18yWdbu20bY679BQLRr69tRIT6UVJcvY88CM9WJMv+7OOV9XyoGeBE+KcYXYU2j
         WId7gM2IrW69ZGYIT4hh3nForfeKOmmxKV7nqxWg=
Date:   Mon, 30 Nov 2020 13:21:33 +0000
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
Subject: Re: [RFC PATCH 1/3] KVM: arm64: Fix possible memory leak in kvm
 stage2
Message-ID: <20201130132133.GA24837@willie-the-truck>
References: <20201130121847.91808-1-wangyanan55@huawei.com>
 <20201130121847.91808-2-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130121847.91808-2-wangyanan55@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 08:18:45PM +0800, Yanan Wang wrote:
> When installing a new leaf pte onto an invalid ptep, we need to get_page(ptep).
> When just updating a valid leaf ptep, we shouldn't get_page(ptep).
> Incorrect page_count of translation tables might lead to memory leak,
> when unmapping a stage 2 memory range.

Did you find this by inspection, or did you hit this in practice? I'd be
interested to see the backtrace for mapping over an existing mapping.

> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> ---
>  arch/arm64/kvm/hyp/pgtable.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index 0271b4a3b9fe..696b6aa83faf 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -186,6 +186,7 @@ static bool kvm_set_valid_leaf_pte(kvm_pte_t *ptep, u64 pa, kvm_pte_t attr,
>  		return old == pte;
>  
>  	smp_store_release(ptep, pte);
> +	get_page(virt_to_page(ptep));

This is also used for the hypervisor stage-1 page-table, so I'd prefer to
leave this function as-is.

>  	return true;
>  }
>  
> @@ -476,6 +477,7 @@ static bool stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>  	/* There's an existing valid leaf entry, so perform break-before-make */
>  	kvm_set_invalid_pte(ptep);
>  	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, level);
> +	put_page(virt_to_page(ptep));
>  	kvm_set_valid_leaf_pte(ptep, phys, data->attr, level);
>  out:
>  	data->phys += granule;

Isn't this hunk alone sufficient to solve the problem?

Will
