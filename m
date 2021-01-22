Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C27A300C9A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 20:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbhAVT0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 14:26:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:39002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729531AbhAVSm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 13:42:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BBCB82376F;
        Fri, 22 Jan 2021 18:41:42 +0000 (UTC)
Date:   Fri, 22 Jan 2021 18:41:40 +0000
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
Subject: Re: [PATCH v4 09/21] arm64: cpufeature: Add global feature override
 facility
Message-ID: <20210122184139.GG8567@gaia>
References: <20210118094533.2874082-1-maz@kernel.org>
 <20210118094533.2874082-10-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118094533.2874082-10-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 09:45:21AM +0000, Marc Zyngier wrote:
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 9a555809b89c..465d2cb63bfc 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -75,6 +75,8 @@ struct arm64_ftr_reg {
>  	u64				sys_val;
>  	u64				user_val;
>  	const struct arm64_ftr_bits	*ftr_bits;
> +	u64				*override_val;
> +	u64				*override_mask;
>  };
>  
>  extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index e99eddec0a46..aaa075c6f029 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -544,13 +544,17 @@ static const struct arm64_ftr_bits ftr_raz[] = {
>  	ARM64_FTR_END,
>  };
>  
> -#define ARM64_FTR_REG(id, table) {		\
> -	.sys_id = id,				\
> -	.reg = 	&(struct arm64_ftr_reg){	\
> -		.name = #id,			\
> -		.ftr_bits = &((table)[0]),	\
> +#define ARM64_FTR_REG_OVERRIDE(id, table, v, m) {		\
> +		.sys_id = id,					\
> +		.reg = 	&(struct arm64_ftr_reg){		\
> +			.name = #id,				\
> +			.ftr_bits = &((table)[0]),		\
> +			.override_val = v,			\
> +			.override_mask = m,			\
>  	}}
>  
> +#define ARM64_FTR_REG(id, table) ARM64_FTR_REG_OVERRIDE(id, table, NULL, NULL)
> +
>  static const struct __ftr_reg_entry {
>  	u32			sys_id;
>  	struct arm64_ftr_reg 	*reg;
> @@ -760,6 +764,7 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
>  	u64 strict_mask = ~0x0ULL;
>  	u64 user_mask = 0;
>  	u64 valid_mask = 0;
> +	u64 override_val = 0, override_mask = 0;
>  
>  	const struct arm64_ftr_bits *ftrp;
>  	struct arm64_ftr_reg *reg = get_arm64_ftr_reg(sys_reg);
> @@ -767,9 +772,38 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
>  	if (!reg)
>  		return;
>  
> +	if (reg->override_mask && reg->override_val) {
> +		override_mask = *reg->override_mask;
> +		override_val = *reg->override_val;
> +	}
> +
>  	for (ftrp = reg->ftr_bits; ftrp->width; ftrp++) {
>  		u64 ftr_mask = arm64_ftr_mask(ftrp);
>  		s64 ftr_new = arm64_ftr_value(ftrp, new);
> +		s64 ftr_ovr = arm64_ftr_value(ftrp, override_val);
> +
> +		if ((ftr_mask & override_mask) == ftr_mask) {
> +			s64 tmp = arm64_ftr_safe_value(ftrp, ftr_ovr, ftr_new);
> +			char *str = NULL;
> +
> +			if (ftr_ovr != tmp) {
> +				/* Unsafe, remove the override */
> +				*reg->override_mask &= ~ftr_mask;
> +				*reg->override_val &= ~ftr_mask;

Do we need such clearing here? I don't think that's ever called again
for this feature/reg.

> +				tmp = ftr_ovr;
> +				str = "ignoring override";
> +			} else if (ftr_new != tmp) {
> +				/* Override was valid */
> +				ftr_new = tmp;
> +				str = "forced";
> +			}
> +
> +			if (str)
> +				pr_warn("%s[%d:%d]: %s to %llx\n",
> +					reg->name,
> +					ftrp->shift + ftrp->width - 1,
> +					ftrp->shift, str, tmp);
> +		}
>  
>  		val = arm64_ftr_set_value(ftrp, val, ftr_new);

I wonder whether we could call, after init_cpu_ftr_reg(), a new function
similar to update_cpu_ftr_reg() that takes a mask and value and leave
init_cpu_ftr_reg() unchanged. The only advantage would be if we can get
rid of the reg->override* fields. Anyway, I need to read the rest of the
series to see whether it's possible. Otherwise this patch looks fine.

-- 
Catalin
