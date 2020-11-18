Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDF32B7FDB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 15:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgKROzV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Nov 2020 09:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgKROzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 09:55:20 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF99C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 06:55:20 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kfOrZ-0002K7-DQ; Wed, 18 Nov 2020 15:55:13 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kfOrY-0003vm-BW; Wed, 18 Nov 2020 15:55:12 +0100
Message-ID: <32aaa90cabfb68952803ca91933bc0e105e34a53.camel@pengutronix.de>
Subject: Re: [PATCH v2] drm/imx: depend on COMMON_CLK to fix compile tests
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 18 Nov 2020 15:55:12 +0100
In-Reply-To: <20201117182419.73853-1-krzk@kernel.org>
References: <20201117182419.73853-1-krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, 2020-11-17 at 19:24 +0100, Krzysztof Kozlowski wrote:
> The iMX DRM LVDS driver uses Common Clock Framework thus it cannot be
> built on platforms without it (e.g. compile test on MIPS with RALINK and
> SOC_RT305X):
> 
>     /usr/bin/mips-linux-gnu-ld: drivers/gpu/drm/imx/imx-ldb.o: in function `imx_ldb_encoder_disable':
>     imx-ldb.c:(.text+0x400): undefined reference to `clk_set_parent'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Put depends in DRM_IMX_LDB option only.
> ---
>  drivers/gpu/drm/imx/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/imx/Kconfig b/drivers/gpu/drm/imx/Kconfig
> index 6231048aa5aa..73fe2bc5633c 100644
> --- a/drivers/gpu/drm/imx/Kconfig
> +++ b/drivers/gpu/drm/imx/Kconfig
> @@ -28,6 +28,7 @@ config DRM_IMX_TVE
>  config DRM_IMX_LDB
>  	tristate "Support for LVDS displays"
>  	depends on DRM_IMX && MFD_SYSCON
> +	depends on COMMON_CLK
>  	select DRM_PANEL
>  	help
>  	  Choose this to enable the internal LVDS Display Bridge (LDB)

Thank you, applied to imx-drm/next.

regards
Philipp
