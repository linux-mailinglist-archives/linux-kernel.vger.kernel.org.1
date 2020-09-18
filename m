Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7C426F929
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 11:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIRJYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 05:24:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgIRJYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:24:07 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 238A120DD4;
        Fri, 18 Sep 2020 09:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600421046;
        bh=5BPFCutNa5VNQMibpDHHB+qvvOTgQcOE09RubxpF1GI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xU5lzR1Ga0PcfhABCdoUUHXJd6dN4fDFAU+RJC4XjY97A6xGaeDusE+AIxQe09UUe
         cjDXcplObHW/R0vJ/QWHVnEYHNiAmMG2eH98/7f5xG9jUnkaKa5fMSVYDlcCKKQY1K
         3J3oarxI8eW8I9yOa/ZZSSr5YNbR3x/6bNNhLGVY=
Date:   Fri, 18 Sep 2020 10:24:01 +0100
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
Subject: Re: [PATCH v3 06/11] kvm: arm64: Add helpers for accessing nVHE hyp
 per-cpu vars
Message-ID: <20200918092400.GF30834@willie-the-truck>
References: <20200916173439.32265-1-dbrazdil@google.com>
 <20200916173439.32265-7-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916173439.32265-7-dbrazdil@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 06:34:34PM +0100, David Brazdil wrote:
> Defining a per-CPU variable in hyp/nvhe will result in its name being
> prefixed with __kvm_nvhe_. Add helpers for declaring these variables
> in kernel proper and accessing them with this_cpu_ptr and per_cpu_ptr.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
> index cf9456663289..abc03f386b40 100644
> --- a/arch/arm64/include/asm/kvm_asm.h
> +++ b/arch/arm64/include/asm/kvm_asm.h
> @@ -54,9 +54,21 @@
>  	DECLARE_KVM_VHE_SYM(sym);		\
>  	DECLARE_KVM_NVHE_SYM(sym)
>  
> +#define DECLARE_KVM_VHE_PER_CPU(type, sym)	\
> +	DECLARE_PER_CPU(type, sym)
> +#define DECLARE_KVM_NVHE_PER_CPU(type, sym)	\
> +	DECLARE_PER_CPU(type, kvm_nvhe_sym(sym))
> +
> +#define DECLARE_KVM_HYP_PER_CPU(type, sym)	\
> +	DECLARE_KVM_VHE_PER_CPU(type, sym);	\
> +	DECLARE_KVM_NVHE_PER_CPU(type, sym)
> +
>  #define CHOOSE_VHE_SYM(sym)	sym
>  #define CHOOSE_NVHE_SYM(sym)	kvm_nvhe_sym(sym)
>  
> +#define this_cpu_ptr_nvhe(sym)		this_cpu_ptr(&kvm_nvhe_sym(sym))
> +#define per_cpu_ptr_nvhe(sym, cpu)	per_cpu_ptr(&kvm_nvhe_sym(sym), cpu)

nit: I'd probably stick a _sym suffix on these macros, to make it clear
that they're just munging the symbol name rather than doing some completely
different pcpu implementation.

THat said, do you expect these to be used outside of the pcpu
implementation? If not, I suggest some underscores as a prefix as well.

>  #ifndef __KVM_NVHE_HYPERVISOR__
>  /*
>   * BIG FAT WARNINGS:
> @@ -69,12 +81,21 @@
>   * - Don't let the nVHE hypervisor have access to this, as it will
>   *   pick the *wrong* symbol (yes, it runs at EL2...).
>   */
> -#define CHOOSE_HYP_SYM(sym)	(is_kernel_in_hyp_mode() ? CHOOSE_VHE_SYM(sym) \
> +#define CHOOSE_HYP_SYM(sym)		(is_kernel_in_hyp_mode()	\
> +					   ? CHOOSE_VHE_SYM(sym)	\
>  					   : CHOOSE_NVHE_SYM(sym))
> +#define this_cpu_ptr_hyp(sym)		(is_kernel_in_hyp_mode()	\
> +					   ? this_cpu_ptr(&sym)		\
> +					   : this_cpu_ptr_nvhe(sym))
> +#define per_cpu_ptr_hyp(sym, cpu)	(is_kernel_in_hyp_mode()	\
> +					   ? per_cpu_ptr(&sym, cpu)	\
> +					   : per_cpu_ptr_nvhe(sym, cpu))

is_kernel_in_hyp_mode() reads a system register to determine the current
exception level, so this doesn't seem like something we should be doing
everytime here. Perhaps is_kernel_in_hyp_mode() should avoid read_sysreg()
and instead use a non-volatile asm to allow the result to be cached by
the compiler. Hmm.

But I think that can be tackled as a future patch, so with the naming nits
resolved:

Acked-by: Will Deacon <will@kernel.org>

Will
