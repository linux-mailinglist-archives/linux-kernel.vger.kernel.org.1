Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AFC2CC97E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 23:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgLBWUF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Dec 2020 17:20:05 -0500
Received: from aposti.net ([89.234.176.197]:37088 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728186AbgLBWUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 17:20:05 -0500
Date:   Wed, 02 Dec 2020 22:19:12 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/4] dt-bindings: clock: Add missing clocks for Ingenic
 SoCs.
To:     =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Message-Id: <0OGQKQ.9XH5E7BM1Y913@crapouillou.net>
In-Reply-To: <20201125172618.112707-3-zhouyanjie@wanyeetech.com>
References: <20201125172618.112707-1-zhouyanjie@wanyeetech.com>
        <20201125172618.112707-3-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le jeu. 26 nov. 2020 à 1:26, 周琰杰 (Zhou Yanjie) 
<zhouyanjie@wanyeetech.com> a écrit :
> Add CIM, AIC, DMIC clocks bindings for the X1000 SoC, and CIM, AIC,
> DMIC, I2S clocks for the X1830 SoC from Ingenic.
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  include/dt-bindings/clock/x1000-cgu.h | 3 +++
>  include/dt-bindings/clock/x1830-cgu.h | 4 ++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/x1000-cgu.h 
> b/include/dt-bindings/clock/x1000-cgu.h
> index f187e07..fa92257 100644
> --- a/include/dt-bindings/clock/x1000-cgu.h
> +++ b/include/dt-bindings/clock/x1000-cgu.h
> @@ -50,5 +50,8 @@
>  #define X1000_CLK_PDMA			35
>  #define X1000_CLK_EXCLK_DIV512	36
>  #define X1000_CLK_RTC			37
> +#define X1000_CLK_CIM			38
> +#define X1000_CLK_AIC			39
> +#define X1000_CLK_DMIC			40
> 
>  #endif /* __DT_BINDINGS_CLOCK_X1000_CGU_H__ */
> diff --git a/include/dt-bindings/clock/x1830-cgu.h 
> b/include/dt-bindings/clock/x1830-cgu.h
> index 8845537..3732507 100644
> --- a/include/dt-bindings/clock/x1830-cgu.h
> +++ b/include/dt-bindings/clock/x1830-cgu.h
> @@ -53,5 +53,9 @@
>  #define X1830_CLK_OST			38
>  #define X1830_CLK_EXCLK_DIV512	39
>  #define X1830_CLK_RTC			40
> +#define X1830_CLK_CIM			41
> +#define X1830_CLK_AIC			42
> +#define X1830_CLK_DMIC			43
> +#define X1830_CLK_I2S			44
> 
>  #endif /* __DT_BINDINGS_CLOCK_X1830_CGU_H__ */
> --
> 2.7.4
> 


