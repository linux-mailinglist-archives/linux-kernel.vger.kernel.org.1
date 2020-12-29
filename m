Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EE32E7292
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 18:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgL2RRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 12:17:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:45404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbgL2RRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 12:17:24 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC47A21D94;
        Tue, 29 Dec 2020 17:16:43 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kuIbx-004Ri2-Kb; Tue, 29 Dec 2020 17:16:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 29 Dec 2020 17:16:41 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] KVM: arm64: Allow PSCI SYSTEM_OFF/RESET to return
In-Reply-To: <20201229160059.64135-1-dbrazdil@google.com>
References: <20201229160059.64135-1-dbrazdil@google.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <229d84b8d7818a170adf489535ea2d43@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 2020-12-29 16:00, David Brazdil wrote:
> The KVM/arm64 PSCI relay assumes that SYSTEM_OFF and SYSTEM_RESET 
> should
> not return, as dictated by the PSCI spec. However, there is firmware 
> out
> there which breaks this assumption, leading to a hyp panic. Make KVM
> more robust to broken firmware by allowing these to return.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/psci-relay.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> index e3947846ffcb..8e7128cb7667 100644
> --- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> +++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> @@ -77,12 +77,6 @@ static unsigned long psci_forward(struct
> kvm_cpu_context *host_ctxt)
>  			 cpu_reg(host_ctxt, 2), cpu_reg(host_ctxt, 3));
>  }
> 
> -static __noreturn unsigned long psci_forward_noreturn(struct
> kvm_cpu_context *host_ctxt)
> -{
> -	psci_forward(host_ctxt);
> -	hyp_panic(); /* unreachable */
> -}
> -
>  static unsigned int find_cpu_id(u64 mpidr)
>  {
>  	unsigned int i;
> @@ -251,10 +245,13 @@ static unsigned long psci_0_2_handler(u64
> func_id, struct kvm_cpu_context *host_
>  	case PSCI_0_2_FN_MIGRATE_INFO_TYPE:
>  	case PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU:
>  		return psci_forward(host_ctxt);
> +	/*
> +	 * SYSTEM_OFF/RESET should not return according to the spec.
> +	 * Allow it so as to stay robust to broken firmware.
> +	 */
>  	case PSCI_0_2_FN_SYSTEM_OFF:
>  	case PSCI_0_2_FN_SYSTEM_RESET:
> -		psci_forward_noreturn(host_ctxt);
> -		unreachable();
> +		return psci_forward(host_ctxt);
>  	case PSCI_0_2_FN64_CPU_SUSPEND:
>  		return psci_cpu_suspend(func_id, host_ctxt);
>  	case PSCI_0_2_FN64_CPU_ON:

Thanks for having tracked this.

I wonder whether we should also taint the kernel in this case,
because this is completely unexpected, and a major spec violation.

Ideally, we'd be able to detect this case and prevent pKVM from
getting initialised at all, but I guess there is no way to detect
the sucker without ... calling SYSTEM_RESET?

         M.
-- 
Jazz is not dead. It just smells funny...
