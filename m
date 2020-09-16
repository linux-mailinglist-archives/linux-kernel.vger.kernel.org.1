Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1511126C0DC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 11:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgIPJlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 05:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgIPJlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 05:41:12 -0400
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFB4C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 02:41:11 -0700 (PDT)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 9E76A5C1831;
        Wed, 16 Sep 2020 11:41:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1600249267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8rHy8vdkEo72E7HSOmCsMx7Z/WPlGosnFRGYVLBt0W8=;
        b=lo8s4de7bPmN7TTDClL5Q+6U32mjTHTMNUdP1Z8Ed//9z32RmClr34Wphejz7rWt6fhjaQ
        xbnrNfcNihTHPkUMIebTrEb547uPWNlGAZcKy2Bq5nkKp8YqrSamCN38z0911S0yplIb8z
        dH34YOSbrlY/VN4SR0GeYH6dgOu9uEw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Wed, 16 Sep 2020 11:41:07 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     marex@denx.de, stefan@agner.ch
Cc:     laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        daniel@ffwll.ch, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, tomi.valkeinen@ti.com,
        linux-imx@nxp.com, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm: mxsfb: check framebuffer pitch
In-Reply-To: <20200908141654.266836-1-stefan@agner.ch>
References: <20200908141654.266836-1-stefan@agner.ch>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <8d70f07a68b9dc199715ba897e093331@agner.ch>
X-Sender: stefan@agner.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-08 16:16, Stefan Agner wrote:
> The lcdif IP does not support a framebuffer pitch (stride) other than
> framebuffer width. Check for equality and reject the framebuffer
> otherwise.
> 
> This prevents a distorted picture when using 640x800 and running the
> Mesa graphics stack. Mesa tries to use a cache aligned stride, which
> leads at that particular resolution to width != stride. Currently
> Mesa has no fallback behavior, but rejecting this configuration allows
> userspace to handle the issue correctly.
> 
> Fixes: 45d59d704080 ("drm: Add new driver for MXSFB controller")
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Applied to drm-misc-next.

--
Stefan

> ---
> Changes in v3:
> - Fix typo in commit message
> - Add fixes tag
> 
> Changes in v2:
> - Validate pitch in fb_create callback
> 
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 8c549c3931af..35122aef037b 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -21,6 +21,7 @@
>  #include <drm/drm_connector.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_fb_helper.h>
> +#include <drm/drm_fourcc.h>
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_irq.h>
> @@ -81,8 +82,26 @@ void mxsfb_disable_axi_clk(struct mxsfb_drm_private *mxsfb)
>  		clk_disable_unprepare(mxsfb->clk_axi);
>  }
>  
> +static struct drm_framebuffer *
> +mxsfb_fb_create(struct drm_device *dev, struct drm_file *file_priv,
> +		const struct drm_mode_fb_cmd2 *mode_cmd)
> +{
> +	const struct drm_format_info *info;
> +
> +	info = drm_get_format_info(dev, mode_cmd);
> +	if (!info)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (mode_cmd->width * info->cpp[0] != mode_cmd->pitches[0]) {
> +		dev_dbg(dev->dev, "Invalid pitch: fb width must match pitch\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return drm_gem_fb_create(dev, file_priv, mode_cmd);
> +}
> +
>  static const struct drm_mode_config_funcs mxsfb_mode_config_funcs = {
> -	.fb_create		= drm_gem_fb_create,
> +	.fb_create		= mxsfb_fb_create,
>  	.atomic_check		= drm_atomic_helper_check,
>  	.atomic_commit		= drm_atomic_helper_commit,
>  };
