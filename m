Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819422A7D10
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgKELcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:32:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729748AbgKELar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:30:47 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C04C12083B;
        Thu,  5 Nov 2020 11:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604575846;
        bh=DHA+HMmRj/vljpoB6PI9AKkrWsALaL5kz7s/bPUod+g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rplNhh2/x15GoJw1yq2xcGLWRcSdakUzgWbwmTVznU3ZJVWM5SMdka+hUtwGF0iOi
         w/AJEBkHKi6Dmq8uyEc0YHX7ZRCaxvDE8mzfYwCtLPilLZf7UCyj30N2hy9H0oW9cV
         sVNJYhUUsD/oxcHj9ZgxnZc+rdEZHbB2longFGb0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kadTY-007oYq-7R; Thu, 05 Nov 2020 11:30:44 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Nov 2020 11:30:44 +0000
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
        Andrew Scull <ascull@google.com>, kernel-team@android.com
Subject: Re: [RFC PATCH 18/26] kvm: arm64: Intercept PSCI_CPU_OFF host SMC
 calls
In-Reply-To: <20201104183630.27513-19-dbrazdil@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
 <20201104183630.27513-19-dbrazdil@google.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <0ebade5427b2d9a020cd33da64cb9d13@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, dennis@kernel.org, tj@kernel.org, cl@linux.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, qperret@google.com, ascull@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-04 18:36, David Brazdil wrote:
> Add a handler of the CPU_OFF PSCI host SMC trapped in KVM nVHE hyp 
> code.
> When invoked, it changes the recorded state of the core to OFF before
> forwarding the call to EL3. If the call fails, it changes the state 
> back
> to ON and returns the error to the host.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/psci.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/psci.c 
> b/arch/arm64/kvm/hyp/nvhe/psci.c
> index c3d0a6246c66..00dc0cab860c 100644
> --- a/arch/arm64/kvm/hyp/nvhe/psci.c
> +++ b/arch/arm64/kvm/hyp/nvhe/psci.c
> @@ -13,6 +13,8 @@
>  #include <kvm/arm_psci.h>
>  #include <uapi/linux/psci.h>
> 
> +#include <nvhe/spinlock.h>
> +
>  /* Config options set by the host. */
>  u32 kvm_host_psci_version = PSCI_VERSION(0, 0);
>  u32 kvm_host_psci_function_id[PSCI_FN_MAX];
> @@ -20,6 +22,7 @@ s64 hyp_physvirt_offset;
> 
>  #define __hyp_pa(x) ((phys_addr_t)(x) + hyp_physvirt_offset)
> 
> +static DEFINE_PER_CPU(hyp_spinlock_t, psci_cpu_lock);
>  DEFINE_PER_CPU(enum kvm_nvhe_psci_state, psci_cpu_state);
> 
>  static u64 get_psci_func_id(struct kvm_cpu_context *host_ctxt)
> @@ -76,9 +79,32 @@ static __noreturn unsigned long
> psci_forward_noreturn(struct kvm_cpu_context *ho
>  	hyp_panic(); /* unreachable */
>  }
> 
> +static int psci_cpu_off(u64 func_id, struct kvm_cpu_context 
> *host_ctxt)
> +{
> +	hyp_spinlock_t *cpu_lock = this_cpu_ptr(&psci_cpu_lock);
> +	enum kvm_nvhe_psci_state *cpu_power = this_cpu_ptr(&psci_cpu_state);
> +	u32 power_state = (u32)host_ctxt->regs.regs[1];
> +	int ret;
> +
> +	/* Change the recorded state to OFF before forwarding the call. */
> +	hyp_spin_lock(cpu_lock);
> +	*cpu_power = KVM_NVHE_PSCI_CPU_OFF;
> +	hyp_spin_unlock(cpu_lock);

So at this point, another CPU can observe the vcpu being "off", and 
issue
a PSCI_ON, which may result in an "already on". I'm not sure this is an
actual issue, but it is worth documenting.

What is definitely missing is a rational about *why* we need to track 
the
state of the vcpus. I naively imagined that we could directly proxy the
PSCI calls to EL3, only repainting PC for PSCI_ON.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
