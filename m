Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770552ECEBF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 12:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbhAGL3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 06:29:55 -0500
Received: from foss.arm.com ([217.140.110.172]:58462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbhAGL3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 06:29:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EC8D31B;
        Thu,  7 Jan 2021 03:29:09 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.34.174])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 656C73F719;
        Thu,  7 Jan 2021 03:29:06 -0800 (PST)
Date:   Thu, 7 Jan 2021 11:29:03 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
        vincenzo.frascino@arm.com, samitolvanen@google.com,
        ardb@kernel.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        v.narang@samsung.com, a.sahrawat@samsung.com
Subject: Re: [PATCH 1/1] arm64/entry.S: check for stack overflow in el1 case
 only
Message-ID: <20210107112903.GB7523@C02TD0UTHF1T.local>
References: <CGME20201211091546epcas5p24511325afff612d57306d733a3307648@epcas5p2.samsung.com>
 <1607678131-20347-1-git-send-email-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607678131-20347-1-git-send-email-maninder1.s@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 02:45:31PM +0530, Maninder Singh wrote:
> current code checks for sp bit flip in all exceptions,
> but only el1 exceptions requires this. el0 can not enter
> into stack overflow case directly.
> 
> it will improve performance for el0 exceptions and interrupts.
> 
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>

I did consider doing this at the time Ard and I wrote the overflow
detection, but there was no measureable impact on the workloads that I
tested, and it seemed worthwhile to have this as a sanity check in case
the SP was somehow corrupted (and to avoid any surprizing differences
between the EL0 and EL1 entry paths).

When you say "it will improve performance for el0 exceptions and
interrupts", do you have a workload where this has a measureable impact,
or was this found by inspection? Unless this is causing a real issue,
I'd prefer to leave it as-is for now.

Thanks,
Mark.

> ---
>  arch/arm64/kernel/entry.S | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 2a93fa5..cad8faf 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -77,6 +77,7 @@ alternative_else_nop_endif
>  
>  	sub	sp, sp, #S_FRAME_SIZE
>  #ifdef CONFIG_VMAP_STACK
> +	.if	\el == 1
>  	/*
>  	 * Test whether the SP has overflowed, without corrupting a GPR.
>  	 * Task and IRQ stacks are aligned so that SP & (1 << THREAD_SHIFT)
> @@ -118,6 +119,7 @@ alternative_else_nop_endif
>  	/* We were already on the overflow stack. Restore sp/x0 and carry on. */
>  	sub	sp, sp, x0
>  	mrs	x0, tpidrro_el0
> +	.endif
>  #endif
>  	b	el\()\el\()_\label
>  	.endm
> -- 
> 1.9.1
> 
