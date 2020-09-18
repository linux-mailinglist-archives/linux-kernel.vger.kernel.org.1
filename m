Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C357E26F8E8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 11:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgIRJFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 05:05:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgIRJFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:05:39 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E677D20684;
        Fri, 18 Sep 2020 09:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600419939;
        bh=8bbkGB04wpb31wFP8bwL1MzqYlfmTRKDty4Y+cqJkqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RW9Go77Wx9GYu/FTIOjFFIKGYaoJQirk92/zZmytjdUrm67V87Lxb3ZtGXddUhikA
         y0b+5uBv4Qb+wfOCqKhzOzwoifzGdX575HxGkW8mgmedHIXMHX44v/XngCe+JAGMS7
         UimHKWTCG8MVKk0k7OI0G4qumwIfcUNQgpQyH1uE=
Date:   Fri, 18 Sep 2020 10:05:33 +0100
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
        kernel-team@android.com, Andrew Scull <ascull@google.com>
Subject: Re: [PATCH v3 05/11] kvm: arm64: Remove hyp_adr/ldr_this_cpu
Message-ID: <20200918090533.GE30834@willie-the-truck>
References: <20200916173439.32265-1-dbrazdil@google.com>
 <20200916173439.32265-6-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916173439.32265-6-dbrazdil@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 06:34:33PM +0100, David Brazdil wrote:
> The hyp_adr/ldr_this_cpu helpers were introduced for use in hyp code
> because they always needed to use TPIDR_EL2 for base, while
> adr/ldr_this_cpu from kernel proper would select between TPIDR_EL2 and
> _EL1 based on VHE/nVHE.
> 
> Simplify this now that the hyp mode case can be handled using the
> __KVM_VHE/NVHE_HYPERVISOR__ macros.
> 
> Acked-by: Andrew Scull <ascull@google.com>
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/include/asm/assembler.h | 27 +++++++++++++++++----------
>  arch/arm64/include/asm/kvm_asm.h   | 14 +-------------
>  arch/arm64/kvm/hyp/hyp-entry.S     |  2 +-
>  3 files changed, 19 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 54d181177656..f79231a0f949 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -218,6 +218,21 @@ lr	.req	x30		// link register
>  	str	\src, [\tmp, :lo12:\sym]
>  	.endm
>  
> +	/*
> +	 * @dst: destination register (32 or 64 bit wide)
> +	 */
> +	.macro	this_cpu_offset, dst
> +#if defined(__KVM_NVHE_HYPERVISOR__) || defined(__KVM_VHE_HYPERVISOR__)
> +	mrs	\dst, tpidr_el2
> +#else
> +alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
> +	mrs	\dst, tpidr_el1
> +alternative_else
> +	mrs	\dst, tpidr_el2
> +alternative_endif
> +#endif

Cosmetic, but I think it would be cleaner just to define two variants of the
macro here:

#if defined(__KVM_NVHE_HYPERVISOR__) || defined(__KVM_VHE_HYPERVISOR__)
	.macro  this_cpu_offset, dst
	mrs     \dst, tpidr_el2
	.endm
#else
	.macro  this_cpu_offset, dst
alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
	mrs     \dst, tpidr_el1
alternative_else
	mrs     \dst, tpidr_el2
alternative_endif
	.endm
#endif

(and should we have a shorthand __HYPERVISOR define to avoid the NVHE || VHE
logic?)

With that:

Acked-by: Will Deacon <will@kernel.org>

Will
