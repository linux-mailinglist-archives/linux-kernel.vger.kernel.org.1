Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EB72A81B8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 16:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbgKEPAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 10:00:22 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:48801 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730775AbgKEPAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:00:18 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D5ACACC5;
        Thu,  5 Nov 2020 10:00:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 05 Nov 2020 10:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=BJn9wPMrR4JofyXsEWtrrotLLO2
        dfn1Z/icllyT1CMo=; b=C6gZfiHnzRYyTPedCtVRLR8S2nXf02285yOXiQeOPn3
        nv+YtIk08c4Hd0K9gEHJs+bFwYw11/kZ39WK8LeB6YJ8ra8Ut4dErsp/J8O+8hjd
        NugCkiHRSBLpXfx3sp64SjKbx6cLcmJUoROnU6ZxB/K0J1llmN0IXg8KttUrE/pn
        eOGxP4jemrsnPAhInUV+hyb+OSdQu49r8I+ojZ0i3IB0XT6BKwblzPlhFsaIo1c/
        UY7b6LH/KD5RmszJM/vfC+P6XrcwtpySn/KXsTcb4z6BkTkc5kJV1n9WUDjAgSWi
        FUvuxr5Kc/02UoHkwYokj8z+E1ZayBAG033DxbWsZaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=BJn9wP
        MrR4JofyXsEWtrrotLLO2dfn1Z/icllyT1CMo=; b=YIakUvPlMaPArchhzYNu8R
        UA9zqsTi2yd+xYJHHATPndDNu81/WlGCvlolXcXGtZarDlZJoKyCKDt8MQT9EMOI
        KeIjkXVj1VeXItZ/6QwbtN9+PuIOU3BX0R4j1oLdm5szWLDCS0boSk3UnBHGTuvL
        kDV0Pmul+We0CZ5w4DAZ8NAmGyZqvDqKLP8BVo+vD2HhLds1TsPnRWgB2JByB1Nk
        v5Q3PG8Mfvz8LePpcU0X4ecJF3Me4InAupAaacP2T8lic0+yB9YFi2dwRYIrCZv0
        Ossya13oGhFIRktao2BDlyo+fLFnNgf8WLgSL3QepFgKlnSqVa6b7v7XtbYOyBqg
        ==
X-ME-Sender: <xms:fxOkX3psu_xWUIVh7MePbIoAGbok08Zp3VxX59OI1XnsC3vXvrh6Aw>
    <xme:fxOkXxrosBMG0IWqcGr-lB6qLGpEua049fWJnZQLFj2XcjuKOUUjQboW2DdkIRCSM
    dBZ0Uj0vCkBdUXIe1I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtjedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:fxOkX0OHMs7jgwx25i11uB2gBGaoR3c388KJ0lKoa3GXig9YzTwxtw>
    <xmx:fxOkX641sUFNqQeO0LJJfXQ3G2nW1SEp06D16H_zUlvRpY4x3LqOmQ>
    <xmx:fxOkX27zWcsGA74xw0U314vRmh6wmjJcKFSAmZd38VJx0TOQ28XOmQ>
    <xmx:gBOkX2HAelJ-mradMjgRHuom7bf9tJ09Ay_uRLLFVPuuGlGGD5kulw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2F4F532801D7;
        Thu,  5 Nov 2020 10:00:15 -0500 (EST)
Date:   Thu, 5 Nov 2020 16:00:13 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Matteo Scordino <matteo.scordino@gmail.com>
Cc:     wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ARM: dts: sun8i: s3: Add dts for the Elimo
 Initium SBC
Message-ID: <20201105150013.aruomoglclrpaacf@gilmour.lan>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
 <20201105144945.484592-4-matteo.scordino@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wmqgwnuarzy4ciml"
Content-Disposition: inline
In-Reply-To: <20201105144945.484592-4-matteo.scordino@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wmqgwnuarzy4ciml
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2020 at 02:49:45PM +0000, Matteo Scordino wrote:
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
>  arch/arm/boot/dts/sun8i-s3-elimo-initium.dts | 34 ++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-s3-elimo-initium.dts
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 4f0adfead547..50e438ab8a00 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1208,6 +1208,7 @@ dtb-$(CONFIG_MACH_SUN8I) +=3D \
>  	sun8i-r16-nintendo-super-nes-classic.dtb \
>  	sun8i-r16-parrot.dtb \
>  	sun8i-r40-bananapi-m2-ultra.dtb \
> +	sun8i-s3-elimo-initium.dtb \
>  	sun8i-s3-lichee-zero-plus.dtb \
>  	sun8i-s3-pinecube.dtb \
>  	sun8i-t3-cqa3t-bv3.dtb \
> diff --git a/arch/arm/boot/dts/sun8i-s3-elimo-initium.dts b/arch/arm/boot=
/dts/sun8i-s3-elimo-initium.dts
> new file mode 100644
> index 000000000000..2119403fb65e
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-s3-elimo-initium.dts
> @@ -0,0 +1,34 @@
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
> +		     "allwinner,sun8i-v3";
> +
> +	aliases {
> +		serial0 =3D &uart0;

This alias would come from the DTSI

> +		serial1 =3D &uart1;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};

And this node too

Maxime

--wmqgwnuarzy4ciml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX6QTfQAKCRDj7w1vZxhR
xdRnAQDPm0Nat9M+Vuk9UOFh7ENvDdddRVxrysZxRC4o+JQYAAD/djrfBB/7Hmsv
mFYpt77vn07SQjgZAHS95pGs/5Vn0gI=
=AYpT
-----END PGP SIGNATURE-----

--wmqgwnuarzy4ciml--
