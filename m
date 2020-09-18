Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B90326FBEB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgIRL7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:59:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgIRL7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:59:18 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 495142100A;
        Fri, 18 Sep 2020 11:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600430357;
        bh=3Qap6q40YIglmIHbQ+ks0DDlLM3eZIky/ggcT6S4TQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wi8gJFm90edZexQ0zmiObRObbHa7NJpw7886jHiADFFDszzxGATrW8XpeWZw5dxah
         fHUFqGko9Z7dTZGUcTjla0sFR8Lz5jiFLcGkCJ+UO1stNpP2Zgh4qHdD4LQYa1s81M
         W0vBdzAmsV0YtPGgfh6haS+qfm6IAI+ycXfGx0Wc=
Date:   Fri, 18 Sep 2020 12:59:12 +0100
From:   Will Deacon <will@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 07/11] kvm: arm64: Duplicate
 arm64_ssbd_callback_required for nVHE hyp
Message-ID: <20200918115911.GB31096@willie-the-truck>
References: <20200916173439.32265-1-dbrazdil@google.com>
 <20200916173439.32265-8-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916173439.32265-8-dbrazdil@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 06:34:35PM +0100, David Brazdil wrote:
> Hyp keeps track of which cores require SSBD callback by accessing a
> kernel-proper global variable. Create an nVHE symbol of the same name
> and copy the value from kernel proper to nVHE at KVM init time.
> 
> Done in preparation for separating percpu memory owned by kernel
> proper and nVHE.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/include/asm/kvm_mmu.h | 10 +++++++---
>  arch/arm64/kernel/image-vars.h   |  1 -
>  arch/arm64/kvm/arm.c             |  2 +-
>  arch/arm64/kvm/hyp/nvhe/switch.c |  3 +++
>  4 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> index 189839c3706a..9db93da35606 100644
> --- a/arch/arm64/include/asm/kvm_mmu.h
> +++ b/arch/arm64/include/asm/kvm_mmu.h
> @@ -529,23 +529,27 @@ static inline int kvm_map_vectors(void)
>  
>  #ifdef CONFIG_ARM64_SSBD
>  DECLARE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
> +DECLARE_KVM_NVHE_PER_CPU(u64, arm64_ssbd_callback_required);
>  
> -static inline int hyp_map_aux_data(void)
> +static inline int hyp_init_aux_data(void)
>  {
>  	int cpu, err;
>  
>  	for_each_possible_cpu(cpu) {
>  		u64 *ptr;
>  
> -		ptr = per_cpu_ptr(&arm64_ssbd_callback_required, cpu);
> +		ptr = per_cpu_ptr_nvhe(arm64_ssbd_callback_required, cpu);
>  		err = create_hyp_mappings(ptr, ptr + 1, PAGE_HYP);
>  		if (err)
>  			return err;
> +
> +		/* Copy value from kernel to hyp. */
> +		*ptr = per_cpu(arm64_ssbd_callback_required, cpu);

Hmm. Is this correct for late arriving CPUs, where we don't know whether
a callback is required at the point we do the copy?

That sounds fiddly to resolve, but this _might_ all be moot because I'm
about to post a series that allows us to remove the hyp mapping of this
variable entirely. So leave this for now, but maybe stick a comment in
that it doesn't work for late cpus.

Will
