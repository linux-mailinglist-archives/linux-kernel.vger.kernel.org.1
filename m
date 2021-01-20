Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E83B2FD83A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404645AbhATSZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:25:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391968AbhATSSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:18:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E69E3233ED;
        Wed, 20 Jan 2021 18:18:10 +0000 (UTC)
Date:   Wed, 20 Jan 2021 18:18:08 +0000
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
Subject: Re: [PATCH v4 02/21] arm64: Fix outdated TCR setup comment
Message-ID: <20210120181807.GB17952@gaia>
References: <20210118094533.2874082-1-maz@kernel.org>
 <20210118094533.2874082-3-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118094533.2874082-3-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 09:45:14AM +0000, Marc Zyngier wrote:
> The arm64 kernel has long be able to use more than 39bit VAs.
> Since day one, actually. Let's rewrite the offending comment.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/mm/proc.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 1f7ee8c8b7b8..ece785477bdc 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -464,8 +464,8 @@ SYM_FUNC_START(__cpu_setup)
>  #endif
>  	msr	mair_el1, x5
>  	/*
> -	 * Set/prepare TCR and TTBR. We use 512GB (39-bit) address range for
> -	 * both user and kernel.
> +	 * Set/prepare TCR and TTBR. TCR_EL1.T1SZ gets further
> +	 * adjusted if the kernel is compiled with 52bit VA support.

I think both T0SZ and T1SZ get updated based on a mismatch between the
kernel configuration and the hardware support. Anyway, I'm not asking
for a detailed comment here, so:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
