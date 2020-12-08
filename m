Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6218B2D30FC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 18:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbgLHR1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 12:27:18 -0500
Received: from foss.arm.com ([217.140.110.172]:52226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729086AbgLHR1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 12:27:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 982841FB;
        Tue,  8 Dec 2020 09:26:31 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.29.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCD4F3F68F;
        Tue,  8 Dec 2020 09:26:29 -0800 (PST)
Date:   Tue, 8 Dec 2020 17:26:28 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     David Brazdil <dbrazdil@google.com>, kvmarm@lists.cs.columbia.edu,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/6] kvm: arm64: Prevent use of invalid PSCI v0.1
 function IDs
Message-ID: <20201208172628.GB18222@C02TD0UTHF1T.local>
References: <20201208142452.87237-1-dbrazdil@google.com>
 <20201208142452.87237-2-dbrazdil@google.com>
 <e3f93946d66c0312a9778e49f1d85abe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3f93946d66c0312a9778e49f1d85abe@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 03:56:39PM +0000, Marc Zyngier wrote:
> On 2020-12-08 14:24, David Brazdil wrote:
> > PSCI driver exposes a struct containing the PSCI v0.1 function IDs
> > configured in the DT. However, the struct does not convey the
> > information whether these were set from DT or contain the default value
> > zero. This could be a problem for PSCI proxy in KVM protected mode.
> > 
> > Extend config passed to KVM with a bit mask with individual bits set
> > depending on whether the corresponding function pointer in psci_ops is
> > set, eg. set bit for PSCI_CPU_SUSPEND if psci_ops.cpu_suspend != NULL.
> > 
> > Previously config was split into multiple global variables. Put
> > everything into a single struct for convenience.
> > 
> > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: David Brazdil <dbrazdil@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_host.h    | 20 +++++++++++
> >  arch/arm64/kvm/arm.c                 | 14 +++++---
> >  arch/arm64/kvm/hyp/nvhe/psci-relay.c | 53 +++++++++++++++++++++-------
> >  3 files changed, 70 insertions(+), 17 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_host.h
> > b/arch/arm64/include/asm/kvm_host.h
> > index 11beda85ee7e..828d50d40dc2 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -17,6 +17,7 @@
> >  #include <linux/jump_label.h>
> >  #include <linux/kvm_types.h>
> >  #include <linux/percpu.h>
> > +#include <linux/psci.h>
> >  #include <asm/arch_gicv3.h>
> >  #include <asm/barrier.h>
> >  #include <asm/cpufeature.h>
> > @@ -240,6 +241,25 @@ struct kvm_host_data {
> >  	struct kvm_pmu_events pmu_events;
> >  };
> > 
> > +#define KVM_HOST_PSCI_0_1_CPU_SUSPEND	BIT(0)
> > +#define KVM_HOST_PSCI_0_1_CPU_ON	BIT(1)
> > +#define KVM_HOST_PSCI_0_1_CPU_OFF	BIT(2)
> > +#define KVM_HOST_PSCI_0_1_MIGRATE	BIT(3)
> > +
> > +struct kvm_host_psci_config {
> > +	/* PSCI version used by host. */
> > +	u32 version;
> > +
> > +	/* Function IDs used by host if version is v0.1. */
> > +	struct psci_0_1_function_ids function_ids_0_1;
> > +
> > +	/* Bitmask of functions enabled for v0.1, bits KVM_HOST_PSCI_0_1_*. */
> > +	unsigned int enabled_functions_0_1;
> 
> Nit: the conventional type for bitmaps is 'unsigned long'.
> Also, "enabled" seems odd. Isn't it actually "available"?

Sure, that or "implemented" works here.

Since there are only 4 functions here, it might make sense to use
independent bools rather than a bitmap, which might make this a bit
simpler...

> > get_psci_0_1_function_ids();
> > +	kvm_host_psci_config.version = psci_ops.get_version();
> > +
> > +	if (kvm_host_psci_config.version == PSCI_VERSION(0, 1)) {
> > +		kvm_host_psci_config.function_ids_0_1 = get_psci_0_1_function_ids();
> > +		kvm_host_psci_config.enabled_functions_0_1 =
> > +			(psci_ops.cpu_suspend ? KVM_HOST_PSCI_0_1_CPU_SUSPEND : 0) |
> > +			(psci_ops.cpu_off ? KVM_HOST_PSCI_0_1_CPU_OFF : 0) |
> > +			(psci_ops.cpu_on ? KVM_HOST_PSCI_0_1_CPU_ON : 0) |
> > +			(psci_ops.migrate ? KVM_HOST_PSCI_0_1_MIGRATE : 0);

... since e.g. this could be roughly:

	kvm_host_psci_config.cpu_suspend_implemented = psci_ops.cpu_suspend;
	kvm_host_psci_config.cpu_off_implemented = psci_ops.cpu_off;
	kvm_host_psci_config.cpu_on_implemented = psci_ops.cpu_on;
	kvm_host_psci_config.migrate_implemented = psci_ops.migrate;

> > +static inline bool is_psci_0_1_cpu_suspend(u64 func_id)
> > +{
> > +	return is_psci_0_1_function_enabled(KVM_HOST_PSCI_0_1_CPU_SUSPEND) &&
> > +	       (func_id == kvm_host_psci_config.function_ids_0_1.cpu_suspend);
> > +}

...and similarly:

	return  kvm_host_psci_config.cpu_suspend_implemented &&
		func_id == kvm_host_psci_config.function_ids_0_1.cpu_suspend)

> Otherwise looks OK. Don't bother respinning the series for my
> comments, I can tidy things up as I apply it if there are no other
> issues.

FWIW, I'm happy with whatever choose to do here, so don't feel like you
have to follow my suggestions above.

Thanks,
Mark.
