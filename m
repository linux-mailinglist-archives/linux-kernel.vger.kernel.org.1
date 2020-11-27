Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1D92C62DE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 11:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgK0KOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 05:14:43 -0500
Received: from foss.arm.com ([217.140.110.172]:36952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgK0KOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 05:14:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D965E1516;
        Fri, 27 Nov 2020 02:14:41 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A809E3F71F;
        Fri, 27 Nov 2020 02:14:39 -0800 (PST)
Date:   Fri, 27 Nov 2020 10:14:33 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
        Sudeep Holla <sudeep.holla@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 16/23] kvm: arm64: Forward safe PSCI SMCs coming from
 host
Message-ID: <20201127101433.GA1061@e121166-lin.cambridge.arm.com>
References: <20201126155421.14901-1-dbrazdil@google.com>
 <20201126155421.14901-17-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126155421.14901-17-dbrazdil@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

What about SYSTEM_SUSPEND ?

Lorenzo

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
> +	else
> +		return PSCI_RET_NOT_SUPPORTED;
>  }
>  
>  static unsigned long psci_0_2_handler(u64 func_id, struct kvm_cpu_context *host_ctxt)
>  {
>  	switch (func_id) {
> +	case PSCI_0_2_FN_PSCI_VERSION:
> +	case PSCI_0_2_FN_CPU_OFF:
> +	case PSCI_0_2_FN64_AFFINITY_INFO:
> +	case PSCI_0_2_FN64_MIGRATE:
> +	case PSCI_0_2_FN_MIGRATE_INFO_TYPE:
> +	case PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU:
> +		return psci_forward(host_ctxt);
> +	case PSCI_0_2_FN_SYSTEM_OFF:
> +	case PSCI_0_2_FN_SYSTEM_RESET:
> +		psci_forward_noreturn(host_ctxt);
> +		unreachable();
>  	default:
>  		return PSCI_RET_NOT_SUPPORTED;
>  	}
> @@ -73,6 +110,10 @@ static unsigned long psci_0_2_handler(u64 func_id, struct kvm_cpu_context *host_
>  static unsigned long psci_1_0_handler(u64 func_id, struct kvm_cpu_context *host_ctxt)
>  {
>  	switch (func_id) {
> +	case PSCI_1_0_FN_PSCI_FEATURES:
> +	case PSCI_1_0_FN_SET_SUSPEND_MODE:
> +	case PSCI_1_1_FN64_SYSTEM_RESET2:
> +		return psci_forward(host_ctxt);
>  	default:
>  		return psci_0_2_handler(func_id, host_ctxt);
>  	}
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
