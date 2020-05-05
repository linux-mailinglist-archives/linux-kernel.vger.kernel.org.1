Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D011C5C7D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 17:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbgEEPuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 11:50:06 -0400
Received: from v6.sk ([167.172.42.174]:40488 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729150AbgEEPuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:50:06 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 8809B610CA;
        Tue,  5 May 2020 15:49:33 +0000 (UTC)
Date:   Tue, 5 May 2020 17:49:30 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ARM: mmp: Replace <linux/clk-provider.h> by
 <linux/of_clk.h>
Message-ID: <20200505154930.GC1997@furthur.local>
References: <20200505154536.4099-1-geert+renesas@glider.be>
 <20200505154536.4099-4-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505154536.4099-4-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 05:45:36PM +0200, Geert Uytterhoeven wrote:
> The Marvell MMP platform code is not a clock provider, and just needs to
> call of_clk_init().
> 
> Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Acked-by: Lubomir Rintel <lkundrak@v3.sk>

> ---
> v2:
>   - Add Reviewed-by.
> ---
>  arch/arm/mach-mmp/mmp-dt.c  | 2 +-
>  arch/arm/mach-mmp/mmp2-dt.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mmp/mmp-dt.c b/arch/arm/mach-mmp/mmp-dt.c
> index 91214996acecc9fb..3f43c0867dcae4ed 100644
> --- a/arch/arm/mach-mmp/mmp-dt.c
> +++ b/arch/arm/mach-mmp/mmp-dt.c
> @@ -8,7 +8,7 @@
>  
>  #include <linux/irqchip.h>
>  #include <linux/of_platform.h>
> -#include <linux/clk-provider.h>
> +#include <linux/of_clk.h>
>  #include <linux/clocksource.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/time.h>
> diff --git a/arch/arm/mach-mmp/mmp2-dt.c b/arch/arm/mach-mmp/mmp2-dt.c
> index 510c762ddc484c40..34a5fe4b3949167e 100644
> --- a/arch/arm/mach-mmp/mmp2-dt.c
> +++ b/arch/arm/mach-mmp/mmp2-dt.c
> @@ -9,7 +9,7 @@
>  #include <linux/io.h>
>  #include <linux/irqchip.h>
>  #include <linux/of_platform.h>
> -#include <linux/clk-provider.h>
> +#include <linux/of_clk.h>
>  #include <linux/clocksource.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/time.h>
> -- 
> 2.17.1
> 
