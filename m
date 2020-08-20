Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFD524C298
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 17:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgHTPyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 11:54:03 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:48522 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728549AbgHTPyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:54:01 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id CEB0C8050D;
        Thu, 20 Aug 2020 17:53:58 +0200 (CEST)
Date:   Thu, 20 Aug 2020 17:53:57 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/panel: novatek,nt39016: Remove 'dev' field in
 priv struct
Message-ID: <20200820155357.GB194134@ravnborg.org>
References: <20200820121256.32037-1-paul@crapouillou.net>
 <20200820121256.32037-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820121256.32037-3-paul@crapouillou.net>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=aP3eV41m c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=ER_8r6IbAAAA:8 a=7gkXJVJtAAAA:8
        a=uqUkV8MoBaGHgs4G9lkA:9 a=CjuIK1q_8ugA:10 a=9LHmKk7ezEChjTCyhBa9:22
        a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 02:12:56PM +0200, Paul Cercueil wrote:
> There is already a 'struct device' pointer in the drm_panel structure,
> that we can access easily from our priv structure, so there's no need
> for a separate 'dev' field there.
> 
> v2: Don't initialize drm_panel->dev manually, it is done by
> drm_panel_init().
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/gpu/drm/panel/panel-novatek-nt39016.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt39016.c b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
> index daa583030246..f8151fe3ac9a 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt39016.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
> @@ -56,7 +56,6 @@ struct nt39016_panel_info {
>  
>  struct nt39016 {
>  	struct drm_panel drm_panel;
> -	struct device *dev;
>  	struct regmap *map;
>  	struct regulator *supply;
>  	const struct nt39016_panel_info *panel_info;
> @@ -124,7 +123,7 @@ static int nt39016_prepare(struct drm_panel *drm_panel)
>  
>  	err = regulator_enable(panel->supply);
>  	if (err) {
> -		dev_err(panel->dev, "Failed to enable power supply: %d\n", err);
> +		dev_err(drm_panel->dev, "Failed to enable power supply: %d\n", err);
>  		return err;
>  	}
>  
> @@ -143,7 +142,7 @@ static int nt39016_prepare(struct drm_panel *drm_panel)
>  	err = regmap_multi_reg_write(panel->map, nt39016_panel_regs,
>  				     ARRAY_SIZE(nt39016_panel_regs));
>  	if (err) {
> -		dev_err(panel->dev, "Failed to init registers: %d\n", err);
> +		dev_err(drm_panel->dev, "Failed to init registers: %d\n", err);
>  		goto err_disable_regulator;
>  	}
>  
> @@ -173,7 +172,7 @@ static int nt39016_enable(struct drm_panel *drm_panel)
>  	ret = regmap_write(panel->map, NT39016_REG_SYSTEM,
>  			   NT39016_SYSTEM_RESET_N | NT39016_SYSTEM_STANDBY);
>  	if (ret) {
> -		dev_err(panel->dev, "Unable to enable panel: %d\n", ret);
> +		dev_err(drm_panel->dev, "Unable to enable panel: %d\n", ret);
>  		return ret;
>  	}
>  
> @@ -193,7 +192,7 @@ static int nt39016_disable(struct drm_panel *drm_panel)
>  	err = regmap_write(panel->map, NT39016_REG_SYSTEM,
>  			   NT39016_SYSTEM_RESET_N);
>  	if (err) {
> -		dev_err(panel->dev, "Unable to disable panel: %d\n", err);
> +		dev_err(drm_panel->dev, "Unable to disable panel: %d\n", err);
>  		return err;
>  	}
>  
> @@ -252,7 +251,6 @@ static int nt39016_probe(struct spi_device *spi)
>  	if (!panel)
>  		return -ENOMEM;
>  
> -	panel->dev = dev;
>  	spi_set_drvdata(spi, panel);
>  
>  	panel->panel_info = of_device_get_match_data(dev);
> -- 
> 2.28.0
