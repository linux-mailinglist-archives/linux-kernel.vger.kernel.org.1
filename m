Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570592CEAE1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387580AbgLDJ16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:27:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:46272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgLDJ15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:27:57 -0500
Date:   Fri, 4 Dec 2020 09:27:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607074037;
        bh=tPpTC9bhjEVC0buQbJ+dbgcUuj+eIqVrhNolNhZi/CI=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=UwiVTr5JnpOgoH6ylOS9zHMRAAIc3D+H0fU8Qf7/R91fAOtiXYYHvNBOswxFDlUX6
         eB5U31VJUyLgces75b4hOKJin38ki4Dx6fUrLU+W16RKrFdIiqjf3r3VfufoycFpxz
         5rwdfcF9ocNDiJxkiqajvK9uJ4QgtIRX1q/fpppSLXbrkCMT09I+SoNfx97FIZsHIn
         szc2V14UjvLNE3SHkx3vRep5t4omptB5z1HDyhzjnEkN++vjgjcyi7JrYGZBol7VEr
         SPiGA8S97kQDsdNHx6lzAIiTx0Y7eH5DvSUDvMu34V5P0HQiFpoPUQ+ZJCTnZxIZLe
         IUvlAl2kxI/0g==
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: fix HARDLOCKUP_DETECTOR dependency
Message-ID: <20201204092711.GA461@willie-the-truck>
References: <20201203222800.1009987-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203222800.1009987-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, Dec 03, 2020 at 11:27:26PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_HW_PERF_EVENTS is disabled, the hardware lockup detector
> fails to link:
> 
> ld.lld: error: undefined symbol: hw_nmi_get_sample_period
> >>> referenced by watchdog_hld.c
> >>>               watchdog_hld.o:(hardlockup_detector_event_create) in archive kernel/built-in.a
> 
> Fix the dependency to refer to the Kconfig symbol that actually controls
> the feature.
> 
> Fixes: 367c820ef080 ("arm64: Enable perf events based hard lockup detector")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7599ad86e9a8..ecd900ad7755 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -176,7 +176,7 @@ config ARM64
>  	select HAVE_PATA_PLATFORM
>  	select HAVE_PERF_EVENTS
>  	select HAVE_PERF_EVENTS_NMI if ARM64_PSEUDO_NMI
> -	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
> +	select HAVE_HARDLOCKUP_DETECTOR_PERF if HW_PERF_EVENTS && HAVE_PERF_EVENTS_NMI
>  	select HAVE_PERF_REGS
>  	select HAVE_PERF_USER_STACK_DUMP
>  	select HAVE_REGS_AND_STACK_ACCESS_API

Cheers, although I already have a fix for this one queued locally [1].
I'll push it out in sec (ran out of time yesterday).

Will

[1] https://lore.kernel.org/r/202012031509.4O5ZoWNI-lkp@intel.com
