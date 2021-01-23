Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE073015A3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 15:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbhAWOFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 09:05:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbhAWOFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 09:05:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D92B222B51;
        Sat, 23 Jan 2021 14:04:33 +0000 (UTC)
Date:   Sat, 23 Jan 2021 14:04:31 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH v4 13/21] arm64: Allow ID_AA64MMFR1_EL1.VH to be
 overridden from the command line
Message-ID: <YAws76q0mEoB5NZh@Catalins-MacBook-Air.local>
References: <20210118094533.2874082-1-maz@kernel.org>
 <20210118094533.2874082-14-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118094533.2874082-14-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 09:45:25AM +0000, Marc Zyngier wrote:
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index fe0130d6c0ff..80a5f423444e 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -814,6 +814,9 @@ static inline unsigned int get_vmid_bits(u64 mmfr1)
>  	return 8;
>  }
>  
> +extern u64 id_aa64mmfr1_val;
> +extern u64 id_aa64mmfr1_mask;
> +
>  u32 get_kvm_ipa_limit(void);
>  void dump_cpu_features(void);
>  
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 48a011935d8c..5b9343d2e9f0 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -555,6 +555,9 @@ static const struct arm64_ftr_bits ftr_raz[] = {
>  
>  #define ARM64_FTR_REG(id, table) ARM64_FTR_REG_OVERRIDE(id, table, NULL, NULL)
>  
> +u64 id_aa64mmfr1_val;
> +u64 id_aa64mmfr1_mask;
> +
>  static const struct __ftr_reg_entry {
>  	u32			sys_id;
>  	struct arm64_ftr_reg 	*reg;
> @@ -602,7 +605,8 @@ static const struct __ftr_reg_entry {
>  
>  	/* Op1 = 0, CRn = 0, CRm = 7 */
>  	ARM64_FTR_REG(SYS_ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0),
> -	ARM64_FTR_REG(SYS_ID_AA64MMFR1_EL1, ftr_id_aa64mmfr1),
> +	ARM64_FTR_REG_OVERRIDE(SYS_ID_AA64MMFR1_EL1, ftr_id_aa64mmfr1,
> +			       &id_aa64mmfr1_val, &id_aa64mmfr1_mask),
>  	ARM64_FTR_REG(SYS_ID_AA64MMFR2_EL1, ftr_id_aa64mmfr2),
>  
>  	/* Op1 = 0, CRn = 1, CRm = 2 */
> diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
> index 392f93b67103..75d9845f489b 100644
> --- a/arch/arm64/kernel/idreg-override.c
> +++ b/arch/arm64/kernel/idreg-override.c
> @@ -10,6 +10,7 @@
>  #include <linux/libfdt.h>
>  
>  #include <asm/cacheflush.h>
> +#include <asm/cpufeature.h>
>  #include <asm/setup.h>
>  
>  struct reg_desc {
> @@ -22,7 +23,18 @@ struct reg_desc {
>  	} 			fields[];
>  };
>  
> +static const struct reg_desc mmfr1 __initdata = {
> +	.name		= "id_aa64mmfr1",
> +	.val		= &id_aa64mmfr1_val,
> +	.mask		= &id_aa64mmfr1_mask,
> +	.fields		= {
> +	        { "vh", ID_AA64MMFR1_VHE_SHIFT },
> +		{}
> +	},
> +};
> +
>  static const struct reg_desc * const regs[] __initdata = {
> +	&mmfr1,
>  };

I'm ok in principle with how all these link together. I wonder however
if we could skip the separate u64 variables and just have a struct
reg_override with val and mask u64 rather than pointers. The
ARM64_FTR_REG_OVERRIDE macro takes a pointer to this new struct
reg_override and can access val/mask directly. Some 'const' may need to
be dropped.

-- 
Catalin
