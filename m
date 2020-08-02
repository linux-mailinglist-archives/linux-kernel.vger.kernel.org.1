Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1209235607
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Aug 2020 10:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgHBIoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Aug 2020 04:44:24 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:55190 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgHBIoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 04:44:24 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 9FEBD80521;
        Sun,  2 Aug 2020 10:44:12 +0200 (CEST)
Date:   Sun, 2 Aug 2020 10:44:11 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Joe Perches <joe@perches.com>
Cc:     Bernard Zhao <bernard@vivo.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Stefan Mavrodiev <stefan@olimex.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] drm: Remove unnecessary drm_panel_attach and
 drm_panel_detach
Message-ID: <20200802084411.GA908790@ravnborg.org>
References: <20200801120216.8488-1-bernard@vivo.com>
 <20200802070743.GA822300@ravnborg.org>
 <f1fbc362695af155a30627ef69b375e8a3daaa55.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1fbc362695af155a30627ef69b375e8a3daaa55.camel@perches.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=IkcTkHD0fZMA:10 a=IJv9LcIfAAAA:8 a=kWeR6k4WL16bM6A69woA:9
        a=rqki1b0NXtSLW0_v:21 a=tN3dDNyB3zf30aEe:21 a=QEXdDO2ut3YA:10
        a=cmr4hm9N53k6aw-X_--Q:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe.

On Sun, Aug 02, 2020 at 01:00:11AM -0700, Joe Perches wrote:
> These functions are now empty and no longer
> useful so remove the functions and their uses.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> 
> It's too tedious to break apart into multiple patches.
> Done with coccinelle and typing.
> 
> Compiled allyesconfig x86-64 only.

Thanks for doing this.
But patch fails to apply for drm-misc-next where we put this kind of
changes. I managed to apply it with some rejects.

There is several warnings like these when building for arm.
I did not build it all as my build failed too.

drivers/gpu/drm/omapdrm/omap_drv.c: In function ‘omap_modeset_fini’:
drivers/gpu/drm/omapdrm/omap_drv.c:390:27: warning: unused variable ‘priv’ [-Wunused-variable]
  struct omap_drm_private *priv = ddev->dev_private;

drivers/gpu/drm/exynos/exynos_drm_dpi.c: In function ‘exynos_dpi_detect’:
drivers/gpu/drm/exynos/exynos_drm_dpi.c:45:21: warning: unused variable ‘ctx’ [-Wunused-variable]
  struct exynos_dpi *ctx = connector_to_dpi(connector);
                     ^~~
drivers/gpu/drm/sun4i/sun4i_lvds.c: In function ‘sun4i_lvds_connector_destroy’:
drivers/gpu/drm/sun4i/sun4i_lvds.c:57:21: warning: unused variable ‘lvds’ [-Wunused-variable]
  struct sun4i_lvds *lvds = drm_connector_to_sun4i_lvds(connector);
                     ^~~~

I know you can do better than this. Care to give it an extra spin?

	Sam
> 
>  drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 12 --------
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  9 ------
>  drivers/gpu/drm/bridge/nxp-ptn3460.c               |  3 --
>  drivers/gpu/drm/bridge/panel.c                     |  7 -----
>  drivers/gpu/drm/bridge/parade-ps8622.c             |  3 --
>  drivers/gpu/drm/bridge/tc358764.c                  |  2 --
>  drivers/gpu/drm/bridge/tc358767.c                  |  3 --
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c              |  3 --
>  drivers/gpu/drm/drm_panel.c                        | 36 ----------------------
>  drivers/gpu/drm/exynos/exynos_drm_dpi.c            |  6 ----
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c            |  7 ++---
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          |  7 -----
>  drivers/gpu/drm/imx/imx-ldb.c                      | 10 ------
>  drivers/gpu/drm/imx/parallel-display.c             |  6 ----
>  .../gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c    |  7 +----
>  drivers/gpu/drm/msm/dsi/dsi_manager.c              |  1 -
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c                  |  7 +----
>  drivers/gpu/drm/mxsfb/mxsfb_out.c                  |  6 ----
>  drivers/gpu/drm/omapdrm/omap_drv.c                 | 15 ---------
>  drivers/gpu/drm/rcar-du/rcar_lvds.c                |  6 +---
>  drivers/gpu/drm/rockchip/rockchip_lvds.c           |  9 ------
>  drivers/gpu/drm/sti/sti_dvo.c                      |  2 --
>  drivers/gpu/drm/sun4i/sun4i_lvds.c                 |  7 -----
>  drivers/gpu/drm/sun4i/sun4i_rgb.c                  |  7 -----
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |  2 --
>  drivers/gpu/drm/tegra/dsi.c                        |  4 +--
>  drivers/gpu/drm/tegra/output.c                     | 10 ------
>  include/drm/drm_panel.h                            |  3 --
>  28 files changed, 6 insertions(+), 194 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> index f082b4ed4878..d9164fab044d 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> @@ -507,10 +507,6 @@ static const struct drm_connector_helper_funcs anx6345_connector_helper_funcs =
>  static void
>  anx6345_connector_destroy(struct drm_connector *connector)
>  {
> -	struct anx6345 *anx6345 = connector_to_anx6345(connector);
> -
> -	if (anx6345->panel)
> -		drm_panel_detach(anx6345->panel);
>  	drm_connector_cleanup(connector);
>  }
>  
> @@ -575,14 +571,6 @@ static int anx6345_bridge_attach(struct drm_bridge *bridge,
>  		return err;
>  	}
>  
> -	if (anx6345->panel) {
> -		err = drm_panel_attach(anx6345->panel, &anx6345->connector);
> -		if (err) {
> -			DRM_ERROR("Failed to attach panel: %d\n", err);
> -			return err;
> -		}
> -	}
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 76736fb8ed94..aa1bb86293fd 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1265,14 +1265,6 @@ static int analogix_dp_bridge_attach(struct drm_bridge *bridge,
>  		}
>  	}
>  
> -	if (dp->plat_data->panel) {
> -		ret = drm_panel_attach(dp->plat_data->panel, &dp->connector);
> -		if (ret) {
> -			DRM_ERROR("Failed to attach panel\n");
> -			return ret;
> -		}
> -	}
> -
>  	return 0;
>  }
>  
> @@ -1803,7 +1795,6 @@ void analogix_dp_unbind(struct analogix_dp_device *dp)
>  	if (dp->plat_data->panel) {
>  		if (drm_panel_unprepare(dp->plat_data->panel))
>  			DRM_ERROR("failed to turnoff the panel\n");
> -		drm_panel_detach(dp->plat_data->panel);
>  	}
>  
>  	drm_dp_aux_unregister(&dp->aux);
> diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
> index 438e566ce0a4..d433902d97e5 100644
> --- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
> +++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
> @@ -265,9 +265,6 @@ static int ptn3460_bridge_attach(struct drm_bridge *bridge,
>  	drm_connector_attach_encoder(&ptn_bridge->connector,
>  							bridge->encoder);
>  
> -	if (ptn_bridge->panel)
> -		drm_panel_attach(ptn_bridge->panel, &ptn_bridge->connector);
> -
>  	drm_helper_hpd_irq_event(ptn_bridge->connector.dev);
>  
>  	return ret;
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> index 1e63ed6b18aa..0ddc37551194 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -82,18 +82,11 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
>  	drm_connector_attach_encoder(&panel_bridge->connector,
>  					  bridge->encoder);
>  
> -	ret = drm_panel_attach(panel_bridge->panel, &panel_bridge->connector);
> -	if (ret < 0)
> -		return ret;
> -
>  	return 0;
>  }
>  
>  static void panel_bridge_detach(struct drm_bridge *bridge)
>  {
> -	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
> -
> -	drm_panel_detach(panel_bridge->panel);
>  }
>  
>  static void panel_bridge_pre_enable(struct drm_bridge *bridge)
> diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bridge/parade-ps8622.c
> index d789ea2a7fb9..c13ec77d858b 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8622.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8622.c
> @@ -505,9 +505,6 @@ static int ps8622_attach(struct drm_bridge *bridge,
>  	drm_connector_attach_encoder(&ps8622->connector,
>  							bridge->encoder);
>  
> -	if (ps8622->panel)
> -		drm_panel_attach(ps8622->panel, &ps8622->connector);
> -
>  	drm_helper_hpd_irq_event(ps8622->connector.dev);
>  
>  	return ret;
> diff --git a/drivers/gpu/drm/bridge/tc358764.c b/drivers/gpu/drm/bridge/tc358764.c
> index 5ac1430fab04..c1e35bdf9232 100644
> --- a/drivers/gpu/drm/bridge/tc358764.c
> +++ b/drivers/gpu/drm/bridge/tc358764.c
> @@ -373,7 +373,6 @@ static int tc358764_attach(struct drm_bridge *bridge,
>  	drm_connector_helper_add(&ctx->connector,
>  				 &tc358764_connector_helper_funcs);
>  	drm_connector_attach_encoder(&ctx->connector, bridge->encoder);
> -	drm_panel_attach(ctx->panel, &ctx->connector);
>  	ctx->connector.funcs->reset(&ctx->connector);
>  	drm_connector_register(&ctx->connector);
>  
> @@ -385,7 +384,6 @@ static void tc358764_detach(struct drm_bridge *bridge)
>  	struct tc358764 *ctx = bridge_to_tc358764(bridge);
>  
>  	drm_connector_unregister(&ctx->connector);
> -	drm_panel_detach(ctx->panel);
>  	ctx->panel = NULL;
>  	drm_connector_put(&ctx->connector);
>  }
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index c2777b226c75..0746462ba0f6 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -1435,9 +1435,6 @@ static int tc_bridge_attach(struct drm_bridge *bridge,
>  					       DRM_CONNECTOR_POLL_DISCONNECT;
>  	}
>  
> -	if (tc->panel)
> -		drm_panel_attach(tc->panel, &tc->connector);
> -
>  	drm_display_info_set_bus_formats(&tc->connector.display_info,
>  					 &bus_format, 1);
>  	tc->connector.display_info.bus_flags =
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> index 86b9f0f87a14..454544e0da7d 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -394,9 +394,6 @@ static int ti_sn_bridge_attach(struct drm_bridge *bridge,
>  	}
>  	pdata->dsi = dsi;
>  
> -	/* attach panel to bridge */
> -	drm_panel_attach(pdata->panel, &pdata->connector);
> -
>  	return 0;
>  
>  err_dsi_attach:
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index 8c7bac85a793..7804b9947fe8 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -97,42 +97,6 @@ void drm_panel_remove(struct drm_panel *panel)
>  }
>  EXPORT_SYMBOL(drm_panel_remove);
>  
> -/**
> - * drm_panel_attach - attach a panel to a connector
> - * @panel: DRM panel
> - * @connector: DRM connector
> - *
> - * After obtaining a pointer to a DRM panel a display driver calls this
> - * function to attach a panel to a connector.
> - *
> - * An error is returned if the panel is already attached to another connector.
> - *
> - * When unloading, the driver should detach from the panel by calling
> - * drm_panel_detach().
> - *
> - * Return: 0 on success or a negative error code on failure.
> - */
> -int drm_panel_attach(struct drm_panel *panel, struct drm_connector *connector)
> -{
> -	return 0;
> -}
> -EXPORT_SYMBOL(drm_panel_attach);
> -
> -/**
> - * drm_panel_detach - detach a panel from a connector
> - * @panel: DRM panel
> - *
> - * Detaches a panel from the connector it is attached to. If a panel is not
> - * attached to any connector this is effectively a no-op.
> - *
> - * This function should not be called by the panel device itself. It
> - * is only for the drm device that called drm_panel_attach().
> - */
> -void drm_panel_detach(struct drm_panel *panel)
> -{
> -}
> -EXPORT_SYMBOL(drm_panel_detach);
> -
>  /**
>   * drm_panel_prepare - power on a panel
>   * @panel: DRM panel
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dpi.c b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
> index 7ba5354e7d94..5f5ba64fc1ff 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dpi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
> @@ -44,9 +44,6 @@ exynos_dpi_detect(struct drm_connector *connector, bool force)
>  {
>  	struct exynos_dpi *ctx = connector_to_dpi(connector);
>  
> -	if (ctx->panel)
> -		drm_panel_attach(ctx->panel, &ctx->connector);
> -
>  	return connector_status_connected;
>  }
>  
> @@ -249,8 +246,5 @@ int exynos_dpi_remove(struct drm_encoder *encoder)
>  
>  	exynos_dpi_disable(&ctx->encoder);
>  
> -	if (ctx->panel)
> -		drm_panel_detach(ctx->panel);
> -
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> index 7a6f6df5e954..843dfcefc46a 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> @@ -1551,12 +1551,10 @@ static int exynos_dsi_host_attach(struct mipi_dsi_host *host,
>  		}
>  
>  		dsi->panel = of_drm_find_panel(device->dev.of_node);
> -		if (IS_ERR(dsi->panel)) {
> +		if (IS_ERR(dsi->panel))
>  			dsi->panel = NULL;
> -		} else {
> -			drm_panel_attach(dsi->panel, &dsi->connector);
> +		else
>  			dsi->connector.status = connector_status_connected;
> -		}
>  	}
>  
>  	/*
> @@ -1596,7 +1594,6 @@ static int exynos_dsi_host_detach(struct mipi_dsi_host *host,
>  	if (dsi->panel) {
>  		mutex_lock(&drm->mode_config.mutex);
>  		exynos_dsi_disable(&dsi->encoder);
> -		drm_panel_detach(dsi->panel);
>  		dsi->panel = NULL;
>  		dsi->connector.status = connector_status_disconnected;
>  		mutex_unlock(&drm->mode_config.mutex);
> diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
> index 9b0c4736c21a..0a7071827533 100644
> --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
> +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
> @@ -43,7 +43,6 @@ static void fsl_dcu_drm_connector_destroy(struct drm_connector *connector)
>  	struct fsl_dcu_drm_connector *fsl_con = to_fsl_dcu_connector(connector);
>  
>  	drm_connector_unregister(connector);
> -	drm_panel_detach(fsl_con->panel);
>  	drm_connector_cleanup(connector);
>  }
>  
> @@ -101,12 +100,6 @@ static int fsl_dcu_attach_panel(struct fsl_dcu_drm_device *fsl_dev,
>  	if (ret < 0)
>  		goto err_sysfs;
>  
> -	ret = drm_panel_attach(panel, connector);
> -	if (ret) {
> -		dev_err(fsl_dev->dev, "failed to attach panel\n");
> -		goto err_sysfs;
> -	}
> -
>  	return 0;
>  
>  err_sysfs:
> diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ldb.c
> index 8791d60be92e..af757d1e21fe 100644
> --- a/drivers/gpu/drm/imx/imx-ldb.c
> +++ b/drivers/gpu/drm/imx/imx-ldb.c
> @@ -455,13 +455,6 @@ static int imx_ldb_register(struct drm_device *drm,
>  		drm_connector_attach_encoder(&imx_ldb_ch->connector, encoder);
>  	}
>  
> -	if (imx_ldb_ch->panel) {
> -		ret = drm_panel_attach(imx_ldb_ch->panel,
> -				       &imx_ldb_ch->connector);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	return 0;
>  }
>  
> @@ -702,9 +695,6 @@ static void imx_ldb_unbind(struct device *dev, struct device *master,
>  	for (i = 0; i < 2; i++) {
>  		struct imx_ldb_channel *channel = &imx_ldb->channel[i];
>  
> -		if (channel->panel)
> -			drm_panel_detach(channel->panel);
> -
>  		kfree(channel->edid);
>  		i2c_put_adapter(channel->ddc);
>  	}
> diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
> index a831b5bd1613..8232f512b9ed 100644
> --- a/drivers/gpu/drm/imx/parallel-display.c
> +++ b/drivers/gpu/drm/imx/parallel-display.c
> @@ -289,9 +289,6 @@ static int imx_pd_register(struct drm_device *drm,
>  				   DRM_MODE_CONNECTOR_DPI);
>  	}
>  
> -	if (imxpd->panel)
> -		drm_panel_attach(imxpd->panel, &imxpd->connector);
> -
>  	if (imxpd->next_bridge) {
>  		ret = drm_bridge_attach(encoder, imxpd->next_bridge,
>  					&imxpd->bridge, 0);
> @@ -357,9 +354,6 @@ static void imx_pd_unbind(struct device *dev, struct device *master,
>  {
>  	struct imx_parallel_display *imxpd = dev_get_drvdata(dev);
>  
> -	if (imxpd->panel)
> -		drm_panel_detach(imxpd->panel);
> -
>  	kfree(imxpd->edid);
>  }
>  
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c
> index c7df71e2fafc..7288041dd86a 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_lvds_connector.c
> @@ -50,14 +50,9 @@ static int mdp4_lvds_connector_get_modes(struct drm_connector *connector)
>  	struct drm_panel *panel = mdp4_lvds_connector->panel;
>  	int ret = 0;
>  
> -	if (panel) {
> -		drm_panel_attach(panel, connector);
> -
> +	if (panel)
>  		ret = drm_panel_get_modes(panel, connector);
>  
> -		drm_panel_detach(panel);
> -	}
> -
>  	return ret;
>  }
>  
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> index 4b363bd7ddff..1d28dfba2c9b 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
> @@ -328,7 +328,6 @@ static int dsi_mgr_connector_get_modes(struct drm_connector *connector)
>  	 * In dual DSI mode, we have one connector that can be
>  	 * attached to the drm_panel.
>  	 */
> -	drm_panel_attach(panel, connector);
>  	num = drm_panel_get_modes(panel, connector);
>  	if (!num)
>  		return 0;
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 508764fccd27..51da0e3de587 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -265,11 +265,7 @@ static int mxsfb_load(struct drm_device *drm)
>  	 */
>  
>  	if (mxsfb->panel) {
> -		ret = drm_panel_attach(mxsfb->panel, mxsfb->connector);
> -		if (ret) {
> -			dev_err(drm->dev, "Cannot connect panel: %d\n", ret);
> -			goto err_vblank;
> -		}
> +		;
>  	} else if (mxsfb->bridge) {
>  		ret = drm_simple_display_pipe_attach_bridge(&mxsfb->pipe,
>  							    mxsfb->bridge);
> @@ -306,7 +302,6 @@ static int mxsfb_load(struct drm_device *drm)
>  	return 0;
>  
>  err_irq:
> -	drm_panel_detach(mxsfb->panel);
>  err_vblank:
>  	pm_runtime_disable(drm->dev);
>  
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_out.c b/drivers/gpu/drm/mxsfb/mxsfb_out.c
> index 9eca1605d11d..f93e7a4d4c15 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_out.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_out.c
> @@ -55,12 +55,6 @@ mxsfb_panel_connector_detect(struct drm_connector *connector, bool force)
>  
>  static void mxsfb_panel_connector_destroy(struct drm_connector *connector)
>  {
> -	struct mxsfb_drm_private *mxsfb =
> -			drm_connector_to_mxsfb_drm_private(connector);
> -
> -	if (mxsfb->panel)
> -		drm_panel_detach(mxsfb->panel);
> -
>  	drm_connector_unregister(connector);
>  	drm_connector_cleanup(connector);
>  }
> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
> index 4526967978b7..db8106afd91f 100644
> --- a/drivers/gpu/drm/omapdrm/omap_drv.c
> +++ b/drivers/gpu/drm/omapdrm/omap_drv.c
> @@ -349,13 +349,6 @@ static int omap_modeset_init(struct drm_device *dev)
>  
>  		drm_connector_attach_encoder(pipe->connector, encoder);
>  
> -		if (pipe->output->panel) {
> -			ret = drm_panel_attach(pipe->output->panel,
> -					       pipe->connector);
> -			if (ret < 0)
> -				return ret;
> -		}
> -
>  		crtc = omap_crtc_init(dev, pipe, priv->planes[i]);
>  		if (IS_ERR(crtc))
>  			return PTR_ERR(crtc);
> @@ -395,17 +388,9 @@ static int omap_modeset_init(struct drm_device *dev)
>  static void omap_modeset_fini(struct drm_device *ddev)
>  {
>  	struct omap_drm_private *priv = ddev->dev_private;
> -	unsigned int i;
>  
>  	omap_drm_irq_uninstall(ddev);
>  
> -	for (i = 0; i < priv->num_pipes; i++) {
> -		struct omap_drm_pipeline *pipe = &priv->pipes[i];
> -
> -		if (pipe->output->panel)
> -			drm_panel_detach(pipe->output->panel);
> -	}
> -
>  	drm_mode_config_cleanup(ddev);
>  }
>  
> diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
> index ab0d49618cf9..bced729a96fe 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
> @@ -677,15 +677,11 @@ static int rcar_lvds_attach(struct drm_bridge *bridge,
>  	if (ret < 0)
>  		return ret;
>  
> -	return drm_panel_attach(lvds->panel, connector);
> +	return 0;
>  }
>  
>  static void rcar_lvds_detach(struct drm_bridge *bridge)
>  {
> -	struct rcar_lvds *lvds = bridge_to_rcar_lvds(bridge);
> -
> -	if (lvds->panel)
> -		drm_panel_detach(lvds->panel);
>  }
>  
>  static const struct drm_bridge_funcs rcar_lvds_bridge_ops = {
> diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> index 63f967902c2d..f292c6a6e20f 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
> @@ -634,13 +634,6 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
>  				      "failed to attach encoder: %d\n", ret);
>  			goto err_free_connector;
>  		}
> -
> -		ret = drm_panel_attach(lvds->panel, connector);
> -		if (ret < 0) {
> -			DRM_DEV_ERROR(drm_dev->dev,
> -				      "failed to attach panel: %d\n", ret);
> -			goto err_free_connector;
> -		}
>  	} else {
>  		ret = drm_bridge_attach(encoder, lvds->bridge, NULL, 0);
>  		if (ret) {
> @@ -676,8 +669,6 @@ static void rockchip_lvds_unbind(struct device *dev, struct device *master,
>  
>  	encoder_funcs = lvds->soc_data->helper_funcs;
>  	encoder_funcs->disable(&lvds->encoder);
> -	if (lvds->panel)
> -		drm_panel_detach(lvds->panel);
>  	pm_runtime_disable(dev);
>  	drm_connector_cleanup(&lvds->connector);
>  	drm_encoder_cleanup(&lvds->encoder);
> diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
> index de4af7735c46..ddb4184f0726 100644
> --- a/drivers/gpu/drm/sti/sti_dvo.c
> +++ b/drivers/gpu/drm/sti/sti_dvo.c
> @@ -389,8 +389,6 @@ sti_dvo_connector_detect(struct drm_connector *connector, bool force)
>  		dvo->panel = of_drm_find_panel(dvo->panel_node);
>  		if (IS_ERR(dvo->panel))
>  			dvo->panel = NULL;
> -		else
> -			drm_panel_attach(dvo->panel, connector);
>  	}
>  
>  	if (dvo->panel)
> diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.c b/drivers/gpu/drm/sun4i/sun4i_lvds.c
> index ffda3184aa12..f8a1ff4bf1bb 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_lvds.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_lvds.c
> @@ -56,7 +56,6 @@ sun4i_lvds_connector_destroy(struct drm_connector *connector)
>  {
>  	struct sun4i_lvds *lvds = drm_connector_to_sun4i_lvds(connector);
>  
> -	drm_panel_detach(lvds->panel);
>  	drm_connector_cleanup(connector);
>  }
>  
> @@ -141,12 +140,6 @@ int sun4i_lvds_init(struct drm_device *drm, struct sun4i_tcon *tcon)
>  
>  		drm_connector_attach_encoder(&lvds->connector,
>  						  &lvds->encoder);
> -
> -		ret = drm_panel_attach(lvds->panel, &lvds->connector);
> -		if (ret) {
> -			dev_err(drm->dev, "Couldn't attach our panel\n");
> -			goto err_cleanup_connector;
> -		}
>  	}
>  
>  	if (bridge) {
> diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
> index 5a7d43939ae6..e08afdffef50 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
> @@ -147,7 +147,6 @@ sun4i_rgb_connector_destroy(struct drm_connector *connector)
>  {
>  	struct sun4i_rgb *rgb = drm_connector_to_sun4i_rgb(connector);
>  
> -	drm_panel_detach(rgb->panel);
>  	drm_connector_cleanup(connector);
>  }
>  
> @@ -233,12 +232,6 @@ int sun4i_rgb_init(struct drm_device *drm, struct sun4i_tcon *tcon)
>  
>  		drm_connector_attach_encoder(&rgb->connector,
>  						  &rgb->encoder);
> -
> -		ret = drm_panel_attach(rgb->panel, &rgb->connector);
> -		if (ret) {
> -			dev_err(drm->dev, "Couldn't attach our panel\n");
> -			goto err_cleanup_connector;
> -		}
>  	}
>  
>  	if (rgb->bridge) {
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index aa67cb037e9d..128471b65f64 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -973,7 +973,6 @@ static int sun6i_dsi_attach(struct mipi_dsi_host *host,
>  	dsi->panel = panel;
>  	dsi->device = device;
>  
> -	drm_panel_attach(dsi->panel, &dsi->connector);
>  	drm_kms_helper_hotplug_event(dsi->drm);
>  
>  	dev_info(host->dev, "Attached device %s\n", device->name);
> @@ -990,7 +989,6 @@ static int sun6i_dsi_detach(struct mipi_dsi_host *host,
>  	dsi->panel = NULL;
>  	dsi->device = NULL;
>  
> -	drm_panel_detach(panel);
>  	drm_kms_helper_hotplug_event(dsi->drm);
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
> index 3820e8dff14b..3387de79718b 100644
> --- a/drivers/gpu/drm/tegra/dsi.c
> +++ b/drivers/gpu/drm/tegra/dsi.c
> @@ -1498,10 +1498,8 @@ static int tegra_dsi_host_attach(struct mipi_dsi_host *host,
>  		if (IS_ERR(output->panel))
>  			output->panel = NULL;
>  
> -		if (output->panel && output->connector.dev) {
> -			drm_panel_attach(output->panel, &output->connector);
> +		if (output->panel && output->connector.dev)
>  			drm_helper_hpd_irq_event(output->connector.dev);
> -		}
>  	}
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/output.c
> index e36e5e7c2f69..a3adb9e4debf 100644
> --- a/drivers/gpu/drm/tegra/output.c
> +++ b/drivers/gpu/drm/tegra/output.c
> @@ -179,13 +179,6 @@ void tegra_output_remove(struct tegra_output *output)
>  int tegra_output_init(struct drm_device *drm, struct tegra_output *output)
>  {
>  	int connector_type;
> -	int err;
> -
> -	if (output->panel) {
> -		err = drm_panel_attach(output->panel, &output->connector);
> -		if (err < 0)
> -			return err;
> -	}
>  
>  	/*
>  	 * The connector is now registered and ready to receive hotplug events
> @@ -220,9 +213,6 @@ void tegra_output_exit(struct tegra_output *output)
>  	 */
>  	if (output->hpd_gpio)
>  		disable_irq(output->hpd_irq);
> -
> -	if (output->panel)
> -		drm_panel_detach(output->panel);
>  }
>  
>  void tegra_output_find_possible_crtcs(struct tegra_output *output,
> diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> index 6193cb555acc..9b374f88fb76 100644
> --- a/include/drm/drm_panel.h
> +++ b/include/drm/drm_panel.h
> @@ -178,9 +178,6 @@ void drm_panel_init(struct drm_panel *panel, struct device *dev,
>  int drm_panel_add(struct drm_panel *panel);
>  void drm_panel_remove(struct drm_panel *panel);
>  
> -int drm_panel_attach(struct drm_panel *panel, struct drm_connector *connector);
> -void drm_panel_detach(struct drm_panel *panel);
> -
>  int drm_panel_prepare(struct drm_panel *panel);
>  int drm_panel_unprepare(struct drm_panel *panel);
>  
