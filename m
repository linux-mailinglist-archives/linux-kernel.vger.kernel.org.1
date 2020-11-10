Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646E22ADA59
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbgKJPY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:24:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:32848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732232AbgKJPYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:24:55 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABD57207D3;
        Tue, 10 Nov 2020 15:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605021894;
        bh=6grBIe9Ab1qZ3+EKmKO+hoC/BEgkpYoULIb3EV2t5yo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xfNstsPMqn3ECov8nxjyJrLJ1+DSpZyC0Ss8RG/e28rt4BLSM8F0v7CrR9L+ZA0/S
         RSUEjAK3adrJk6vUBiDTu6vDp24Jz1wWPISq73w6uzLvPeMvrBW1AaQTEgfm7tBt24
         dVU5iImG7WCRm7bkND2kFaKfCAF6YXP3QSVDTu2w=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kcVVs-009UKZ-Jg; Tue, 10 Nov 2020 15:24:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Nov 2020 15:24:52 +0000
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
Subject: Re: [PATCH v1 07/24] kvm: arm64: Create nVHE copy of cpu_logical_map
In-Reply-To: <20201109113233.9012-8-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
 <20201109113233.9012-8-dbrazdil@google.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <d473fd26e5314f2407b70242488f33de@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, dennis@kernel.org, tj@kernel.org, cl@linux.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, qperret@google.com, ascull@google.com, qwandor@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-09 11:32, David Brazdil wrote:
> When KVM starts validating host's PSCI requests, it will need to map
> MPIDR back to the CPU ID. To this end, copy cpu_logical_map into nVHE
> hyp memory when KVM is initialized.
> 
> Only copy the information for CPUs that are online at the point of KVM
> initialization so that KVM rejects CPUs whose features were not checked
> against the finalized capabilities.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/kvm/arm.c             | 17 +++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/percpu.c | 16 ++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 9ba9db2aa7f8..b85b4294b72d 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1481,6 +1481,21 @@ static inline void hyp_cpu_pm_exit(void)
>  }
>  #endif
> 
> +static void init_cpu_logical_map(void)
> +{
> +	extern u64 kvm_nvhe_sym(__cpu_logical_map)[NR_CPUS];
> +	int cpu;
> +
> +	/*
> +	 * Copy the MPIDR <-> logical CPU ID mapping to hyp.
> +	 * Only copy the set of online CPUs whose features have been chacked
> +	 * against the finalized system capabilities. The hypervisor will not
> +	 * allow any other CPUs from the `possible` set to boot.
> +	 */
> +	for_each_online_cpu(cpu)
> +		CHOOSE_NVHE_SYM(__cpu_logical_map)[cpu] = cpu_logical_map(cpu);
> +}
> +
>  static int init_common_resources(void)
>  {
>  	return kvm_set_ipa_limit();
> @@ -1659,6 +1674,8 @@ static int init_hyp_mode(void)
>  		}
>  	}
> 
> +	init_cpu_logical_map();
> +
>  	return 0;
> 
>  out_err:
> diff --git a/arch/arm64/kvm/hyp/nvhe/percpu.c 
> b/arch/arm64/kvm/hyp/nvhe/percpu.c
> index 5fd0c5696907..d0b9dbc2df45 100644
> --- a/arch/arm64/kvm/hyp/nvhe/percpu.c
> +++ b/arch/arm64/kvm/hyp/nvhe/percpu.c
> @@ -8,6 +8,22 @@
>  #include <asm/kvm_hyp.h>
>  #include <asm/kvm_mmu.h>
> 
> +/*
> + * nVHE copy of data structures tracking available CPU cores.
> + * Only entries for CPUs that were online at KVM init are populated.
> + * Other CPUs should not be allowed to boot because their features 
> were
> + * not checked against the finalized system capabilities.
> + */
> +u64 __ro_after_init __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1]
> = INVALID_HWID };

I'm not sure what __ro_after_init means once we get S2 isolation.

> +
> +u64 cpu_logical_map(int cpu)

nit: is there any reason why "cpu" cannot be unsigned? The thought
of a negative CPU number makes me shiver...

> +{
> +	if (cpu < 0 || cpu >= ARRAY_SIZE(__cpu_logical_map))
> +		hyp_panic();
> +
> +	return __cpu_logical_map[cpu];
> +}
> +
>  unsigned long __hyp_per_cpu_offset(unsigned int cpu)
>  {
>  	unsigned long *cpu_base_array;

Overall, this patch would make more sense closer it its use case
(in patch 19). I also don't understand why this lives in percpu.c...

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
