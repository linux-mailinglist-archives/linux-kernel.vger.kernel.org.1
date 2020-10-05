Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062582834FD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 13:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgJELaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 07:30:46 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36883 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbgJELap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 07:30:45 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A329C5C0161;
        Mon,  5 Oct 2020 07:30:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 05 Oct 2020 07:30:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=0w88DBGKAhgLFUf7eu3Tu2FkzP2
        57wGCxMP8hGv9EwQ=; b=UVNK0mlYtiN8t95SYZUsnyteeOVjOpYz7SMPpY1AQ2W
        lRKuD73AKAbmxpKD4FdVO8S7AthaIdQ2IL58jE00bhDg+T1llnbi66sB1lq+Q27R
        53y0EiuxjERMbcGSUlMbc8RHcgWbmywVuCpog0vqE39X4H+RwlJ9EZhTwvWg1Qvc
        E3StfSOEfLXYjKiATmD882UmiLCE0j2e56H6IFdMqH4WDXuKypLurjGU6Gkvp2ET
        yh0dI8X8YSo36RrIUsjVhhAW6uK/X+RLbdPI1C7poRcd0QhpaANtsE5l0I0O11Eg
        z8vbgPsfaoRgZX+yLglpP5zwIvnuSCnj0Pgv3x6Cmzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=0w88DB
        GKAhgLFUf7eu3Tu2FkzP257wGCxMP8hGv9EwQ=; b=dJfWV7ILT/7BqLfAADzBIP
        Jnox/SHJwZP9IZew1IyTdtbfk4JuUA4zViqYzRdpAQWtJ6NVirksLCIF0aMhG12g
        pFeihPXEdDzco9KQzAnHK9Qd4WkxxgGiP8mZb4SSO6Ue8b/B+tU3yyygnbR9mgKd
        35kGr9ieEjsAXNtlasvJVP6uVg9V/aOKumiELxCKL2pQwTKaGtEidivBgqOiyEE3
        Y/kFT3E4Pgob0wBhpRc0furLv9XPQjmdef8nVosg/NospNvAGmvRgcFiMI3+LrFw
        1OO8NvaMPajzgEqw0AAfBmDMMVdXUIZ2gUQVcHB9rE8W9nlSou1rY1zDCI7W8x7g
        ==
X-ME-Sender: <xms:4wN7XwuMBG86z9VNIngA4TKtw0kgMMGqeM2w0xtHT5CAaJBFUtrOkg>
    <xme:4wN7X9ee20ZTkA6ebJsarord9ZTah2bwrR7aAMmnakB6W1zyBpGYa_0oFqirOFyL_
    05OnCbcBmZr2AYcNs0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrgedvgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:4wN7X7wjzFNYkcVtJmaZi2dDMSjUxQ6SOqNjBoJTxpjKwdpubpiOuA>
    <xmx:4wN7XzOLOVTeoFGMXukW4CzEkH-sWWdF4LA4qMyu1HN__kS52B7lKg>
    <xmx:4wN7Xw_b11g1FZQbXoALGZJYHPFoJhmmd4X_0krnaImnAFDu43vlFw>
    <xmx:4wN7X9OM1kAu1GBtoNYuimA1JQX710hjdNqL7aZiRFwc_SVQ7m93sg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1F5353064680;
        Mon,  5 Oct 2020 07:30:43 -0400 (EDT)
Date:   Mon, 5 Oct 2020 13:30:42 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/25] ASoC: sun8i-codec: Program the correct word size
Message-ID: <20201005113042.whe7rbwbn577mjp5@gilmour.lan>
References: <20201001021148.15852-1-samuel@sholland.org>
 <20201001021148.15852-13-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mcqs7d2akjb4wh2q"
Content-Disposition: inline
In-Reply-To: <20201001021148.15852-13-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mcqs7d2akjb4wh2q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 09:11:35PM -0500, Samuel Holland wrote:
> The hardware supports 8 to 24-bit word sizes on all three of its DAIs,
> only one of which is connected to the CPU DAI. Program the word size
> based on the actual selected format, instead of relying on limitations
> in another driver (which, incedentally, has patches pending to remove
> that limitation).
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--mcqs7d2akjb4wh2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX3sD4gAKCRDj7w1vZxhR
xVb5AP9WzBxZUrtowllJ0MIvYjPWOg2h5mKh/KXskSb4AcQOFwEAtiPmv0wor2UW
3m/4VT/7vIAc7wlp5VO6G+LxXSuzlAA=
=+rHz
-----END PGP SIGNATURE-----

--mcqs7d2akjb4wh2q--
