Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E254527B46D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgI1S0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbgI1S0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:26:09 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88E23206C3;
        Mon, 28 Sep 2020 18:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601317568;
        bh=u3Ru8Fp5ZqhFBwNIXZAOccSRXU2X+Qr4X2uqL+hJr/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B03u8dyNCfhxAIlvYxgJmoafLkMChsrV98Aao3vYaGNFG8KHfTnE6sNTcZbE3ym/b
         Er4NWOpq1K4ZY4i7huD+aYeJ61Zy3Z6SLZPCkrjwcrWH0aT6pIP5ZDIaBtM1ErEr+Q
         +t/obcQz90G7jfpNwCksmWsI4HkHME2Vv6dKDlZw=
Date:   Mon, 28 Sep 2020 19:26:02 +0100
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com
Subject: Re: [PATCH v3 01/10] arm64: pmu: Add hook to handle pmu-related
 undefined instructions
Message-ID: <20200928182601.GA11974@willie-the-truck>
References: <20200911215118.2887710-1-robh@kernel.org>
 <20200911215118.2887710-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911215118.2887710-2-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 03:51:09PM -0600, Rob Herring wrote:
> From: Raphael Gault <raphael.gault@arm.com>
> 
> This patch introduces a protection for the userspace processes which are
> trying to access the registers from the pmu registers on a big.LITTLE
> environment. It introduces a hook to handle undefined instructions.
> 
> The goal here is to prevent the process to be interrupted by a signal
> when the error is caused by the task being scheduled while accessing
> a counter, causing the counter access to be invalid. As we are not able
> to know efficiently the number of counters available physically on both
> pmu in that context we consider that any faulting access to a counter
> which is architecturally correct should not cause a SIGILL signal if
> the permissions are set accordingly.
> 
> This commit also modifies the mask of the mrs_hook declared in
> arch/arm64/kernel/cpufeatures.c which emulates only feature register
> access. This is necessary because this hook's mask was too large and
> thus masking any mrs instruction, even if not related to the emulated
> registers which made the pmu emulation inefficient.
> 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Fix warning for set but unused sys_reg
> ---
>  arch/arm64/kernel/cpufeature.c |  4 +--
>  arch/arm64/kernel/perf_event.c | 54 ++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index a389b999482e..00bf53ffd9b0 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2811,8 +2811,8 @@ static int emulate_mrs(struct pt_regs *regs, u32 insn)
>  }
>  
>  static struct undef_hook mrs_hook = {
> -	.instr_mask = 0xfff00000,
> -	.instr_val  = 0xd5300000,
> +	.instr_mask = 0xffff0000,
> +	.instr_val  = 0xd5380000,
>  	.pstate_mask = PSR_AA32_MODE_MASK,
>  	.pstate_val = PSR_MODE_EL0t,
>  	.fn = emulate_mrs,
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 462f9a9cc44b..70538ae684da 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -8,9 +8,11 @@
>   * This code is based heavily on the ARMv7 perf event code.
>   */
>  
> +#include <asm/cpu.h>
>  #include <asm/irq_regs.h>
>  #include <asm/perf_event.h>
>  #include <asm/sysreg.h>
> +#include <asm/traps.h>
>  #include <asm/virt.h>
>  
>  #include <clocksource/arm_arch_timer.h>
> @@ -1016,6 +1018,58 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
>  	return probe.present ? 0 : -ENODEV;
>  }
>  
> +static int emulate_pmu(struct pt_regs *regs, u32 insn)
> +{
> +	u32 rt;
> +	u32 pmuserenr;
> +
> +	rt = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT, insn);
> +	pmuserenr = read_sysreg(pmuserenr_el0);
> +
> +	if ((pmuserenr & (ARMV8_PMU_USERENR_ER|ARMV8_PMU_USERENR_CR)) !=
> +	    (ARMV8_PMU_USERENR_ER|ARMV8_PMU_USERENR_CR))
> +		return -EINVAL;
> +
> +
> +	/*
> +	 * Userspace is expected to only use this in the context of the scheme
> +	 * described in the struct perf_event_mmap_page comments.
> +	 *
> +	 * Given that context, we can only get here if we got migrated between
> +	 * getting the register index and doing the MSR read.  This in turn
> +	 * implies we'll fail the sequence and retry, so any value returned is
> +	 * 'good', all we need is to be non-fatal.
> +	 *
> +	 * The choice of the value 0 is comming from the fact that when
> +	 * accessing a register which is not counting events but is accessible,
> +	 * we get 0.
> +	 */
> +	pt_regs_write_reg(regs, rt, 0);

Hmm... this feels pretty fragile since, although we may expect userspace only
to trigger this in the context of the specific perf use-case, we don't have
a way to detect that, so the ABI we're exposing is that EL0 accesses to
non-existent counters will return 0. I don't really think that's something
we want to commit to.

When restartable sequences were added to the kernel, one of the proposed
use-cases was to allow PMU access on big/little systems, because the
sequence will abort on preemption. Taking that approach removes the need
for this emulation hook entirely. Is that something we can rely on instead
of this emulation hook?

Cheers,

Will
