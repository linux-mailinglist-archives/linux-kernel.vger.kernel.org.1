Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCE32F9E13
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390039AbhARL0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390271AbhARL0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:26:00 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E45EC061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 03:25:20 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id q18so16111353wrn.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 03:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XYCl/7LEBptqBylZzqxKLPCyZs5+nBXkfq6fYhltRm0=;
        b=nShMz5jN5vJE2BGQ9VJ9TjIZF4htJVLD4cX2LUoWMIjfMUrrCteI+U6K6+De/YUcaQ
         qju3PMamZnZO4wzdRl5neqqXMAchPPvyszz780zvOgvjoQfEVloS9pgx3nvflUf6Eqik
         OxNmeToQISyMeu7FGHHKjjM+kWRilooyIqNUDdUYIICAZaH0OJViPmkwgoGYypg5LZN6
         rQi9q4Qq6FQxNoWIhTvM532m3z96QwpV8akhCPQuvfD4zLCuTsuJ4WAfECoq6lNhpEuA
         WQVX0l5viz7FroSzF5PsZLhzSgLsJteYZtm0t3dBSblFencKZCIkmRlAnyWcmPJfBDUd
         +35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XYCl/7LEBptqBylZzqxKLPCyZs5+nBXkfq6fYhltRm0=;
        b=A63CyOQ47PoHVp1tfWO4W5+2JDPa7v2g+FRFzyrOvoyNcst+bUeNNVz/z074WeqGG0
         m6gIQJQaPXNyMalcx5OrDORoQ2rBuL0s+xpEeWnL/Wd91bxUtNZwL4sh090V0YbTac7Y
         kPxmrfDv/fimtNxSS28DeDprARgjaQZK+Diyh0WUQxVGxs+oKFXCy9GtGVj0GvWzcwnV
         hWwOm+73/JTls8l7JZlh/x1wVon36En4sxTH0+UV9stidaCdTXdOnCdPaTJTFjT6F0Hm
         oxxiTHDKLoXoLs+rwUmcMBIrX//d6LrloAPCmWPToD8zA51X0jvh3HHCTxMSScM7Hh21
         xc4A==
X-Gm-Message-State: AOAM530FV5LgpumSSlmhiPZhZmZs71USfC4JDxTGZQ6Tn+mNlFAQAjKZ
        tzwkgemWwcjm6MqO7kCzrTiTWg==
X-Google-Smtp-Source: ABdhPJwJwPpnZuDApRSlME2GxkH9HCddnQ1/MxIWxbrkWuSlN59LquzRy2Ly9w2y5hLE1ChWeNwdRw==
X-Received: by 2002:adf:decb:: with SMTP id i11mr25457327wrn.26.1610969118728;
        Mon, 18 Jan 2021 03:25:18 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:3d4d:985d:87b7:4d55])
        by smtp.gmail.com with ESMTPSA id o14sm25505406wmc.28.2021.01.18.03.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 03:25:17 -0800 (PST)
Date:   Mon, 18 Jan 2021 11:25:16 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH v4 04/21] arm64: Provide an 'upgrade to VHE' stub
 hypercall
Message-ID: <20210118112516.6a7lnrtbjvey4iiv@google.com>
References: <20210118094533.2874082-1-maz@kernel.org>
 <20210118094533.2874082-5-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118094533.2874082-5-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 09:45:16AM +0000, Marc Zyngier wrote:
> As we are about to change the way a VHE system boots, let's
> provide the core helper, in the form of a stub hypercall that
> enables VHE and replicates the full EL1 context at EL2, thanks
> to EL1 and VHE-EL2 being extremely similar.
> 
> On exception return, the kernel carries on at EL2. Fancy!
> 
> Nothing calls this new hypercall yet, so no functional change.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/virt.h |  7 +++-
>  arch/arm64/kernel/hyp-stub.S  | 67 +++++++++++++++++++++++++++++++++--
>  2 files changed, 71 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
> index ee6a48df89d9..7379f35ae2c6 100644
> --- a/arch/arm64/include/asm/virt.h
> +++ b/arch/arm64/include/asm/virt.h
> @@ -35,8 +35,13 @@
>   */
>  #define HVC_RESET_VECTORS 2
>  
> +/*
> + * HVC_VHE_RESTART - Upgrade the CPU from EL1 to EL2, if possible
> + */
> +#define HVC_VHE_RESTART	3
> +
>  /* Max number of HYP stub hypercalls */
> -#define HVC_STUB_HCALL_NR 3
> +#define HVC_STUB_HCALL_NR 4
>  
>  /* Error returned when an invalid stub number is passed into x0 */
>  #define HVC_STUB_ERR	0xbadca11
> diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> index 160f5881a0b7..fb12398b5c28 100644
> --- a/arch/arm64/kernel/hyp-stub.S
> +++ b/arch/arm64/kernel/hyp-stub.S
> @@ -8,9 +8,9 @@
>  
>  #include <linux/init.h>
>  #include <linux/linkage.h>
> -#include <linux/irqchip/arm-gic-v3.h>
>  
>  #include <asm/assembler.h>
> +#include <asm/el2_setup.h>
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_asm.h>
>  #include <asm/ptrace.h>
> @@ -47,10 +47,13 @@ SYM_CODE_END(__hyp_stub_vectors)
>  
>  SYM_CODE_START_LOCAL(el1_sync)
>  	cmp	x0, #HVC_SET_VECTORS
> -	b.ne	2f
> +	b.ne	1f
>  	msr	vbar_el2, x1
>  	b	9f
>  
> +1:	cmp	x0, #HVC_VHE_RESTART
> +	b.eq	mutate_to_vhe
> +
>  2:	cmp	x0, #HVC_SOFT_RESTART
>  	b.ne	3f
>  	mov	x0, x2
> @@ -70,6 +73,66 @@ SYM_CODE_START_LOCAL(el1_sync)
>  	eret
>  SYM_CODE_END(el1_sync)
>  
> +// nVHE? No way! Give me the real thing!
> +SYM_CODE_START_LOCAL(mutate_to_vhe)
> +	// Sanity check: MMU *must* be off
> +	mrs	x0, sctlr_el2
> +	tbnz	x0, #0, 1f
> +
> +	// Needs to be VHE capable, obviously
> +	mrs	x0, id_aa64mmfr1_el1
> +	ubfx	x0, x0, #ID_AA64MMFR1_VHE_SHIFT, #4
> +	cbz	x0, 1f

nit: There is a HVC_STUB_ERR that you could return if these sanity checks fail.
The documentation also states that it should be returned on error.

> +
> +	// Engage the VHE magic!
> +	mov_q	x0, HCR_HOST_VHE_FLAGS
> +	msr	hcr_el2, x0
> +	isb
> +
> +	// Doesn't do much on VHE, but still, worth a shot
> +	init_el2_state vhe
> +
> +	// Use the EL1 allocated stack, per-cpu offset
> +	mrs	x0, sp_el1
> +	mov	sp, x0
> +	mrs	x0, tpidr_el1
> +	msr	tpidr_el2, x0
> +
> +	// FP configuration, vectors
> +	mrs_s	x0, SYS_CPACR_EL12
> +	msr	cpacr_el1, x0
> +	mrs_s	x0, SYS_VBAR_EL12
> +	msr	vbar_el1, x0
> +
> +	// Transfer the MM state from EL1 to EL2
> +	mrs_s	x0, SYS_TCR_EL12
> +	msr	tcr_el1, x0
> +	mrs_s	x0, SYS_TTBR0_EL12
> +	msr	ttbr0_el1, x0
> +	mrs_s	x0, SYS_TTBR1_EL12
> +	msr	ttbr1_el1, x0
> +	mrs_s	x0, SYS_MAIR_EL12
> +	msr	mair_el1, x0
> +	isb
> +
> +	// Invalidate TLBs before enabling the MMU
> +	tlbi	vmalle1
> +	dsb	nsh
> +
> +	// Enable the EL2 S1 MMU, as set up from EL1
> +	mrs_s	x0, SYS_SCTLR_EL12
> +	set_sctlr_el1	x0
> +
> +	// Hack the exception return to stay at EL2
> +	mrs	x0, spsr_el1
> +	and	x0, x0, #~PSR_MODE_MASK
> +	mov	x1, #PSR_MODE_EL2h
> +	orr	x0, x0, x1
> +	msr	spsr_el1, x0
> +
> +1:	eret
> +SYM_CODE_END(mutate_to_vhe)
> +
>  .macro invalid_vector	label
>  SYM_CODE_START_LOCAL(\label)
>  	b \label
> -- 
> 2.29.2
> 
