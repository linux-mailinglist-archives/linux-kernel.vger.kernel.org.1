Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0272CFE15
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 20:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgLETP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 14:15:58 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:53550 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgLETPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 14:15:53 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 44A8A804C8;
        Sat,  5 Dec 2020 20:15:04 +0100 (CET)
Date:   Sat, 5 Dec 2020 20:15:02 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/2] drm: panel: add Khadas TS050 panel driver
Message-ID: <20201205191502.GB332836@ravnborg.org>
References: <20201204081949.38418-1-narmstrong@baylibre.com>
 <20201204081949.38418-3-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204081949.38418-3-narmstrong@baylibre.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Itgwjo3g c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=-T1gHi2C1pDd2DPyCjwA:9
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

> +
> +static int khadas_ts050_panel_probe(struct mipi_dsi_device *dsi)
> +{
> +	struct khadas_ts050_panel *khadas_ts050;
> +	int err;
> +
> +	dsi->lanes = 4;
> +	dsi->format = MIPI_DSI_FMT_RGB888;
> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
> +			  MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_EOT_PACKET;
> +
> +	khadas_ts050 = devm_kzalloc(&dsi->dev, sizeof(*khadas_ts050),
> +				    GFP_KERNEL);
> +	if (!khadas_ts050)
> +		return -ENOMEM;
> +
> +	mipi_dsi_set_drvdata(dsi, khadas_ts050);
> +	khadas_ts050->link = dsi;
> +
> +	err = khadas_ts050_panel_add(khadas_ts050);
> +	if (err < 0)
> +		return err;
> +
> +	return mipi_dsi_attach(dsi);
> +}

If mipi_dsi_attach() failes then da a drm_panel_remove() like this:

	ret = mipi_dsi_attach(dsi);
	if (ret)
		drm_panel_remove(&khadas_ts050->base);

	return ret;

This is again something several panels gets wrong.

With this fixed:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

I assume you will fix it while applying.

	Sam
