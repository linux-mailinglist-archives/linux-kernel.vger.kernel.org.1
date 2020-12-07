Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47732D1250
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgLGNlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:41:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:48608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgLGNlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:41:39 -0500
Date:   Mon, 7 Dec 2020 13:40:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607348458;
        bh=Wi5SMyGM9uyVoSdAy74aJh2UMPtwUKtUU8CMK6gezcY=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=n1w8OR/NmXAqtAa8TG0UjI7ivuFVDdh99zrbuXxuXdjaJj31CB7VBLOirM/bAJS89
         xZI/TZofhOEFLT6hz7Bk9ZaQRideoWzX2+ceTsmxQgkWdvi87rbOTrMpCMx+kCBXu8
         ohFnUg0gTLdgsT+hsR7Ld4Udy3oVEjXZQIZ8gydCMrLFbfTOkd6pZuZkfxQay6joup
         itjjEC/PMT5kDwTSX3fvlmV8E+DjjuptXAA/gVhFZu/ndKJH5USQFbUN5ZC6zMNDVw
         KG3BYjdAXn9UQ7OyFx2gj1KuApgM81+6T38W6F5JY/+flBam8HAwROhu0ndJP40J/d
         PX1/VsdBJSkug==
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, kernel-team@android.com,
        android-kvm@google.com
Subject: Re: [RFC PATCH 16/27] KVM: arm64: Prepare Hyp memory protection
Message-ID: <20201207134052.GA4563@willie-the-truck>
References: <20201117181607.1761516-1-qperret@google.com>
 <20201117181607.1761516-17-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117181607.1761516-17-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Tue, Nov 17, 2020 at 06:15:56PM +0000, Quentin Perret wrote:
> When memory protection is enabled, the Hyp code needs the ability to
> create and manage its own page-table. To do so, introduce a new set of
> hypercalls to initialize Hyp memory protection.
> 
> During the init hcall, the hypervisor runs with the host-provided
> page-table and uses the trivial early page allocator to create its own
> set of page-tables, using a memory pool that was donated by the host.
> Specifically, the hypervisor creates its own mappings for __hyp_text,
> the Hyp memory pool, the __hyp_bss, the portion of hyp_vmemmap
> corresponding to the Hyp pool, among other things. It then jumps back in
> the idmap page, switches to use the newly-created pgd (instead of the
> temporary one provided by the host) and then installs the full-fledged
> buddy allocator which will then be the only one in used from then on.
> 
> Note that for the sake of symplifying the review, this only introduces
> the code doing this operation, without actually being called by anyhing
> yet. This will be done in a subsequent patch, which will introduce the
> necessary host kernel changes.

[...]

> diff --git a/arch/arm64/kvm/hyp/reserved_mem.c b/arch/arm64/kvm/hyp/reserved_mem.c
> new file mode 100644
> index 000000000000..02b0b18006f5
> --- /dev/null
> +++ b/arch/arm64/kvm/hyp/reserved_mem.c

[...]

> +extern bool enable_protected_kvm;
> +void __init reserve_kvm_hyp(void)
> +{
> +	u64 nr_pages, prev;
> +
> +	if (!enable_protected_kvm)
> +		return;
> +
> +	if (!is_hyp_mode_available() || is_kernel_in_hyp_mode())
> +		return;
> +
> +	if (kvm_nvhe_sym(hyp_memblock_nr) <= 0)
> +		return;
> +
> +	hyp_mem_size += num_possible_cpus() << PAGE_SHIFT;
> +	hyp_mem_size += hyp_s1_pgtable_size();
> +
> +	/*
> +	 * The hyp_vmemmap needs to be backed by pages, but these pages
> +	 * themselves need to be present in the vmemmap, so compute the number
> +	 * of pages needed by looking for a fixed point.
> +	 */
> +	nr_pages = 0;
> +	do {
> +		prev = nr_pages;
> +		nr_pages = (hyp_mem_size >> PAGE_SHIFT) + prev;
> +		nr_pages = DIV_ROUND_UP(nr_pages * sizeof(struct hyp_page), PAGE_SIZE);
> +		nr_pages += __hyp_pgtable_max_pages(nr_pages);
> +	} while (nr_pages != prev);
> +	hyp_mem_size += nr_pages << PAGE_SHIFT;
> +
> +	hyp_mem_base = memblock_find_in_range(0, memblock_end_of_DRAM(),
> +					      hyp_mem_size, SZ_2M);
> +	if (!hyp_mem_base) {
> +		kvm_err("Failed to reserve hyp memory\n");
> +		return;
> +	}
> +	memblock_reserve(hyp_mem_base, hyp_mem_size);

Why not use the RESERVEDMEM_OF_DECLARE() interface for the hypervisor
memory? That way, the hypervisor memory can either be statically partitioned
as a carveout or allocated dynamically for us -- we wouldn't need to care.

Will
