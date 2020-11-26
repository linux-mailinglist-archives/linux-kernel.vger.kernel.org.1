Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3012C5B89
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 19:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404765AbgKZSGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 13:06:16 -0500
Received: from foss.arm.com ([217.140.110.172]:42526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404339AbgKZSGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 13:06:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C69831B;
        Thu, 26 Nov 2020 10:06:15 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.30.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F2F63F23F;
        Thu, 26 Nov 2020 10:06:11 -0800 (PST)
Date:   Thu, 26 Nov 2020 18:06:08 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 05/23] arm64: Extract parts of el2_setup into a macro
Message-ID: <20201126180608.GF38486@C02TD0UTHF1T.local>
References: <20201126155421.14901-1-dbrazdil@google.com>
 <20201126155421.14901-6-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126155421.14901-6-dbrazdil@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 03:54:03PM +0000, David Brazdil wrote:
> When the a CPU is booted in EL2, the kernel checks for VHE support and
> initializes the CPU core accordingly. For nVHE it also installs the stub
> vectors and drops down to EL1.
> 
> Once KVM gains the ability to boot cores without going through the
> kernel entry point, it will need to initialize the CPU the same way.
> Extract the relevant bits of el2_setup into an init_el2_state macro
> with an argument specifying whether to initialize for VHE or nVHE.
> 
> No functional change. Size of el2_setup increased by 148 bytes due
> to duplication.

As a heads-up, this will conflict with my rework which is queued in the
arm64 for-next/uaccess branch. I reworked an renamed el2_setup to
initialize SCTLR_ELx and PSTATE more consistently as a prerequisite for
the set_fs() removal.

I'm afraid this is going to conflict, and I reckon this needs to be
rebased atop that. I think the actual conflicts are logically trivial,
but the diff is going to be painful.

I'm certainly in favour of breaking this down into manageable chunks,
especially as that makes the branch naming easier to follow, but I have
a couple of concerns below.

> +/* GICv3 system register access */
> +.macro __init_el2_gicv3
> +	mrs	x0, id_aa64pfr0_el1
> +	ubfx	x0, x0, #ID_AA64PFR0_GIC_SHIFT, #4
> +	cbz	x0, 1f
> +
> +	mrs_s	x0, SYS_ICC_SRE_EL2
> +	orr	x0, x0, #ICC_SRE_EL2_SRE	// Set ICC_SRE_EL2.SRE==1
> +	orr	x0, x0, #ICC_SRE_EL2_ENABLE	// Set ICC_SRE_EL2.Enable==1
> +	msr_s	SYS_ICC_SRE_EL2, x0
> +	isb					// Make sure SRE is now set
> +	mrs_s	x0, SYS_ICC_SRE_EL2		// Read SRE back,
> +	tbz	x0, #0, 1f			// and check that it sticks
> +	msr_s	SYS_ICH_HCR_EL2, xzr		// Reset ICC_HCR_EL2 to defaults
> +1:
> +.endm

In the head.S code, this was under an ifdef CONFIG_ARM_GIC_V3, but that
ifdef wasn't carried into the macro here, or into its use below. I'm not
sure of the impact, but that does seem to be a functional change.

> +
> +.macro __init_el2_hstr
> +	msr	hstr_el2, xzr			// Disable CP15 traps to EL2
> +.endm

Likewise, this used to be be guarded by CONFIG_COMPAT, but that's not
carried into the macro or its use.

If the intent was to remove the conditionality, then that should be
mentioned in the commit message, since it is a potential functional
change.

Thanks,
Mark.
