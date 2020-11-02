Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1902A27B7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgKBKGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:06:35 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:47223 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728004AbgKBKGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:06:35 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 700BEE3B;
        Mon,  2 Nov 2020 05:06:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 02 Nov 2020 05:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=AP/YqtABarQe6MzZIB/L2nQZH3Z
        zHxt15yvG7nEYn+o=; b=gyUFXc+38GHBJlyyQOTd8Hs+j6jdRcsA2d49cyWujE2
        nDEB+Uy9A+ZcBnnST9h5PuepGoYEkwFvA6WcoCKgG4RUWiFfB5PNKXo7pDeE7Vtn
        Ekxs8XIfVEfUO6adKqyvsNZd/hDaU63KIRPI8KsTSdfvp5x8QME1g6LtIqDhKLnS
        xhQT/UjbOBMsHFrP8Z8CDqRlJwQRzoP8dG7VSUUwKgTiiba08lDj6pfnK+85eaq8
        lkcGUG3SCzfh+qKCwbMOGDweB4ILU6QFlKr5gKY3InXotB3+xj4zejyNkEvHet48
        3K9EcVVzi6RSiPI0Qafh2yvl2uRs10g81dOzlIM0ZzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=AP/Yqt
        ABarQe6MzZIB/L2nQZH3ZzHxt15yvG7nEYn+o=; b=PuRJHubtJL/D9hU6brh97Y
        hRRSLW+3El4b7sG34mGVGCzkDwepBpzu6/81nW0/HEiI3UD1YQp6N296WBDp9iP6
        x69xr0322rRRY2A0hv5ILQQQtBAo+yLr/17uKt+TB/ZYkMHGSx66NoJwVBGpTHlg
        LMt9yVlPs74oe2UU1GhcblRGaldF0fcWxABS9KAHuUx83F0sCClCj5on+0cxqCic
        fPvgLFDgs8KqA8pel5e5DeSatzgDkDAnbI2KNpJ2VnpP63mFcRk/caTwF2S3Le2d
        nWDVx2kiQK7ifE5nq1mwH7WXPo4wK2ov07U8ZrFzjK4hOEDNPqu2uilfj6A0u5og
        ==
X-ME-Sender: <xms:KdqfX4GF8VZjjioHTpjx5yHFt8GYn6ItHiTmP6x3-61GhpPw_RTikg>
    <xme:KdqfXxXaqTuJ19LMyPfLAwnHoYArR4QbmjZR6cGw2U6LzHndEgdCNSwoMnT4xMSmp
    9dJ_ezwJiYgHed_aLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtuddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:KdqfXyIR_Tm3XmJHKLyxqMeR1SZgxM6XpbCW5aagxyUfJreoRE7j1A>
    <xmx:KdqfX6FDYJonRXEG8L4gpcVpCiTZ774eqG-z5Vi-_a_giy4JXv770Q>
    <xmx:KdqfX-U1b2rkB56sGcYZC-UTYJi5Kw2zIDjoRsqSGSNqd_hfrkq0Iw>
    <xmx:KtqfX7g6s4yc1PMHupmCsOcf0lDl0Jsj3wHt7KWfrs_ukLrNEcC7MQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 924F03064685;
        Mon,  2 Nov 2020 05:06:33 -0500 (EST)
Date:   Mon, 2 Nov 2020 11:06:32 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Matteo Scordino <matteo.scordino@gmail.com>
Cc:     wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] ARM: dts: sun8i: s3: Add dts for the Elimo
 Initium SBC
Message-ID: <20201102100632.g5tozkzfjzzch4ny@gilmour.lan>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
 <20201030234325.5865-6-matteo.scordino@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vtixvegn4iodbojd"
Content-Disposition: inline
In-Reply-To: <20201030234325.5865-6-matteo.scordino@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtixvegn4iodbojd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 11:43:24PM +0000, Matteo Scordino wrote:
> The Elimo Engineering Initium is an Open Source Hardware Single Board
> Computer based on the Elimo Impetus SoM.
>=20
> It is meant as the first development platform for the Impetus, providing
> convenient access to the peripherals on the Impetus.
>=20
> It provides:
> USB-C power input
> UART-to-USB bridge on the USB-C connector, connected to UART1
> USB-A connector for USB2.0 (Host, Device, OTG)
> Audio Line In/Out
> Pin header to access all signals on the M2 connector of the SoM
>=20
> Signed-off-by: Matteo Scordino <matteo.scordino@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                   |  1 +
>  arch/arm/boot/dts/sun8i-s3-elimo-initium.dts | 28 ++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-s3-elimo-initium.dts
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 4f0adfead547..dcfb8d39c267 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1210,6 +1210,7 @@ dtb-$(CONFIG_MACH_SUN8I) +=3D \
>  	sun8i-r40-bananapi-m2-ultra.dtb \
>  	sun8i-s3-lichee-zero-plus.dtb \
>  	sun8i-s3-pinecube.dtb \
> +	sun8i-s3-elimo-initium.dtb \

This should be sorted as well

>  	sun8i-t3-cqa3t-bv3.dtb \
>  	sun8i-v3s-licheepi-zero.dtb \
>  	sun8i-v3s-licheepi-zero-dock.dtb \
> diff --git a/arch/arm/boot/dts/sun8i-s3-elimo-initium.dts b/arch/arm/boot=
/dts/sun8i-s3-elimo-initium.dts
> new file mode 100644
> index 000000000000..7677ddc07bf9
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-s3-elimo-initium.dts
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2020 Matteo Scordino <matteo@elimo.io>
> + */
> +
> +/dts-v1/;
> +#include "sun8i-s3-elimo-impetus.dtsi"
> +
> +/ {
> +	model =3D "Elimo Initium";
> +	compatible =3D "elimo,initium", "elimo,impetus", "sochip,s3",
> +    "allwinner,sun8i-v3";

You should indent that properly

> +	aliases {
> +		serial0 =3D &uart0;
> +		serial1 =3D &uart1;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +};

It's already in the DTSI, there's no need to duplicate it here

Maxime

--vtixvegn4iodbojd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5/aKAAKCRDj7w1vZxhR
xTCcAP9A5eaG4zp+uRq9V4pmAEZ/N8oHvIpEWTJ6DMc31yWCTwEA6q3Ozu/epgFx
BoI6slmWzDPQKiDGl0guYHROyZ+MDAI=
=xHsN
-----END PGP SIGNATURE-----

--vtixvegn4iodbojd--
