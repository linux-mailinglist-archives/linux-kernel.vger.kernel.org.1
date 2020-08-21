Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE8124D644
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 15:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgHUNlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 09:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgHUNlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:41:11 -0400
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4FEC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 06:41:10 -0700 (PDT)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 29F1D5C3C51;
        Fri, 21 Aug 2020 15:41:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1598017269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LE2TFZ1+IweKi2vTZvvLk5Fk6G2KUt1tDlOSM8ejL5I=;
        b=mn8bJG3LS59omc5t6yxfYTIT+YcoTGKpneHtDa5pyD7zYO891zZLYf//ab4rICxuI/4nfU
        x1kL8cKVWk3LnbX4FIbovfXtIBww1CDUw13qOHWL6aQKgtTVBFuXNSASrkJ0rLnvJH57TH
        vDRaj9sQxLLSt09PSG9GCDdKX/7LPzs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Fri, 21 Aug 2020 15:41:09 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        sboyd@kernel.org, mturquette@baylibre.com
Cc:     Alison Wang <alison.wang@nxp.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: fsl-dcu: enable PIXCLK on LS1021A
In-Reply-To: <20200820105832.22331-1-matthias.schiffer@ew.tq-group.com>
References: <20200820105832.22331-1-matthias.schiffer@ew.tq-group.com>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <0321e3b1a9def003322b71f2a5fdfe08@agner.ch>
X-Sender: stefan@agner.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2020-08-20 12:58, Matthias Schiffer wrote:
> The PIXCLK needs to be enabled in SCFG before accessing the DCU on LS1021A,
> or the access will hang.

Hm, this seems a rather ad-hoc access to SCFG from the DCU. We do
support a pixel clock in the device tree bindings of fsl-dcu, so ideally
we should enable the pixel clock through the clock framework.

On the other hand, I guess that would mean adding a clock driver to flip
a single bit, which seems a bit excessive too.

I'd like a second opinion on that. Adding clk framework maintainers.

--
Stefan

> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/gpu/drm/fsl-dcu/Kconfig           |  1 +
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 25 +++++++++++++++++++++++
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h |  3 +++
>  3 files changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/fsl-dcu/Kconfig b/drivers/gpu/drm/fsl-dcu/Kconfig
> index d7dd8ba90e3a..9e5a35e7c00c 100644
> --- a/drivers/gpu/drm/fsl-dcu/Kconfig
> +++ b/drivers/gpu/drm/fsl-dcu/Kconfig
> @@ -8,6 +8,7 @@ config DRM_FSL_DCU
>  	select DRM_PANEL
>  	select REGMAP_MMIO
>  	select VIDEOMODE_HELPERS
> +	select MFD_SYSCON if SOC_LS1021A
>  	help
>  	  Choose this option if you have an Freescale DCU chipset.
>  	  If M is selected the module will be called fsl-dcu-drm.
> diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> index abbc1ddbf27f..8a7556655581 100644
> --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> @@ -51,6 +51,23 @@ static const struct regmap_config fsl_dcu_regmap_config = {
>  	.volatile_reg = fsl_dcu_drm_is_volatile_reg,
>  };
>  
> +static int fsl_dcu_scfg_config_ls1021a(struct device_node *np)
> +{
> +	struct regmap *scfg;
> +
> +	scfg = syscon_regmap_lookup_by_compatible("fsl,ls1021a-scfg");
> +	if (IS_ERR(scfg))
> +		return PTR_ERR(scfg);
> +
> +	/*
> +	 * For simplicity, enable the PIXCLK unconditionally. It might
> +	 * be possible to disable the clock in PM or on unload as a future
> +	 * improvement.
> +	 */
> +	return regmap_update_bits(scfg, SCFG_PIXCLKCR, SCFG_PIXCLKCR_PXCEN,
> +				  SCFG_PIXCLKCR_PXCEN);
> +}
> +
>  static void fsl_dcu_irq_uninstall(struct drm_device *dev)
>  {
>  	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
> @@ -70,6 +87,14 @@ static int fsl_dcu_load(struct drm_device *dev,
> unsigned long flags)
>  		return ret;
>  	}
>  
> +	if (of_device_is_compatible(fsl_dev->np, "fsl,ls1021a-dcu")) {
> +		ret = fsl_dcu_scfg_config_ls1021a(fsl_dev->np);
> +		if (ret < 0) {
> +			dev_err(dev->dev, "failed to enable pixclk\n");
> +			goto done;
> +		}
> +	}
> +
>  	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
>  	if (ret < 0) {
>  		dev_err(dev->dev, "failed to initialize vblank\n");
> diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
> b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
> index e2049a0e8a92..566396013c04 100644
> --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
> +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
> @@ -160,6 +160,9 @@
>  #define FSL_DCU_ARGB4444		12
>  #define FSL_DCU_YUV422			14
>  
> +#define SCFG_PIXCLKCR			0x28
> +#define SCFG_PIXCLKCR_PXCEN		BIT(31)
> +
>  #define VF610_LAYER_REG_NUM		9
>  #define LS1021A_LAYER_REG_NUM		10
