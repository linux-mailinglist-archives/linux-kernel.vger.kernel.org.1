Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F392F4F0B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 16:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbhAMPpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 10:45:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbhAMPpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 10:45:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D01FA208BA;
        Wed, 13 Jan 2021 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610552661;
        bh=+rZ1G0MM72WaqgZtoKvVZ0XdQ+wClUuZnuEWYmqhNAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K8P+Ll0pkHS0co8mduKu2x4XQGzTmwp/re9ivY0Rm6Y1SaRk8tCzdlCMgVW/Qqs3q
         cSRjWLsbk8Knxh7HzOYiZK2NwryIfOEO8iSHNGCdtVI6yZvrs4tEJy3hj8uQa07WEr
         eWw+IQ2YYMOTevQ/oEeUGlVWF7fofd0qjyVxJVFS9PigiDSr+AHPBtpomjpgV8cQN/
         AOG/1qqHCNkggeEipinOedyNFqdzAJg5OTfwuaUFad32FMACRtwbwOasrGCpMQRqTR
         DDprXhjv2lobyQFXua7wUfZZKJN1o+14+R8r2G4ZNJltSNFsY5qyvrQAN9guO2DgUD
         PpEL+qjJ3Hbww==
Date:   Wed, 13 Jan 2021 15:44:15 +0000
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
Subject: Re: [PATCH v2 2/3] KVM: arm64: Add prejudgement for relaxing
 permissions only case in stage2 translation fault handler
Message-ID: <20210113154414.GA11892@willie-the-truck>
References: <20201216122844.25092-1-wangyanan55@huawei.com>
 <20201216122844.25092-3-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216122844.25092-3-wangyanan55@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 08:28:43PM +0800, Yanan Wang wrote:
> In dirty-logging, or dirty-logging-stopped time, even normal running
> time of a guest configed with huge mappings and numbers of vCPUs,
> translation faults by different vCPUs on the same GPA could occur
> successively almost at the same time. There are two reasons for it.
> 
> (1) If there are some vCPUs accessing the same GPA at the same time and
> the leaf PTE is not set yet, then they will all cause translation faults
> and the first vCPU holding mmu_lock will set valid leaf PTE, and the
> others will later update the old PTE with a new one if they are different.
> 
> (2) When changing a leaf entry or a table entry with break-before-make,
> if there are some vCPUs accessing the same GPA just catch the moment when
> the target PTE is set invalid in a BBM procedure coincidentally, they will
> all cause translation faults and will later update the old PTE with a new
> one if they are different.
> 
> The worst case can be like this: vCPU A causes a translation fault with RW
> prot and sets the leaf PTE with RW permissions, and then the next vCPU B
> with RO prot updates the PTE back to RO permissions with break-before-make.
> And the BBM-invalid moment may trigger more unnecessary translation faults,
> then some useless small loops might occur which could lead to vCPU stuck.
> 
> To avoid unnecessary update and small loops, add prejudgement in the
> translation fault handler: Skip updating the PTE with break-before-make
> if we are trying to recreate the exact same mapping or only change the
> access permissions. Actually, change of permissions will be handled
> through the relax_perms path next time if necessary.
> 
> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> ---
>  arch/arm64/kvm/hyp/pgtable.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index 350f9f810930..8225ced49bad 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -45,6 +45,10 @@
>  
>  #define KVM_PTE_LEAF_ATTR_HI_S2_XN	BIT(54)
>  
> +#define KVM_PTE_LEAF_ATTR_S2_PERMS	(KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | \
> +					 KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
> +					 KVM_PTE_LEAF_ATTR_HI_S2_XN)
> +
>  struct kvm_pgtable_walk_data {
>  	struct kvm_pgtable		*pgt;
>  	struct kvm_pgtable_walker	*walker;
> @@ -460,7 +464,7 @@ static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
>  	return 0;
>  }
>  
> -static bool stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
> +static int stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>  				       kvm_pte_t *ptep,
>  				       struct stage2_map_data *data)
>  {
> @@ -469,13 +473,18 @@ static bool stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
>  	struct page *page = virt_to_page(ptep);
>  
>  	if (!kvm_block_mapping_supported(addr, end, phys, level))
> -		return false;
> +		return 1;

It would probably be cleaner to return another error code here, as we
have failed to install a mapping (e.g. E2BIG or perhaps more perversely,
ENOTBLK). Then the caller can decide to install a trable.

Will
