Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5902874C0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 15:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgJHNCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 09:02:47 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:49203 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730184AbgJHNCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 09:02:46 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 8CE38B69;
        Thu,  8 Oct 2020 09:02:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 08 Oct 2020 09:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=OnX2OclxUMbS2YHgH9OBLagClcV
        8/eB+1eHYfJZoPcc=; b=NYylp3Scv0U41vEA323yHi1GV10gD9r94Ble+fzQ8i9
        T8ucGY05g80hQQ2imFXkgNsxD/BmBcKujiUa/tTzQjGwozaUxUROuXzWH1c7RxqU
        9OFCURdinvVZMKvV7Oei8O2pkz27cPlbS4CJhP85KCDv5OnpffVL10QxpR4OTIBd
        gKzH/mBwgNVdqm4wmwstK17+oXTAEwx5qt4VWtLg8YsZsgcGv03havdobuGV9Vuw
        orT7meEOiQqXSurhSy26W47Cvuo+Ir311jOC2F4s+0ffIN3DPkvkQSDzD4eTV1oo
        ui9frIXBP2hmidE3K2Te1Z4wZT1i517SNbm0dC4MY0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=OnX2Oc
        lxUMbS2YHgH9OBLagClcV8/eB+1eHYfJZoPcc=; b=nLW1XWUE6LKvGPKt8xvmFf
        QrpCp6NfagO2jJzkOKRqygxf4hc5mH9h772F/ZEuM++AR20Hti62BQoHooIhhKgf
        Q9o3aquCVbzwCFJ/ky7aU6TYrZjLwN3KAQKmDbJsuZ3Rv8STBGrR75GTpreeg02d
        78+YHgveFdhnfqzPPuuommOpmgQWM6c5lGiPUJK+pxdJwdilq3TvAhhPFs3ftwQF
        deDsMKBSu+jTiniZv5Hz6ExPHKmy3IF22ukM+Zoxx5FrvVXTbKF4mrQ92ApmJeOC
        87Lw5EXvADItHrVNDZzuEsJRumjMmXE35gKd6/phEKtvgcZDORa0+xz8tIpPOdfw
        ==
X-ME-Sender: <xms:8g1_X-yl7bJuy72MxbNMxpYknqhqf8SGdbN0FqU7jrENP1sJ7cEtTA>
    <xme:8g1_X6TJx5eX2E0L1WiBLyMJxpq3OrstKjDmc8Jp3TWEzmksHnL98iEahF2h45HrV
    YEqAGtx3iN-XaV43aY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgeelgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:8g1_XwWLyjFDfA1biphbMHrlJwXQhUrlXFd9c9EEtMrqXn9JqclZRA>
    <xmx:8g1_X0gbo-9Z0t7LsTXd6qeAr-oe1G1_j0wrjPXm5QpByHwvPILQIA>
    <xmx:8g1_XwASmWX8mjoLYOmmQv7seBIC-ruocKes4iad-xJr5801BBei5Q>
    <xmx:9Q1_X-AEB-rszeT-_GsGS4GBke2mZB7jm0b0NDZpkzAjsTfBuPz1ww>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 466093064674;
        Thu,  8 Oct 2020 09:02:42 -0400 (EDT)
Date:   Thu, 8 Oct 2020 15:02:41 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/25] ASoC: sun8i-codec: Protect the clock rate while
 streams are open
Message-ID: <20201008130241.uigiys7iv72hca7r@gilmour.lan>
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-21-samuel@sholland.org>
 <20201005120101.igzzwosnq6bzbua6@gilmour.lan>
 <5ef4351f-e9ed-1a38-b79e-53e62a70437e@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="os5ttu6dxe7xjvcl"
Content-Disposition: inline
In-Reply-To: <5ef4351f-e9ed-1a38-b79e-53e62a70437e@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--os5ttu6dxe7xjvcl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2020 at 11:43:51PM -0500, Samuel Holland wrote:
> On 10/5/20 7:01 AM, Maxime Ripard wrote:
> > On Wed, Sep 30, 2020 at 09:11:43PM -0500, Samuel Holland wrote:
> >> The codec's clock input is shared among all AIFs, and shared with other
> >> audio-related hardware in the SoC, including I2S and SPDIF controllers.
> >> To ensure sample rates selected by userspace or by codec2codec DAI lin=
ks
> >> are maintained, the clock rate must be protected while it is in use.
> >>
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> ---
> >>  sound/soc/sunxi/sun8i-codec.c | 25 ++++++++++++++++++++++---
> >>  1 file changed, 22 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-cod=
ec.c
> >> index 501af64d43a0..86065bee7cd3 100644
> >> --- a/sound/soc/sunxi/sun8i-codec.c
> >> +++ b/sound/soc/sunxi/sun8i-codec.c
> >> @@ -416,27 +416,32 @@ static int sun8i_codec_get_lrck_div_order(unsign=
ed int slots,
> >>  	unsigned int div =3D slots * slot_width;
> >> =20
> >>  	if (div < 16 || div > 256)
> >>  		return -EINVAL;
> >> =20
> >>  	return order_base_2(div);
> >>  }
> >> =20
> >> +static unsigned int sun8i_codec_get_sysclk_rate(unsigned int sample_r=
ate)
> >> +{
> >> +	return sample_rate % 4000 ? 22579200 : 24576000;
> >> +}
> >> +
> >>  static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
> >>  				 struct snd_pcm_hw_params *params,
> >>  				 struct snd_soc_dai *dai)
> >>  {
> >>  	struct sun8i_codec *scodec =3D snd_soc_dai_get_drvdata(dai);
> >>  	struct sun8i_codec_aif *aif =3D &scodec->aifs[dai->id];
> >>  	unsigned int sample_rate =3D params_rate(params);
> >>  	unsigned int slots =3D aif->slots ?: params_channels(params);
> >>  	unsigned int slot_width =3D aif->slot_width ?: params_width(params);
> >> -	unsigned int sysclk_rate =3D clk_get_rate(scodec->clk_module);
> >> -	int lrck_div_order, word_size;
> >> +	unsigned int sysclk_rate =3D sun8i_codec_get_sysclk_rate(sample_rate=
);
> >> +	int lrck_div_order, ret, word_size;
> >>  	u8 bclk_div;
> >> =20
> >>  	/* word size */
> >>  	switch (params_width(params)) {
> >>  	case 8:
> >>  		word_size =3D 0x0;
> >>  		break;
> >>  	case 16:
> >> @@ -466,17 +471,30 @@ static int sun8i_codec_hw_params(struct snd_pcm_=
substream *substream,
> >>  			   (lrck_div_order - 4) << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV);
> >> =20
> >>  	/* BCLK divider (SYSCLK/BCLK ratio) */
> >>  	bclk_div =3D sun8i_codec_get_bclk_div(sysclk_rate, lrck_div_order, s=
ample_rate);
> >>  	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
> >>  			   SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK,
> >>  			   bclk_div << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV);
> >> =20
> >> -	if (!aif->open_streams) {
> >> +	/* SYSCLK rate */
> >> +	if (aif->open_streams) {
> >> +		ret =3D clk_set_rate(scodec->clk_module, sysclk_rate);
> >> +		if (ret < 0)
> >> +			return ret;
> >> +	} else {
> >> +		ret =3D clk_set_rate_exclusive(scodec->clk_module, sysclk_rate);
> >=20
> > It's not really clear to me why we wouldn't want to always protect the
> > clock rate here?
>=20
> From Documentation/sound/kernel-api/writing-an-alsa-driver.rst:
>=20
>     hw_params callback
>     ...
>     Note that this and ``prepare`` callbacks may be called multiple
>     times per initialization. For example, the OSS emulation may call
>     these callbacks at each change via its ioctl.
>=20
> Clock rate protection is reference counted, so we must only take one
> reference (or at least a known number of references) per stream.

Ah, right.

Can you add a comment to make that more obvious?

> >> +		if (ret =3D=3D -EBUSY)
> >> +			dev_err(dai->dev, "%s: clock is busy! Sample rate %u Hz "
> >> +				"conflicts with other audio streams.\n",
> >=20
> > This string creates a checkpatch warning.
>=20
> I will put it on one line, though >100 columns is also a checkpatch warni=
ng.

Yeah, but in general having an error on a single line is more important.
That way you can then grep for that error message

Maxime

--os5ttu6dxe7xjvcl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX38N8QAKCRDj7w1vZxhR
xeeGAP0cFB8uWUUs+EZIcN6bxqGf/Bf/dWy9iwe3GhQXO0PhlgEA3YDzSc4+mvs5
7RfAvmCMM9CZpNlLZYle3uVbztf7Wwk=
=yu/i
-----END PGP SIGNATURE-----

--os5ttu6dxe7xjvcl--
