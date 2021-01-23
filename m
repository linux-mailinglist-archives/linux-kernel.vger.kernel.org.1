Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31B33015A8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 15:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbhAWOIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 09:08:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:33512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbhAWOIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 09:08:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2961022B51;
        Sat, 23 Jan 2021 14:07:56 +0000 (UTC)
Date:   Sat, 23 Jan 2021 14:07:53 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
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
Subject: Re: [PATCH v4 14/21] arm64: Honor VHE being disabled from the
 command-line
Message-ID: <YAwtuZZpTwwoMqrk@Catalins-MacBook-Air.local>
References: <20210118094533.2874082-1-maz@kernel.org>
 <20210118094533.2874082-15-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118094533.2874082-15-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 09:45:26AM +0000, Marc Zyngier wrote:
> diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> index 59820f9b8522..bbab2148a2a2 100644
> --- a/arch/arm64/kernel/hyp-stub.S
> +++ b/arch/arm64/kernel/hyp-stub.S
> @@ -77,13 +77,24 @@ SYM_CODE_END(el1_sync)
>  SYM_CODE_START_LOCAL(mutate_to_vhe)
>  	// Sanity check: MMU *must* be off
>  	mrs	x0, sctlr_el2
> -	tbnz	x0, #0, 1f
> +	tbnz	x0, #0, 2f
>  
>  	// Needs to be VHE capable, obviously
>  	mrs	x0, id_aa64mmfr1_el1
>  	ubfx	x0, x0, #ID_AA64MMFR1_VHE_SHIFT, #4
> -	cbz	x0, 1f
> +	cbz	x0, 2f
>  
> +	// Check whether VHE is disabled from the command line
> +	adr_l	x1, id_aa64mmfr1_val
> +	ldr	x0, [x1]
> +	adr_l	x1, id_aa64mmfr1_mask
> +	ldr	x1, [x1]
> +	ubfx	x0, x0, #ID_AA64MMFR1_VHE_SHIFT, #4
> +	ubfx	x1, x1, #ID_AA64MMFR1_VHE_SHIFT, #4
> +	cbz	x1, 1f
> +	and	x0, x0, x1
> +	cbz	x0, 2f
> +1:

I can see the advantage here in separate id_aa64mmfr1_val/mask but we
could use some asm offsets here and keep the pointer indirection simpler
in C code. You'd just need something like 'adr_l mmfr1_ovrd + VAL_OFFSET'.

Anyway, if you have a strong preference for the current approach, leave
it as is.

-- 
Catalin
