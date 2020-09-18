Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E094226F8AB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgIRIvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:51:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgIRIvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:51:24 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97F6D208B8;
        Fri, 18 Sep 2020 08:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600419083;
        bh=xSuljIaVzLXu/fP2mE0aGU32cBoHqrhtfIi4pwf6ku0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RNh/kppbBRNafdG5SxQjmgKu6lqLfCQO68yvGZ2XZ0suKr94KuMwIOD6RSsQFvnKI
         U+4FYyhlZN9nx3UowWA8v4x4ZWdHVqoC6dPHOwb405yYU93zomqj0i4XFen2uxOpKC
         fkimNUzViQv7Z0sKBHoDStVpoTLvWQ417k2DNin0=
Date:   Fri, 18 Sep 2020 09:51:17 +0100
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
Subject: Re: [PATCH v3 01/11] kvm: arm64: Partially link nVHE hyp code,
 simplify HYPCOPY
Message-ID: <20200918085116.GA30834@willie-the-truck>
References: <20200916173439.32265-1-dbrazdil@google.com>
 <20200916173439.32265-2-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916173439.32265-2-dbrazdil@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 06:34:29PM +0100, David Brazdil wrote:
> Relying on objcopy to prefix the ELF section names of the nVHE hyp code
> is brittle and prevents us from using wildcards to match specific
> section names.
> 
> Improve the build rules by partially linking all '.nvhe.o' files and
> prefixing their ELF section names using a linker script. Continue using
> objcopy for prefixing ELF symbol names.
> 
> One immediate advantage of this approach is that all subsections
> matching a pattern can be merged into a single prefixed section, eg.
> .text and .text.* can be linked into a single '.hyp.text'. This removes
> the need for -fno-reorder-functions on GCC and will be useful in the
> future too: LTO builds use .text subsections, compilers routinely
> generate .rodata subsections, etc.
> 
> Partially linking all hyp code into a single object file also makes it
> easier to analyze.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/include/asm/hyp_image.h | 24 ++++++++++++
>  arch/arm64/kvm/hyp/nvhe/Makefile   | 60 ++++++++++++++++--------------
>  arch/arm64/kvm/hyp/nvhe/hyp.lds.S  | 13 +++++++
>  3 files changed, 70 insertions(+), 27 deletions(-)
>  create mode 100644 arch/arm64/include/asm/hyp_image.h
>  create mode 100644 arch/arm64/kvm/hyp/nvhe/hyp.lds.S
> 
> diff --git a/arch/arm64/include/asm/hyp_image.h b/arch/arm64/include/asm/hyp_image.h
> new file mode 100644
> index 000000000000..5b1e3b9ef376
> --- /dev/null
> +++ b/arch/arm64/include/asm/hyp_image.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020 Google LLC.
> + * Written by David Brazdil <dbrazdil@google.com>
> + */
> +
> +#ifndef __ARM64_HYP_IMAGE_H__
> +#define __ARM64_HYP_IMAGE_H__
> +
> +#ifdef LINKER_SCRIPT
> +
> +/*
> + * KVM nVHE ELF section names are prefixed with .hyp, to separate them
> + * from the kernel proper.
> + */
> +#define HYP_SECTION_NAME(NAME)	.hyp##NAME
> +
> +/* Defines an ELF hyp section from input section @NAME and its subsections. */
> +#define HYP_SECTION(NAME) \
> +	HYP_SECTION_NAME(NAME) : { *(NAME NAME##.[0-9a-zA-Z_]*) }

I still don't get why we can't just use NAME ## .* for the regex here. That
matches what we do elsewhere for linker script wildcarding, e.g. .rodata.*,
.init.text.* ...  in asm-generic/vmlinux.lds.h. Why is it different for
these sections?

> +
> +#endif /* LINKER_SCRIPT */
> +
> +#endif /* __ARM64_HYP_IMAGE_H__ */
> diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
> index aef76487edc2..2b27b60182f9 100644
> --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> @@ -10,40 +10,46 @@ obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o
>  obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
>  	 ../fpsimd.o ../hyp-entry.o
>  
> -obj-y := $(patsubst %.o,%.hyp.o,$(obj-y))
> -extra-y := $(patsubst %.hyp.o,%.hyp.tmp.o,$(obj-y))
> +##
> +## Build rules for compiling nVHE hyp code
> +## Output of this folder is `kvm_nvhe.o`, a partially linked object
> +## file containing all nVHE hyp code and data.
> +##
>  
> -$(obj)/%.hyp.tmp.o: $(src)/%.c FORCE
> +hyp-obj := $(patsubst %.o,%.nvhe.o,$(obj-y))
> +obj-y := kvm_nvhe.o
> +extra-y := $(hyp-obj) kvm_nvhe.tmp.o hyp.lds
> +
> +# 1) Compile all source files to `.nvhe.o` object files. The file extension
> +#    avoids file name clashes for files shared with VHE.
> +$(obj)/%.nvhe.o: $(src)/%.c FORCE
>  	$(call if_changed_rule,cc_o_c)
> -$(obj)/%.hyp.tmp.o: $(src)/%.S FORCE
> +$(obj)/%.nvhe.o: $(src)/%.S FORCE
>  	$(call if_changed_rule,as_o_S)
> -$(obj)/%.hyp.o: $(obj)/%.hyp.tmp.o FORCE
> -	$(call if_changed,hypcopy)
>  
> -# Disable reordering functions by GCC (enabled at -O2).
> -# This pass puts functions into '.text.*' sections to aid the linker
> -# in optimizing ELF layout. See HYPCOPY comment below for more info.
> -ccflags-y += $(call cc-option,-fno-reorder-functions)
> +# 2) Compile linker script.
> +$(obj)/hyp.lds: $(src)/hyp.lds.S FORCE
> +	$(call if_changed_dep,cpp_lds_S)

You need a .gitignore file listing hyp.lds, otherwise some idiot will end
up committing it. I definitely didn't do that when playing around with this
series. Nope. Not at all.

With that, and the regex resolved:

Acked-by: Will Deacon <will@kernel.org>

Will
