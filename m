Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01BE2C3DCD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 11:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgKYKgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 05:36:42 -0500
Received: from foss.arm.com ([217.140.110.172]:39022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728722AbgKYKgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 05:36:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39361106F;
        Wed, 25 Nov 2020 02:36:41 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4A923F70D;
        Wed, 25 Nov 2020 02:36:39 -0800 (PST)
Date:   Wed, 25 Nov 2020 10:36:37 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com
Subject: Re: [PATCH] arm64: Kconfig: Add SYS_SUPPORTS_APM_EMULATION
Message-ID: <20201125103637.GC70906@C02TD0UTHF1T.local>
References: <20201124090131.27257-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124090131.27257-1-lecopzer.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 05:01:31PM +0800, Lecopzer Chen wrote:
> From: "Lecopzer Chen" <lecopzer.chen@mediatek.com>
> 
> Although most of modern devices use ACPI, there still has combination
> of APM + ARM64.
> 
> In order to select CONFIG_APM_EMULATION, make SYS_SUPPORTS_APM_EMULATION
> default is y if ACPI isn't configured.

I'm a bit confused why this should be enabled for !ACPI. Which DT
platforms need this, and how do they use it? Why should this only be
enabled for kernels without ACPI support, and not for kernels that
support both ACPI and DT?

Thanks,
Mark.

> 
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> Suggested-by: YJ Chiang <yj.chiang@mediatek.com>
> ---
>  arch/arm64/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1515f6f153a0..5e9e3694015a 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -260,6 +260,9 @@ config NO_IOPORT_MAP
>  config STACKTRACE_SUPPORT
>  	def_bool y
>  
> +config SYS_SUPPORTS_APM_EMULATION
> +	def_bool y if !ACPI
> +
>  config ILLEGAL_POINTER_VALUE
>  	hex
>  	default 0xdead000000000000
> -- 
> 2.18.0
> 
