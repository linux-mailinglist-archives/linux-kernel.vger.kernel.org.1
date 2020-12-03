Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0711A2CD735
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 14:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387961AbgLCNcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 08:32:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437065AbgLCNcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 08:32:03 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91734207EA;
        Thu,  3 Dec 2020 13:31:22 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kkohb-00FfbD-86; Thu, 03 Dec 2020 13:31:20 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 03 Dec 2020 13:31:18 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com
Subject: Re: [PATCH v4 15/26] kvm: arm64: Add SMC handler in nVHE EL2
In-Reply-To: <20201202184122.26046-16-dbrazdil@google.com>
References: <20201202184122.26046-1-dbrazdil@google.com>
 <20201202184122.26046-16-dbrazdil@google.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <6370e564fa4d82bf6a5fb3bb545e01a3@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, dennis@kernel.org, tj@kernel.org, cl@linux.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-02 18:41, David Brazdil wrote:
> Add handler of host SMCs in KVM nVHE trap handler. Forward all SMCs to
> EL3 and propagate the result back to EL1. This is done in preparation
> for validating host SMCs in KVM protected mode.
> 
> The implementation assumes that firmware uses SMCCC v1.2 or older. That
> means x0-x17 can be used both for arguments and results, other GPRs are
> preserved.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/host.S     | 38 ++++++++++++++++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c | 35 ++++++++++++++++++++++++---
>  2 files changed, 70 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/host.S 
> b/arch/arm64/kvm/hyp/nvhe/host.S
> index fe2740b224cf..2b56f0bdf874 100644
> --- a/arch/arm64/kvm/hyp/nvhe/host.S
> +++ b/arch/arm64/kvm/hyp/nvhe/host.S
> @@ -180,3 +180,41 @@ SYM_CODE_START(__kvm_hyp_host_vector)
>  	invalid_host_el1_vect			// FIQ 32-bit EL1
>  	invalid_host_el1_vect			// Error 32-bit EL1
>  SYM_CODE_END(__kvm_hyp_host_vector)
> +
> +/*
> + * Forward SMC with arguments in struct kvm_cpu_context, and
> + * store the result into the same struct. Assumes SMCCC 1.2 or older.
> + *
> + * x0: struct kvm_cpu_context*
> + */
> +SYM_CODE_START(__kvm_hyp_host_forward_smc)
> +	/*
> +	 * Use x18 to keep the pointer to the host context because
> +	 * x18 is callee-saved in SMCCC but not in AAPCS64.
> +	 */
> +	mov	x18, x0
> +
> +	ldp	x0, x1,   [x18, #CPU_XREG_OFFSET(0)]
> +	ldp	x2, x3,   [x18, #CPU_XREG_OFFSET(2)]
> +	ldp	x4, x5,   [x18, #CPU_XREG_OFFSET(4)]
> +	ldp	x6, x7,   [x18, #CPU_XREG_OFFSET(6)]
> +	ldp	x8, x9,   [x18, #CPU_XREG_OFFSET(8)]
> +	ldp	x10, x11, [x18, #CPU_XREG_OFFSET(10)]
> +	ldp	x12, x13, [x18, #CPU_XREG_OFFSET(12)]
> +	ldp	x14, x15, [x18, #CPU_XREG_OFFSET(14)]
> +	ldp	x16, x17, [x18, #CPU_XREG_OFFSET(16)]
> +
> +	smc	#0
> +
> +	stp	x0, x1,   [x18, #CPU_XREG_OFFSET(0)]
> +	stp	x2, x3,   [x18, #CPU_XREG_OFFSET(2)]
> +	stp	x4, x5,   [x18, #CPU_XREG_OFFSET(4)]
> +	stp	x6, x7,   [x18, #CPU_XREG_OFFSET(6)]
> +	stp	x8, x9,   [x18, #CPU_XREG_OFFSET(8)]
> +	stp	x10, x11, [x18, #CPU_XREG_OFFSET(10)]
> +	stp	x12, x13, [x18, #CPU_XREG_OFFSET(12)]
> +	stp	x14, x15, [x18, #CPU_XREG_OFFSET(14)]
> +	stp	x16, x17, [x18, #CPU_XREG_OFFSET(16)]
> +
> +	ret
> +SYM_CODE_END(__kvm_hyp_host_forward_smc)
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index a4f1cac714d7..f25680ede080 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -18,6 +18,8 @@
> 
>  DEFINE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
> 
> +void __kvm_hyp_host_forward_smc(struct kvm_cpu_context *host_ctxt);
> +
>  static void handle___kvm_vcpu_run(struct kvm_cpu_context *host_ctxt)
>  {
>  	DECLARE_REG(struct kvm_vcpu *, vcpu, host_ctxt, 1);
> @@ -152,12 +154,39 @@ static void handle_host_hcall(struct
> kvm_cpu_context *host_ctxt)
>  	cpu_reg(host_ctxt, 0) = SMCCC_RET_NOT_SUPPORTED;
>  }
> 
> +static void default_host_smc_handler(struct kvm_cpu_context 
> *host_ctxt)
> +{
> +	__kvm_hyp_host_forward_smc(host_ctxt);
> +}
> +
> +static void skip_host_instruction(void)
> +{
> +	write_sysreg_el2(read_sysreg_el2(SYS_ELR) + 4, SYS_ELR);
> +}

Just for the sake of keeping things together, it'd be good to
move this helper to include/hyp/adjust_pc.h. Nothing urgent though.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
