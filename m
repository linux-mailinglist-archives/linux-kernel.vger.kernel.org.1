Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD4A2CA1B9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgLALmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgLALmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:42:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB182C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 03:42:03 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kk42f-0000To-Ns; Tue, 01 Dec 2020 12:41:57 +0100
Message-ID: <350854e574f87f0e14f16702d53b22109fe1ab35.camel@pengutronix.de>
Subject: Re: [PATCH v1 1/1] drm/imx/dcss: Add interconnect support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 01 Dec 2020 12:41:56 +0100
In-Reply-To: <f44d42dd9b3750e2516413b2cbb3bc799b2a5628.1606822378.git.agx@sigxcpu.org>
References: <cover.1606822378.git.agx@sigxcpu.org>
         <f44d42dd9b3750e2516413b2cbb3bc799b2a5628.1606822378.git.agx@sigxcpu.org>
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

Am Dienstag, den 01.12.2020, 12:34 +0100 schrieb Guido Günther:
> This allows us to raise DRAM bandiwth to a high enough value for a
> stable picture on i.mx8mq. We pick a bandwidth that should be sufficient
> for 4k@60Hz.
> 
> Modelled like mdp5_kms.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  drivers/gpu/drm/imx/dcss/dcss-dev.c | 47 +++++++++++++++++++++++++++--
>  drivers/gpu/drm/imx/dcss/dcss-dev.h |  3 ++
>  2 files changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.c b/drivers/gpu/drm/imx/dcss/dcss-dev.c
> index c849533ca83e..e336f03448d6 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-dev.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-dev.c
> @@ -15,6 +15,9 @@
>  #include "dcss-dev.h"
>  #include "dcss-kms.h"
>  
> +/* sufficient for 4K at 60 Hz */
> +#define DCSS_BW_MAX GBps_to_icc(2)
> +

Same comment as for the similar change in mxsfb: this should not be a
static value, but should be scaled proportional to the current mode and
plane settings. With a single static value you keep the clocks way too
high for most use-cases with smaller displays, but fail to account for
the additional bandwidth requirement when more than one plane is
active.

Regards,
Lucas

>  static void dcss_clocks_enable(struct dcss_dev *dcss)
>  {
>  	clk_prepare_enable(dcss->axi_clk);
> @@ -162,6 +165,31 @@ static void dcss_clks_release(struct dcss_dev *dcss)
>  	devm_clk_put(dcss->dev, dcss->apb_clk);
>  }
>  
> 
> 
> 
> +static int dcss_init_icc(struct dcss_dev *dcss)
> +{
> +	int ret;
> +	struct icc_path *icc_path;
> +
> +	/* Optional interconnect request */
> +	icc_path = of_icc_get(dcss->dev, NULL);
> +	if (IS_ERR(icc_path)) {
> +		ret = PTR_ERR(icc_path);
> +		if (ret == -EPROBE_DEFER)
> +			return ret;
> +		/* no interconnect support is not necessarily a fatal
> +		 * condition, the platform may simply not have an
> +		 * interconnect driver yet.  But warn about it in case
> +		 * bootloader didn't setup bus clocks high enough for
> +		 * scanout.
> +		 */
> +		dev_warn(dcss->dev, "No interconnect support may cause display underflows!\n");
> +		return 0;
> +	}
> +	dcss->icc_path = icc_path;
> +	dcss->icc_peak_bw = DCSS_BW_MAX;
> +	return 0;
> +}
> +
>  struct dcss_dev *dcss_dev_create(struct device *dev, bool hdmi_output)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> @@ -190,10 +218,14 @@ struct dcss_dev *dcss_dev_create(struct device *dev, bool hdmi_output)
>  	dcss->devtype = devtype;
>  	dcss->hdmi_output = hdmi_output;
>  
> 
> 
> 
> +	ret = dcss_init_icc(dcss);
> +	if (ret < 0)
> +		goto err;
> +
>  	ret = dcss_clks_init(dcss);
>  	if (ret) {
>  		dev_err(dev, "clocks initialization failed\n");
> -		goto err;
> +		goto icc_err;
>  	}
>  
> 
> 
> 
>  	dcss->of_port = of_graph_get_port_by_id(dev->of_node, 0);
> @@ -223,7 +255,8 @@ struct dcss_dev *dcss_dev_create(struct device *dev, bool hdmi_output)
>  
> 
> 
> 
>  clks_err:
>  	dcss_clks_release(dcss);
> -
> +icc_err:
> +	icc_put(dcss->icc_path);
>  err:
>  	kfree(dcss);
>  
> 
> 
> 
> @@ -243,6 +276,8 @@ void dcss_dev_destroy(struct dcss_dev *dcss)
>  
> 
> 
> 
>  	dcss_clks_release(dcss);
>  
> 
> 
> 
> +	icc_put(dcss->icc_path);
> +
>  	kfree(dcss);
>  }
>  
> 
> 
> 
> @@ -267,6 +302,8 @@ int dcss_dev_suspend(struct device *dev)
>  
> 
> 
> 
>  	dcss_clocks_disable(dcss);
>  
> 
> 
> 
> +	icc_set_bw(dcss->icc_path, 0, 0);
> +
>  	return 0;
>  }
>  
> 
> 
> 
> @@ -281,6 +318,8 @@ int dcss_dev_resume(struct device *dev)
>  		return 0;
>  	}
>  
> 
> 
> 
> +	icc_set_bw(dcss->icc_path, 0, dcss->icc_peak_bw);
> +
>  	dcss_clocks_enable(dcss);
>  
> 
> 
> 
>  	dcss_blkctl_cfg(dcss->blkctl);
> @@ -307,6 +346,8 @@ int dcss_dev_runtime_suspend(struct device *dev)
>  
> 
> 
> 
>  	dcss_clocks_disable(dcss);
>  
> 
> 
> 
> +	icc_set_bw(dcss->icc_path, 0, 0);
> +
>  	return 0;
>  }
>  
> 
> 
> 
> @@ -314,6 +355,8 @@ int dcss_dev_runtime_resume(struct device *dev)
>  {
>  	struct dcss_dev *dcss = dcss_drv_dev_to_dcss(dev);
>  
> 
> 
> 
> +	icc_set_bw(dcss->icc_path, 0, dcss->icc_peak_bw);
> +
>  	dcss_clocks_enable(dcss);
>  
> 
> 
> 
>  	dcss_blkctl_cfg(dcss->blkctl);
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-dev.h b/drivers/gpu/drm/imx/dcss/dcss-dev.h
> index c642ae17837f..1b35a6f0d0d4 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-dev.h
> +++ b/drivers/gpu/drm/imx/dcss/dcss-dev.h
> @@ -8,6 +8,7 @@
>  
> 
> 
> 
>  #include <drm/drm_fourcc.h>
>  #include <linux/io.h>
> +#include <linux/interconnect.h>
>  #include <video/videomode.h>
>  
> 
> 
> 
>  #define SET			0x04
> @@ -85,6 +86,8 @@ struct dcss_dev {
>  	struct clk *pll_phy_ref_clk;
>  
> 
> 
> 
>  	bool hdmi_output;
> +	struct icc_path *icc_path;
> +	u32 icc_peak_bw;
>  
> 
> 
> 
>  	void (*disable_callback)(void *data);
>  	struct completion disable_completion;


