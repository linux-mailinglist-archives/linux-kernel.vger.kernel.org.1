Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4421128B94D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390121AbgJLN7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:59:14 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:39167 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731466AbgJLN6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:58:49 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id E644B5802DE;
        Mon, 12 Oct 2020 09:58:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 12 Oct 2020 09:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=sEZcyXmHBZEDouzMk16DQ7A+uj0
        n9Hmw8HMTAmUqJfE=; b=sNqTujZFyiNiSFlovqDYbgmqHijW/8SVF36UDKYU/tU
        J/nk7oXUFQX7UD7rs5Y6GbMsXrbvNQCPZabRxPYLevz8+Cmc4epqgShk3HvHQkt0
        qdrNpT6Ig1skcbAFNGbJUQ6BR9voFaT+MXr3lbLrDuFeFp7TNIqQcan2t7jeq1S0
        0FO3p7lfq4fbMwO6Im3/fVtcQ1HMDqZdfyW0uBCKs9sRjO35iLyOrt+4weDOeiFt
        9EboT8moNnJc3PFKABj2rF09KctylrVgAYIdZM0WDLCmHM72/ViByTI2zy2l5mm4
        8P0U7Y3MR12GIwamvxyXK3JGshlhHkG9VCKknT5ivAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=sEZcyX
        mHBZEDouzMk16DQ7A+uj0n9Hmw8HMTAmUqJfE=; b=eYXTngJGlD5XLuscT3f0ex
        DOhZj5i7CgiqFAuuJmlMKnfhJW4ib8I1mq//bAaWM/0VGNWwA52a2WrhT9/CQbST
        fQsPhNPwujfdsipbjxlY/NtxTEJ0CqYYrOHH4en9uQMFQj1EwHvfK+iFNh8mzPKU
        MWjQxigheo8gWq4jYPyEgIw757x1Eav+e7xTq9q4DQz6DOX4ui91E4rfxPxCLgAx
        ETthHhQBuiD8wk9EWYFArC4m5s23OTUMGrmE1NfYP44XQlwH7qQY5dHm9hiCn1Qn
        M3zYSiTOlAw/ubC5hnQNs1bPMY/F0+UGoN3rNdvEmhyG44yzbdxuNUIF+V3+6M9Q
        ==
X-ME-Sender: <xms:FmGEX1R9UOYg1BipFqTFO1G4FFVuoZZO0hvxY3LVcDhrEA0foITvAA>
    <xme:FmGEX-zwRAqNLFzxYyw-L0af-HpfZ6HBpI0qaAsv4syQ2I0KOqWS-EOWFtzsYBPRZ
    zi8Kxzzhulcd33S8tQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrheejgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:FmGEX630vghiH5FBREanLrOx6Jk3-ZWpNdCioDXorraeIE0jUBpV7g>
    <xmx:FmGEX9AHgSPckErYJ9-I5o5IXw34A6ccxuyOW-Y7t_LqBXVBvAVA-A>
    <xmx:FmGEX-j3-NoJ9WyhNitdQD1ptwoy670KMcqVDnT4yq8u1Sb17lrBcQ>
    <xmx:F2GEX_ZgaIP_SSeCWTSSC5MS5yw6_JhptqZgR98wYt_gZj5BnYu25w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 577493280066;
        Mon, 12 Oct 2020 09:58:46 -0400 (EDT)
Date:   Mon, 12 Oct 2020 15:58:45 +0200
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
Subject: Re: [PATCH v7 01/14] ASoC: sun4i-i2s: Change set_chan_cfg() params
Message-ID: <20201012135845.s6tknsnjrtsuoacf@gilmour.lan>
References: <20201011202224.47544-1-peron.clem@gmail.com>
 <20201011202224.47544-2-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g3qoejqmxfoskuxo"
Content-Disposition: inline
In-Reply-To: <20201011202224.47544-2-peron.clem@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g3qoejqmxfoskuxo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2020 at 10:22:11PM +0200, Cl=E9ment P=E9ron wrote:
> As slots and slot_width can be set manually using set_tdm().
> These values are then kept in sun4i_i2s struct.
> So we need to check if these values are set or not.
>=20
> This is not done actually and will trigger a bug.
> For example, if we set to the simple soundcard in the device-tree
> dai-tdm-slot-width =3D <32> and then start a stream using S16_LE,
> currently we would calculate BCLK for 32-bit slots, but program
> lrck_period for 16-bit slots, making the sample rate double what we
> expected.
>=20
> To fix this, we need to check if these values are set or not but as
> this logic is already done by the caller. Avoid duplicating this
> logic and just pass the required values as params to set_chan_cfg().
>=20
> Suggested-by: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

We still have an ongoing discussion on this one in the v6

Maxime

--g3qoejqmxfoskuxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX4RhFQAKCRDj7w1vZxhR
xSBFAQC6KZxQXo2wkmG7IYJL8mCSpdD6xPNJqcknI6+pUmt2uwD/QQEBR+rIzK8+
3i5szDEx6Z3mAunz7uCj/u9/KpumUg8=
=PQvS
-----END PGP SIGNATURE-----

--g3qoejqmxfoskuxo--
