Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBC92CDBE9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501925AbgLCRIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:08:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:34932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbgLCRIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:08:35 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C993207AE;
        Thu,  3 Dec 2020 17:07:54 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kks5A-00FjC8-59; Thu, 03 Dec 2020 17:07:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 03 Dec 2020 17:07:52 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Steven Price <steven.price@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v6 1/2] arm64: kvm: Save/restore MTE registers
In-Reply-To: <20201127152113.13099-2-steven.price@arm.com>
References: <20201127152113.13099-1-steven.price@arm.com>
 <20201127152113.13099-2-steven.price@arm.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <946b1e7b06c4d286a78cf61408e0fc8d@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: steven.price@arm.com, catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dave.Martin@arm.com, mark.rutland@arm.com, tglx@linutronix.de, qemu-devel@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, richard.henderson@linaro.org, peter.maydell@linaro.org, Haibo.Xu@arm.com, drjones@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> diff --git a/arch/arm64/include/asm/sysreg.h 
> b/arch/arm64/include/asm/sysreg.h
> index e2ef4c2edf06..b6668ffa04d9 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -569,7 +569,8 @@
>  #define SCTLR_ELx_M	(BIT(0))
> 
>  #define SCTLR_ELx_FLAGS	(SCTLR_ELx_M  | SCTLR_ELx_A | SCTLR_ELx_C | \
> -			 SCTLR_ELx_SA | SCTLR_ELx_I | SCTLR_ELx_IESB)
> +			 SCTLR_ELx_SA | SCTLR_ELx_I | SCTLR_ELx_IESB | \
> +			 SCTLR_ELx_ITFSB)
> 
>  /* SCTLR_EL2 specific flags. */
>  #define SCTLR_EL2_RES1	((BIT(4))  | (BIT(5))  | (BIT(11)) | (BIT(16)) 
> | \
> diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> index cce43bfe158f..45255ba60152 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> @@ -18,6 +18,11 @@
>  static inline void __sysreg_save_common_state(struct kvm_cpu_context 
> *ctxt)
>  {
>  	ctxt_sys_reg(ctxt, MDSCR_EL1)	= read_sysreg(mdscr_el1);
> +	if (system_supports_mte()) {

Please move the per-VM predicate to this patch so that it can be used
not to save/restore the MTE registers if we don't need to.

> +		ctxt_sys_reg(ctxt, RGSR_EL1)	= read_sysreg_s(SYS_RGSR_EL1);
> +		ctxt_sys_reg(ctxt, GCR_EL1)	= read_sysreg_s(SYS_GCR_EL1);
> +		ctxt_sys_reg(ctxt, TFSRE0_EL1)	= read_sysreg_s(SYS_TFSRE0_EL1);
> +	}

Overall, I still don't understand how this is going to work once
we have MTE in the kernel. You mentioned having the ability to
create turn off the tag checks at times, but I don't see that
in this patch (and I'm not sure we want that either).

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
