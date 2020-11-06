Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C882A8E4E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 05:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgKFE0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 23:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKFE0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 23:26:55 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5406CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 20:26:55 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 82AC4B16;
        Fri,  6 Nov 2020 05:26:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1604636811;
        bh=Dzy4k7oMrh6Qwr0FibbNWC+4whZQko79sRwDL+YBC5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hp7cQ1Cyu0ma0fKXMBujwp0zP6HjHtC7x3tNfOHBazC+xC9z/qrPFCj03UALtowE0
         YQFP6oDJeY2jNiR1yNJ9Rr1VpM8K6Ry4DNagPN4Gsii0WTEv4uxlhaW/kA5PINLsWF
         H1LLmCc5JSyKR4PwbePZZZUW/cKHHYt0wyziJNEQ=
Date:   Fri, 6 Nov 2020 06:26:50 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 08/19] gpu: drm: omapdrm: dss: dsi: Rework and remove a
 few unused variables
Message-ID: <20201106042650.GA16469@pendragon.ideasonboard.com>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105144517.1826692-9-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201105144517.1826692-9-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Thank you for the patch.

On Thu, Nov 05, 2020 at 02:45:06PM +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/omapdrm/dss/dsi.c: In function ‘_dsi_print_reset_status’:
>  drivers/gpu/drm/omapdrm/dss/dsi.c:1131:6: warning: variable ‘l’ set but not used [-Wunused-but-set-variable]
>  drivers/gpu/drm/omapdrm/dss/dsi.c: In function ‘dsi_update’:
>  drivers/gpu/drm/omapdrm/dss/dsi.c:3943:10: warning: variable ‘dh’ set but not used [-Wunused-but-set-variable]
>  drivers/gpu/drm/omapdrm/dss/dsi.c:3943:6: warning: variable ‘dw’ set but not used [-Wunused-but-set-variable]
> 
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/omapdrm/dss/dsi.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> index eeccf40bae416..5929b320b3cfa 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -1128,13 +1128,12 @@ static void dsi_runtime_put(struct dsi_data *dsi)
>  
>  static void _dsi_print_reset_status(struct dsi_data *dsi)
>  {
> -	u32 l;
>  	int b0, b1, b2;
>  
>  	/* A dummy read using the SCP interface to any DSIPHY register is
>  	 * required after DSIPHY reset to complete the reset of the DSI complex
>  	 * I/O. */
> -	l = dsi_read_reg(dsi, DSI_DSIPHY_CFG5);
> +	dsi_read_reg(dsi, DSI_DSIPHY_CFG5);
>  
>  	if (dsi->data->quirks & DSI_QUIRK_REVERSE_TXCLKESC) {
>  		b0 = 28;
> @@ -3940,7 +3939,6 @@ static int dsi_update(struct omap_dss_device *dssdev, int channel,
>  		void (*callback)(int, void *), void *data)
>  {
>  	struct dsi_data *dsi = to_dsi_data(dssdev);
> -	u16 dw, dh;
>  
>  	dsi_perf_mark_setup(dsi);
>  
> @@ -3949,11 +3947,8 @@ static int dsi_update(struct omap_dss_device *dssdev, int channel,
>  	dsi->framedone_callback = callback;
>  	dsi->framedone_data = data;
>  
> -	dw = dsi->vm.hactive;
> -	dh = dsi->vm.vactive;
> -
>  #ifdef DSI_PERF_MEASURE
> -	dsi->update_bytes = dw * dh *
> +	dsi->update_bytes = dsi->vm.hactive * dsi->vm.vactive *
>  		dsi_get_pixel_size(dsi->pix_fmt) / 8;
>  #endif
>  	dsi_update_screen_dispc(dsi);

-- 
Regards,

Laurent Pinchart
