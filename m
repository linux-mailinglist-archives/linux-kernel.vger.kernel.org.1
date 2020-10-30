Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA8329F9A3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 01:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgJ3A0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 20:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ3A0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 20:26:18 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76996C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 17:26:16 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id h22so1468978wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 17:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=Mb2hc4MpPZ00GqiqGOtkkKxmWtt67FONuXv9ver+BN0=;
        b=G5Vvym93PNQulnqiwa0EIxJzBLmcCvL1fTYl2v1n8oVH5iim448fSpMLsPEp9xeKHh
         vicP1RRXRBdnOB8Tx3r6h5Xbx4SaR1UeIqE7wwdIagLp8qYzgfZ6gPNdtYwokhlKF/Cn
         D+jLE8jvF5zPv6kRsvVEI/V3g0yB8NrFw9lME3rC0sgdHR4zYgRZvHfTQ2YhFIM5Xua5
         UlBuHxxyHmxH2i7xKJSBVpRdLDYKn/GudC6nexVpFtOdU9s8uo9RJtd9Y7VfyZaPKUjh
         vrphVogIkr6vHC72nI6qC7kgAs6pe4jxAGG3BqMFt2x8XpBJFF1NH3QkIFRVIHabztay
         vAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=Mb2hc4MpPZ00GqiqGOtkkKxmWtt67FONuXv9ver+BN0=;
        b=YzYL4INuwU1+7QLBddnt3ALS3PlJIMzqsbYU1QGNEZPY6YZKzI6Eied6Syy8ZE/zeY
         rvBJP+7UCg+hIgem6HZlxln2oQvdATi5JXBF9coX2jNOW+rgLAdwH/dYT/FvJtHZDBH5
         ZDQXDSeCXOubBUTmjnHmxW0UB0rOlsJ2zgfajKowtTxcxhZA6wypsyP7kwsID6+l4BlZ
         Ij005MQ3XoqOvaTo5cygUc+g6R1XxWpqnPo4ZUNiE7S2qaWDWqTw2AARa3I/yINE2oIw
         UbowxsXcOBeBGKycfZOeCRFEPNtXAHzE7DIzOUHjkxYaGh6ueJlmMAXlkzwPfwcHnnNQ
         JySQ==
X-Gm-Message-State: AOAM5329w3FD/vuG9Y1ILeUXCP4QxqX+7SbQ/8KCS4W6c9R/xmf7wWhG
        NFWiwTHOa28p50eYCWn2ino=
X-Google-Smtp-Source: ABdhPJxLg/0rWmdVPk9i2cU2Uf1zQpwzykQtMCgi95npCZnBtUrLWutjB0e5AzI654zH2LRbAl1MMg==
X-Received: by 2002:a1c:1f05:: with SMTP id f5mr1549732wmf.98.1604017574879;
        Thu, 29 Oct 2020 17:26:14 -0700 (PDT)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id l124sm2282320wml.48.2020.10.29.17.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 17:26:13 -0700 (PDT)
Message-ID: <e8ffc534e18dd9cfc2c747e332f239a64f837bd9.camel@gmail.com>
Subject: Re: [PATCH 5/5] ARM: dts: sun8i: s3: Add dts for the Elimo Initium
 SBC
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 30 Oct 2020 00:26:12 +0000
In-Reply-To: <20201029101030.GD460689@aptenodytes>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
         <20201029022000.601913-6-matteo.scordino@gmail.com>
         <20201029101030.GD460689@aptenodytes>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-4Bm3IR+O1c7xCWq+3Uk7"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4Bm3IR+O1c7xCWq+3Uk7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


On Thu, 2020-10-29 at 11:10 +0100, Paul Kocialkowski wrote:
> Hi,
>=20
> On Thu 29 Oct 20, 02:20, Matteo Scordino wrote:
> > The Elimo Engineering Initium is an Open Source Hardware Single Board
> > Computer based on the Elimo Impetus SoM.
> >=20
> > It is meant as the first development platform for the Impetus, providin=
g
> > convenient access to the peripherals on the Impetus.
> >=20
> > It provides:
> > USB-C power input
> > UART-to-USB bridge on the USB-C connector, connected to UART1
> > USB-A connector for USB2.0 (Host, Device, OTG)
> > Audio Line In/Out
> > Pin header to access all signals on the M2 connector of the SoM
> >=20
> > Signed-off-by: Matteo Scordino <matteo.scordino@gmail.com>
> > ---
> >  arch/arm/boot/dts/Makefile                   |  1 +
> >  arch/arm/boot/dts/sun8i-s3-elimo-initium.dts | 27 ++++++++++++++++++++
> >  2 files changed, 28 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/sun8i-s3-elimo-initium.dts
> >=20
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 4f0adfead547..dcfb8d39c267 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -1210,6 +1210,7 @@ dtb-$(CONFIG_MACH_SUN8I) +=3D \
> >  	sun8i-r40-bananapi-m2-ultra.dtb \
> >  	sun8i-s3-lichee-zero-plus.dtb \
> >  	sun8i-s3-pinecube.dtb \
> > +	sun8i-s3-elimo-initium.dtb \
> >  	sun8i-t3-cqa3t-bv3.dtb \
> >  	sun8i-v3s-licheepi-zero.dtb \
> >  	sun8i-v3s-licheepi-zero-dock.dtb \
> > diff --git a/arch/arm/boot/dts/sun8i-s3-elimo-initium.dts b/arch/arm/bo=
ot/dts/sun8i-s3-elimo-initium.dts
> > new file mode 100644
> > index 000000000000..5ddd4dbd636c
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/sun8i-s3-elimo-initium.dts
> > @@ -0,0 +1,27 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (C) 2020 Matteo Scordino <matteo@elimo.io>
> > + */
> > +
> > +/dts-v1/;
> > +#include "sun8i-s3-elimo-impetus.dtsi"
> > +
> > +/ {
> > +	model =3D "Elimo Initium";
> > +	compatible =3D "elimo,initium", "elimo,impetus", "allwinner,sun8i-s3"=
;
>=20
> Same comment as before about having an extra "allwinner,sun8i-v3" here.
>=20
> Cheers,
>=20
> Paul

As above, I will apply and resubmit

>=20
> > +
> > +	aliases {
> > +		serial0 =3D &uart0;
> > +		serial1 =3D &uart1;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path =3D "serial0:115200n8";
> > +	};
> > +};
> > +
> > +&emac {
> > +	phy-handle =3D <&int_mii_phy>;
> > +	phy-mode =3D "mii";
> > +	status =3D "okay";
> > +};
> > --=20
> > 2.20.1
> >=20
> >=20
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--=-4Bm3IR+O1c7xCWq+3Uk7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEzO0zAuXCENUlBKYqFH4A68XNhRoFAl+bXaQACgkQFH4A68XN
hRoyIQ//fyWBNAXqCokwgC7mIjFvqvbWWduRtzqH8rnJA25Pod4eP9Cq3wJPRjjk
Khtn4LAjxVK+AwyZjHlZ+oEZaNDlsqsZfp+wwj4z6GXwxOCDR++ed8yf3MUKwQ0z
AzsJ19/b8V9K2xd9iVDwi9sU5ppQx9vPKCL1gPTIVf+wL6FDbDdFkGxq7k8mN/96
CfruL6OaXocamnWN7z2MjQl+ME9ef9CeXwQ7c0/QuYs8yBLqV3BBInqsri6Gn2a1
A9JqXWhCVqhE0RdxZtDcS/di3j/rcLVNuMYcl6t0rp7Sq5wqQSVQf9jhFARz7Gtc
JKvH//8ncaY0lkGpb2+uyYdvx7dtaHxtZO/e27efMJeKEc1K6bstNaXj8NPRdDt8
TNZxy6OoPdBVvxzV4vJzIS3hh/ICxbd4vJXdhmg1WwFHs4lEXBkz/juHDnDJoBGU
fpAzSkscNeqaEjFUvBhDt8/S1ljGppJyjBPD/1JfRw4DAWLLs8/pXe4dG+Ofe+r5
fnd8K3I9ICzg75EkvfV8qxtSpQOmW2/HCjcW1xx5q6sWmg3gB90CZj2tMbTqHJsu
JDvDx6aX+ELZ8N2hxzk9Vyz6b8fDujTu+wy4Og2YbiQ1SKg6SFXhkJ4vS98LNIFr
KQGV3NjoEVCQI/YbuUlbtM0zYh/Je3QVcIwP4wVG/0Mqi8qgXRA=
=LAnW
-----END PGP SIGNATURE-----

--=-4Bm3IR+O1c7xCWq+3Uk7--

