Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A922C8A93
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgK3RNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:13:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:38386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgK3RNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:13:53 -0500
Received: from gaia (unknown [95.146.230.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 133102073C;
        Mon, 30 Nov 2020 17:13:11 +0000 (UTC)
Date:   Mon, 30 Nov 2020 17:13:09 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] arm64: mte: Fix typo in macro definition
Message-ID: <20201130171309.GG3902@gaia>
References: <20201130170709.22309-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130170709.22309-1-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 05:07:09PM +0000, Vincenzo Frascino wrote:
> UL in the definition of SYS_TFSR_EL1_TF1 was misspelled causing
> compilation issues when trying to implement in kernel MTE async
> mode.
> 
> Fix the macro correcting the typo.
> 
> Note: MTE async mode will be introduced with a future series.
> 
> Fixes: c058b1c4a5ea ("arm64: mte: system register definitions")
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/include/asm/sysreg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index e2ef4c2edf06..801861d05426 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -987,7 +987,7 @@
>  #define SYS_TFSR_EL1_TF0_SHIFT	0
>  #define SYS_TFSR_EL1_TF1_SHIFT	1
>  #define SYS_TFSR_EL1_TF0	(UL(1) << SYS_TFSR_EL1_TF0_SHIFT)
> -#define SYS_TFSR_EL1_TF1	(UK(2) << SYS_TFSR_EL1_TF1_SHIFT)
> +#define SYS_TFSR_EL1_TF1	(UL(1) << SYS_TFSR_EL1_TF1_SHIFT)

I think we should first rename it to EU and then fix it properly ;).

While nothing breaks without this patch currently, we should merge it as
a fix.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks.
