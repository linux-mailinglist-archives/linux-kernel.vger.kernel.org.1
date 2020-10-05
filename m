Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D169E283549
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgJEMCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:02:06 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51343 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbgJEMCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:02:05 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 35EE55C0047;
        Mon,  5 Oct 2020 08:02:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 05 Oct 2020 08:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Y1hLXBtPe3k97QoXYWSp0TNpaRs
        DYWsWj/6aYARplJc=; b=AVpuGiwbvil/tdw1QM+J6qsmYMDGZ0aI4A025mpMYHY
        8HU+1drPe5GvQjjSE9MRokekIkjNEY1DPeMDI/i6zW3ODbiYtdZu+KlYrZfHyShH
        KBnSdif1rcYG/VNdYELZ0m2FcswIPJFULOzwDG9+Utl2q03/wpL5A5n2rd+A+STK
        et8QhU7YSalDszFmevEQuMbzLrhlGSwKKCWO+ld4+6aQENj5etNrw3VMep/i6Ga2
        X5AT1UwEdb4kEJ6ZYEM1YfdgIxusjeq7wZeyQ1x1l6L/U0xd+oMg2CEw2nG81TMe
        szppAfd/gkFdI7QhJ7VQZLhUDYdSIFNLnJvMWHspSwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Y1hLXB
        tPe3k97QoXYWSp0TNpaRsDYWsWj/6aYARplJc=; b=d3+QRcZbJJe3bdYIb4A8Sq
        pEzZ79XrSqbroIsaaN6r/2fslztOPD9lteQE7P65T9USzA7f6EIsRtFB+XoeK/cV
        10YE6LijEjgnKMwH94TH7PCCKKtW1Sg5JeqWDatQNE3Ia9n+be3/X2cv1kt6l6r5
        Lv8jnqg8BF0QC7nrc0zYnycY97neGoQ6L05GAYYiVqWypZTARkttPfBJel3flN5J
        O8iycVVabwKCKb6MovPc7bIu2HdvMP0Xplw5m6uPniA4XSf4ij9wqfGiLQc1kg3J
        Eh3YVLAiA68mKXN9va0UytXXLWTJJwaYQXy+qJpa4f3RaYkvY0PAb//xnGJnWqdw
        ==
X-ME-Sender: <xms:Owt7X01V-Icm8-0CoCajiphcpKu_c6gSjMiVDGxiSWEIzDfxglv7NQ>
    <xme:Owt7X_GbUbJ29zUJhJb-1RlEAYqr0R8NQ7fp4AjQssTyBRbljZw1_KC6G1P99Z6e2
    dvHW_pYuGZ6ZXtnuwM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpeegnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:Owt7X85DZvaMNgu14GEVZ_2q-U1qnLaGYZaMPkdtaXD7UTEIhQb3UA>
    <xmx:Owt7X91eQTWY0X-Ps9vH4EuYjF9Xi6x_0YuZD7FRn-DxhvuHaS31-g>
    <xmx:Owt7X3G2D76tOJiGWQoJSSrUBLEfVj7SXhb7PzJb6BhVcyftcvXYcQ>
    <xmx:PAt7X20EjuVhC5LITus2RNj8o-Y6EFVSGBaXGbTkRamyn4dGmby3DA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id AA9D3328005E;
        Mon,  5 Oct 2020 08:02:03 -0400 (EDT)
Date:   Mon, 5 Oct 2020 14:02:02 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/25] ASoC: sun8i-codec: Enable all supported PCM formats
Message-ID: <20201005120202.ercvwd4cpbm33kdc@gilmour.lan>
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-23-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yeww75x6wv54vvjq"
Content-Disposition: inline
In-Reply-To: <20201001021148.15852-23-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yeww75x6wv54vvjq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 09:11:45PM -0500, Samuel Holland wrote:
> Now that the DAI clock setup is correct for all hardware-supported PCM
> formats, we can enable them in the driver. With the appropriate support
> in the CPU DAI driver, this allows userspace to access the additional
> formats.
>=20
> Since this codec is connected to the CPU via a DAI, not directly, we do
> not care if the CPU DAI is using 3-byte or 4-byte formats, so we can
> support them both.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--yeww75x6wv54vvjq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3sLOgAKCRDj7w1vZxhR
xYDWAQDr5q94Ogym9NGJaETJjeya3WyYjNM3x/lY3+7DgCc4KgD/TwWZmKkUiPVh
4jSuQX7i0eDIXg/CHVOvPPRkRwj69Qk=
=EhaR
-----END PGP SIGNATURE-----

--yeww75x6wv54vvjq--
