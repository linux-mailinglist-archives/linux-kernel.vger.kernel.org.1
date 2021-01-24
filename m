Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B4D301AD5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 10:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbhAXJ2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 04:28:06 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:60594 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbhAXJ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 04:27:58 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id F151C1C0B7F; Sun, 24 Jan 2021 10:27:13 +0100 (CET)
Date:   Sun, 24 Jan 2021 10:27:13 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     broonie@kernel.org, aaro.koskinen@iki.fi, spinal.by@gmail.com,
        jarkko.nikula@bitmer.com, merlijn@wizzup.org, pavel@ucw.cz,
        peter.ujfalusi@ti.com, sre@kernel.org, tony@atomide.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        phone-devel@vger.kernel.org
Subject: [PATCH] ASoC: ti: Allocate dais dynamically for TDM and audio graph
 card
Message-ID: <20210124092713.GA22195@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Tony Lindgren <tony@atomide.com>

We can have multiple connections on a single McBSP instance configured
with audio graph card when using TDM (Time Division Multiplexing). Let's
allow that by configuring dais dynamically.

See Documentation/devicetree/bindings/sound/audio-graph-card.txt and
Documentation/devicetree/bindings/graph.txt for more details for
multiple endpoints.

I've tested this with droid4 where cpcap pmic and modem voice are both
both wired to mcbsp3. I've also tested this on droid4 both with and
without the pending modem audio codec driver that is waiting for n_gsm
serdev dependencies to clear.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Arthur D. <spinal.by@gmail.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Pavel Machek <pavel@ucw.cz>

---
 sound/soc/ti/omap-mcbsp-priv.h |  2 ++
 sound/soc/ti/omap-mcbsp.c      | 76 +++++++++++++++++++++++++++++---------=
----
 2 files changed, 55 insertions(+), 23 deletions(-)

diff --git a/sound/soc/ti/omap-mcbsp-priv.h b/sound/soc/ti/omap-mcbsp-priv.h
index 7865cda4bf0a..9464f5d35822 100644
--- a/sound/soc/ti/omap-mcbsp-priv.h
+++ b/sound/soc/ti/omap-mcbsp-priv.h
@@ -262,6 +262,8 @@ struct omap_mcbsp {
 	struct omap_mcbsp_platform_data *pdata;
 	struct omap_mcbsp_st_data *st_data;
 	struct omap_mcbsp_reg_cfg cfg_regs;
+	struct snd_soc_dai_driver *dais;
+	int dai_count;
 	struct snd_dmaengine_dai_dma_data dma_data[2];
 	unsigned int dma_req[2];
 	int dma_op_mode;
diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
index 6025b30bbe77..189a6461b671 100644
--- a/sound/soc/ti/omap-mcbsp.c
+++ b/sound/soc/ti/omap-mcbsp.c
@@ -14,6 +14,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_graph.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -1299,23 +1300,53 @@ static int omap_mcbsp_remove(struct snd_soc_dai *da=
i)
 	return 0;
 }
=20
-static struct snd_soc_dai_driver omap_mcbsp_dai =3D {
-	.probe =3D omap_mcbsp_probe,
-	.remove =3D omap_mcbsp_remove,
-	.playback =3D {
-		.channels_min =3D 1,
-		.channels_max =3D 16,
-		.rates =3D OMAP_MCBSP_RATES,
-		.formats =3D SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
-	},
-	.capture =3D {
-		.channels_min =3D 1,
-		.channels_max =3D 16,
-		.rates =3D OMAP_MCBSP_RATES,
-		.formats =3D SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
-	},
-	.ops =3D &mcbsp_dai_ops,
-};
+static int omap_mcbsp_init_dais(struct omap_mcbsp *mcbsp)
+{
+	struct device_node *np =3D mcbsp->dev->of_node;
+	int i;
+
+	if (np)
+		mcbsp->dai_count =3D of_graph_get_endpoint_count(np);
+
+	if (!mcbsp->dai_count)
+		mcbsp->dai_count =3D 1;
+
+	mcbsp->dais =3D devm_kcalloc(mcbsp->dev, mcbsp->dai_count,
+				   sizeof(*mcbsp->dais), GFP_KERNEL);
+	if (!mcbsp->dais)
+		return -ENOMEM;
+
+	for (i =3D 0; i < mcbsp->dai_count; i++) {
+		struct snd_soc_dai_driver *dai =3D &mcbsp->dais[i];
+
+		dai->name =3D devm_kasprintf(mcbsp->dev, GFP_KERNEL, "%s-dai%i",
+					   dev_name(mcbsp->dev), i);
+
+		if (i =3D=3D 0) {
+			dai->probe =3D omap_mcbsp_probe;
+			dai->remove =3D omap_mcbsp_remove;
+			dai->ops =3D &mcbsp_dai_ops;
+		}
+		dai->playback.channels_min =3D 1;
+		dai->playback.channels_max =3D 16;
+		dai->playback.rates =3D OMAP_MCBSP_RATES;
+		if (mcbsp->pdata->reg_size =3D=3D 2)
+			dai->playback.formats =3D SNDRV_PCM_FMTBIT_S16_LE;
+		else
+			dai->playback.formats =3D SNDRV_PCM_FMTBIT_S16_LE |
+						SNDRV_PCM_FMTBIT_S32_LE;
+		dai->capture.channels_min =3D 1;
+		dai->capture.channels_max =3D 16;
+		dai->capture.rates =3D OMAP_MCBSP_RATES;
+		if (mcbsp->pdata->reg_size =3D=3D 2)
+			dai->capture.formats =3D SNDRV_PCM_FMTBIT_S16_LE;
+		else
+			dai->capture.formats =3D SNDRV_PCM_FMTBIT_S16_LE |
+					       SNDRV_PCM_FMTBIT_S32_LE;
+	}
+
+	return 0;
+}
=20
 static const struct snd_soc_component_driver omap_mcbsp_component =3D {
 	.name		=3D "omap-mcbsp",
@@ -1404,18 +1435,17 @@ static int asoc_mcbsp_probe(struct platform_device =
*pdev)
 	mcbsp->dev =3D &pdev->dev;
 	platform_set_drvdata(pdev, mcbsp);
=20
-	ret =3D omap_mcbsp_init(pdev);
+	ret =3D omap_mcbsp_init_dais(mcbsp);
 	if (ret)
 		return ret;
=20
-	if (mcbsp->pdata->reg_size =3D=3D 2) {
-		omap_mcbsp_dai.playback.formats =3D SNDRV_PCM_FMTBIT_S16_LE;
-		omap_mcbsp_dai.capture.formats =3D SNDRV_PCM_FMTBIT_S16_LE;
-	}
+	ret =3D omap_mcbsp_init(pdev);
+	if (ret)
+		return ret;
=20
 	ret =3D devm_snd_soc_register_component(&pdev->dev,
 					      &omap_mcbsp_component,
-					      &omap_mcbsp_dai, 1);
+					      mcbsp->dais, mcbsp->dai_count);
 	if (ret)
 		return ret;
=20
--=20
2.11.0

--=20
http://www.livejournal.com/~pavelmachek

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmANPXAACgkQMOfwapXb+vLfrgCeNvSRS9g22zGEyaBrP8dM+pds
zs8Ani6OgW/IB2/CcypeT+4Dp1n+GCMc
=zxjB
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
