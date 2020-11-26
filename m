Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6B22C5AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391668AbgKZRet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:34:49 -0500
Received: from foss.arm.com ([217.140.110.172]:41564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbgKZRet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:34:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D73D31B;
        Thu, 26 Nov 2020 09:34:48 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C9993F23F;
        Thu, 26 Nov 2020 09:34:46 -0800 (PST)
Date:   Thu, 26 Nov 2020 17:34:40 +0000
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
Subject: Re: [PATCH v3 02/23] psci: Accessor for configured PSCI function IDs
Message-ID: <20201126173440.GA21563@e121166-lin.cambridge.arm.com>
References: <20201126155421.14901-1-dbrazdil@google.com>
 <20201126155421.14901-3-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126155421.14901-3-dbrazdil@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 03:54:00PM +0000, David Brazdil wrote:
> Function IDs used by PSCI are configurable for v0.1 via DT/APCI. If the

Side note: in ACPI we don't support versions < 0.2, for commit log
accuracy.

Other than that I agree with Mark's change request.

Thanks,
Lorenzo

> host is using PSCI v0.1, KVM's host PSCI proxy needs to use the same IDs.
> Expose the array holding the information with a read-only accessor.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  drivers/firmware/psci/psci.c | 16 ++++++++--------
>  include/linux/psci.h         | 10 ++++++++++
>  2 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 213c68418a65..40609564595e 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -58,16 +58,16 @@ typedef unsigned long (psci_fn)(unsigned long, unsigned long,
>  				unsigned long, unsigned long);
>  static psci_fn *invoke_psci_fn;
>  
> -enum psci_function {
> -	PSCI_FN_CPU_SUSPEND,
> -	PSCI_FN_CPU_ON,
> -	PSCI_FN_CPU_OFF,
> -	PSCI_FN_MIGRATE,
> -	PSCI_FN_MAX,
> -};
> -
>  static u32 psci_function_id[PSCI_FN_MAX];
>  
> +u32 psci_get_function_id(enum psci_function fn)
> +{
> +	if (WARN_ON_ONCE(fn < 0 || fn >= PSCI_FN_MAX))
> +		return 0;
> +
> +	return psci_function_id[fn];
> +}
> +
>  #define PSCI_0_2_POWER_STATE_MASK		\
>  				(PSCI_0_2_POWER_STATE_ID_MASK | \
>  				PSCI_0_2_POWER_STATE_TYPE_MASK | \
> diff --git a/include/linux/psci.h b/include/linux/psci.h
> index 2a1bfb890e58..5b49a5c82d6f 100644
> --- a/include/linux/psci.h
> +++ b/include/linux/psci.h
> @@ -21,6 +21,16 @@ bool psci_power_state_is_valid(u32 state);
>  int psci_set_osi_mode(bool enable);
>  bool psci_has_osi_support(void);
>  
> +enum psci_function {
> +	PSCI_FN_CPU_SUSPEND,
> +	PSCI_FN_CPU_ON,
> +	PSCI_FN_CPU_OFF,
> +	PSCI_FN_MIGRATE,
> +	PSCI_FN_MAX,
> +};
> +
> +u32 psci_get_function_id(enum psci_function fn);
> +
>  struct psci_operations {
>  	u32 (*get_version)(void);
>  	int (*cpu_suspend)(u32 state, unsigned long entry_point);
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
