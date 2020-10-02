Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376352814FE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388103AbgJBOXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:23:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59535 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387688AbgJBOXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601648600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wQ+HSosg+XAzZv7hWPdlxsgYgk4XvIPV+Q8NIU1ufCo=;
        b=VScXDTODfioNCZpZFANKTNU9W+18Ynk4XP8e+LMd3xYjbDtsdjQpzWG1ss8UVPfD3nxWD0
        S5ao8d1w/rHwoMWu1qwANHlown7bhgpPczZI5UdvxKqKogW1ga3CeJPKiHLA/dWvXm9Cfl
        hDrheh3Hsfd0bJuXqO4AanH0e7eEXMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-arJUEmwxP1--hVhtIvVv-g-1; Fri, 02 Oct 2020 10:23:18 -0400
X-MC-Unique: arJUEmwxP1--hVhtIvVv-g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D43E1186DD2C;
        Fri,  2 Oct 2020 14:23:15 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.194.110])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DF482C31E;
        Fri,  2 Oct 2020 14:23:11 +0000 (UTC)
Date:   Fri, 2 Oct 2020 16:23:08 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Haibo Xu <Haibo.Xu@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        qemu-devel@nongnu.org, Dave Martin <Dave.Martin@arm.com>,
        Juan Quintela <quintela@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] arm64: kvm: Save/restore MTE registers
Message-ID: <20201002142308.xo4aaj33vpchpd3r@kamzik.brq.redhat.com>
References: <20200925093607.3051-1-steven.price@arm.com>
 <20200925093607.3051-2-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925093607.3051-2-steven.price@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 10:36:06AM +0100, Steven Price wrote:
> Define the new system registers that MTE introduces and context switch
> them. The MTE feature is still hidden from the ID register as it isn't
> supported in a VM yet.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/arm64/include/asm/kvm_host.h          |  4 ++++
>  arch/arm64/include/asm/sysreg.h            |  3 ++-
>  arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 14 ++++++++++++++
>  arch/arm64/kvm/sys_regs.c                  | 14 ++++++++++----
>  4 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index e52c927aade5..4f4360dd149e 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -126,6 +126,8 @@ enum vcpu_sysreg {
>  	SCTLR_EL1,	/* System Control Register */
>  	ACTLR_EL1,	/* Auxiliary Control Register */
>  	CPACR_EL1,	/* Coprocessor Access Control */
> +	RGSR_EL1,	/* Random Allocation Tag Seed Register */
> +	GCR_EL1,	/* Tag Control Register */
>  	ZCR_EL1,	/* SVE Control */
>  	TTBR0_EL1,	/* Translation Table Base Register 0 */
>  	TTBR1_EL1,	/* Translation Table Base Register 1 */
> @@ -142,6 +144,8 @@ enum vcpu_sysreg {
>  	TPIDR_EL1,	/* Thread ID, Privileged */
>  	AMAIR_EL1,	/* Aux Memory Attribute Indirection Register */
>  	CNTKCTL_EL1,	/* Timer Control Register (EL1) */
> +	TFSRE0_EL1,	/* Tag Fault Status Register (EL0) */
> +	TFSR_EL1,	/* Tag Fault Stauts Register (EL1) */
>  	PAR_EL1,	/* Physical Address Register */
>  	MDSCR_EL1,	/* Monitor Debug System Control Register */
>  	MDCCINT_EL1,	/* Monitor Debug Comms Channel Interrupt Enable Reg */
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 52eefe2f7d95..cd60677551b7 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -563,7 +563,8 @@
>  #define SCTLR_ELx_M	(BIT(0))
>  
>  #define SCTLR_ELx_FLAGS	(SCTLR_ELx_M  | SCTLR_ELx_A | SCTLR_ELx_C | \
> -			 SCTLR_ELx_SA | SCTLR_ELx_I | SCTLR_ELx_IESB)
> +			 SCTLR_ELx_SA | SCTLR_ELx_I | SCTLR_ELx_IESB | \
> +			 SCTLR_ELx_ITFSB)
>  
>  /* SCTLR_EL2 specific flags. */
>  #define SCTLR_EL2_RES1	((BIT(4))  | (BIT(5))  | (BIT(11)) | (BIT(16)) | \
> diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> index 7a986030145f..a124ffa49ba3 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> @@ -18,6 +18,11 @@
>  static inline void __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
>  {
>  	ctxt_sys_reg(ctxt, MDSCR_EL1)	= read_sysreg(mdscr_el1);
> +	if (system_supports_mte()) {
> +		ctxt_sys_reg(ctxt, RGSR_EL1)	= read_sysreg_s(SYS_RGSR_EL1);
> +		ctxt_sys_reg(ctxt, GCR_EL1)	= read_sysreg_s(SYS_GCR_EL1);
> +		ctxt_sys_reg(ctxt, TFSRE0_EL1)	= read_sysreg_s(SYS_TFSRE0_EL1);
> +	}
>  }
>  
>  static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
> @@ -45,6 +50,8 @@ static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
>  	ctxt_sys_reg(ctxt, CNTKCTL_EL1)	= read_sysreg_el1(SYS_CNTKCTL);
>  	ctxt_sys_reg(ctxt, PAR_EL1)	= read_sysreg(par_el1);
>  	ctxt_sys_reg(ctxt, TPIDR_EL1)	= read_sysreg(tpidr_el1);
> +	if (system_supports_mte())
> +		ctxt_sys_reg(ctxt, TFSR_EL1) = read_sysreg_el1(SYS_TFSR);
>  
>  	ctxt_sys_reg(ctxt, SP_EL1)	= read_sysreg(sp_el1);
>  	ctxt_sys_reg(ctxt, ELR_EL1)	= read_sysreg_el1(SYS_ELR);
> @@ -63,6 +70,11 @@ static inline void __sysreg_save_el2_return_state(struct kvm_cpu_context *ctxt)
>  static inline void __sysreg_restore_common_state(struct kvm_cpu_context *ctxt)
>  {
>  	write_sysreg(ctxt_sys_reg(ctxt, MDSCR_EL1),  mdscr_el1);
> +	if (system_supports_mte()) {
> +		write_sysreg_s(ctxt_sys_reg(ctxt, RGSR_EL1), SYS_RGSR_EL1);
> +		write_sysreg_s(ctxt_sys_reg(ctxt, GCR_EL1), SYS_GCR_EL1);
> +		write_sysreg_s(ctxt_sys_reg(ctxt, TFSRE0_EL1), SYS_TFSRE0_EL1);
> +	}
>  }
>  
>  static inline void __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
> @@ -106,6 +118,8 @@ static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
>  	write_sysreg_el1(ctxt_sys_reg(ctxt, CNTKCTL_EL1), SYS_CNTKCTL);
>  	write_sysreg(ctxt_sys_reg(ctxt, PAR_EL1),	par_el1);
>  	write_sysreg(ctxt_sys_reg(ctxt, TPIDR_EL1),	tpidr_el1);
> +	if (system_supports_mte())
> +		write_sysreg_el1(ctxt_sys_reg(ctxt, TFSR_EL1), SYS_TFSR);
>  
>  	if (!has_vhe() &&
>  	    cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT) &&
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 379f4969d0bd..a655f172b5ad 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1391,6 +1391,12 @@ static bool access_mte_regs(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  	return false;
>  }
>  
> +static unsigned int mte_visibility(const struct kvm_vcpu *vcpu,
> +				   const struct sys_reg_desc *rd)
> +{
> +	return REG_HIDDEN_USER | REG_HIDDEN_GUEST;
> +}
> +
>  /* sys_reg_desc initialiser for known cpufeature ID registers */
>  #define ID_SANITISED(name) {			\
>  	SYS_DESC(SYS_##name),			\
> @@ -1557,8 +1563,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  	{ SYS_DESC(SYS_ACTLR_EL1), access_actlr, reset_actlr, ACTLR_EL1 },
>  	{ SYS_DESC(SYS_CPACR_EL1), NULL, reset_val, CPACR_EL1, 0 },
>  
> -	{ SYS_DESC(SYS_RGSR_EL1), access_mte_regs },
> -	{ SYS_DESC(SYS_GCR_EL1), access_mte_regs },
> +	{ SYS_DESC(SYS_RGSR_EL1), access_mte_regs, reset_unknown, RGSR_EL1, .visibility = mte_visibility },
> +	{ SYS_DESC(SYS_GCR_EL1), access_mte_regs, reset_unknown, GCR_EL1, .visibility = mte_visibility },
>  
>  	{ SYS_DESC(SYS_ZCR_EL1), NULL, reset_val, ZCR_EL1, 0, .visibility = sve_visibility },
>  	{ SYS_DESC(SYS_TTBR0_EL1), access_vm_reg, reset_unknown, TTBR0_EL1 },
> @@ -1584,8 +1590,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  	{ SYS_DESC(SYS_ERXMISC0_EL1), trap_raz_wi },
>  	{ SYS_DESC(SYS_ERXMISC1_EL1), trap_raz_wi },
>  
> -	{ SYS_DESC(SYS_TFSR_EL1), access_mte_regs },
> -	{ SYS_DESC(SYS_TFSRE0_EL1), access_mte_regs },
> +	{ SYS_DESC(SYS_TFSR_EL1), access_mte_regs, reset_unknown, TFSR_EL1, .visibility = mte_visibility },
> +	{ SYS_DESC(SYS_TFSRE0_EL1), access_mte_regs, reset_unknown, TFSRE0_EL1, .visibility = mte_visibility },
>  
>  	{ SYS_DESC(SYS_FAR_EL1), access_vm_reg, reset_unknown, FAR_EL1 },
>  	{ SYS_DESC(SYS_PAR_EL1), NULL, reset_unknown, PAR_EL1 },
> -- 
> 2.20.1
> 
>

Reviewed-by: Andrew Jones <drjones@redhat.com>

