Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E43E28AF74
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 09:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgJLHuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 03:50:20 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:55399 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726530AbgJLHuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 03:50:20 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id CCA92A40;
        Mon, 12 Oct 2020 03:50:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 12 Oct 2020 03:50:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=2HnensbnRprVfrAOh35A98n6Gnw
        TpILGBDYJWovEqMY=; b=sY7+LG0RS2beLeI8+yLiCSLAA+Rblj3FifxozIo6O1A
        DPRS89Se6q3fFdMSim8QdJOWqceI2lXeoA0HAzBieI+kDPMJnYUDI2CiRDZIQceW
        PbJwOvaPpsQpn36Qvf035Wnvc/MG+BJFfThdjHVKsOgkCK3pMSbfsjRqmMQa7lJk
        atxk4y9wtOicVsR7w/8H2FxIpMWDAEG8wMJrxGDgwyOhLrFv6+q4Mk4JSS7VSgqy
        8rZ8B8AnuVYELE3zOiRJ9dM7s+N8CptrCC4eVnqRAiN2Bda1vsPi900XAfnBip8s
        diuS7dFsocsS+wIkNLZrb3vPtpPjbQYXfQPXhflyl2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=2Hnens
        bnRprVfrAOh35A98n6GnwTpILGBDYJWovEqMY=; b=rLLk3r4AtF+SB58qw/mclg
        jzVFqgMIChrUdOf+2yQxsR+zqHZ9Fqc+NnH/ps0iLP1kFOYqDICkS9kTRVHY7KmF
        uSCRIqdO00MlaEAoaluoFgmWjr9Mls/VbCPvkF0YtzfO2/sNRUGpA7BGc551ZyXt
        dm/vwR8BRGlr4kMkUhOxcrdc6+Ykrfc7lSWYQDMJYoERWmjJ7EpFwL86m+AMdmMP
        w3NnY4Ke7f1sIi5zPWNDDTY1yLMmrCkBB4nxnbY6TEsYpQWoukTVrCfiw72MptOK
        O/WzD9ygq9XBJ2SD1qCedH/KvWdYWx3H1wjPQec58JQI+NcvELGjRn6VZt7B4D2A
        ==
X-ME-Sender: <xms:twqEX0jv97MNjIvP_xjQi0B-XmFflF7nass8cz70S0m0rhjEmk7Ptg>
    <xme:twqEX9Ct4a-f1IKhJi17z3HatUHWCQkiEsCl1pfGVL038HVTiaV457reRYBUxq5YO
    U9oiKZEL-vwwCwkW7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrheeigdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepjeekkefftdffhffhvedvudetgfdtleejveffvedvvdetgeeltdfggefhhedv
    ieffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepledtrdekledrieekrd
    ejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehm
    rgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:twqEX8E5YDgV3dR_t-nmfzMXPC6z-ogN8dRXh8Mm21rpLZI5VTRpSQ>
    <xmx:twqEX1Rpq1WERqXCJRUJgRKrffZ1D2ZeTApnzjshFziWABnjamFCuQ>
    <xmx:twqEXxwVUagdMRNqZJI83CTTUpnVUNk18VVsCGrBx3jhkO2pqDIAcg>
    <xmx:uAqEX4m237mgCXkIEPZsFNQxV2By3uNwaJrgfh92GLZhcqNM6yVvXQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 165FD3280059;
        Mon, 12 Oct 2020 03:50:15 -0400 (EDT)
Date:   Mon, 12 Oct 2020 09:50:13 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: sound: sun8i-a33-codec: Add Allwinner A64
 codec compatible fallback
Message-ID: <20201012075013.yrpknpbrzl5f5eah@gilmour.lan>
References: <20201011211543.155561-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gfrcskavm3inlijo"
Content-Disposition: inline
In-Reply-To: <20201011211543.155561-1-peron.clem@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gfrcskavm3inlijo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Sun, Oct 11, 2020 at 11:15:42PM +0200, Cl=E9ment P=E9ron wrote:
> make dtbs_check report a warning because the documentation
> for the A64 codec compatible is missing.
>=20
> The A64 codec compatible is actually a simple fallback to the A33.
>=20
> Reflect this in the dt-bindings Documentation.
>=20
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

This patch is already in the ASoC tree and linux-next:

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/Do=
cumentation/devicetree/bindings/sound/allwinner,sun8i-a33-codec.yaml?id=3Dc=
ef305d4eb0733f25215793ed30b056a7db9bb62

Maxime

--gfrcskavm3inlijo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX4QKtQAKCRDj7w1vZxhR
xXmWAQCdAPjX+5B94QYZ3ivKkRQ8tkyEOA9yii0hciLUC6QpYQD/aUoeE4LN0aJd
+rwe2tScwX9STO93maFMZ0Gvx0vJ+wc=
=7oTv
-----END PGP SIGNATURE-----

--gfrcskavm3inlijo--
