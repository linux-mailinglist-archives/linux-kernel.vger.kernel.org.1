Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58E92FAB86
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 21:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388637AbhARUcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 15:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388890AbhARKjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:39:01 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077F3C06179B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:37:50 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id 6so8639863wri.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8RXkrFRFJwJ+oqCkXLgdONP2D6hTU8qpkCbMpSj9WH0=;
        b=OhObTyOoxSMRWrfcNrTccJedaKdnx+PkZW8hkA3Nhksao0r9R5CyAx2p0WOwzsu/hp
         8XswgsCkqkdhri9K5twqBgerq1kg1J6EECSqMn2Hasib1YCZXszwR1hG8qoZdeTaPAMI
         qUrUfGrU4UbdzoOQAvzimXKEcCgFBlCVt12Ykh58Ajm1HlwmYr72u24pJfXgLB4qdyvu
         NqQ4bRbb9Yh0vMWOuaDd6dDQAN38+sM0Zs4vZp+5ysqdBxjUmuvEp7rbDiU0VY5icDf2
         74HRq16H5sO35IsYdo9GcnONS8W58IehOpKcHLkfqqMdJoJkCGAiWRxDY/L0OQNn6l81
         tu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8RXkrFRFJwJ+oqCkXLgdONP2D6hTU8qpkCbMpSj9WH0=;
        b=ZredQD8gPXZdzgGbLkXdWZmcHwEAhoPlNMwlpmYB0vQ6bqMqP3ksT8Oc+zxSIbeP5W
         5lGo+NFl9BVLKTJdqOiz/GtLJavukTKN2/XCZhp2JiXk/e9HBreIUNi1ueQa+zi80N/0
         2GvO4iXypz5HSG465uqJQCsauyABa+HGuTVzpTCNgV1Oiz97AxVMZLWQ2Bnz28gBpjMs
         GXzW8T+5uT7pdXXkzbo6R6xitUJo95gSpfZs/Mx3tSaIxbeVvHAyMBFfSugQtq66K2gc
         nPWIPkhhfmhBKoFZVhiFRpwCwgOjJV34clkIbQricuDky48IKe/dB8035rteSNcVbPaw
         InpA==
X-Gm-Message-State: AOAM5301DEvDVXND7TuD1PSoecFEj6Y5rroCBpz+ZSLD1MFvqDIpY5mf
        pnLW3tAMHOobVEF2uT8M5qf/Ww==
X-Google-Smtp-Source: ABdhPJysKE8lBWCShK+bM2jqC3yLfqUFGuDKvVf+C6aF24rTM535yOPc8akXpH9HIWrOLgV6YvS9jg==
X-Received: by 2002:a5d:690d:: with SMTP id t13mr25129837wru.410.1610966268608;
        Mon, 18 Jan 2021 02:37:48 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:3d4d:985d:87b7:4d55])
        by smtp.gmail.com with ESMTPSA id s13sm30502983wra.53.2021.01.18.02.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 02:37:47 -0800 (PST)
Date:   Mon, 18 Jan 2021 10:37:46 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Elena Petrova <lenaptr@google.com>
Cc:     kvmarm@lists.cs.columbia.edu,
        George Popescu <georgepope@google.com>,
        Marc Zyngier <maz@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        George Popescu <george.apopescu97@gmail.com>
Subject: Re: [PATCH v3 2/9] KVM: arm64: Add a buffer that can pass UBSan data
 from hyp/nVHE to kernel
Message-ID: <20210118103746.hnmx2eqhubx6ekni@google.com>
References: <20210115171830.3602110-1-lenaptr@google.com>
 <20210115171830.3602110-3-lenaptr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115171830.3602110-3-lenaptr@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 05:18:23PM +0000, Elena Petrova wrote:
> From: George Popescu <georgepope@google.com>
> 
> Share a buffer between the kernel and the hyp/nVHE code by using the
> macros from kvm_debug_buffer.h.
> The hyp/nVHE code requires a write index which counts how many elements
> have been writtens inside the buffer and the kernel requires a read
> index which counts how many elements have been read from the buffer.
> The write index and the buffer are shared with the kernel in read-only.
> 
> The kvm_debug_buffer_ind returns the reading and writing points of the
> circular buffer and updates the reading index.
> 
> Data collected from UBSan handlers inside hyp/nVHE is stored in the
> kvm_ubsan_buffer.
> This buffer stores only UBSan data because it should not be preoccupied
> by other mechanisms data structures and functionalities.
> 
> Also, for the moment the buffer is mapped inside .bss, where both the kernel
> and the hyp/nVHE code have Read/Write rights, but in the future this will change
> and the kernel will not be able to acess hyp/nVHE's .bss. At that point the buffer
> will only need to be mapped in order for this patch to work.
> 
> Signed-off-by: Elena Petrova <lenaptr@google.com>
> ---
>  arch/arm64/include/asm/assembler.h        | 11 +++++++
>  arch/arm64/include/asm/kvm_debug_buffer.h | 36 ++++++++++++++++++++
>  arch/arm64/include/asm/kvm_host.h         |  8 ++++-
>  arch/arm64/include/asm/kvm_ubsan.h        | 14 ++++++++
>  arch/arm64/kvm/Makefile                   |  2 ++
>  arch/arm64/kvm/arm.c                      |  9 +++++
>  arch/arm64/kvm/hyp/nvhe/host.S            |  4 +++
>  arch/arm64/kvm/hyp/nvhe/ubsan.c           | 23 +++++++++++++
>  arch/arm64/kvm/kvm_ubsan_buffer.c         | 40 +++++++++++++++++++++++
>  9 files changed, 146 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/include/asm/kvm_debug_buffer.h
>  create mode 100644 arch/arm64/include/asm/kvm_ubsan.h
>  create mode 100644 arch/arm64/kvm/kvm_ubsan_buffer.c
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index bf125c591116..ebc18a8a0e1f 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -258,6 +258,17 @@ alternative_endif
>  	ldr	\dst, [\dst, \tmp]
>  	.endm
>  
> +	/*
> +         * @sym: The name of the per-cpu variable
> +         * @reg: value to store
> +         * @tmp1: scratch register
> +         * @tmp2: scratch register
> +         */
> +        .macro str_this_cpu sym, reg, tmp1, tmp2
> +        adr_this_cpu \tmp1, \sym, \tmp2
> +        str \reg, [\tmp1]
> +        .endm
> +
>  /*
>   * vma_vm_mm - get mm pointer from vma pointer (vma->vm_mm)
>   */
> diff --git a/arch/arm64/include/asm/kvm_debug_buffer.h b/arch/arm64/include/asm/kvm_debug_buffer.h
> new file mode 100644
> index 000000000000..e5375c2cff1a
> --- /dev/null
> +++ b/arch/arm64/include/asm/kvm_debug_buffer.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright 2020 Google LLC
> + * Author: George Popescu <georgepope@google.com>
> + */
> +
> +#include <linux/percpu-defs.h>
> +
> +
> +#define KVM_DEBUG_BUFFER_SIZE 1000
nit: unused?

> +
> +#ifdef __KVM_NVHE_HYPERVISOR__
> +#define DEFINE_KVM_DEBUG_BUFFER(type_name, buffer_name, write_ind, size)\
> +	DEFINE_PER_CPU(type_name, buffer_name)[size];			\
> +	DEFINE_PER_CPU(unsigned long, write_ind) = 0;

This is subjective but I would:
  * stop calling the second variable a "write index" and instead call it
    "cursor" - I think this is a leftover from George's early two-cursor
    implementation
  * wrap these two variables in a struct; that is a bit tricky given that each
    instantiation defines its own size (the macros would have to generate that
    struct), so bar that I would at least generate the name of the cursor
    variable as buffer_name##suffix.

> +
> +#define DECLARE_KVM_DEBUG_BUFFER(type_name, buffer_name, write_ind, size)\
> +	DECLARE_PER_CPU(type_name, buffer_name)[size];			\
> +	DECLARE_PER_CPU(unsigned long, write_ind);
> +#else
> +#define DECLARE_KVM_DEBUG_BUFFER(type_name, buffer_name, write_ind, size)\
> +	DECLARE_KVM_NVHE_PER_CPU(type_name, buffer_name)[size]; 	\
> +        DECLARE_KVM_NVHE_PER_CPU(unsigned long, write_ind);
> +#endif //__KVM_NVHE_HYPERVISOR__
> +
> +#ifdef __ASSEMBLY__
> +#include <asm/assembler.h>
> +
> +.macro clear_buffer tmp1, tmp2, tmp3
> +        mov \tmp1, 0
> +#ifdef CONFIG_UBSAN
> +        str_this_cpu kvm_ubsan_buff_wr_ind, \tmp1, \tmp2, \tmp3
> +#endif //CONFIG_UBSAN
> +.endm

I find this macro odd. Everything else in this file is about a generic buffer
data structure, yet this macro enumerates all instantiations of it (currently
just one). Please keep this generic and pass the name of the buffer cursor
as a parameter.

> +
> +#endif
> \ No newline at end of file
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 8fcfab0c2567..905ca0d7c52c 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -592,6 +592,12 @@ int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
>  void kvm_arm_halt_guest(struct kvm *kvm);
>  void kvm_arm_resume_guest(struct kvm *kvm);
>  
> +
nit: Two empty lines

> +#ifdef CONFIG_UBSAN
> +extern void __kvm_check_ubsan_buffer(void);
> +#else
> +static inline void __kvm_check_ubsan_buffer(void) {}
> +#endif /* CONFIG_UBSAN */
nit: An empty line here would be nice.

>  #define kvm_call_hyp_nvhe(f, ...)						\
>  	({								\
>  		struct arm_smccc_res res;				\
> @@ -599,7 +605,7 @@ void kvm_arm_resume_guest(struct kvm *kvm);
>  		arm_smccc_1_1_hvc(KVM_HOST_SMCCC_FUNC(f),		\
>  				  ##__VA_ARGS__, &res);			\
>  		WARN_ON(res.a0 != SMCCC_RET_SUCCESS);			\
> -									\
> +		__kvm_check_ubsan_buffer();				\
>  		res.a1;							\
>  	})
>  
> diff --git a/arch/arm64/include/asm/kvm_ubsan.h b/arch/arm64/include/asm/kvm_ubsan.h
> new file mode 100644
> index 000000000000..fb32c7fd65d4
> --- /dev/null
> +++ b/arch/arm64/include/asm/kvm_ubsan.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright 2020 Google LLC
> + * Author: George Popescu <georgepope@google.com>
> + */
> +
> +#include <ubsan.h>
> +
> +#define UBSAN_MAX_TYPE 6
nit: How about you make this the last entry in the `type` enum in
`kvm_ubsan_info`.

> +#define KVM_UBSAN_BUFFER_SIZE 1000
> +
> +struct kvm_ubsan_info {
> +	int type;
> +};
> diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> index 13b017284bf9..ab3a9c402550 100644
> --- a/arch/arm64/kvm/Makefile
> +++ b/arch/arm64/kvm/Makefile
> @@ -4,6 +4,7 @@
>  #
>  
>  ccflags-y += -I $(srctree)/$(src)
> +CFLAGS_kvm_ubsan_buffer.o += -I $(srctree)/lib/
>  
>  KVM=../../../virt/kvm
>  
> @@ -25,3 +26,4 @@ kvm-y := $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o \
>  	 vgic/vgic-its.o vgic/vgic-debug.o
>  
>  kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o
> +kvm-$(CONFIG_UBSAN) += kvm_ubsan_buffer.o
nit: Can we just name this kvm_ubsan.c?

> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 04c44853b103..63f0495550b8 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1784,6 +1784,15 @@ static int init_hyp_mode(void)
>  			goto out_err;
>  		}
>  	}
> +#ifdef CONFIG_UBSAN
> +	/* required by ubsan to access the handlers structures fields */
nit: capital R, grammar "handlers structures fields"

> +	err = create_hyp_mappings(kvm_ksym_ref(_data),
> +				  kvm_ksym_ref(__end_once), PAGE_HYP_RO);
> +	if (err) {
> +		kvm_err("Cannot map data section\n");
> +		goto out_err;
> +	}
> +#endif

The hypervisor currently doesn't use the .data section, so this approach works
fine at the moment. But this will stop working as soon as somebody starts using
.data for other purposes. It would be nice to do this properly now rather than
fix it later as part of some unrelated series. What you'd need to do:

  * add .data to arch/arm64/kvm/hyp/nvhe/hyp.lds.S; that will rename
    hypervisor's .data to .hyp.data
  * add .hyp.data to arch/arm64/kernel/vmlinux.lds.S
  * add new entries to arch/arm64/include/asm/sections.h
  * map .hyp.data here

Related, this currently relies on the fact that all pointers in .data are the
kernel VAs. That means later in this series it is safe to just copy the event
description to the buffer without any conversion. my series "Relocate absolute
hyp VAs" will convert all pointers in .hyp.* sections to the hypervisor VAs.
So once we do introduce .hyp.data, the hypervisor's ubsan.c will also have to
convert all pointers.

>  
>  	/*
>  	 * Map Hyp percpu pages
> diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
> index a820dfdc9c25..0967906265d3 100644
> --- a/arch/arm64/kvm/hyp/nvhe/host.S
> +++ b/arch/arm64/kvm/hyp/nvhe/host.S
> @@ -8,6 +8,7 @@
>  
>  #include <asm/assembler.h>
>  #include <asm/kvm_asm.h>
> +#include <asm/kvm_debug_buffer.h>
>  #include <asm/kvm_mmu.h>
>  
>  	.text
> @@ -34,6 +35,9 @@ SYM_FUNC_START(__host_exit)
>  	/* Store the host regs x18-x29, lr */
>  	save_callee_saved_regs x0
>  
> +	/* when entering the host clear the buffers */
nit: capital W

> +   	clear_buffer    x4, x5, x6  
> +
>  	/* Save the host context pointer in x29 across the function call */
>  	mov	x29, x0
>  	bl	handle_trap
> diff --git a/arch/arm64/kvm/hyp/nvhe/ubsan.c b/arch/arm64/kvm/hyp/nvhe/ubsan.c
> index a5db6b61ceb2..8a194fb1f6cf 100644
> --- a/arch/arm64/kvm/hyp/nvhe/ubsan.c
> +++ b/arch/arm64/kvm/hyp/nvhe/ubsan.c
> @@ -3,10 +3,33 @@
>   * Copyright 2020 Google LLC
>   * Author: George Popescu <georgepope@google.com>
>   */
> +#include <linux/bitops.h>
>  #include <linux/ctype.h>
>  #include <linux/types.h>
> +#include <linux/percpu-defs.h>
> +#include <linux/kvm_host.h>
> +#include <asm/kvm_arm.h>
> +#include <asm/kvm_asm.h>
> +#include <asm/kvm_ubsan.h>
> +#include <asm/kvm_debug_buffer.h>
> +#include <kvm/arm_pmu.h>
>  #include <ubsan.h>
>  
> +DEFINE_KVM_DEBUG_BUFFER(struct kvm_ubsan_info, kvm_ubsan_buffer,
> +                kvm_ubsan_buff_wr_ind, KVM_UBSAN_BUFFER_SIZE);
> +
> +static inline struct kvm_ubsan_info *kvm_ubsan_buffer_next_slot(void)
> +{
> +	struct kvm_ubsan_info *res = NULL;
> +	unsigned long write_ind = __this_cpu_read(kvm_ubsan_buff_wr_ind);
nit: checkpatch will want an empty line between declarations and code

> +	if (write_ind < KVM_UBSAN_BUFFER_SIZE) {
> +		res = this_cpu_ptr(&kvm_ubsan_buffer[write_ind]);
> +		++write_ind;
> +		__this_cpu_write(kvm_ubsan_buff_wr_ind, write_ind);
nit: Could save a line by just writing write_ind+1

> +	}
> +	return res;
> +}
> +
>  void __ubsan_handle_add_overflow(void *_data, void *lhs, void *rhs) {}
>  
>  void __ubsan_handle_sub_overflow(void *_data, void *lhs, void *rhs) {}
> diff --git a/arch/arm64/kvm/kvm_ubsan_buffer.c b/arch/arm64/kvm/kvm_ubsan_buffer.c
> new file mode 100644
> index 000000000000..4a1959ba9f68
> --- /dev/null
> +++ b/arch/arm64/kvm/kvm_ubsan_buffer.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2020 Google LLC
> + * Author: George Popescu <georgepope@google.com>
> + */
> +
> +#include <linux/ctype.h>
> +#include <linux/types.h>
> +#include <asm/kvm_debug_buffer.h>
> +#include <asm/kvm_arm.h>
> +#include <asm/kvm_asm.h>
> +#include <kvm/arm_pmu.h>
> +
> +#include <ubsan.h>
> +#include <asm/kvm_ubsan.h>
> +
> +DECLARE_KVM_DEBUG_BUFFER(struct kvm_ubsan_info, kvm_ubsan_buffer,
> +		kvm_ubsan_buff_wr_ind, KVM_UBSAN_BUFFER_SIZE);
> +
> +
> +void iterate_kvm_ubsan_buffer(unsigned long left, unsigned long right)
> +{
> +	unsigned long i;
> +	struct kvm_ubsan_info *slot;
> +
> +	slot = (struct kvm_ubsan_info *) this_cpu_ptr_nvhe_sym(kvm_ubsan_buffer);
nit: no whitespace after bracket?

> +	for (i = left; i < right; ++i) {
> +		/* check ubsan data */
> +		slot[i].type = 0;
> +	}
> +}
> +
> +void __kvm_check_ubsan_buffer(void)
> +{
> +	unsigned long *write_ind;
> +
> +	write_ind = (unsigned long *) this_cpu_ptr_nvhe_sym(kvm_ubsan_buff_wr_ind);
> +	iterate_kvm_ubsan_buffer(0, *write_ind);

I think this is another remnant of George's previous implementation. The first
argument will always be zero, so I don't see the point in splitting this into
two functions any more.

> +}
> +
> -- 
> 2.30.0.296.g2bfb1c46d8-goog
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
