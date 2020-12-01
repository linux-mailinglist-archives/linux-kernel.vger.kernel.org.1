Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79E72C9FDD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 11:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgLAKeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 05:34:46 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:41191 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbgLAKep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:34:45 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 40A4E12EE;
        Tue,  1 Dec 2020 05:33:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 01 Dec 2020 05:33:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=0LEfd4MCIrC63dAvEa6z1MW0wtY
        FYRkWZYqY55AEO8g=; b=jSVkKhsgYZeSIM++cj4EeOcK+b3KmjZNTi6FPx5B721
        Pt2qxkJcAfgM91OgCCovFez6CqdU/dcnXgzWn7UZA6N0uVlacZWvsh2RVr6o1nKp
        BaXqS97EdYzmHDEWlLLrCm1ozESoCg0PGtxIZ+ddqYEtVyjhGJZOew/Cls0QhQr2
        5iqtOxjDcHc/HVkgnEx6HuZ9TAdyvAW+yKyGIJBAeaEsf9gY+699L28W7IRoMWgp
        rKiv37s4sXoi6lPnf/8fieN5EVYwSIDyZmax2+Gac9RPxax4LXZGT7vPaUnIO411
        I1QhAdnhw6tLjKAxwRHR1iw/iOzozyNH0Xz4eJidqTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=0LEfd4
        MCIrC63dAvEa6z1MW0wtYFYRkWZYqY55AEO8g=; b=TBqmcqoXxOvtWbFmXKpv3I
        7xGFOb+fBksE+xxjusPd+eX3xKve+bHPy9bxuai/VoONGbFc9BrXvlLJPMbluXIF
        dlsWA+nGVgxeZ5eMYafVMy/odL26cTIhvBnB3C/Scu+xqZV/L5TupRZNzPhige7w
        dDFxWeYqzDJLBkHRSV1L8q/M+C1ex4MtXppwexKiRzFXqns9p6gDcCME82IUD/kz
        Hzbn6A/8vfmZH/3r9/2Gfonl14YkFB1u8jRKI6uBecp4CKazozCltN9LdK/ElNZ2
        85q9bLBWKHmRYJa1xi/zn44gfihXmG621ZLuurFEbVgauT4I/xRHUWhg/vHts2Og
        ==
X-ME-Sender: <xms:FRzGX1saAobQBmoRaP2Ql8kz9q_5KMBOOgAyoyqxYS8KakAFRKoSYw>
    <xme:FRzGX6IzHZyxxL055yVKFTY_3Yf2zbXcxtGPgGQrF_cgxWpcY1MQ9wuKh8KyKRgjd
    ygQSJOy0nQUb1BoO3U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeivddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:FRzGX1OJn_o_oS7GTYyC2YINhiHWAch-ta9Wi-SjkZ6pNCq2ValGjA>
    <xmx:FRzGX1Xi7_m7CPiHfZXO7A9W0U5PlWGt_1tLbneGfkeHwyiiuUbz4w>
    <xmx:FRzGX7kz2iUdCaANsm-3_P5cqD07grJ93w_stRgB4XWFh7-RXKN7kw>
    <xmx:FhzGX7h991ektQJ-dSnXplKgbbv3dBQQPaeu-GmHT_kSMfM7kg5ckA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B9E0D108005C;
        Tue,  1 Dec 2020 05:33:57 -0500 (EST)
Date:   Tue, 1 Dec 2020 11:33:56 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Willy Liu <willy.liu@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: allwinner: H5: NanoPi Neo Plus2:
 phy-mode rgmii-id
Message-ID: <20201201103356.qedqb24n5ucx2eps@gilmour>
References: <20201129194512.1475586-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xmjuxfopfcov7c44"
Content-Disposition: inline
In-Reply-To: <20201129194512.1475586-1-xypron.glpk@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xmjuxfopfcov7c44
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 29, 2020 at 08:45:12PM +0100, Heinrich Schuchardt wrote:
> Since commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx
> delay config") network is broken on the NanoPi Neo Plus2.
>=20
> This patch changes the phy-mode to use internal delays both for RX and TX
> as has been done for other boards affected by the same commit.
>=20
> Fixes: bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay config")
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Applied, thanks!
Maxime

--xmjuxfopfcov7c44
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX8YcFAAKCRDj7w1vZxhR
xb7BAQCqCR/UJ4Xh5CChtMLLJuo9b1NQwbTyk2T93GgLjg+I0QD+JzUXAMFE+LVk
YnlfT8pUzdg8JUEF37cKbBIuXkYgfQ8=
=Eupy
-----END PGP SIGNATURE-----

--xmjuxfopfcov7c44--
