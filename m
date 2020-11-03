Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE89B2A4B9C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 17:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgKCQdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 11:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgKCQd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 11:33:29 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8221CC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 08:33:29 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id s9so19193951wro.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 08:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=Q4kLibuT5w52vf8rM7f7rdD5EtuXIibZ3sV5hoXRtaQ=;
        b=K8GoAuWLpowlXhGUqLyydPTcQfs3w/mh1xBkH2lvJtdJKs1YevQSoDQSgHDjM0qDdy
         /cUGhqlT2I+1raCyFwLOrs/e7KBfMU/hVmV66co+/pcTyQLZPCmA5K+favFR0hCU6ADc
         0H/K5mVpyk2tTyliRO+AOJWLiwyMoeUYyGfMMZRYBajHN58Dk8Od7dNWCUhRzp3LReMQ
         xwjlk5cdyHvc3ZQ0k9b9al3LkfgUXUzu5V7dKdbBqPq6I9ATKTOBoH9Qz8hg3GZ0ZU0O
         /9ZBjyFS13KSn+g/s5xGkW0QtgW3+cDIACIqcbJr3Rfa0gV3CrjgWmIrT/LhyN69XIp2
         rw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=Q4kLibuT5w52vf8rM7f7rdD5EtuXIibZ3sV5hoXRtaQ=;
        b=MyVvO5bPOQQF8cbN2gqA6dS87RsWEFbXVxpIjvra5Pa1rS4ACxeI12qlO0bCD9bmA4
         7AazX+Gbx2jcZbs/y45QFzlOmtKVaceNJeUQSvaTPpv0rWKdg5xWnzYsov78s6VfjNzW
         7CM/jOgbWG+IvW6Gu2jiEIPzDfbE2JjXKsT1ZgggB4N7sjUCDFvazs45HTH0gyFkPg8n
         1j4qOKXXNfNyV4RGWhpqXzx5sdf59xcq7Z/+g8knPTvOSVqFki/t4eXFsRTy5pAnUWrO
         8Msvm10JlLCjYgxzhQpJTHjvD8z4eSDzRBqNn9JHDoZKqMlmSBIZ3YzgksZ11U74Y/rR
         RnPQ==
X-Gm-Message-State: AOAM530KW4pAZeFX8+b5R3pWlbC5OLvvHuu/BnXPNwkkODGG/I/7P1dx
        ZyO10TWADNdZfQENiZbkDuc=
X-Google-Smtp-Source: ABdhPJw5UyDokuC4QCMJs7wlcGDdbLr4hn+ovxWiGyWQ1C99NUuTP9rDhF59I8Ynh7dm2XzX45Fn2A==
X-Received: by 2002:adf:f90f:: with SMTP id b15mr27360507wrr.343.1604421208127;
        Tue, 03 Nov 2020 08:33:28 -0800 (PST)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id g17sm27135313wrw.37.2020.11.03.08.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 08:33:27 -0800 (PST)
Message-ID: <5064a1921b0ba98289c13f325e11347b09cd3672.camel@gmail.com>
Subject: Re: [PATCH v2 5/6] ARM: dts: sun8i: s3: Add dts for the Elimo
 Initium SBC
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 03 Nov 2020 16:33:26 +0000
In-Reply-To: <20201102100632.g5tozkzfjzzch4ny@gilmour.lan>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
         <20201030234325.5865-6-matteo.scordino@gmail.com>
         <20201102100632.g5tozkzfjzzch4ny@gilmour.lan>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-we+FtxMeYutOzm6ox5w0"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-we+FtxMeYutOzm6ox5w0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

--=20
Matteo Scordino / Embedded Software Consultant
Mobile: +44 (0)7463701446

On Mon, 2020-11-02 at 11:06 +0100, Maxime Ripard wrote:
> On Fri, Oct 30, 2020 at 11:43:24PM +0000, Matteo Scordino wrote:
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
> >  arch/arm/boot/dts/sun8i-s3-elimo-initium.dts | 28 ++++++++++++++++++++
> >  2 files changed, 29 insertions(+)
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
>=20
> This should be sorted as well

Ouch. Will do.

>=20
> >  	sun8i-t3-cqa3t-bv3.dtb \
> >  	sun8i-v3s-licheepi-zero.dtb \
> >  	sun8i-v3s-licheepi-zero-dock.dtb \
> > diff --git a/arch/arm/boot/dts/sun8i-s3-elimo-initium.dts b/arch/arm/bo=
ot/dts/sun8i-s3-elimo-initium.dts
> > new file mode 100644
> > index 000000000000..7677ddc07bf9
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/sun8i-s3-elimo-initium.dts
> > @@ -0,0 +1,28 @@
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
> > +	compatible =3D "elimo,initium", "elimo,impetus", "sochip,s3",
> > +    "allwinner,sun8i-v3";
>=20
> You should indent that properly

Double ouch.=20
However, how is a multiline dt property supposed to be indented?=20
I have tried a few combinations but nothing seemed to make checkpatch.pl ha=
ppy,
except leaving no space at all at the beginning of the line. But I think ma=
kes it
quite unreadable?

> > +	aliases {
> > +		serial0 =3D &uart0;
> > +		serial1 =3D &uart1;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path =3D "serial0:115200n8";
> > +	};
> > +};
>=20
> It's already in the DTSI, there's no need to duplicate it here

After your question about the UART1 in the Impetus dtsi, I think it makes m=
ore
sense to remove it from the dtsi, since UART1 is directly used in this boar=
d (for
an FTDI chip) but not necessarily used in the "bare" Impetus SoM.

> Maxime


--=-we+FtxMeYutOzm6ox5w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEzO0zAuXCENUlBKYqFH4A68XNhRoFAl+hhlYACgkQFH4A68XN
hRrd7xAAjUw+5pi5twLc9zlFmWyz493U+jS0PUZnN7y9TDX5IjTvqj6t5ufAL/Sd
Ss0jhmlN7XmoAfIylwPjJpCxIvtihAZwsvDcexOKQM397ZqrnfrmILsiCb4u2HZg
gkWA0fFv9CpD3+J7EGKhI3+2rcIJ1cdr+Q03fYBHuHFcs+9lYquPnXNjL5IkB5OK
rhiqu9JqwMIw3yldOtPMJZwRjdWghm9CZYv6V9Kqb4gXHmFstSPUnmRl+W/eTB7B
YTXyNNR1I9F5aV1dyEdTHfLuMyow+yYK8elCZ+ekAxQpmUA+qB6/tpJJx8gNUq8L
sx1/BIAkxL/9QG+6UdUfOjuW443/JKojgesZi7Hr6vvnmE0l5HaTN9jyGLbOgu2L
t/WtUCADI8gtL/aNSKtx+sMlN19vyUPPj+J/srHtBY47p5DCCf1HjaTw7QD6zGVb
eCCCvcul6TB4NkYCSUwbg/CdqvfpVM41mba94xEG3boq92o/x/y/JDmiTF/ZAFg2
zptMya87AFSl8uFoPddvCtG+TpdmdW5vxKA6U47JWgSZ9OqmpPE6PrLtulmJ9qCi
lbAKrTSGclbmPb3W8ADHYIP/YCzvI+LRnjcpAdo6BxSdK2eo9O8qErIU0VaFYM33
5W+pVqDYnlng+oMHy0904xtpWJJ8Lcuzel5JKhBKInLd8kDesNE=
=pUit
-----END PGP SIGNATURE-----

--=-we+FtxMeYutOzm6ox5w0--

