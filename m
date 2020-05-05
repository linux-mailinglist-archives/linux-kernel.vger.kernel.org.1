Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74FD1C5969
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 16:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgEEO0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 10:26:05 -0400
Received: from foss.arm.com ([217.140.110.172]:41716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729142AbgEEO0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:26:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAEE01FB;
        Tue,  5 May 2020 07:26:03 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.25.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 456BF3F68F;
        Tue,  5 May 2020 07:25:59 -0700 (PDT)
Date:   Tue, 5 May 2020 15:25:56 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Torsten Duwe <duwe@lst.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Torsten Duwe <duwe@suse.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Julien Thierry <jthierry@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] arm64: disable patchable function entry on big-endian
 clang builds
Message-ID: <20200505142556.GF82823@C02TD0UTHF1T.local>
References: <20200505141257.707945-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505141257.707945-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 04:12:36PM +0200, Arnd Bergmann wrote:
> Clang only supports the patchable_function_entry attribute on
> little-endian arm64 builds, but not on big-endian:
> 
> include/linux/kasan-checks.h:16:8: error: unknown attribute 'patchable_function_entry' ignored [-Werror,-Wunknown-attributes]
> 
> Disable that configuration with another dependency. Unfortunately
> the existing check is not enough, as $(cc-option) at this point does
> not pass the -mbig-endian flag.

Well that's unfortunate. :(

Do we know if this is deliberate and/or likely to change in future? This
practically rules out a BE distro kernel with things like PAC, which
isn't ideal.

> Fixes: 3b23e4991fb6 ("arm64: implement ftrace with regs")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This looks fine for now, and we can add a version check in future, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 4b256fa6db7a..a33d6402b934 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -151,7 +151,7 @@ config ARM64
>  	select HAVE_DMA_CONTIGUOUS
>  	select HAVE_DYNAMIC_FTRACE
>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS \
> -		if $(cc-option,-fpatchable-function-entry=2)
> +		if $(cc-option,-fpatchable-function-entry=2) && !(CC_IS_CLANG && CPU_BIG_ENDIAN)
>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
>  	select HAVE_FAST_GUP
>  	select HAVE_FTRACE_MCOUNT_RECORD
> -- 
> 2.26.0
> 
