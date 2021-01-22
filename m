Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7BC300C97
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 20:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbhAVT0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 14:26:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730408AbhAVSyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 13:54:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B8F623AC1;
        Fri, 22 Jan 2021 18:53:47 +0000 (UTC)
Date:   Fri, 22 Jan 2021 18:53:45 +0000
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
Subject: Re: [PATCH v4 10/21] arm64: cpufeature: Use IDreg override in
 __read_sysreg_by_encoding()
Message-ID: <20210122185344.GH8567@gaia>
References: <20210118094533.2874082-1-maz@kernel.org>
 <20210118094533.2874082-11-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118094533.2874082-11-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 09:45:22AM +0000, Marc Zyngier wrote:
> __read_sysreg_by_encoding() is used by a bunch of cpufeature helpers,
> which should take the feature override into account. Let's do that.
> 
> For a good measure (and because we are likely to need to further
> down the line), make this helper available to the rest of the
> non-modular kernel.
> 
> Code that needs to know the *real* features of a CPU can still
> use read_sysreg_s(), and find the bare, ugly truth.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/cpufeature.h |  1 +
>  arch/arm64/kernel/cpufeature.c      | 15 +++++++++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 465d2cb63bfc..fe0130d6c0ff 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -602,6 +602,7 @@ void __init setup_cpu_features(void);
>  void check_local_cpu_capabilities(void);
>  
>  u64 read_sanitised_ftr_reg(u32 id);
> +u64 __read_sysreg_by_encoding(u32 sys_id);
>  
>  static inline bool cpu_supports_mixed_endian_el0(void)
>  {
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index aaa075c6f029..48a011935d8c 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1149,14 +1149,17 @@ u64 read_sanitised_ftr_reg(u32 id)
>  EXPORT_SYMBOL_GPL(read_sanitised_ftr_reg);
>  
>  #define read_sysreg_case(r)	\
> -	case r:		return read_sysreg_s(r)
> +	case r:		val = read_sysreg_s(r); break;
>  
>  /*
>   * __read_sysreg_by_encoding() - Used by a STARTING cpu before cpuinfo is populated.
>   * Read the system register on the current CPU
>   */
> -static u64 __read_sysreg_by_encoding(u32 sys_id)
> +u64 __read_sysreg_by_encoding(u32 sys_id)
>  {
> +	struct arm64_ftr_reg *regp;
> +	u64 val;
> +
>  	switch (sys_id) {
>  	read_sysreg_case(SYS_ID_PFR0_EL1);
>  	read_sysreg_case(SYS_ID_PFR1_EL1);
> @@ -1199,6 +1202,14 @@ static u64 __read_sysreg_by_encoding(u32 sys_id)
>  		BUG();
>  		return 0;
>  	}
> +
> +	regp  = get_arm64_ftr_reg(sys_id);
> +	if (regp && regp->override_mask && regp->override_val) {
> +		val &= ~*regp->override_mask;
> +		val |= (*regp->override_val & *regp->override_mask);
> +	}
> +
> +	return val;

Ah, now the previous patch makes more sense. I don't particularly like
this but I can't tell how to work around it. I was hoping that the
overriding feature behaves more like a secondary CPU that limits all the
overridden features. However, this approach would fail for FTR_EXACT
cases (like PAC, though I wonder whether it fails already with your
previous patch since the boot CPU value won't match the override, hence
dropping to the safe one).

-- 
Catalin
