Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA55625F0F1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 00:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgIFWfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Sep 2020 18:35:44 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38296 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgIFWfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 18:35:42 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kF3G6-0002XA-BB; Mon, 07 Sep 2020 00:35:38 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, xxx@rock-chips.com,
        xf@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com, Elaine Zhang <zhangqing@rock-chips.com>
Subject: Re: [PATCH v3 3/6] clk: rockchip: Export rockchip_register_softrst()
Date:   Mon, 07 Sep 2020 00:35:37 +0200
Message-ID: <2186827.9gi7mZr2Dv@diego>
In-Reply-To: <20200904074405.24439-4-zhangqing@rock-chips.com>
References: <20200904074405.24439-1-zhangqing@rock-chips.com> <20200904074405.24439-4-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 4. September 2020, 09:44:02 CEST schrieb Elaine Zhang:
> This is used by the Rockchip clk driver, export it to allow that
> driver to be compiled as a module..
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>  drivers/clk/rockchip/softrst.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/softrst.c b/drivers/clk/rockchip/softrst.c
> index 5f1ff5e47c4f..caba9055090b 100644
> --- a/drivers/clk/rockchip/softrst.c
> +++ b/drivers/clk/rockchip/softrst.c
> @@ -77,9 +77,9 @@ static const struct reset_control_ops rockchip_softrst_ops = {
>  	.deassert	= rockchip_softrst_deassert,
>  };
>  
> -void __init rockchip_register_softrst(struct device_node *np,
> -				      unsigned int num_regs,
> -				      void __iomem *base, u8 flags)
> +void rockchip_register_softrst(struct device_node *np,
> +			       unsigned int num_regs,
> +			       void __iomem *base, u8 flags)
>  {
>  	struct rockchip_softrst *softrst;
>  	int ret;
> @@ -107,3 +107,4 @@ void __init rockchip_register_softrst(struct device_node *np,
>  		kfree(softrst);
>  	}
>  };
> +EXPORT_SYMBOL(rockchip_register_softrst);

Same comment about EXPORT_SYMBOL_GPL perhaps?




