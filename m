Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F4E2F4A4F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbhAMLd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:33:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:47154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbhAMLd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:33:57 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA900233EF;
        Wed, 13 Jan 2021 11:33:15 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kzeOn-007Epc-Ma; Wed, 13 Jan 2021 11:33:13 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Jan 2021 11:33:13 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 13/26] KVM: arm64: Enable access to sanitized CPU
 features at EL2
In-Reply-To: <20210108121524.656872-14-qperret@google.com>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-14-qperret@google.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <d55643ea391f73a2297f499f3219ba8a@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: qperret@google.com, catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, robh+dt@kernel.org, frowand.list@gmail.com, devicetree@vger.kernel.org, android-kvm@google.com, linux-kernel@vger.kernel.org, kernel-team@android.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, tabba@google.com, mark.rutland@arm.com, dbrazdil@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On 2021-01-08 12:15, Quentin Perret wrote:
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
>  arch/arm64/kvm/arm.c                    | 31 +++++++++++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/Makefile        |  3 ++-
>  arch/arm64/kvm/hyp/nvhe/cache.S         | 13 +++++++++++
>  arch/arm64/kvm/hyp/nvhe/cpufeature.c    |  8 +++++++
>  7 files changed, 84 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/include/asm/kvm_cpufeature.h
>  create mode 100644 arch/arm64/kvm/hyp/nvhe/cache.S
>  create mode 100644 arch/arm64/kvm/hyp/nvhe/cpufeature.c
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h
> b/arch/arm64/include/asm/cpufeature.h
> index 16063c813dcd..742e9bcc051b 100644
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
> diff --git a/arch/arm64/include/asm/kvm_cpufeature.h
> b/arch/arm64/include/asm/kvm_cpufeature.h
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
> +
> +#include <asm/cpufeature.h>
> +
> +#ifndef KVM_HYP_CPU_FTR_REG
> +#if defined(__KVM_NVHE_HYPERVISOR__)
> +#define KVM_HYP_CPU_FTR_REG(id, name) extern struct arm64_ftr_reg 
> name;
> +#else
> +#define KVM_HYP_CPU_FTR_REG(id, name) DECLARE_KVM_NVHE_SYM(name);
> +#endif
> +#endif
> +
> +KVM_HYP_CPU_FTR_REG(SYS_CTR_EL0, arm64_ftr_reg_ctrel0)
> diff --git a/arch/arm64/kernel/cpufeature.c 
> b/arch/arm64/kernel/cpufeature.c
> index bc3549663957..c2019aaaadc3 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1113,6 +1113,18 @@ u64 read_sanitised_ftr_reg(u32 id)
>  }
>  EXPORT_SYMBOL_GPL(read_sanitised_ftr_reg);
> 
> +int copy_ftr_reg(u32 id, struct arm64_ftr_reg *dst)
> +{
> +	struct arm64_ftr_reg *regp = get_arm64_ftr_reg(id);
> +
> +	if (!regp)
> +		return -EINVAL;
> +
> +	memcpy(dst, regp, sizeof(*regp));
> +
> +	return 0;
> +}
> +
>  #define read_sysreg_case(r)	\
>  	case r:		return read_sysreg_s(r)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 51b53ca36dc5..9fd769349e9e 100644
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
> @@ -1697,6 +1698,29 @@ static void teardown_hyp_mode(void)
>  	}
>  }
> 
> +#undef KVM_HYP_CPU_FTR_REG
> +#define KVM_HYP_CPU_FTR_REG(id, name) \
> +	{ .sys_id = id, .dst = (struct arm64_ftr_reg *)&kvm_nvhe_sym(name) },
> +static const struct __ftr_reg_copy_entry {
> +	u32			sys_id;
> +	struct arm64_ftr_reg	*dst;

Why do we need the whole data structure? Can't we just live with 
sys_val?

> +} hyp_ftr_regs[] = {
> +	#include <asm/kvm_cpufeature.h>
> +};

Can't this be made __initdata?

> +
> +static int copy_cpu_ftr_regs(void)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(hyp_ftr_regs); i++) {
> +		ret = copy_ftr_reg(hyp_ftr_regs[i].sys_id, hyp_ftr_regs[i].dst);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * Inits Hyp-mode on all online CPUs
>   */
> @@ -1705,6 +1729,13 @@ static int init_hyp_mode(void)
>  	int cpu;
>  	int err = 0;
> 
> +	/*
> +	 * Copy the required CPU feature register in their EL2 counterpart
> +	 */
> +	err = copy_cpu_ftr_regs();
> +	if (err)
> +		return err;
> +

Just to keep things together, please move any sysreg manipulation into
sys_regs.c, most probably into kvm_sys_reg_table_init().

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
