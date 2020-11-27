Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873702C6A35
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 17:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732187AbgK0QwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 11:52:06 -0500
Received: from foss.arm.com ([217.140.110.172]:46604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732138AbgK0QwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:52:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1848731B;
        Fri, 27 Nov 2020 08:52:05 -0800 (PST)
Received: from bogus (unknown [10.57.59.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EF3D3F71F;
        Fri, 27 Nov 2020 08:52:01 -0800 (PST)
Date:   Fri, 27 Nov 2020 16:51:59 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com
Subject: Re: [PATCH v3 16/23] kvm: arm64: Forward safe PSCI SMCs coming from
 host
Message-ID: <20201127165159.3s7hob5tgjcrbz33@bogus>
References: <20201126155421.14901-1-dbrazdil@google.com>
 <20201126155421.14901-17-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126155421.14901-17-dbrazdil@google.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 03:54:14PM +0000, David Brazdil wrote:
> Forward the following PSCI SMCs issued by host to EL3 as they do not
> require the hypervisor's intervention. This assumes that EL3 correctly
> implements the PSCI specification.
> 
> Only function IDs implemented in Linux are included.
> 
> Where both 32-bit and 64-bit variants exist, it is assumed that the host
> will always use the 64-bit variant.
> 
>  * SMCs that only return information about the system
>    * PSCI_VERSION        - PSCI version implemented by EL3
>    * PSCI_FEATURES       - optional features supported by EL3
>    * AFFINITY_INFO       - power state of core/cluster
>    * MIGRATE_INFO_TYPE   - whether Trusted OS can be migrated
>    * MIGRATE_INFO_UP_CPU - resident core of Trusted OS
>  * operations which do not affect the hypervisor
>    * MIGRATE             - migrate Trusted OS to a different core
>    * SET_SUSPEND_MODE    - toggle OS-initiated mode
>  * system shutdown/reset
>    * SYSTEM_OFF
>    * SYSTEM_RESET
>    * SYSTEM_RESET2
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/psci-relay.c | 43 +++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> index e7091d89f0fc..7aa87ab7f5ce 100644
> --- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> +++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> @@ -57,14 +57,51 @@ static bool is_psci_call(u64 func_id)
>  	}
>  }
>  
> +static unsigned long psci_call(unsigned long fn, unsigned long arg0,
> +			       unsigned long arg1, unsigned long arg2)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_smc(fn, arg0, arg1, arg2, &res);
> +	return res.a0;
> +}
> +
> +static unsigned long psci_forward(struct kvm_cpu_context *host_ctxt)
> +{
> +	return psci_call(cpu_reg(host_ctxt, 0), cpu_reg(host_ctxt, 1),
> +			 cpu_reg(host_ctxt, 2), cpu_reg(host_ctxt, 3));
> +}
> +
> +static __noreturn unsigned long psci_forward_noreturn(struct kvm_cpu_context *host_ctxt)
> +{
> +	psci_forward(host_ctxt);
> +	hyp_panic(); /* unreachable */
> +}
> +
>  static unsigned long psci_0_1_handler(u64 func_id, struct kvm_cpu_context *host_ctxt)
>  {
> -	return PSCI_RET_NOT_SUPPORTED;
> +	if (func_id == kvm_host_psci_function_id[PSCI_FN_CPU_OFF])
> +		return psci_forward(host_ctxt);
> +	else if (func_id == kvm_host_psci_function_id[PSCI_FN_MIGRATE])
> +		return psci_forward(host_ctxt);

Looks weird or I am not seeing something right ? Same action for both
right ? Can't they be combined ?

-- 
Regards,
Sudeep
