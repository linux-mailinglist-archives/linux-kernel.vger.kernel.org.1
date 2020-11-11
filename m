Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF212AF05E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 13:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgKKMRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 07:17:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:56266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgKKMNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 07:13:00 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A78A8206C0;
        Wed, 11 Nov 2020 12:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605096778;
        bh=Y7WQDylQg7yYQhKNN1XmrJY4WMKGZ6qQ7NVfXf4EVuA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wuhm79VX8qG+ixjPdtrHi/Jgygupw2lRyMbvOQr2NjP3309XUJMhdqlwAkLjlh9MD
         GsdiZ0jR3BxLFZ5pdoINjJXptxUW8iaP/PyheIUfJoZRf5gkBbHOpIThFZee9jDJCh
         o2GhDV+D/FUcRtuRlueEcv9vSI+Qg9cl7O5liTuE=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kcozg-009kif-EZ; Wed, 11 Nov 2020 12:12:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 11 Nov 2020 12:12:56 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Quentin Perret <qperret@google.com>,
        Andrew Scull <ascull@google.com>,
        Andrew Walbran <qwandor@google.com>, kernel-team@android.com
Subject: Re: [PATCH v1 11/24] kvm: arm64: Add SMC handler in nVHE EL2
In-Reply-To: <20201109113233.9012-12-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
 <20201109113233.9012-12-dbrazdil@google.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <05aa7bb6f29dd3a560b3ea520e82b4bc@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, dennis@kernel.org, tj@kernel.org, cl@linux.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, qperret@google.com, ascull@google.com, qwandor@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-09 11:32, David Brazdil wrote:
> Add handler of host SMCs in KVM nVHE trap handler. Forward all SMCs to
> EL3 and propagate the result back to EL1. This is done in preparation
> for validating host SMCs in KVM nVHE protected mode.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/hyp-main.c | 35 ++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> index 19332c20fcde..8661bc7deaa9 100644
> --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> @@ -106,6 +106,38 @@ static void handle_host_hcall(struct
> kvm_cpu_context *host_ctxt)
>  	host_ctxt->regs.regs[1] = ret;
>  }
> 
> +static void skip_host_instruction(void)
> +{
> +	write_sysreg_el2(read_sysreg_el2(SYS_ELR) + 4, SYS_ELR);
> +}
> +
> +static void forward_host_smc(struct kvm_cpu_context *host_ctxt)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_smc(host_ctxt->regs.regs[0], host_ctxt->regs.regs[1],
> +			  host_ctxt->regs.regs[2], host_ctxt->regs.regs[3],
> +			  host_ctxt->regs.regs[4], host_ctxt->regs.regs[5],
> +			  host_ctxt->regs.regs[6], host_ctxt->regs.regs[7],
> +			  &res);

How do you make sure that EL3 actually supports SMCCC 1.1? If that's not
the case, don't we risk additional registers being corrupted?

What of SMCCC 1.2 calls that extend arguments to up to x17?

> +	host_ctxt->regs.regs[0] = res.a0;
> +	host_ctxt->regs.regs[1] = res.a1;
> +	host_ctxt->regs.regs[2] = res.a2;
> +	host_ctxt->regs.regs[3] = res.a3;
> +}
> +
> +static void handle_host_smc(struct kvm_cpu_context *host_ctxt)
> +{
> +	/*
> +	 * Unlike HVC, the return address of an SMC is the instruction's PC.
> +	 * Move the return address past the instruction.
> +	 */
> +	skip_host_instruction();
> +
> +	/* Forward SMC not handled in EL2 to EL3. */
> +	forward_host_smc(host_ctxt);

nit: In general, we update the PC *after* emulating the instruction that
trapped. Not a big deal, but it makes it easier to reason across the
code base.

> +}
> +
>  void handle_trap(struct kvm_cpu_context *host_ctxt)
>  {
>  	u64 esr = read_sysreg_el2(SYS_ESR);
> @@ -114,6 +146,9 @@ void handle_trap(struct kvm_cpu_context *host_ctxt)
>  	case ESR_ELx_EC_HVC64:
>  		handle_host_hcall(host_ctxt);
>  		break;
> +	case ESR_ELx_EC_SMC64:
> +		handle_host_smc(host_ctxt);
> +		break;
>  	default:
>  		hyp_panic();
>  	}

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
