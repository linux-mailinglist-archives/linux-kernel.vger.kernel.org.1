Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F7D2C03BA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 11:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgKWKz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 05:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgKWKz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:55:58 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF16C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 02:55:58 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id g19so15459074otp.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 02:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dAaII84HcEXvbNnxDSLxHAH0+A0aTsvl9gY1tLGjitA=;
        b=u9OdSH8/A0gwoY9Zp72hxARskG+k/xWPCFPPnekC1ftQBMBE3PMoJsjJCHyV+SqI/s
         JeOsSvWTrpdPFaEbCadkDjXXuHbKumLaCgmWJB/EDqL+kHQwmCDR/NfBpvmw8Iz0cq0s
         ZyL8RfhMY8yi/AOQokmbwGEoDgleZ+07GhQlQmFbesCSjbf+vFfz+xsngppSgufZ0Y9C
         bHvWyXrYir9R2F+HXr3ZhTAmvLwlbb4DJD0ynzhzO8A97UVzCZ1G4yoFX38Y8uXIhy6e
         w7bPzcZ40eHS6fAqnKXRL8HnuL2kc+VbjbVIUhDxbxALOu82FyP8TcoCLju3BIIUbSwq
         xyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dAaII84HcEXvbNnxDSLxHAH0+A0aTsvl9gY1tLGjitA=;
        b=FzyHRNEin15mwcWC0O/klM2OZn9R2ZlHNONjAy/1VrVJGxpB20U8mHnDDWt+xKGDdo
         ZY+CD1ZQNnnspz2o2FY6NCO3GxLu5dmRkdFXQZfHcA7dRegPe1DB8xElFqJXXJTqoRw0
         zbNm+txnXk7VAva1n2t1ThQbMmyLr4g1yz0/wU8vrslu38j/aSW2LtZ8ysL1D0dg7RvQ
         1hslPq6jjIkFg6N3XUGEoxSisVEcru/iSMAQKuzVOwusWmPo5xEhv8HXAXwWBtK4QHqF
         Y74K7jw2WTdxedaAFIraLTfmEdH/HMvWahT30uYEwRuD+6df9X6NkzpcSfPpLeqE3B7J
         415A==
X-Gm-Message-State: AOAM532SC+uz4WyPNBrvWk4VMReNLuVW6ItqCx2lwZBzqFU3uDUfv/Wc
        5z+RgrVXcpcRM6P9qFGiXi8YEiiS+VUegICvjaHpnQ==
X-Google-Smtp-Source: ABdhPJwRt9ZTExdG3bTGNmtLDlC7Bo8D2sx0n1oualDFMvNUtVyUQdSRJK5olUqVyqT+fdvVmIdmSzl4mhaczHMK7zo=
X-Received: by 2002:a05:6830:1e08:: with SMTP id s8mr1944890otr.144.1606128957173;
 Mon, 23 Nov 2020 02:55:57 -0800 (PST)
MIME-Version: 1.0
References: <20201117181607.1761516-1-qperret@google.com> <20201117181607.1761516-14-qperret@google.com>
In-Reply-To: <20201117181607.1761516-14-qperret@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 23 Nov 2020 10:55:20 +0000
Message-ID: <CA+EHjTwebfoJLpure-mHNzCnmLwnNEi6yh66OLFGrhH_+ysExA@mail.gmail.com>
Subject: Re: [RFC PATCH 13/27] KVM: arm64: Enable access to sanitized CPU
 features at EL2
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
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
        Android KVM <android-kvm@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Tue, Nov 17, 2020 at 6:16 PM 'Quentin Perret' via kernel-team
<kernel-team@android.com> wrote:
>
> Introduce the infrastructure in KVM enabling to copy CPU feature
> registers into EL2-owned data-structures, to allow reading sanitised
> values directly at EL2 in nVHE.
>
> Given that only a subset of these features are being read by the
> hypervisor, the ones that need to be copied are to be listed under
> <asm/kvm_cpufeature.h> together with the name of the nVHE variable that
> will hold the copy.
>
> While at it, introduce the first user of this infrastructure by
> implementing __flush_dcache_area at EL2, which needs
> arm64_ftr_reg_ctrel0.
>
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/cpufeature.h     |  1 +
>  arch/arm64/include/asm/kvm_cpufeature.h | 17 ++++++++++++++
>  arch/arm64/kernel/cpufeature.c          | 12 ++++++++++
>  arch/arm64/kernel/image-vars.h          |  2 ++
>  arch/arm64/kvm/arm.c                    | 31 +++++++++++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/Makefile        |  3 ++-
>  arch/arm64/kvm/hyp/nvhe/cache.S         | 13 +++++++++++
>  arch/arm64/kvm/hyp/nvhe/cpufeature.c    |  8 +++++++
>  8 files changed, 86 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/include/asm/kvm_cpufeature.h
>  create mode 100644 arch/arm64/kvm/hyp/nvhe/cache.S
>  create mode 100644 arch/arm64/kvm/hyp/nvhe/cpufeature.c
>
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index da250e4741bd..3dfbd76fb647 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -600,6 +600,7 @@ void __init setup_cpu_features(void);
>  void check_local_cpu_capabilities(void);
>
>  u64 read_sanitised_ftr_reg(u32 id);
> +int copy_ftr_reg(u32 id, struct arm64_ftr_reg *dst);
>
>  static inline bool cpu_supports_mixed_endian_el0(void)
>  {
> diff --git a/arch/arm64/include/asm/kvm_cpufeature.h b/arch/arm64/include/asm/kvm_cpufeature.h
> new file mode 100644
> index 000000000000..d34f85cba358
> --- /dev/null
> +++ b/arch/arm64/include/asm/kvm_cpufeature.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2020 - Google LLC
> + * Author: Quentin Perret <qperret@google.com>
> + */

Missing include guard.


> +
> +#include <asm/cpufeature.h>
> +
> +#ifndef KVM_HYP_CPU_FTR_REG
> +#if defined(__KVM_NVHE_HYPERVISOR__)
> +#define KVM_HYP_CPU_FTR_REG(id, name) extern struct arm64_ftr_reg name;
> +#else
> +#define KVM_HYP_CPU_FTR_REG(id, name) DECLARE_KVM_NVHE_SYM(name);
> +#endif
> +#endif
> +
> +KVM_HYP_CPU_FTR_REG(SYS_CTR_EL0, arm64_ftr_reg_ctrel0)
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index dd5bc0f0cf0d..3bc86d1423f8 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1116,6 +1116,18 @@ u64 read_sanitised_ftr_reg(u32 id)
>  }
>  EXPORT_SYMBOL_GPL(read_sanitised_ftr_reg);
>
> +int copy_ftr_reg(u32 id, struct arm64_ftr_reg *dst)
> +{
> +       struct arm64_ftr_reg *regp = get_arm64_ftr_reg(id);
> +
> +       if (!regp)
> +               return -EINVAL;
> +
> +       memcpy(dst, regp, sizeof(*regp));
> +
> +       return 0;
> +}
> +
>  #define read_sysreg_case(r)    \
>         case r:         return read_sysreg_s(r)
>
> diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
> index dd8ccc9efb6a..c35d768672eb 100644
> --- a/arch/arm64/kernel/image-vars.h
> +++ b/arch/arm64/kernel/image-vars.h
> @@ -116,6 +116,8 @@ __kvm_nvhe___memcpy                 = __kvm_nvhe___pi_memcpy;
>  __kvm_nvhe___memset                    = __kvm_nvhe___pi_memset;
>  #endif
>
> +_kvm_nvhe___flush_dcache_area          = __kvm_nvhe___pi___flush_dcache_area;
> +
>  #endif /* CONFIG_KVM */
>
>  #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 391cf6753a13..c7f8fca97202 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -34,6 +34,7 @@
>  #include <asm/virt.h>
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_asm.h>
> +#include <asm/kvm_cpufeature.h>
>  #include <asm/kvm_mmu.h>
>  #include <asm/kvm_emulate.h>
>  #include <asm/sections.h>
> @@ -1636,6 +1637,29 @@ static void teardown_hyp_mode(void)
>         }
>  }
>
> +#undef KVM_HYP_CPU_FTR_REG
> +#define KVM_HYP_CPU_FTR_REG(id, name) \
> +       { .sys_id = id, .dst = (struct arm64_ftr_reg *)&kvm_nvhe_sym(name) },
> +static const struct __ftr_reg_copy_entry {
> +       u32                     sys_id;
> +       struct arm64_ftr_reg    *dst;
> +} hyp_ftr_regs[] = {
> +       #include <asm/kvm_cpufeature.h>
> +};
> +
> +static int copy_cpu_ftr_regs(void)
> +{
> +       int i, ret;
> +
> +       for (i = 0; i < ARRAY_SIZE(hyp_ftr_regs); i++) {
> +               ret = copy_ftr_reg(hyp_ftr_regs[i].sys_id, hyp_ftr_regs[i].dst);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
>  /**
>   * Inits Hyp-mode on all online CPUs
>   */
> @@ -1644,6 +1668,13 @@ static int init_hyp_mode(void)
>         int cpu;
>         int err = 0;
>
> +       /*
> +        * Copy the required CPU feature register in their EL2 counterpart
> +        */
> +       err = copy_cpu_ftr_regs();
> +       if (err)
> +               return err;
> +
>         /*
>          * Allocate Hyp PGD and setup Hyp identity mapping
>          */
> diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
> index 9e5eacfec6ec..72cfe53f106f 100644
> --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> @@ -10,7 +10,8 @@ lib-objs := clear_page.o copy_page.o memcpy.o memset.o
>  lib-objs := $(addprefix ../../../lib/, $(lib-objs))
>
>  obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
> -        hyp-main.o hyp-smp.o psci-relay.o early_alloc.o stub.o page_alloc.o
> +        hyp-main.o hyp-smp.o psci-relay.o early_alloc.o stub.o page_alloc.o \
> +        cache.o cpufeature.o
>  obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
>          ../fpsimd.o ../hyp-entry.o ../exception.o
>  obj-y += $(lib-objs)
> diff --git a/arch/arm64/kvm/hyp/nvhe/cache.S b/arch/arm64/kvm/hyp/nvhe/cache.S
> new file mode 100644
> index 000000000000..36cef6915428
> --- /dev/null
> +++ b/arch/arm64/kvm/hyp/nvhe/cache.S
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Code copied from arch/arm64/mm/cache.S.
> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/assembler.h>
> +#include <asm/alternative.h>
> +
> +SYM_FUNC_START_PI(__flush_dcache_area)
> +       dcache_by_line_op civac, sy, x0, x1, x2, x3
> +       ret
> +SYM_FUNC_END_PI(__flush_dcache_area)
> diff --git a/arch/arm64/kvm/hyp/nvhe/cpufeature.c b/arch/arm64/kvm/hyp/nvhe/cpufeature.c
> new file mode 100644
> index 000000000000..a887508f996f
> --- /dev/null
> +++ b/arch/arm64/kvm/hyp/nvhe/cpufeature.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2020 - Google LLC
> + * Author: Quentin Perret <qperret@google.com>
> + */
> +
> +#define KVM_HYP_CPU_FTR_REG(id, name) struct arm64_ftr_reg name;
> +#include <asm/kvm_cpufeature.h>
> --
> 2.29.2.299.gdc1121823c-goog
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>

/fuad
