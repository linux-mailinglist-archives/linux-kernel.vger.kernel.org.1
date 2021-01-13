Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31ED12F4F36
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 16:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbhAMPvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 10:51:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbhAMPvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 10:51:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E50042339F;
        Wed, 13 Jan 2021 15:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610553067;
        bh=1Z8kzuRj8UI/6fvft+ap1+v80qkzAnNOJX1YJ8zkw2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A2x/KI16upUQfU/SupIDBtGzUJm/3Ba0U76DvtygD4kBsZT4yL320QjAc8pGXdhD5
         jpp52yBL1NW6dHqL+ADNpodo95YEUm7rCTF0QmTuKWktEilswXn9z9FwxPLsxJua5h
         IB48KpyHJu/JSGn8WbDbKp1QyGPPDo7F8Q/tqY367FG3Xa4hHl1S6r8DTlE/AREnIo
         d7UMs90WTpNmBegxk3rVDvHn8Wyh3gF27h1eoALdDp1SPblwOgmqZik21LE9b4ida7
         9nVPN/ZmX+qD8twK0+twH7adJ9tZbV7JcGUaGwNV7bqwi5Al4sjBJ/CPkM6e4apk/f
         bAg0AFwUa7RZw==
Date:   Wed, 13 Jan 2021 15:51:01 +0000
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
        zhukeqian1@huawei.com, yuzenghui@huawei.com
Subject: Re: [PATCH v2 3/3] KVM: arm64: Mark the page dirty only if the fault
 is handled successfully
Message-ID: <20210113155101.GB11892@willie-the-truck>
References: <20201216122844.25092-1-wangyanan55@huawei.com>
 <20201216122844.25092-4-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216122844.25092-4-wangyanan55@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 08:28:44PM +0800, Yanan Wang wrote:
> We now mark the page dirty and set the bitmap before calling fault handlers
> in user_mem_abort(), and we might end up having spurious dirty pages if
> update of permissions or mapping has failed.
> So, mark the page dirty only if the fault is handled successfully.
> 
> Let the guest directly enter again but not return to userspace if we were
> trying to recreate the same mapping or only change access permissions
> with BBM, which is not permitted in the mapping path.
> 
> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> ---
>  arch/arm64/kvm/mmu.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 75814a02d189..72e516a10914 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -879,11 +879,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  	if (vma_pagesize == PAGE_SIZE && !force_pte)
>  		vma_pagesize = transparent_hugepage_adjust(memslot, hva,
>  							   &pfn, &fault_ipa);
> -	if (writable) {
> +	if (writable)
>  		prot |= KVM_PGTABLE_PROT_W;
> -		kvm_set_pfn_dirty(pfn);
> -		mark_page_dirty(kvm, gfn);
> -	}
>  
>  	if (fault_status != FSC_PERM && !device)
>  		clean_dcache_guest_page(pfn, vma_pagesize);
> @@ -911,6 +908,19 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>  					     memcache);
>  	}
>  
> +	/* Mark the page dirty only if the fault is handled successfully */
> +	if (writable && !ret) {
> +		kvm_set_pfn_dirty(pfn);
> +		mark_page_dirty(kvm, gfn);
> +	}
> +
> +	/* Let the guest directly enter again if we were trying to recreate the
> +	 * same mapping or only change access permissions with BBM, which is not
> +	 * permitted in the mapping path.
> +	 */
> +	if (ret == -EAGAIN)
> +		ret = 0;

Maybe just 'return ret != -EAGAIN ? ret : 0;' at the end of the function?

Will
