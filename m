Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FBB27873B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 14:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgIYM3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 08:29:30 -0400
Received: from crapouillou.net ([89.234.176.41]:35888 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727248AbgIYM3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 08:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1601036965; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=coxUdSb0RLs0Q7iFvmQrRhsxAjTfXODm69Rc6NSxIqU=;
        b=h4y7kE3HPDHSFEY9qs/N1726Gzt3yVX+o1+e3CkwTi2jH1EhYqHZwAZ4K+CfC9++3fllY1
        p7OYe62zCifHFXNWFo1bzYCLCK5ueE3ZWev4nHqZtkIgO3uoF0Cjd1HS+qn4jar8Gb8OG2
        KXY8v4+XY0W9zQk8YuiaIZlb+k2bdqg=
Date:   Fri, 25 Sep 2020 14:29:12 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 2/3] drm/ingenic: Reset pixclock rate when parent
 =?UTF-8?Q?clock=0D=0A?= rate changes
To:     Sam Ravnborg <sam@ravnborg.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Message-Id: <O0S7HQ.34QHSNHJ7JWJ2@crapouillou.net>
In-Reply-To: <20200924202237.GJ1223313@ravnborg.org>
References: <20200915123818.13272-1-paul@crapouillou.net>
        <20200915123818.13272-3-paul@crapouillou.net>
        <20200924202237.GJ1223313@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Le jeu. 24 sept. 2020 =E0 22:22, Sam Ravnborg <sam@ravnborg.org> a=20
=E9crit :
> Hi Paul.
>=20
> On Tue, Sep 15, 2020 at 02:38:17PM +0200, Paul Cercueil wrote:
>>  Old Ingenic SoCs can overclock very well, up to +50% of their=20
>> nominal
>>  clock rate, whithout requiring overvolting or anything like that,=20
>> just
>>  by changing the rate of the main PLL. Unfortunately, all clocks on=20
>> the
>>  system are derived from that PLL, and when the PLL rate is updated,=20
>> so
>>  is our pixel clock.
>>=20
>>  To counter that issue, we make sure that the panel is in VBLANK=20
>> before
>>  the rate change happens, and we will then re-set the pixel clock=20
>> rate
>>  afterwards, once the PLL has been changed, to be as close as=20
>> possible to
>>  the pixel rate requested by the encoder.
>>=20
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 49=20
>> ++++++++++++++++++++++-
>>   1 file changed, 48 insertions(+), 1 deletion(-)
>>=20
>>  diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c=20
>> b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>>  index fb62869befdc..aa32660033d2 100644
>>  --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>>  +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
>>  @@ -12,6 +12,7 @@
>>   #include <linux/dma-noncoherent.h>
>>   #include <linux/io.h>
>>   #include <linux/module.h>
>>  +#include <linux/mutex.h>
>>   #include <linux/of_device.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/regmap.h>
>>  @@ -73,6 +74,9 @@ struct ingenic_drm {
>>=20
>>   	bool panel_is_sharp;
>>   	bool no_vblank;
>>  +	bool update_clk_rate;
>>  +	struct mutex clk_mutex;
> Please add comment about what the mutex protects.
> Especially since the mutex is locked and unlocked based on a
> notification.
>=20
> With the comment added:
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
>=20
>>  +	struct notifier_block clock_nb;
>>   };
>>=20
>>   static bool ingenic_drm_cached_gem_buf;
>>  @@ -115,6 +119,29 @@ static inline struct ingenic_drm=20
>> *drm_crtc_get_priv(struct drm_crtc *crtc)
>>   	return container_of(crtc, struct ingenic_drm, crtc);
>>   }
>>=20
>>  +static inline struct ingenic_drm *drm_nb_get_priv(struct=20
>> notifier_block *nb)
>>  +{
>>  +	return container_of(nb, struct ingenic_drm, clock_nb);
>>  +}
>>  +
>>  +static int ingenic_drm_update_pixclk(struct notifier_block *nb,
>>  +				     unsigned long action,
>>  +				     void *data)
>>  +{
>>  +	struct ingenic_drm *priv =3D drm_nb_get_priv(nb);
>>  +
>>  +	switch (action) {
>>  +	case PRE_RATE_CHANGE:
>>  +		mutex_lock(&priv->clk_mutex);
>>  +		priv->update_clk_rate =3D true;
>>  +		drm_crtc_wait_one_vblank(&priv->crtc);
>>  +		return NOTIFY_OK;
>>  +	default:
>>  +		mutex_unlock(&priv->clk_mutex);
> Any risk the POST_RATE_CHANGE or ABORT_RATE_CHANGE may go missing so=20
> we
> fail to unlock the mutex?
> I think not but wanted to make sure you had thought about it.

My assumption was that you always get POST_RATE_CHANGE or=20
ABORT_RATE_CHANGE. But I am not 100% sure about that.

Michael, Stephen: is it safe to assume that I will always get notified=20
with POST_RATE_CHANGE or ABORT_RATE_CHANGE, after I got notified with=20
PRE_RATE_CHANGE?

Thanks,
-Paul

>>  +		return NOTIFY_OK;
>>  +	}
>>  +}
>>  +
>>   static void ingenic_drm_crtc_atomic_enable(struct drm_crtc *crtc,
>>   					   struct drm_crtc_state *state)
>>   {
>>  @@ -280,8 +307,14 @@ static void=20
>> ingenic_drm_crtc_atomic_flush(struct drm_crtc *crtc,
>>=20
>>   	if (drm_atomic_crtc_needs_modeset(state)) {
>>   		ingenic_drm_crtc_update_timings(priv, &state->mode);
>>  +		priv->update_clk_rate =3D true;
>>  +	}
>>=20
>>  +	if (priv->update_clk_rate) {
>>  +		mutex_lock(&priv->clk_mutex);
>>   		clk_set_rate(priv->pix_clk, state->adjusted_mode.clock * 1000);
>>  +		priv->update_clk_rate =3D false;
>>  +		mutex_unlock(&priv->clk_mutex);
>>   	}
>>=20
>>   	if (event) {
>>  @@ -1046,16 +1079,28 @@ static int ingenic_drm_bind(struct device=20
>> *dev, bool has_components)
>>   	if (soc_info->has_osd)
>>   		regmap_write(priv->map, JZ_REG_LCD_OSDC, JZ_LCD_OSDC_OSDEN);
>>=20
>>  +	mutex_init(&priv->clk_mutex);
>>  +	priv->clock_nb.notifier_call =3D ingenic_drm_update_pixclk;
>>  +
>>  +	parent_clk =3D clk_get_parent(priv->pix_clk);
>>  +	ret =3D clk_notifier_register(parent_clk, &priv->clock_nb);
>>  +	if (ret) {
>>  +		dev_err(dev, "Unable to register clock notifier\n");
>>  +		goto err_devclk_disable;
>>  +	}
>>  +
>>   	ret =3D drm_dev_register(drm, 0);
>>   	if (ret) {
>>   		dev_err(dev, "Failed to register DRM driver\n");
>>  -		goto err_devclk_disable;
>>  +		goto err_clk_notifier_unregister;
>>   	}
>>=20
>>   	drm_fbdev_generic_setup(drm, 32);
>>=20
>>   	return 0;
>>=20
>>  +err_clk_notifier_unregister:
>>  +	clk_notifier_unregister(parent_clk, &priv->clock_nb);
>>   err_devclk_disable:
>>   	if (priv->lcd_clk)
>>   		clk_disable_unprepare(priv->lcd_clk);
>>  @@ -1077,7 +1122,9 @@ static int compare_of(struct device *dev,=20
>> void *data)
>>   static void ingenic_drm_unbind(struct device *dev)
>>   {
>>   	struct ingenic_drm *priv =3D dev_get_drvdata(dev);
>>  +	struct clk *parent_clk =3D clk_get_parent(priv->pix_clk);
>>=20
>>  +	clk_notifier_unregister(parent_clk, &priv->clock_nb);
>>   	if (priv->lcd_clk)
>>   		clk_disable_unprepare(priv->lcd_clk);
>>   	clk_disable_unprepare(priv->pix_clk);
>>  --
>>  2.28.0


