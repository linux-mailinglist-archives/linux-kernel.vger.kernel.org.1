Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394DA276924
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 08:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgIXGlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 02:41:42 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52818 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbgIXGll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 02:41:41 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kLKwi-00048m-KT; Thu, 24 Sep 2020 08:41:36 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Elaine Zhang <zhangqing@rock-chips.com>
Subject: Re: [PATCH] clk: rockchip: Initialize hw to error to avoid undefined behavior
Date:   Thu, 24 Sep 2020 08:41:36 +0200
Message-ID: <1741951.WK9IEl5h0a@diego>
In-Reply-To: <20200924004441.1476015-1-sboyd@kernel.org>
References: <20200924004441.1476015-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 24. September 2020, 02:44:41 CEST schrieb Stephen Boyd:
> We can get down to this return value from ERR_CAST() without
> initializing hw. Set it to -ENOMEM so that we always return something
> sane.
> 
> Fixes the following smatch warning:
> 
> drivers/clk/rockchip/clk-half-divider.c:228 rockchip_clk_register_halfdiv() error: uninitialized symbol 'hw'.
> drivers/clk/rockchip/clk-half-divider.c:228 rockchip_clk_register_halfdiv() warn: passing zero to 'ERR_CAST'
> 
> Cc: Elaine Zhang <zhangqing@rock-chips.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Fixes: 956060a52795 ("clk: rockchip: add support for half divider")
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


> ---
>  drivers/clk/rockchip/clk-half-divider.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/rockchip/clk-half-divider.c b/drivers/clk/rockchip/clk-half-divider.c
> index e97fd3dfbae7..ccd5c270c213 100644
> --- a/drivers/clk/rockchip/clk-half-divider.c
> +++ b/drivers/clk/rockchip/clk-half-divider.c
> @@ -166,7 +166,7 @@ struct clk *rockchip_clk_register_halfdiv(const char *name,
>  					  unsigned long flags,
>  					  spinlock_t *lock)
>  {
> -	struct clk_hw *hw;
> +	struct clk_hw *hw = ERR_PTR(-ENOMEM);
>  	struct clk_mux *mux = NULL;
>  	struct clk_gate *gate = NULL;
>  	struct clk_divider *div = NULL;
> 
> base-commit: ca52a47af60f791b08a540a8e14d8f5751ee63e9
> 




