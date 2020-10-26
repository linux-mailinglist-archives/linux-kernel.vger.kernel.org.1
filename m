Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B22299245
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785764AbgJZQXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:23:24 -0400
Received: from foss.arm.com ([217.140.110.172]:44070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1775605AbgJZQXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:23:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 920E81042;
        Mon, 26 Oct 2020 09:23:22 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.56.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 257703F719;
        Mon, 26 Oct 2020 09:23:20 -0700 (PDT)
Date:   Mon, 26 Oct 2020 16:23:14 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        James Morse <james.morse@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: traps: fix -Woverride-init warnings
Message-ID: <20201026162314.GA42396@C02TD0UTHF1T.local>
References: <20201026160342.3705327-1-arnd@kernel.org>
 <20201026160342.3705327-4-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026160342.3705327-4-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, Oct 26, 2020 at 05:03:31PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are many warnings in this file when we re-enable the
> Woverride-init flag:
> 
> arch/arm64/kernel/traps.c:704:26: warning: initialized field overwritten [-Woverride-init]
>   704 |  [ESR_ELx_EC_UNKNOWN]  = "Unknown/Uncategorized",
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~
> arch/arm64/kernel/traps.c:704:26: note: (near initialization for 'esr_class_str[0]')
> arch/arm64/kernel/traps.c:705:22: warning: initialized field overwritten [-Woverride-init]
>   705 |  [ESR_ELx_EC_WFx]  = "WFI/WFE",
>       |                      ^~~~~~~~~
> 
> This is harmless since they are only informational strings,
> but it's easy to change the code to ignore missing initialization
> and instead warn about possible duplicate initializers.

This has come up before, and IMO the warning is more hindrance than
helpful, given the prevalance of spurious warnings, and the (again IMO)
the rework needed to avoid those making the code harder to reason about.

We use this pattern all througout the kernel (e.g. in the syscall
wrappers), so unless the plan is to avoid this everywhere, I don't think
that we should alter individual cases. I also don't think that the Fixes
tag is appropriate given the code is correct.

Could we instead convince the compiler folk to give us better tools to
deal with this? For example, if we could annotate assignmments as
overridable or being an override, it'd be possible to distinguish the
benign cases from bad ones, without forcing us to have dynamic checks.

Thanks,
Mark.

> 
> Fixes: 60a1f02c9e91 ("arm64: decode ESR_ELx.EC when reporting exceptions")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/kernel/traps.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 8af4e0e85736..d21cb25f9e1f 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -700,7 +700,6 @@ void do_sysinstr(unsigned int esr, struct pt_regs *regs)
>  NOKPROBE_SYMBOL(do_sysinstr);
>  
>  static const char *esr_class_str[] = {
> -	[0 ... ESR_ELx_EC_MAX]		= "UNRECOGNIZED EC",
>  	[ESR_ELx_EC_UNKNOWN]		= "Unknown/Uncategorized",
>  	[ESR_ELx_EC_WFx]		= "WFI/WFE",
>  	[ESR_ELx_EC_CP15_32]		= "CP15 MCR/MRC",
> @@ -746,7 +745,7 @@ static const char *esr_class_str[] = {
>  
>  const char *esr_get_class_string(u32 esr)
>  {
> -	return esr_class_str[ESR_ELx_EC(esr)];
> +	return esr_class_str[ESR_ELx_EC(esr)] ?: "UNRECOGNIZED EC";
>  }
>  
>  /*
> -- 
> 2.27.0
> 
