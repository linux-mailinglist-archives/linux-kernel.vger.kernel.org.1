Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7952CD656
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 14:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgLCNDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 08:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgLCNDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 08:03:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3CBC061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 05:02:35 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kkoF2-0007dQ-F6; Thu, 03 Dec 2020 14:01:48 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kkoEv-0008ME-Ca; Thu, 03 Dec 2020 14:01:41 +0100
Date:   Thu, 3 Dec 2020 14:01:41 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, Eric Anholt <eric@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh@kernel.org>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] amba: Make the remove callback return void
Message-ID: <20201203130141.ys2s7aaltyzkdena@pengutronix.de>
References: <20201124133139.3072124-1-uwe@kleine-koenig.org>
 <20201124133139.3072124-5-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zevifqbsc3drtqwh"
Content-Disposition: inline
In-Reply-To: <20201124133139.3072124-5-uwe@kleine-koenig.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zevifqbsc3drtqwh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[This is a resend because somehow my MUA failed to parse the To: list
and dropped it without me noticing it. Sorry to those who got it twice
now.]

On Tue, Nov 24, 2020 at 02:31:38PM +0100, Uwe Kleine-K=F6nig wrote:
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> All amba drivers return 0 in their remove callback. Together with the
> driver core ignoring the return value anyhow, it doesn't make sense to
> return a value here.
>=20
> Change the remove prototype to return void, which makes it explicit that
> returning an error value doesn't work as expected. This simplifies changi=
ng
> the core remove callback to return void, too.
>=20
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/amba/bus.c                                 | 5 ++---
>  drivers/char/hw_random/nomadik-rng.c               | 3 +--
>  drivers/dma/pl330.c                                | 3 +--
>  drivers/gpu/drm/pl111/pl111_drv.c                  | 4 +---
>  drivers/hwtracing/coresight/coresight-catu.c       | 3 +--
>  drivers/hwtracing/coresight/coresight-cpu-debug.c  | 4 +---
>  drivers/hwtracing/coresight/coresight-cti-core.c   | 4 +---
>  drivers/hwtracing/coresight/coresight-etb10.c      | 4 +---
>  drivers/hwtracing/coresight/coresight-etm3x-core.c | 4 +---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 4 +---
>  drivers/hwtracing/coresight/coresight-funnel.c     | 4 ++--
>  drivers/hwtracing/coresight/coresight-replicator.c | 4 ++--
>  drivers/hwtracing/coresight/coresight-stm.c        | 4 +---
>  drivers/hwtracing/coresight/coresight-tmc-core.c   | 4 +---
>  drivers/hwtracing/coresight/coresight-tpiu.c       | 4 +---
>  drivers/i2c/busses/i2c-nomadik.c                   | 4 +---
>  drivers/input/serio/ambakmi.c                      | 3 +--
>  drivers/memory/pl172.c                             | 4 +---
>  drivers/memory/pl353-smc.c                         | 4 +---
>  drivers/mmc/host/mmci.c                            | 4 +---
>  drivers/rtc/rtc-pl030.c                            | 4 +---
>  drivers/rtc/rtc-pl031.c                            | 4 +---
>  drivers/spi/spi-pl022.c                            | 5 ++---
>  drivers/tty/serial/amba-pl010.c                    | 4 +---
>  drivers/tty/serial/amba-pl011.c                    | 3 +--
>  drivers/vfio/platform/vfio_amba.c                  | 3 +--
>  drivers/video/fbdev/amba-clcd.c                    | 4 +---
>  drivers/watchdog/sp805_wdt.c                       | 4 +---
>  include/linux/amba/bus.h                           | 2 +-
>  sound/arm/aaci.c                                   | 4 +---
>  30 files changed, 34 insertions(+), 80 deletions(-)

I failed to Cc: the relevant maintainers before, so that's why I'm
adressing you now. The idea is to let this series (completely available at
https://lore.kernel.org/linux-arm-kernel/20201124133139.3072124-1-uwe@klein=
e-koenig.org/)
go in via Russell King's tree, so an Ack from you would be great. If you
want the original in your mailbox, just tell me and I can send you a
bounce (or use b4 on the above link).

Best regards
Uwe

> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 8c4a42df47c6..48b5d4b4e889 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -300,11 +300,10 @@ static int amba_remove(struct device *dev)
>  {
>  	struct amba_device *pcdev =3D to_amba_device(dev);
>  	struct amba_driver *drv =3D to_amba_driver(dev->driver);
> -	int ret =3D 0;
> =20
>  	pm_runtime_get_sync(dev);
>  	if (drv->remove)
> -		ret =3D drv->remove(pcdev);
> +		drv->remove(pcdev);
>  	pm_runtime_put_noidle(dev);
> =20
>  	/* Undo the runtime PM settings in amba_probe() */
> @@ -315,7 +314,7 @@ static int amba_remove(struct device *dev)
>  	amba_put_disable_pclk(pcdev);
>  	dev_pm_domain_detach(dev, true);
> =20
> -	return ret;
> +	return 0;
>  }
> =20
>  static void amba_shutdown(struct device *dev)
> diff --git a/drivers/char/hw_random/nomadik-rng.c b/drivers/char/hw_rando=
m/nomadik-rng.c
> index b0ded41eb865..67947a19aa22 100644
> --- a/drivers/char/hw_random/nomadik-rng.c
> +++ b/drivers/char/hw_random/nomadik-rng.c
> @@ -69,11 +69,10 @@ static int nmk_rng_probe(struct amba_device *dev, con=
st struct amba_id *id)
>  	return ret;
>  }
> =20
> -static int nmk_rng_remove(struct amba_device *dev)
> +static void nmk_rng_remove(struct amba_device *dev)
>  {
>  	amba_release_regions(dev);
>  	clk_disable(rng_clk);
> -	return 0;
>  }
> =20
>  static const struct amba_id nmk_rng_ids[] =3D {
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> index bc0f66af0f11..fd8d2bc3be9f 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -3195,7 +3195,7 @@ pl330_probe(struct amba_device *adev, const struct =
amba_id *id)
>  	return ret;
>  }
> =20
> -static int pl330_remove(struct amba_device *adev)
> +static void pl330_remove(struct amba_device *adev)
>  {
>  	struct pl330_dmac *pl330 =3D amba_get_drvdata(adev);
>  	struct dma_pl330_chan *pch, *_p;
> @@ -3235,7 +3235,6 @@ static int pl330_remove(struct amba_device *adev)
> =20
>  	if (pl330->rstc)
>  		reset_control_assert(pl330->rstc);
> -	return 0;
>  }
> =20
>  static const struct amba_id pl330_ids[] =3D {
> diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl=
111_drv.c
> index 40e6708fbbe2..1fb5eacefd2d 100644
> --- a/drivers/gpu/drm/pl111/pl111_drv.c
> +++ b/drivers/gpu/drm/pl111/pl111_drv.c
> @@ -320,7 +320,7 @@ static int pl111_amba_probe(struct amba_device *amba_=
dev,
>  	return ret;
>  }
> =20
> -static int pl111_amba_remove(struct amba_device *amba_dev)
> +static void pl111_amba_remove(struct amba_device *amba_dev)
>  {
>  	struct device *dev =3D &amba_dev->dev;
>  	struct drm_device *drm =3D amba_get_drvdata(amba_dev);
> @@ -331,8 +331,6 @@ static int pl111_amba_remove(struct amba_device *amba=
_dev)
>  		drm_panel_bridge_remove(priv->bridge);
>  	drm_dev_put(drm);
>  	of_reserved_mem_device_release(dev);
> -
> -	return 0;
>  }
> =20
>  /*
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtra=
cing/coresight/coresight-catu.c
> index 99430f6cf5a5..3ea6a5f7f93d 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -567,12 +567,11 @@ static int catu_probe(struct amba_device *adev, con=
st struct amba_id *id)
>  	return ret;
>  }
> =20
> -static int __exit catu_remove(struct amba_device *adev)
> +static void __exit catu_remove(struct amba_device *adev)
>  {
>  	struct catu_drvdata *drvdata =3D dev_get_drvdata(&adev->dev);
> =20
>  	coresight_unregister(drvdata->csdev);
> -	return 0;
>  }
> =20
>  static struct amba_id catu_ids[] =3D {
> diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/=
hwtracing/coresight/coresight-cpu-debug.c
> index e1d232411d8d..2dcf13de751f 100644
> --- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
> +++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
> @@ -627,7 +627,7 @@ static int debug_probe(struct amba_device *adev, cons=
t struct amba_id *id)
>  	return ret;
>  }
> =20
> -static int debug_remove(struct amba_device *adev)
> +static void debug_remove(struct amba_device *adev)
>  {
>  	struct device *dev =3D &adev->dev;
>  	struct debug_drvdata *drvdata =3D amba_get_drvdata(adev);
> @@ -642,8 +642,6 @@ static int debug_remove(struct amba_device *adev)
> =20
>  	if (!--debug_count)
>  		debug_func_exit();
> -
> -	return 0;
>  }
> =20
>  static const struct amba_cs_uci_id uci_id_debug[] =3D {
> diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/h=
wtracing/coresight/coresight-cti-core.c
> index d28eae93e55c..d25c6f0150ad 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-core.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
> @@ -836,7 +836,7 @@ static void cti_device_release(struct device *dev)
>  	if (drvdata->csdev_release)
>  		drvdata->csdev_release(dev);
>  }
> -static int __exit cti_remove(struct amba_device *adev)
> +static void __exit cti_remove(struct amba_device *adev)
>  {
>  	struct cti_drvdata *drvdata =3D dev_get_drvdata(&adev->dev);
> =20
> @@ -845,8 +845,6 @@ static int __exit cti_remove(struct amba_device *adev)
>  	mutex_unlock(&ect_mutex);
> =20
>  	coresight_unregister(drvdata->csdev);
> -
> -	return 0;
>  }
> =20
>  static int cti_probe(struct amba_device *adev, const struct amba_id *id)
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtr=
acing/coresight/coresight-etb10.c
> index 1b320ab581ca..0f9ec21a9eda 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -803,7 +803,7 @@ static int etb_probe(struct amba_device *adev, const =
struct amba_id *id)
>  	return ret;
>  }
> =20
> -static int __exit etb_remove(struct amba_device *adev)
> +static void __exit etb_remove(struct amba_device *adev)
>  {
>  	struct etb_drvdata *drvdata =3D dev_get_drvdata(&adev->dev);
> =20
> @@ -814,8 +814,6 @@ static int __exit etb_remove(struct amba_device *adev)
>  	 */
>  	misc_deregister(&drvdata->miscdev);
>  	coresight_unregister(drvdata->csdev);
> -
> -	return 0;
>  }
> =20
>  #ifdef CONFIG_PM
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers=
/hwtracing/coresight/coresight-etm3x-core.c
> index 47f610b1c2b1..5f7a008a1af2 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> @@ -909,7 +909,7 @@ static void __exit clear_etmdrvdata(void *info)
>  	etmdrvdata[cpu] =3D NULL;
>  }
> =20
> -static int __exit etm_remove(struct amba_device *adev)
> +static void __exit etm_remove(struct amba_device *adev)
>  {
>  	struct etm_drvdata *drvdata =3D dev_get_drvdata(&adev->dev);
> =20
> @@ -932,8 +932,6 @@ static int __exit etm_remove(struct amba_device *adev)
>  	cpus_read_unlock();
> =20
>  	coresight_unregister(drvdata->csdev);
> -
> -	return 0;
>  }
> =20
>  #ifdef CONFIG_PM
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers=
/hwtracing/coresight/coresight-etm4x-core.c
> index d78a37b6592c..40dd59233810 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1582,7 +1582,7 @@ static void __exit clear_etmdrvdata(void *info)
>  	etmdrvdata[cpu] =3D NULL;
>  }
> =20
> -static int __exit etm4_remove(struct amba_device *adev)
> +static void __exit etm4_remove(struct amba_device *adev)
>  {
>  	struct etmv4_drvdata *drvdata =3D dev_get_drvdata(&adev->dev);
> =20
> @@ -1605,8 +1605,6 @@ static int __exit etm4_remove(struct amba_device *a=
dev)
>  	cpus_read_unlock();
> =20
>  	coresight_unregister(drvdata->csdev);
> -
> -	return 0;
>  }
> =20
>  static const struct amba_id etm4_ids[] =3D {
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwt=
racing/coresight/coresight-funnel.c
> index 39be46b74dfe..43431001fd72 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -370,9 +370,9 @@ static int dynamic_funnel_probe(struct amba_device *a=
dev,
>  	return funnel_probe(&adev->dev, &adev->res);
>  }
> =20
> -static int __exit dynamic_funnel_remove(struct amba_device *adev)
> +static void __exit dynamic_funnel_remove(struct amba_device *adev)
>  {
> -	return funnel_remove(&adev->dev);
> +	funnel_remove(&adev->dev);
>  }
> =20
>  static const struct amba_id dynamic_funnel_ids[] =3D {
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers=
/hwtracing/coresight/coresight-replicator.c
> index 6772f23e5c4b..aab13f9de2f6 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -388,9 +388,9 @@ static int dynamic_replicator_probe(struct amba_devic=
e *adev,
>  	return replicator_probe(&adev->dev, &adev->res);
>  }
> =20
> -static int __exit dynamic_replicator_remove(struct amba_device *adev)
> +static void __exit dynamic_replicator_remove(struct amba_device *adev)
>  {
> -	return replicator_remove(&adev->dev);
> +	replicator_remove(&adev->dev);
>  }
> =20
>  static const struct amba_id dynamic_replicator_ids[] =3D {
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtrac=
ing/coresight/coresight-stm.c
> index b0ad912651a9..33c5b3080c81 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -951,15 +951,13 @@ static int stm_probe(struct amba_device *adev, cons=
t struct amba_id *id)
>  	return ret;
>  }
> =20
> -static int __exit stm_remove(struct amba_device *adev)
> +static void __exit stm_remove(struct amba_device *adev)
>  {
>  	struct stm_drvdata *drvdata =3D dev_get_drvdata(&adev->dev);
> =20
>  	coresight_unregister(drvdata->csdev);
> =20
>  	stm_unregister_device(&drvdata->stm);
> -
> -	return 0;
>  }
> =20
>  #ifdef CONFIG_PM
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/h=
wtracing/coresight/coresight-tmc-core.c
> index 5653e0945c74..bd159905dccd 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -559,7 +559,7 @@ static void tmc_shutdown(struct amba_device *adev)
>  	spin_unlock_irqrestore(&drvdata->spinlock, flags);
>  }
> =20
> -static int __exit tmc_remove(struct amba_device *adev)
> +static void __exit tmc_remove(struct amba_device *adev)
>  {
>  	struct tmc_drvdata *drvdata =3D dev_get_drvdata(&adev->dev);
> =20
> @@ -570,8 +570,6 @@ static int __exit tmc_remove(struct amba_device *adev)
>  	 */
>  	misc_deregister(&drvdata->miscdev);
>  	coresight_unregister(drvdata->csdev);
> -
> -	return 0;
>  }
> =20
>  static const struct amba_id tmc_ids[] =3D {
> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtra=
cing/coresight/coresight-tpiu.c
> index 566c57e03596..934eee4b0e60 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -173,13 +173,11 @@ static int tpiu_probe(struct amba_device *adev, con=
st struct amba_id *id)
>  	return PTR_ERR(drvdata->csdev);
>  }
> =20
> -static int __exit tpiu_remove(struct amba_device *adev)
> +static void __exit tpiu_remove(struct amba_device *adev)
>  {
>  	struct tpiu_drvdata *drvdata =3D dev_get_drvdata(&adev->dev);
> =20
>  	coresight_unregister(drvdata->csdev);
> -
> -	return 0;
>  }
> =20
>  #ifdef CONFIG_PM
> diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-no=
madik.c
> index d4b1b0865f67..a3363b20f168 100644
> --- a/drivers/i2c/busses/i2c-nomadik.c
> +++ b/drivers/i2c/busses/i2c-nomadik.c
> @@ -1055,7 +1055,7 @@ static int nmk_i2c_probe(struct amba_device *adev, =
const struct amba_id *id)
>  	return ret;
>  }
> =20
> -static int nmk_i2c_remove(struct amba_device *adev)
> +static void nmk_i2c_remove(struct amba_device *adev)
>  {
>  	struct resource *res =3D &adev->res;
>  	struct nmk_i2c_dev *dev =3D amba_get_drvdata(adev);
> @@ -1068,8 +1068,6 @@ static int nmk_i2c_remove(struct amba_device *adev)
>  	i2c_clr_bit(dev->virtbase + I2C_CR, I2C_CR_PE);
>  	clk_disable_unprepare(dev->clk);
>  	release_mem_region(res->start, resource_size(res));
> -
> -	return 0;
>  }
> =20
>  static struct i2c_vendor_data vendor_stn8815 =3D {
> diff --git a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
> index ecdeca147ed7..4408245b61d2 100644
> --- a/drivers/input/serio/ambakmi.c
> +++ b/drivers/input/serio/ambakmi.c
> @@ -159,7 +159,7 @@ static int amba_kmi_probe(struct amba_device *dev,
>  	return ret;
>  }
> =20
> -static int amba_kmi_remove(struct amba_device *dev)
> +static void amba_kmi_remove(struct amba_device *dev)
>  {
>  	struct amba_kmi_port *kmi =3D amba_get_drvdata(dev);
> =20
> @@ -168,7 +168,6 @@ static int amba_kmi_remove(struct amba_device *dev)
>  	iounmap(kmi->base);
>  	kfree(kmi);
>  	amba_release_regions(dev);
> -	return 0;
>  }
> =20
>  static int __maybe_unused amba_kmi_resume(struct device *dev)
> diff --git a/drivers/memory/pl172.c b/drivers/memory/pl172.c
> index 575fadbffa30..9eb8cc7de494 100644
> --- a/drivers/memory/pl172.c
> +++ b/drivers/memory/pl172.c
> @@ -273,14 +273,12 @@ static int pl172_probe(struct amba_device *adev, co=
nst struct amba_id *id)
>  	return ret;
>  }
> =20
> -static int pl172_remove(struct amba_device *adev)
> +static void pl172_remove(struct amba_device *adev)
>  {
>  	struct pl172_data *pl172 =3D amba_get_drvdata(adev);
> =20
>  	clk_disable_unprepare(pl172->clk);
>  	amba_release_regions(adev);
> -
> -	return 0;
>  }
> =20
>  static const struct amba_id pl172_ids[] =3D {
> diff --git a/drivers/memory/pl353-smc.c b/drivers/memory/pl353-smc.c
> index 73bd3023202f..3b5b1045edd9 100644
> --- a/drivers/memory/pl353-smc.c
> +++ b/drivers/memory/pl353-smc.c
> @@ -426,14 +426,12 @@ static int pl353_smc_probe(struct amba_device *adev=
, const struct amba_id *id)
>  	return err;
>  }
> =20
> -static int pl353_smc_remove(struct amba_device *adev)
> +static void pl353_smc_remove(struct amba_device *adev)
>  {
>  	struct pl353_smc_data *pl353_smc =3D amba_get_drvdata(adev);
> =20
>  	clk_disable_unprepare(pl353_smc->memclk);
>  	clk_disable_unprepare(pl353_smc->aclk);
> -
> -	return 0;
>  }
> =20
>  static const struct amba_id pl353_ids[] =3D {
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index b5a41a7ce165..32f52d070bbd 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -2195,7 +2195,7 @@ static int mmci_probe(struct amba_device *dev,
>  	return ret;
>  }
> =20
> -static int mmci_remove(struct amba_device *dev)
> +static void mmci_remove(struct amba_device *dev)
>  {
>  	struct mmc_host *mmc =3D amba_get_drvdata(dev);
> =20
> @@ -2223,8 +2223,6 @@ static int mmci_remove(struct amba_device *dev)
>  		clk_disable_unprepare(host->clk);
>  		mmc_free_host(mmc);
>  	}
> -
> -	return 0;
>  }
> =20
>  #ifdef CONFIG_PM
> diff --git a/drivers/rtc/rtc-pl030.c b/drivers/rtc/rtc-pl030.c
> index 5a880516f3e8..39038c0754ee 100644
> --- a/drivers/rtc/rtc-pl030.c
> +++ b/drivers/rtc/rtc-pl030.c
> @@ -137,7 +137,7 @@ static int pl030_probe(struct amba_device *dev, const=
 struct amba_id *id)
>  	return ret;
>  }
> =20
> -static int pl030_remove(struct amba_device *dev)
> +static void pl030_remove(struct amba_device *dev)
>  {
>  	struct pl030_rtc *rtc =3D amba_get_drvdata(dev);
> =20
> @@ -146,8 +146,6 @@ static int pl030_remove(struct amba_device *dev)
>  	free_irq(dev->irq[0], rtc);
>  	iounmap(rtc->base);
>  	amba_release_regions(dev);
> -
> -	return 0;
>  }
> =20
>  static struct amba_id pl030_ids[] =3D {
> diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
> index 224bbf096262..620c8dc33647 100644
> --- a/drivers/rtc/rtc-pl031.c
> +++ b/drivers/rtc/rtc-pl031.c
> @@ -280,7 +280,7 @@ static int pl031_set_alarm(struct device *dev, struct=
 rtc_wkalrm *alarm)
>  	return 0;
>  }
> =20
> -static int pl031_remove(struct amba_device *adev)
> +static void pl031_remove(struct amba_device *adev)
>  {
>  	struct pl031_local *ldata =3D dev_get_drvdata(&adev->dev);
> =20
> @@ -289,8 +289,6 @@ static int pl031_remove(struct amba_device *adev)
>  	if (adev->irq[0])
>  		free_irq(adev->irq[0], ldata);
>  	amba_release_regions(adev);
> -
> -	return 0;
>  }
> =20
>  static int pl031_probe(struct amba_device *adev, const struct amba_id *i=
d)
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index d1776fea287e..fd74ddfbb686 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -2314,13 +2314,13 @@ static int pl022_probe(struct amba_device *adev, =
const struct amba_id *id)
>  	return status;
>  }
> =20
> -static int
> +static void
>  pl022_remove(struct amba_device *adev)
>  {
>  	struct pl022 *pl022 =3D amba_get_drvdata(adev);
> =20
>  	if (!pl022)
> -		return 0;
> +		return;
> =20
>  	/*
>  	 * undo pm_runtime_put() in probe.  I assume that we're not
> @@ -2335,7 +2335,6 @@ pl022_remove(struct amba_device *adev)
>  	clk_disable_unprepare(pl022->clk);
>  	amba_release_regions(adev);
>  	tasklet_disable(&pl022->pump_transfers);
> -	return 0;
>  }
> =20
>  #ifdef CONFIG_PM_SLEEP
> diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl=
010.c
> index 3284f34e9dfe..3f96edfe569c 100644
> --- a/drivers/tty/serial/amba-pl010.c
> +++ b/drivers/tty/serial/amba-pl010.c
> @@ -754,7 +754,7 @@ static int pl010_probe(struct amba_device *dev, const=
 struct amba_id *id)
>  	return ret;
>  }
> =20
> -static int pl010_remove(struct amba_device *dev)
> +static void pl010_remove(struct amba_device *dev)
>  {
>  	struct uart_amba_port *uap =3D amba_get_drvdata(dev);
>  	int i;
> @@ -770,8 +770,6 @@ static int pl010_remove(struct amba_device *dev)
> =20
>  	if (!busy)
>  		uart_unregister_driver(&amba_reg);
> -
> -	return 0;
>  }
> =20
>  #ifdef CONFIG_PM_SLEEP
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl=
011.c
> index c255476cce28..4ead0c9048a8 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2679,13 +2679,12 @@ static int pl011_probe(struct amba_device *dev, c=
onst struct amba_id *id)
>  	return pl011_register_port(uap);
>  }
> =20
> -static int pl011_remove(struct amba_device *dev)
> +static void pl011_remove(struct amba_device *dev)
>  {
>  	struct uart_amba_port *uap =3D amba_get_drvdata(dev);
> =20
>  	uart_remove_one_port(&amba_reg, &uap->port);
>  	pl011_unregister_port(uap);
> -	return 0;
>  }
> =20
>  #ifdef CONFIG_PM_SLEEP
> diff --git a/drivers/vfio/platform/vfio_amba.c b/drivers/vfio/platform/vf=
io_amba.c
> index 7b3ebf1558e1..3626c2150101 100644
> --- a/drivers/vfio/platform/vfio_amba.c
> +++ b/drivers/vfio/platform/vfio_amba.c
> @@ -71,14 +71,13 @@ static int vfio_amba_probe(struct amba_device *adev, =
const struct amba_id *id)
>  	return ret;
>  }
> =20
> -static int vfio_amba_remove(struct amba_device *adev)
> +static void vfio_amba_remove(struct amba_device *adev)
>  {
>  	struct vfio_platform_device *vdev =3D
>  		vfio_platform_remove_common(&adev->dev);
> =20
>  	kfree(vdev->name);
>  	kfree(vdev);
> -	return 0;
>  }
> =20
>  static const struct amba_id pl330_ids[] =3D {
> diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-c=
lcd.c
> index b7682de412d8..33595cc4778e 100644
> --- a/drivers/video/fbdev/amba-clcd.c
> +++ b/drivers/video/fbdev/amba-clcd.c
> @@ -925,7 +925,7 @@ static int clcdfb_probe(struct amba_device *dev, cons=
t struct amba_id *id)
>  	return ret;
>  }
> =20
> -static int clcdfb_remove(struct amba_device *dev)
> +static void clcdfb_remove(struct amba_device *dev)
>  {
>  	struct clcd_fb *fb =3D amba_get_drvdata(dev);
> =20
> @@ -942,8 +942,6 @@ static int clcdfb_remove(struct amba_device *dev)
>  	kfree(fb);
> =20
>  	amba_release_regions(dev);
> -
> -	return 0;
>  }
> =20
>  static const struct amba_id clcdfb_id_table[] =3D {
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index 190d26e2e75f..2815f78d22bb 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -304,14 +304,12 @@ sp805_wdt_probe(struct amba_device *adev, const str=
uct amba_id *id)
>  	return ret;
>  }
> =20
> -static int sp805_wdt_remove(struct amba_device *adev)
> +static void sp805_wdt_remove(struct amba_device *adev)
>  {
>  	struct sp805_wdt *wdt =3D amba_get_drvdata(adev);
> =20
>  	watchdog_unregister_device(&wdt->wdd);
>  	watchdog_set_drvdata(&wdt->wdd, NULL);
> -
> -	return 0;
>  }
> =20
>  static int __maybe_unused sp805_wdt_suspend(struct device *dev)
> diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
> index 0bbfd647f5c6..6cc93ab5b809 100644
> --- a/include/linux/amba/bus.h
> +++ b/include/linux/amba/bus.h
> @@ -76,7 +76,7 @@ struct amba_device {
>  struct amba_driver {
>  	struct device_driver	drv;
>  	int			(*probe)(struct amba_device *, const struct amba_id *);
> -	int			(*remove)(struct amba_device *);
> +	void			(*remove)(struct amba_device *);
>  	void			(*shutdown)(struct amba_device *);
>  	const struct amba_id	*id_table;
>  };
> diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
> index a0996c47e58f..b326a5f5f0d5 100644
> --- a/sound/arm/aaci.c
> +++ b/sound/arm/aaci.c
> @@ -1055,7 +1055,7 @@ static int aaci_probe(struct amba_device *dev,
>  	return ret;
>  }
> =20
> -static int aaci_remove(struct amba_device *dev)
> +static void aaci_remove(struct amba_device *dev)
>  {
>  	struct snd_card *card =3D amba_get_drvdata(dev);
> =20
> @@ -1066,8 +1066,6 @@ static int aaci_remove(struct amba_device *dev)
>  		snd_card_free(card);
>  		amba_release_regions(dev);
>  	}
> -
> -	return 0;
>  }
> =20
>  static struct amba_id aaci_ids[] =3D {
> --=20
> 2.29.2
>=20
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zevifqbsc3drtqwh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/I4bEACgkQwfwUeK3K
7AkXSQgAjHg7dm6k9fFq5Q1lbHXmmflpH5Tnk9A6JZ8KmsDTROTcfcnwGPa/oKPo
cfVm7aP8EeWxV33QornEpS4kD+CCFaODjqxtOMXZAoq7iR19cXdD6XVZ1DWIw5TQ
FYKpoFdw8q5iDkXDtIrcohzmH+X7+uZcBtLw5l1e4cvlF5yuhOknn1/SrBIj/+kW
+/SryrYcU8uyBL20h9yuT7Orde+tZ246y/ft63et0c+pFuhg8rAOr5caaPb8zEEI
HrsTeBFFJ3FAyeUyRBEGrlXr/4LURPfeSjh3inTc0WM0/JqwTlLmaQ6KhQ0yzSSz
ENTRvRsidspq0GwYAaSHU3ncQ0iXcA==
=lKQe
-----END PGP SIGNATURE-----

--zevifqbsc3drtqwh--
