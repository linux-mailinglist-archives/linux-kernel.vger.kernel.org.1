Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401692C9FDE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 11:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbgLAKeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 05:34:46 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:47843 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726871AbgLAKek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:34:40 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A018612F7;
        Tue,  1 Dec 2020 05:33:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 01 Dec 2020 05:33:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=miypkxvthetDBOn9oi94R0JCWeh
        iNAhQ1JY9FWr5gUc=; b=ZQ8sL1l9cQD7eWkMldcwaECkS5P9JRvlEYdsNBfi8WD
        4VnLiM7Jd455Gwy7Euoh70SntSP0PTLWRlwaWHbtXHdjF7HoSwEJD5ntjWCrrBtV
        mk8Th7bESJw2AFWreCY4ZwTMAM0+BdeEOaDhM63MLHxtm8JTY62jUCMzvvZJfyXW
        WEmm2nWT8WUF7G7ub1aAzKrdEaoC0DAfontrwJQ2SfAgkCbHIMv2p/U+mon2JHQJ
        NKIXUCVbwP+w7+ynSpFKWR+1e/YSw6Um/a+nJgTZzuxK7C7Um2kQKz4XOrBH4YnH
        4jruP/9Lntor5HJzgESt5T+KBli5tbrwIklPFp2rWuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=miypkx
        vthetDBOn9oi94R0JCWehiNAhQ1JY9FWr5gUc=; b=C5jRc34TmyVb+Jd63uC2MA
        zKp4aCpTW76YZPSB163pksJSuscmk+YfwxKLbUDxDMT+3I5jhc8MvEWJF7D4DUdZ
        NmA2z54wIyiB4/0Ytt3JS7Dyd7Y6/fGqK8ZV9XzhW51DOvcnsRZeKxDSs/3Sf5JH
        KjrD6NFG3efWb4/sGBREWRzYcezYZRkEW+geJmvcp9wzXmU+tCCzJuA8qexMSCys
        c/RKoojHq2AenVXcUU85EpHVN7YnRFrLK5JMER1ZwOdSxAxHSt/op+TS3wb6OXLk
        U8wDt40mKvn0k7QE67HUxHcjSzzmuhCrz89V/Nv/CfdGSHFRUbriZLx+vIjkgttw
        ==
X-ME-Sender: <xms:ChzGXyL1N8TP0-FRdDWukIwdI10Yvyua1oTeNyUFQLZ-rDIhzKjbyw>
    <xme:ChzGX6IHXpEpPYRKXtCDUxoZWtwGX08FBZ1ddOSmy10Y8Cfr9mYqfI1PGwvYDqxW5
    asxWhi32JwT1sar-TA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeivddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:ChzGXyskndzYKl9H-N95TZddXCmzRBubhrLtNIu8mclmadyItNZHCg>
    <xmx:ChzGX3Z07gOTVhyIh8pLK2hNGTIhbYxLeyyMLcce51VpPFEHKZRSeg>
    <xmx:ChzGX5ZeNdYNUAc-8ICi5TCqzbU5s3gldoJum13DVE2yBj7bukKZ2g>
    <xmx:DBzGX8ybq8L_BBQFISfAwY1X1DXp5Cly50z_7ypcpVbs4OFBuTO_8A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4FCE73280068;
        Tue,  1 Dec 2020 05:33:46 -0500 (EST)
Date:   Tue, 1 Dec 2020 11:33:44 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Willy Liu <willy.liu@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: allwinner: A64 Sopine: phy-mode rgmii-id
Message-ID: <20201201103344.5zc35klj334aflpk@gilmour>
References: <20201129162627.1244808-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="phy4sbo5vae5y3zo"
Content-Disposition: inline
In-Reply-To: <20201129162627.1244808-1-xypron.glpk@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--phy4sbo5vae5y3zo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 29, 2020 at 05:26:27PM +0100, Heinrich Schuchardt wrote:
> Since commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx
> delay config") iSCSI booting fails on the Pine A64 LTS.
>=20
> This patch changes the phy-mode to use internal delays both for RX and TX
> as has been done for other boards affected by the same commit.
>=20
> Fixes: bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay config")
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Applied, thanks
Maxime

--phy4sbo5vae5y3zo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX8YcCAAKCRDj7w1vZxhR
xf02AQD/FiprdlhjFA/6zTeA0NIXyimkwUHILyJsDztvkohCygEAq9I6EY0gfVLt
MCyjkdzLXqvbUOwgm+7AhXF6gadupAM=
=JuLM
-----END PGP SIGNATURE-----

--phy4sbo5vae5y3zo--
