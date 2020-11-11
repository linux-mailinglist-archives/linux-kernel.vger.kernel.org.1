Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499452AF274
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgKKNsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:48:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbgKKNrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:47:31 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D74222072C;
        Wed, 11 Nov 2020 13:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605102451;
        bh=O75Cb/oSTOVEsh2cfT+C7Cb6UuFAt0jwxEEIDWUu0Yk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s6qdkedV3+4fsv9ewvPeAiOR1c16RxhYCj1bxqVcF8hYBi4cakLSoT6XUMMqSTaN4
         CXEY3k1jZuMLQuGBUBc+i5/+4MQxW2NWjIkXf7oYbmQMiG7ZoybazDCyw0dRCQBTjz
         bk5cbgxOFOFRrOJSG862TzA8ZbBF3FvDVdFJCC+4=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kcqTA-009mCw-Hm; Wed, 11 Nov 2020 13:47:28 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 11 Nov 2020 13:47:28 +0000
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
Subject: Re: [PATCH v1 16/24] kvm: arm64: Add offset for hyp VA <-> PA
 conversion
In-Reply-To: <20201109113233.9012-17-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
 <20201109113233.9012-17-dbrazdil@google.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <ded6b623ea8ddc43f7dcabd0ec59d4b5@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, dennis@kernel.org, tj@kernel.org, cl@linux.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, qperret@google.com, ascull@google.com, qwandor@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-09 11:32, David Brazdil wrote:
> Add a host-initialized constant to KVM nVHE hyp code for converting
> between EL2 linear map virtual addresses and physical addresses.
> Also add `__hyp_pa` macro that performs the conversion.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/kvm/arm.c           | 15 +++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/psci.c |  3 +++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 28e3bc056225..dc7d43d7785a 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1484,6 +1484,20 @@ static inline void hyp_cpu_pm_exit(void)
>  }
>  #endif
> 
> +static void init_hyp_physvirt_offset(void)
> +{
> +	extern s64 kvm_nvhe_sym(hyp_physvirt_offset);
> +	unsigned long kern_vaddr, hyp_vaddr, paddr;
> +
> +	/* Check that kvm_arm_hyp_percpu_base has been set. */
> +	BUG_ON(kvm_arm_hyp_percpu_base[0] == 0);

Why is this dependent on the percpu base? Or is that just a convenient
symbol?

> +
> +	kern_vaddr = kvm_arm_hyp_percpu_base[0];
> +	hyp_vaddr = kern_hyp_va(kern_vaddr);
> +	paddr = __pa(kern_vaddr);
> +	CHOOSE_NVHE_SYM(hyp_physvirt_offset) = (s64)paddr - (s64)hyp_vaddr;
> +}

It feels like this offset could be set at the point where we compute
the hyp_va offset in va_layout.c, couldn't it? It would have the
advantage of keeping all the ugly VA hacks together.

> +
>  static void init_cpu_logical_map(void)
>  {
>  	extern u64 kvm_nvhe_sym(__cpu_logical_map)[NR_CPUS];
> @@ -1688,6 +1702,7 @@ static int init_hyp_mode(void)
>  		}
>  	}
> 
> +	init_hyp_physvirt_offset();
>  	init_cpu_logical_map();
>  	init_psci();
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/psci.c 
> b/arch/arm64/kvm/hyp/nvhe/psci.c
> index 82d3b2c89658..b0b5df590ba5 100644
> --- a/arch/arm64/kvm/hyp/nvhe/psci.c
> +++ b/arch/arm64/kvm/hyp/nvhe/psci.c
> @@ -16,6 +16,9 @@
>  /* Config options set by the host. */
>  u32 kvm_host_psci_version = PSCI_VERSION(0, 0);
>  u32 kvm_host_psci_function_id[PSCI_FN_MAX];
> +s64 hyp_physvirt_offset;
> +
> +#define __hyp_pa(x) ((phys_addr_t)((x)) + hyp_physvirt_offset)
> 
>  static u64 get_psci_func_id(struct kvm_cpu_context *host_ctxt)
>  {

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
