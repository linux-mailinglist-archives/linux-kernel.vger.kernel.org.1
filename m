Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83292CA126
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbgLALVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgLALVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:21:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1DDC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 03:20:27 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kk3hl-00063f-Ft; Tue, 01 Dec 2020 12:20:21 +0100
Message-ID: <0a7f2c0e8618f89c1e2eede661cf5a59d68cecad.camel@pengutronix.de>
Subject: Re: [PATCH] drm: mxsfb: Add interconnect path request
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>, marex@denx.de,
        stefan@agner.ch, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 01 Dec 2020 12:20:18 +0100
In-Reply-To: <20201201103757.32165-1-martin.kepplinger@puri.sm>
References: <20201201103757.32165-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 01.12.2020, 11:37 +0100 schrieb Martin Kepplinger:
> Add interconnect support to mxsfb so that it is able to request enough
> bandwidth to DDR for display output to work.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c | 33 +++++++++++++++++++++++++++++++
>  drivers/gpu/drm/mxsfb/mxsfb_drv.h |  2 ++
>  drivers/gpu/drm/mxsfb/mxsfb_kms.c | 13 ++++++++++++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 6faf17b6408d..b05e8e5f1e38 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -15,6 +15,7 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/interconnect.h>
>  
> 
> 
> 
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
> @@ -311,6 +312,34 @@ static const struct of_device_id mxsfb_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, mxsfb_dt_ids);
> 
> +
> +static int mxsfb_init_icc(struct platform_device *pdev)
> +{
> +	struct drm_device *drm = platform_get_drvdata(pdev);
> +	struct mxsfb_drm_private *mxsfb = drm->dev_private;
> +	int ret;
> +
> +	/* Optional interconnect request */
> +	mxsfb->icc_path = devm_of_icc_get(&pdev->dev, "lcdif-dram");
> +	if (IS_ERR(mxsfb->icc_path)) {
> +		ret = PTR_ERR(mxsfb->icc_path);
> +		if (ret == -EPROBE_DEFER)
> +			return ret;
> +
> +		mxsfb->icc_path = NULL;
> +		dev_dbg(drm->dev,
> +			"No interconnect may cause display underflows!\n");
> +	}
> +
> +	ret = icc_set_bw(mxsfb->icc_path, 0, MBps_to_icc(700));

Shouldn't this be proportional to the current mode, instead of a fixed
value? 700MB looks like 1080p@60Hz@32bpp with a bit of headroom, but
there are many valid use-cases where significantly smaller displays are
connected to the eLCDIF. Also it doesn't cover the case where an
overlay is active, which needs additional bandwidth.

> +	if (ret) {
> +		dev_err(drm->dev, "%s: icc_set_bw failed: %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
[...]
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
> @@ -310,6 +311,12 @@ static void mxsfb_crtc_atomic_enable(struct drm_crtc *crtc,
>  	struct mxsfb_drm_private *mxsfb = to_mxsfb_drm_private(crtc->dev);
>  	struct drm_device *drm = mxsfb->drm;
>  	dma_addr_t paddr;
> +	int ret;
> +
> +	ret = icc_enable(mxsfb->icc_path);
> +	if (ret)
> +		dev_err_ratelimited(drm->dev, "%s: icc_enable failed: %d\n",
> +				    __func__, ret);

Why ratelimited? I wouldn't expect atomic enable/disable to be called
often enough for this to make any difference.

Regards,
Lucas

> 
>  	pm_runtime_get_sync(drm->dev);
>  	mxsfb_enable_axi_clk(mxsfb);

