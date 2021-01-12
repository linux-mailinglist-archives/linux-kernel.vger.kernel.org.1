Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C98D2F3798
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391944AbhALRrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:47:48 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:58934 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391894AbhALRrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:47:47 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AD73B1C0B8F; Tue, 12 Jan 2021 18:47:04 +0100 (CET)
Date:   Tue, 12 Jan 2021 18:47:04 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, kuninori.morimoto.gx@renesas.com,
        peter.ujfalusi@ti.com, tony@atomide.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     "Arthur D." <spinal.by@gmail.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: ASoC: cpcap: Implement set_tdm_slot for voice call support
Message-ID: <20210112174704.GA13496@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Tony Lindgren <tony@atomide.com>
   =20
ASoC: cpcap: Implement set_tdm_slot for voice call support
   =20
For using cpcap for voice calls, we need to route audio directly from
the modem to cpcap for TDM (Time Division Multiplexing). The voice call
is direct data between the modem and cpcap with no CPU involvment. In
this mode, the cpcap related audio mixer controls work for the speaker
selection and volume though.

To do this, we need to implement standard snd_soc_dai_set_tdm_slot()
for cpcap. Then the modem codec driver can use snd_soc_dai_set_sysclk(),
snd_soc_dai_set_fmt(), and snd_soc_dai_set_tdm_slot() to configure a
voice call.

Let's add cpcap_voice_set_tdm_slot() for this, and cpcap_voice_call()
helper to configure the additional registers needed for voice call.

Let's also clear CPCAP_REG_VAUDIOC on init in case we have the bit for
CPCAP_BIT_VAUDIO_MODE0 set on init.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Pavel Machek <pavel@ucw.cz>


diff --git a/sound/soc/codecs/cpcap.c b/sound/soc/codecs/cpcap.c
index f046987ee4cd..e266d993ab2a 100644
--- a/sound/soc/codecs/cpcap.c
+++ b/sound/soc/codecs/cpcap.c
@@ -16,6 +16,14 @@
 #include <sound/soc.h>
 #include <sound/tlv.h>
=20
+/* Register 512 CPCAP_REG_VAUDIOC --- Audio Regulator and Bias Voltage */
+#define CPCAP_BIT_AUDIO_LOW_PWR           6
+#define CPCAP_BIT_AUD_LOWPWR_SPEED        5
+#define CPCAP_BIT_VAUDIOPRISTBY           4
+#define CPCAP_BIT_VAUDIO_MODE1            2
+#define CPCAP_BIT_VAUDIO_MODE0            1
+#define CPCAP_BIT_V_AUDIO_EN              0
+
 /* Register 513 CPCAP_REG_CC     --- CODEC */
 #define CPCAP_BIT_CDC_CLK2                15
 #define CPCAP_BIT_CDC_CLK1                14
@@ -221,6 +229,7 @@ struct cpcap_reg_info {
 };
=20
 static const struct cpcap_reg_info cpcap_default_regs[] =3D {
+	{ CPCAP_REG_VAUDIOC, 0x003F, 0x0000 },
 	{ CPCAP_REG_CC, 0xFFFF, 0x0000 },
 	{ CPCAP_REG_CC, 0xFFFF, 0x0000 },
 	{ CPCAP_REG_CDI, 0xBFFF, 0x0000 },
@@ -1371,8 +1380,121 @@ static int cpcap_voice_set_dai_fmt(struct snd_soc_d=
ai *codec_dai,
 	return 0;
 }
=20
-static int cpcap_voice_set_mute(struct snd_soc_dai *dai,
-				int mute, int direction)
+
+/*
+ * Configure codec for voice call if requested.
+ *
+ * We can configure most with snd_soc_dai_set_sysclk(), snd_soc_dai_set_fm=
t()
+ * and snd_soc_dai_set_tdm_slot(). This function configures the rest of the
+ * cpcap related hardware as CPU is not involved in the voice call.
+ */
+static int cpcap_voice_call(struct cpcap_audio *cpcap, struct snd_soc_dai =
*dai,
+			    bool voice_call)
+{
+	int mask, err;
+
+	/* Modem to codec VAUDIO_MODE1 */
+	mask =3D BIT(CPCAP_BIT_VAUDIO_MODE1);
+	err =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_VAUDIOC,
+				 mask, voice_call ? mask : 0);
+	if (err)
+		return err;
+
+	/* Clear MIC1_MUX for call */
+	mask =3D BIT(CPCAP_BIT_MIC1_MUX);
+	err =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_TXI,
+				 mask, voice_call ? 0 : mask);
+	if (err)
+		return err;
+
+	/* Set MIC2_MUX for call */
+	mask =3D BIT(CPCAP_BIT_MB_ON1L) | BIT(CPCAP_BIT_MB_ON1R) |
+		BIT(CPCAP_BIT_MIC2_MUX) | BIT(CPCAP_BIT_MIC2_PGA_EN);
+	err =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_TXI,
+				 mask, voice_call ? mask : 0);
+	if (err)
+		return err;
+
+	/* Enable LDSP for call */
+	mask =3D BIT(CPCAP_BIT_A2_LDSP_L_EN) | BIT(CPCAP_BIT_A2_LDSP_R_EN);
+	err =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_RXOA,
+				 mask, voice_call ? mask : 0);
+	if (err)
+		return err;
+
+	/* Enable CPCAP_BIT_PGA_CDC_EN for call */
+	mask =3D BIT(CPCAP_BIT_PGA_CDC_EN);
+	err =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_RXCOA,
+				 mask, voice_call ? mask : 0);
+	if (err)
+		return err;
+
+	/* Unmute voice for call */
+	if (dai) {
+		err =3D snd_soc_dai_digital_mute(dai, !voice_call,
+					       SNDRV_PCM_STREAM_PLAYBACK);
+		if (err)
+			return err;
+	}
+
+	/* Set modem to codec mic CDC and HPF for call */
+	mask =3D BIT(CPCAP_BIT_MIC2_CDC_EN) | BIT(CPCAP_BIT_CDC_EN_RX) |
+	       BIT(CPCAP_BIT_AUDOHPF_1) | BIT(CPCAP_BIT_AUDOHPF_0) |
+	       BIT(CPCAP_BIT_AUDIHPF_1) | BIT(CPCAP_BIT_AUDIHPF_0);
+	err =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_CC,
+				 mask, voice_call ? mask : 0);
+	if (err)
+		return err;
+
+	/* Enable modem to codec CDC for call*/
+	mask =3D BIT(CPCAP_BIT_CDC_CLK_EN);
+	err =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_CDI,
+				 mask, voice_call ? mask : 0);
+
+	return err;
+}
+
+static int cpcap_voice_set_tdm_slot(struct snd_soc_dai *dai,
+				    unsigned int tx_mask, unsigned int rx_mask,
+				    int slots, int slot_width)
+{
+	struct snd_soc_component *component =3D dai->component;
+	struct cpcap_audio *cpcap =3D snd_soc_component_get_drvdata(component);
+	int err, ts_mask, mask;
+	bool voice_call;
+
+	/*
+	 * Primitive test for voice call, probably needs more checks
+	 * later on for 16-bit calls detected, Bluetooth headset etc.
+	 */
+	if (tx_mask =3D=3D 0 && rx_mask =3D=3D 1 && slot_width =3D=3D 8)
+		voice_call =3D true;
+	else
+		voice_call =3D false;
+
+	ts_mask =3D 0x7 << CPCAP_BIT_MIC2_TIMESLOT0;
+	ts_mask |=3D 0x7 << CPCAP_BIT_MIC1_RX_TIMESLOT0;
+
+	mask =3D (tx_mask & 0x7) << CPCAP_BIT_MIC2_TIMESLOT0;
+	mask |=3D (rx_mask & 0x7) << CPCAP_BIT_MIC1_RX_TIMESLOT0;
+
+	err =3D regmap_update_bits(cpcap->regmap, CPCAP_REG_CDI,
+				 ts_mask, mask);
+	if (err)
+		return err;
+
+	err =3D cpcap_set_samprate(cpcap, CPCAP_DAI_VOICE, slot_width * 1000);
+	if (err)
+		return err;
+
+	err =3D cpcap_voice_call(cpcap, dai, voice_call);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int cpcap_voice_set_mute(struct snd_soc_dai *dai, int mute, int dir=
ection)
 {
 	struct snd_soc_component *component =3D dai->component;
 	struct cpcap_audio *cpcap =3D snd_soc_component_get_drvdata(component);
@@ -1393,6 +1515,7 @@ static const struct snd_soc_dai_ops cpcap_dai_voice_o=
ps =3D {
 	.hw_params	=3D cpcap_voice_hw_params,
 	.set_sysclk	=3D cpcap_voice_set_dai_sysclk,
 	.set_fmt	=3D cpcap_voice_set_dai_fmt,
+	.set_tdm_slot	=3D cpcap_voice_set_tdm_slot,
 	.mute_stream	=3D cpcap_voice_set_mute,
 	.no_capture_mute =3D 1,
 };

--=20
http://www.livejournal.com/~pavelmachek

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX/3gmAAKCRAw5/Bqldv6
8kPjAKDAGEAWqE4nY+zW6WpziwRvYNzRoACghioNh5t5lQB6Biklf82E9uXkong=
=tA+m
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
