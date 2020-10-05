Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E37283594
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgJEMOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:14:34 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:43893 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726786AbgJEMOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:14:23 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 620BE5800F5;
        Mon,  5 Oct 2020 08:14:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 05 Oct 2020 08:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=wNkwTYhnWei++a07J8jTnePakPC
        Iw1wKzuJo1C46iZw=; b=sXdHqQz/rm3FvPJP/lBkipN1PxCYolAmHOI1x9fZShr
        rcN1wDhUOC190H6pHTQnl7ApmvOPRuq3dNqoWyvPvl+7fBuyJdW0+fpIfDwpt7Nq
        SO74RbfWX0zpxdC4TtEzjkpqwxyTzdNh5lIv69Wh1Ljl3vGeKJkR7OHVaNZ5J/uM
        kGxY/iCy4EbRBuVTcgG8Ehaa+oGrXrQ5TSD26Jq8k8dPNZn3Rye7AFRfRhBszIIQ
        p8flfbMNdZuzE12AwaI1qeN6ea3q/mx4atP2R4MLGRIf74FVyudUeSVFwcFsj/cU
        ztlvF8mIqKF0+dqKNheNdK7RVY/+XY9Rdg6iIpxsmXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=wNkwTY
        hnWei++a07J8jTnePakPCIw1wKzuJo1C46iZw=; b=ARSeklQ41yU2dCmTtw3uS1
        3eeqWBDJUhJpZV7zS3lCIIai1CkCsRBc7HhqQBMWc/5+petF5vAVDoqCOYxC4TJw
        LDSfpXXUXo8x21iEcGyYfTLCc+MJZn8ntDMwlEAx8o6Tv9c/oC4GJldQnVVd2cUS
        9bNZtS1iA5Bi2/mkwwNweooJCV1YMWUl/9xbApZXPBYgQdJWv+fTtR1KaF/z80B3
        A2kn/U5bsoYZO6O//KnKeJ04i7MNf49oxadSDgHAOR0hvwTfZdEsitndNjuyrMNO
        0pb0uTY1K8EQhy8wgChqvWu87e4e928M0LRmPWAyo4jPz0rQ04vimcOg1z72qHXQ
        ==
X-ME-Sender: <xms:HQ57X3R8fK2vnrflBGkGEJ3TnJEXb2se0tUOQJIQIKjPd1qV0AOzHw>
    <xme:HQ57X4xRt1Bao1L8Ru7vq9KgsMZ9oy7Nz1hrnr6V0a4i5aQ_xpYMHkCUl3iNJ_al_
    ifSVlTInMRGaaXVsl0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:HQ57X83YwZ19cfHepFWG_HYd8QDvZ-uI4DBtwqbfbbLLK3nWypIzYw>
    <xmx:HQ57X3DpMDywoWGJQwOEeNtX29HeQMuiY3ZuAzP08zr_VTt9fAmc8Q>
    <xmx:HQ57XwjJESIlwvMPu21Jab-YT7TPyFw9Xw_j9ckDJMPhzFJ_o8Di1A>
    <xmx:HQ57X_oZt-3VG5Ukj89zfHCm9oHofysFgI-kCPgluv9znhSeo51yoA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B405B3064686;
        Mon,  5 Oct 2020 08:14:20 -0400 (EDT)
Date:   Mon, 5 Oct 2020 14:14:19 +0200
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
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v6 03/14] ASoC: sun4i-i2s: Change get_sr() and get_wss()
 to be more explicit
Message-ID: <20201005121419.mum4g5utdesvyg7a@gilmour.lan>
References: <20201003141950.455829-1-peron.clem@gmail.com>
 <20201003141950.455829-4-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f3324tpftog7wx7u"
Content-Disposition: inline
In-Reply-To: <20201003141950.455829-4-peron.clem@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f3324tpftog7wx7u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 03, 2020 at 04:19:39PM +0200, Cl=E9ment P=E9ron wrote:
> We are actually using a complex formula to just return a bunch of
> simple values. Also this formula is wrong for sun4i when calling
> get_wss() the function return 4 instead of 3.
>=20
> Replace this with a simpler switch case.
>=20
> Also drop the i2s params which is unused and return a simple int as
> returning an error code could be out of range for an s8 and there is
> no optim to return a s8 here.
>=20
> Fixes: 619c15f7fac9 ("ASoC: sun4i-i2s: Change SR and WSS computation")
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 69 +++++++++++++++++++++++--------------
>  1 file changed, 44 insertions(+), 25 deletions(-)
>=20
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 1f577dbc20a6..8e497fb3de09 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -175,8 +175,8 @@ struct sun4i_i2s_quirks {
>  	unsigned int			num_mclk_dividers;
> =20
>  	unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *);
> -	s8	(*get_sr)(const struct sun4i_i2s *, int);
> -	s8	(*get_wss)(const struct sun4i_i2s *, int);
> +	int	(*get_sr)(unsigned int width);
> +	int	(*get_wss)(unsigned int width);
>  	int	(*set_chan_cfg)(const struct sun4i_i2s *i2s,
>  				unsigned int channels,	unsigned int slots,
>  				unsigned int slot_width);
> @@ -381,37 +381,56 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_da=
i *dai,
>  	return 0;
>  }
> =20
> -static s8 sun4i_i2s_get_sr(const struct sun4i_i2s *i2s, int width)
> +static int sun4i_i2s_get_sr(unsigned int width)
>  {
> -	if (width < 16 || width > 24)
> -		return -EINVAL;
> -
> -	if (width % 4)
> -		return -EINVAL;
> +	switch (width) {
> +	case 16:
> +		return 0x0;
> +	case 20:
> +		return 0x1;
> +	case 24:
> +		return 0x2;
> +	}
> =20
> -	return (width - 16) / 4;
> +	return -EINVAL;
>  }
> =20
> -static s8 sun4i_i2s_get_wss(const struct sun4i_i2s *i2s, int width)
> +static int sun4i_i2s_get_wss(unsigned int width)
>  {
> -	if (width < 16 || width > 32)
> -		return -EINVAL;
> -
> -	if (width % 4)
> -		return -EINVAL;
> +	switch (width) {
> +	case 16:
> +		return 0x0;
> +	case 20:
> +		return 0x1;
> +	case 24:
> +		return 0x2;
> +	case 32:
> +		return 0x3;
> +	}

Like I said in the previous version, I'm not really sure why we need to
use the hexadecimal representation here?

Maxime

--f3324tpftog7wx7u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3sOGwAKCRDj7w1vZxhR
xbKFAQCPBrnvMNeZ6dpV8po4HqA+JN6qoi3GPyWWMvl49iOTjAD+JoJULUd+x5nO
eXN6HpYzM2lj/96qCwXbPjMCXLl9OQs=
=6Hqk
-----END PGP SIGNATURE-----

--f3324tpftog7wx7u--
