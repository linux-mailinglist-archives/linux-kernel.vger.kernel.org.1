Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565DF26BF7A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgIPIiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:38:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbgIPIiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:38:03 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4FA82064E;
        Wed, 16 Sep 2020 08:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600245482;
        bh=ayHqD0TxwK+DKfoaoQ5U/0qGfOY6exkP6goS8angK4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qGEn+X97bm/YN/f+V8umKxtNMSFx/ciTUIo7tQe8epZAfaYwBRvP6AEB5Z5NInYAD
         S3STXFRBhTgYskh7xiRZm9P5KJIN/vOPJWDaBdcjdTou5QCVZYtRIuk2X40h3l80fw
         uQ5jSfJsSaY2ecWqqpn4aTryoCuef03zQiXcvC+s=
Date:   Wed, 16 Sep 2020 09:37:57 +0100
From:   Will Deacon <will@kernel.org>
To:     Xiaofei Tan <tanxiaofei@huawei.com>
Cc:     maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v2] KVM: arm64: fix doc warnings in mmu code
Message-ID: <20200916083756.GD27496@willie-the-truck>
References: <1600221639-4471-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600221639-4471-1-git-send-email-tanxiaofei@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 10:00:39AM +0800, Xiaofei Tan wrote:
> Fix following warnings caused by mismatch bewteen function parameters
> and comments.
> arch/arm64/kvm/mmu.c:128: warning: Function parameter or member 'mmu' not described in '__unmap_stage2_range'
> arch/arm64/kvm/mmu.c:128: warning: Function parameter or member 'may_block' not described in '__unmap_stage2_range'
> arch/arm64/kvm/mmu.c:128: warning: Excess function parameter 'kvm' description in '__unmap_stage2_range'
> arch/arm64/kvm/mmu.c:499: warning: Function parameter or member 'writable' not described in 'kvm_phys_addr_ioremap'
> arch/arm64/kvm/mmu.c:538: warning: Function parameter or member 'mmu' not described in 'stage2_wp_range'
> arch/arm64/kvm/mmu.c:538: warning: Excess function parameter 'kvm' description in 'stage2_wp_range'
> 
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> ---
>  arch/arm64/kvm/mmu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index e8a51799..909e995 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -114,9 +114,10 @@ static bool kvm_is_device_pfn(unsigned long pfn)
>   */
>  /**
>   * unmap_stage2_range -- Clear stage2 page table entries to unmap a range
> - * @kvm:   The VM pointer
> + * @mmu:   pointer to mmu structure to operate on
>   * @start: The intermediate physical base address of the range to unmap
>   * @size:  The size of the area to unmap
> + * @may_block: The flag that if block is allowed here

Whether or not we are permitted to block.

>   *
>   * Clear a range of stage-2 mappings, lowering the various ref-counts.  Must
>   * be called while holding mmu_lock (unless for freeing the stage2 pgd before
> @@ -493,6 +494,7 @@ void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu)
>   * @guest_ipa:	The IPA at which to insert the mapping
>   * @pa:		The physical address of the device
>   * @size:	The size of the mapping
> + * @writable:   If it is writable here

Whether or not to create a writable mapping.

>   */
>  int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
>  			  phys_addr_t pa, unsigned long size, bool writable)
> @@ -530,7 +532,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
>  
>  /**
>   * stage2_wp_range() - write protect stage2 memory region range
> - * @kvm:	The KVM pointer
> + * @mmu:        pointer to mmu structure to operate on

The KVM stage-2 MMU pointer.

Will
