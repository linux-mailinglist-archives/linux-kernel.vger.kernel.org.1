Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9C128357E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgJEMNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:13:23 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:51553 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726621AbgJEMNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:13:16 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id DF1365800E8;
        Mon,  5 Oct 2020 08:13:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 05 Oct 2020 08:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=gjkSdCJ5XMvY0rZWJfrkdjtfXFF
        U30Hkg8qAgbuJMbg=; b=CdbVmR1a+WHfNqUBQh0KzxiNCXDqXTiKKcQYv8ifxxg
        cRlW8b0Q8+ZgqUDR6u3/CgCuL1fNafBJMRrHZMYu8UTVTt+Q6u4Pl5+T/gKWMk0E
        +jRaB/sKqrDta6JFWr/d+Fion+LtIcuywV+hT8gA4aD9jLB6RSyDGArln+QIPySy
        3gS10JwGPVW7+OtEY5M74vjIR0Q501A5SQgCOVYVghpHQSkBOnzkH+8Bze6f+v3+
        eXZXfyIVCAfBxtK8Zec9QwqSuU+2Du+748QpiKOfM/VCWSgZ/x203u90i+cFxKNm
        5W9MriLXnXtlutoAIznrnI76j46v1fCGs3qM8No+Wkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=gjkSdC
        J5XMvY0rZWJfrkdjtfXFFU30Hkg8qAgbuJMbg=; b=ijz7b48oDYZmzJzzIH0Rrq
        CMy5OPx4p3pbbDcvxOq4tX21L04Xd4ZiasOMxPi812IonJBnje1zr1ug1u4+9soI
        jpXwcqeIEL2Vskfm6h5sGdEkbPsxJZj0P6L3Ds/hIJxdjtazA5IrCw2hDrbWk5Dz
        S4BlkidVqWYmHMxVRkmF1J/hgyWhCvPeDgpsn+r4DK4byXdBJk3YBat9Y9zglT+j
        8p4rwyGrjYtaPo8ifEa0kyjVQXmXxT+Z76NfYLCwQRh4xwvEh/XwIgqvplbDcJ0f
        P+alyxASx1D3zFYXNj9TGzmtGgONi1CAeeh3AAkbAsERMqWfxfZ91euf3WMITdJg
        ==
X-ME-Sender: <xms:1A17X0M2_ARBpVe-jZkH75nK4pvZnMcQrq2SYzncFQxO0chzpZyBKA>
    <xme:1A17X69o3R9qPuIx2mRMwhwaBKJ9Ux_CDZYn5mUfCP0xjR9egtb3jHMNlrFJjxuOb
    YatQ5rfYc5Ggm2amt4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:1Q17X7QkB7gKysOm-oIGXo_IKPXQ7nm-ZBuOCNBPsXmtiC7DcbQreQ>
    <xmx:1Q17X8vE1_jeVmrn_z-dQT8E3pYtkueQLkiX6_II74wvr5V1H2kvAA>
    <xmx:1Q17X8fwFIBjlF6Mk26-jAzyAg7lcAvtz3_lSNMu3ql3t4JMGR7v4g>
    <xmx:1g17Xy12K_WHEpGOuz9n2GJNqb-xvJmIitm8svm2PCuQghXw0I2JcA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B38943280063;
        Mon,  5 Oct 2020 08:13:08 -0400 (EDT)
Date:   Mon, 5 Oct 2020 14:13:07 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v6 02/14] ASoC: sun4i-i2s: Change set_chan_cfg() params
Message-ID: <20201005121307.v6jpyeyfi4kxc2cl@gilmour.lan>
References: <20201003141950.455829-1-peron.clem@gmail.com>
 <20201003141950.455829-3-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m6smyiuducluzh7y"
Content-Disposition: inline
In-Reply-To: <20201003141950.455829-3-peron.clem@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m6smyiuducluzh7y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 03, 2020 at 04:19:38PM +0200, Cl=E9ment P=E9ron wrote:
> As slots and slot_width can be set manually using set_tdm().
> These values are then kept in sun4i_i2s struct.
> So we need to check if these values are setted or not
> in the struct.
>=20
> Avoid to check for this logic in set_chan_cfg(). This will
> duplicate the same check instead pass the required values
> as params to set_chan_cfg().
>=20
> This will also avoid a bug when we will enable 20/24bits support,
> i2s->slot_width is not actually used in the lrck_period computation.
>=20
> Suggested-by: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 36 ++++++++++++++----------------------
>  1 file changed, 14 insertions(+), 22 deletions(-)
>=20
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index c5ccd423e6d3..1f577dbc20a6 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -177,8 +177,9 @@ struct sun4i_i2s_quirks {
>  	unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *);
>  	s8	(*get_sr)(const struct sun4i_i2s *, int);
>  	s8	(*get_wss)(const struct sun4i_i2s *, int);
> -	int	(*set_chan_cfg)(const struct sun4i_i2s *,
> -				const struct snd_pcm_hw_params *);
> +	int	(*set_chan_cfg)(const struct sun4i_i2s *i2s,
> +				unsigned int channels,	unsigned int slots,
> +				unsigned int slot_width);
>  	int	(*set_fmt)(const struct sun4i_i2s *, unsigned int);
>  };
> =20
> @@ -414,10 +415,9 @@ static s8 sun8i_i2s_get_sr_wss(const struct sun4i_i2=
s *i2s, int width)
>  }
> =20
>  static int sun4i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> -				  const struct snd_pcm_hw_params *params)
> +				  unsigned int channels, unsigned int slots,
> +				  unsigned int slot_width)
>  {
> -	unsigned int channels =3D params_channels(params);
> -
>  	/* Map the channels for playback and capture */
>  	regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_MAP_REG, 0x76543210);
>  	regmap_write(i2s->regmap, SUN4I_I2S_RX_CHAN_MAP_REG, 0x00003210);
> @@ -434,15 +434,11 @@ static int sun4i_i2s_set_chan_cfg(const struct sun4=
i_i2s *i2s,
>  }
> =20
>  static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> -				  const struct snd_pcm_hw_params *params)
> +				  unsigned int channels, unsigned int slots,
> +				  unsigned int slot_width)
>  {
> -	unsigned int channels =3D params_channels(params);
> -	unsigned int slots =3D channels;
>  	unsigned int lrck_period;
> =20
> -	if (i2s->slots)
> -		slots =3D i2s->slots;
> -
>  	/* Map the channels for playback and capture */
>  	regmap_write(i2s->regmap, SUN8I_I2S_TX_CHAN_MAP_REG, 0x76543210);
>  	regmap_write(i2s->regmap, SUN8I_I2S_RX_CHAN_MAP_REG, 0x76543210);
> @@ -467,11 +463,11 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4=
i_i2s *i2s,
>  	case SND_SOC_DAIFMT_DSP_B:
>  	case SND_SOC_DAIFMT_LEFT_J:
>  	case SND_SOC_DAIFMT_RIGHT_J:
> -		lrck_period =3D params_physical_width(params) * slots;
> +		lrck_period =3D slot_width * slots;
>  		break;
> =20
>  	case SND_SOC_DAIFMT_I2S:
> -		lrck_period =3D params_physical_width(params);
> +		lrck_period =3D slot_width;
>  		break;
> =20
>  	default:
> @@ -490,15 +486,11 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4=
i_i2s *i2s,
>  }
> =20
>  static int sun50i_h6_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> -				      const struct snd_pcm_hw_params *params)
> +				      unsigned int channels, unsigned int slots,
> +				      unsigned int slot_width)
>  {
> -	unsigned int channels =3D params_channels(params);
> -	unsigned int slots =3D channels;
>  	unsigned int lrck_period;
> =20
> -	if (i2s->slots)
> -		slots =3D i2s->slots;
> -
>  	/* Map the channels for playback and capture */
>  	regmap_write(i2s->regmap, SUN50I_H6_I2S_TX_CHAN_MAP0_REG, 0xFEDCBA98);
>  	regmap_write(i2s->regmap, SUN50I_H6_I2S_TX_CHAN_MAP1_REG, 0x76543210);
> @@ -525,11 +517,11 @@ static int sun50i_h6_i2s_set_chan_cfg(const struct =
sun4i_i2s *i2s,
>  	case SND_SOC_DAIFMT_DSP_B:
>  	case SND_SOC_DAIFMT_LEFT_J:
>  	case SND_SOC_DAIFMT_RIGHT_J:
> -		lrck_period =3D params_physical_width(params) * slots;
> +		lrck_period =3D slot_width * slots;
>  		break;
> =20
>  	case SND_SOC_DAIFMT_I2S:
> -		lrck_period =3D params_physical_width(params);
> +		lrck_period =3D slot_width;
>  		break;
> =20
>  	default:
> @@ -565,7 +557,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substre=
am *substream,
>  	if (i2s->slot_width)
>  		slot_width =3D i2s->slot_width;
> =20
> -	ret =3D i2s->variant->set_chan_cfg(i2s, params);
> +	ret =3D i2s->variant->set_chan_cfg(i2s, channels, slots, slot_width);

Isn't slots and slot_width set to 0 here ?

And therefore, wouldn't we set lrck_period to 0 if we're using any
format but I2S?

More importantly, I'm not really convinced this needs to be done, and it
introduces some side effects that are not explained.

Maxime

--m6smyiuducluzh7y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3sN0wAKCRDj7w1vZxhR
xU4HAP9MbbyLxD6JGRAt1mWDpIDanWpcRwibxPgG7jEAb/lHXgD9EJSskHvSPvv8
lrQLWmFagACCBeDOdgrAUpMebbPmKgA=
=KpfD
-----END PGP SIGNATURE-----

--m6smyiuducluzh7y--
