Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F85C202BFE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jun 2020 20:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgFUSWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 14:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgFUSWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 14:22:34 -0400
X-Greylist: delayed 2609 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 21 Jun 2020 11:22:33 PDT
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EFFC061794;
        Sun, 21 Jun 2020 11:22:33 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1jn3vf-0007dG-R4; Sun, 21 Jun 2020 19:38:51 +0200
Date:   Sun, 21 Jun 2020 19:38:51 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] hwrng: imx-rngc: enable driver for i.MX6
Message-ID: <20200621173851.w6wkknjbzuyfxx7v@viti.kaiser.cx>
References: <20200621145658.12528-1-horia.geanta@nxp.com>
 <20200621145658.12528-6-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200621145658.12528-6-horia.geanta@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Horia Geantă (horia.geanta@nxp.com):

> i.MX6 SL, SLL, ULL, ULZ SoCs have an RNGB block.

> Since imx-rngc driver supports also rngb,
> let's enable it for these SoCs too.

> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
> ---
>  drivers/char/hw_random/Kconfig    | 2 +-
>  drivers/char/hw_random/imx-rngc.c | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)

> diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
> index 0ad17efc96df..53f6a7e4392f 100644
> --- a/drivers/char/hw_random/Kconfig
> +++ b/drivers/char/hw_random/Kconfig
> @@ -245,7 +245,7 @@ config HW_RANDOM_MXC_RNGA
>  config HW_RANDOM_IMX_RNGC
>  	tristate "Freescale i.MX RNGC Random Number Generator"
>  	depends on HAS_IOMEM && HAVE_CLK
> -	depends on SOC_IMX25 || COMPILE_TEST
> +	depends on SOC_IMX25 || SOC_IMX6SL || SOC_IMX6SLL || SOC_IMX6UL || COMPILE_TEST
>  	default HW_RANDOM
>  	help
>  	  This driver provides kernel-side support for the Random Number
> diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
> index 9c47e431ce90..84576d2fbf8c 100644
> --- a/drivers/char/hw_random/imx-rngc.c
> +++ b/drivers/char/hw_random/imx-rngc.c
> @@ -350,6 +350,9 @@ static SIMPLE_DEV_PM_OPS(imx_rngc_pm_ops, imx_rngc_suspend, imx_rngc_resume);

>  static const struct of_device_id imx_rngc_dt_ids[] = {
>  	{ .compatible = "fsl,imx25-rngb", .data = NULL, },
> +	{ .compatible = "fsl,imx6sl-rngb", .data = NULL, },
> +	{ .compatible = "fsl,imx6sll-rngb", .data = NULL, },
> +	{ .compatible = "fsl,imx6ull-rngb", .data = NULL, },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, imx_rngc_dt_ids);
> -- 
> 2.17.1

Reviewed-by: Martin Kaiser <martin@kaiser.cx>
