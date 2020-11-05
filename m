Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1855D2A86E7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 20:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731880AbgKETRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 14:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgKETRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 14:17:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C7DC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 11:17:33 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1kaklE-0000Lw-MI; Thu, 05 Nov 2020 20:17:28 +0100
Subject: Re: [PATCH 03/19] gpu: drm: imx: ipuv3-plane: Mark 'crtc_state' as
 __always_unused
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105144517.1826692-4-lee.jones@linaro.org>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <15a4a184-74c2-e630-193a-cdea61545a03@pengutronix.de>
Date:   Thu, 5 Nov 2020 20:17:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105144517.1826692-4-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lee,

On 11/5/20 3:45 PM, Lee Jones wrote:
> In the macro for_each_oldnew_crtc_in_state() 'crtc_state' is provided
> as a container for state->crtcs[i].new_state, but is not utilised in
> this use-case.  We cannot simply delete the variable, so here we tell
> the compiler that we're intentionally discarding the read value.

for_each_oldnew_crtc_in_state already (void) casts the drm_crtc and the old
drm_crtc_state to silence unused-but-set-variable warning. Should we maybe
(void) cast the new crtc_state as well?

Cheers
Ahmad

> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/imx/ipuv3-plane.c: In function ‘ipu_planes_assign_pre’:
>  drivers/gpu/drm/imx/ipuv3-plane.c:746:42: warning: variable ‘crtc_state’ set but not used [-Wunused-but-set-variable]
> 
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/imx/ipuv3-plane.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/imx/ipuv3-plane.c b/drivers/gpu/drm/imx/ipuv3-plane.c
> index 8a4235d9d9f1e..acc0a3ce4992f 100644
> --- a/drivers/gpu/drm/imx/ipuv3-plane.c
> +++ b/drivers/gpu/drm/imx/ipuv3-plane.c
> @@ -743,7 +743,7 @@ bool ipu_plane_atomic_update_pending(struct drm_plane *plane)
>  int ipu_planes_assign_pre(struct drm_device *dev,
>  			  struct drm_atomic_state *state)
>  {
> -	struct drm_crtc_state *old_crtc_state, *crtc_state;
> +	struct drm_crtc_state *old_crtc_state, __always_unused *crtc_state;
>  	struct drm_plane_state *plane_state;
>  	struct ipu_plane_state *ipu_state;
>  	struct ipu_plane *ipu_plane;
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
