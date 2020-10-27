Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D5229C87D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829558AbgJ0TPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:15:41 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37124 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1829551AbgJ0TPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:15:03 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2CCEC20130A;
        Tue, 27 Oct 2020 20:15:02 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1E1BA2012F5;
        Tue, 27 Oct 2020 20:15:02 +0100 (CET)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 082A2202AE;
        Tue, 27 Oct 2020 20:15:01 +0100 (CET)
Date:   Tue, 27 Oct 2020 21:15:01 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     trix@redhat.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, peng.fan@nxp.com,
        leonard.crestez@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: remove unneeded semicolon
Message-ID: <20201027191501.fuzc3d72774xmivz@fsr-ub1664-175>
References: <20201027185756.1586607-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027185756.1586607-1-trix@redhat.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-10-27 11:57:56, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A semicolon is not needed after a switch statement.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
>  drivers/clk/imx/clk-pll14xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
> index aba36e4217d2..2b5ed86b9dbb 100644
> --- a/drivers/clk/imx/clk-pll14xx.c
> +++ b/drivers/clk/imx/clk-pll14xx.c
> @@ -416,7 +416,7 @@ struct clk_hw *imx_dev_clk_hw_pll14xx(struct device *dev, const char *name,
>  		       __func__, name);
>  		kfree(pll);
>  		return ERR_PTR(-EINVAL);
> -	};
> +	}
>  
>  	pll->base = base;
>  	pll->hw.init = &init;
> -- 
> 2.18.1
> 
