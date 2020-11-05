Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284F92A861D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbgKES3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKES3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:29:50 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7373C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 10:29:49 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p1so2895821wrf.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 10:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=D4Q/g6zcNZTw1UTddraeuBRe9Eire3jALhkaslJC9mg=;
        b=Gi/4Ffei3oEUAC/nkfVuK37u+UJ6WBlqnvHP8HW0z6uEDP9LZ2Ft2j+xI4yC9fPj+3
         gt1xqdRcOdQoGv1mu+I0zjlrNBmjMWi273ngRnn9UGWmxHG0L1eWZjNt6VAw/4v1rZNj
         2+ZemkuMDFlAcUoGysaHeEszBm+zOPxW9dcfGehqlrOPlZ4p3JSVN1di+gRKTHq4ZQfj
         eXRDxRCRBhGLE+l0x57jPgNoNrQMcxjenabCCaR1gtNGiopNiY0xoPa1RaR1zqYWvkmm
         +2GHR9ektch/IsahjpJ35rS0vgIEWGMvdIHKZZPgKm3tbbxLfh0PhnPReP+ayS0Vs2un
         sFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=D4Q/g6zcNZTw1UTddraeuBRe9Eire3jALhkaslJC9mg=;
        b=fHYMFNVQPU4lKFEbreOvbyDzdmn4P2AnzOaASD5nr8kewJxvnoj7KvDKMU176/U8dw
         8nLivpr4049HTZF5E3Py/WAaATtLtiDlzG2tuRHbfxrC+i/oCIkk0aKnpFcHsAuj6eMl
         qvDqmn5VxeA9EODOYIpTtYyrQX9pg4zlZwnFUlCAMRxRLpXIjgPz9wApWHK8GMR52Hkp
         0AzQVjGp500FPZAtGYcfqW2UEkPqN9uGqaLKzjizn85ROz2vFYfKhGK1OgRyvgaHcw/Q
         t0bz3uOhrWJwmQRMnZzyUxfmAJs9wS/l3ywXsFtXaFl/tbrE0mBt5941Vdp2q8aOPMfb
         mgRw==
X-Gm-Message-State: AOAM53067jH1vhXqN8nDeyfTW8+hDWlyuWqofa5wgz2zSWeVkpTYEfHP
        4CQjXFbKcg9TH0gbRZf7oFc=
X-Google-Smtp-Source: ABdhPJzVvEVT1hHZzepVztA1HH8EsgGNUSlDylgDMUZgMajsTNl4XELvZVYiVz18KPchCX6Zdtcz1A==
X-Received: by 2002:a5d:4d0d:: with SMTP id z13mr4318169wrt.23.1604600988417;
        Thu, 05 Nov 2020 10:29:48 -0800 (PST)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id o17sm3634320wmd.34.2020.11.05.10.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 10:29:47 -0800 (PST)
Message-ID: <7051ef1a9220ab092ee33a6f65e8e84b0bdf6529.camel@gmail.com>
Subject: Re: [PATCH v3 3/3] ARM: dts: sun8i: s3: Add dts for the Elimo
 Initium SBC
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 05 Nov 2020 18:29:46 +0000
In-Reply-To: <20201105150013.aruomoglclrpaacf@gilmour.lan>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
         <20201105144945.484592-4-matteo.scordino@gmail.com>
         <20201105150013.aruomoglclrpaacf@gilmour.lan>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-q53BkwNgoVdj81DfBC6y"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-q53BkwNgoVdj81DfBC6y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2020-11-05 at 16:00 +0100, Maxime Ripard wrote:
> On Thu, Nov 05, 2020 at 02:49:45PM +0000, Matteo Scordino wrote:
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
> >  arch/arm/boot/dts/sun8i-s3-elimo-initium.dts | 34 ++++++++++++++++++++
> >  2 files changed, 35 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/sun8i-s3-elimo-initium.dts
> >=20
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 4f0adfead547..50e438ab8a00 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -1208,6 +1208,7 @@ dtb-$(CONFIG_MACH_SUN8I) +=3D \
> >  	sun8i-r16-nintendo-super-nes-classic.dtb \
> >  	sun8i-r16-parrot.dtb \
> >  	sun8i-r40-bananapi-m2-ultra.dtb \
> > +	sun8i-s3-elimo-initium.dtb \
> >  	sun8i-s3-lichee-zero-plus.dtb \
> >  	sun8i-s3-pinecube.dtb \
> >  	sun8i-t3-cqa3t-bv3.dtb \
> > diff --git a/arch/arm/boot/dts/sun8i-s3-elimo-initium.dts b/arch/arm/bo=
ot/dts/sun8i-s3-elimo-initium.dts
> > new file mode 100644
> > index 000000000000..2119403fb65e
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/sun8i-s3-elimo-initium.dts
> > @@ -0,0 +1,34 @@
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
> > +		     "allwinner,sun8i-v3";
> > +
> > +	aliases {
> > +		serial0 =3D &uart0;
>=20
> This alias would come from the DTSI

Removing it.
>=20
> > +		serial1 =3D &uart1;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path =3D "serial0:115200n8";
> > +	};
>=20
> And this node too

Removing this too. Sorry for the many iterations, as you can probably see b=
y now,
this is my first kernel patch submission =3D)

> Maxime


--=-q53BkwNgoVdj81DfBC6y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEzO0zAuXCENUlBKYqFH4A68XNhRoFAl+kRJoACgkQFH4A68XN
hRrLqg/+JHo5DGZScaHZk6o/3HFU5Oqyw2+bPDLcHkvVmKe2dp1iqbtlYjQBLv1j
bXlsWIdG0XHRSSBoY0xfyectLngfi7ddC1jdq7pn7tstbV14WPdn5bs2+pUjaFiL
y6+MF6CXtZHdiSifHefLzNH68C7EfTrvWcKMwD9Q//rZZdShaLNKPGxGTMYF9sOx
XTe+2JQ9Ar+Hiz7Io7C5951DW26T2wrivN7tv+2v7fCuVkPWuHx/9H5SmQ1WTrPG
CBqhMu07ZXsZn+XLvbplIjSSeIE03ZGriyg6no8Rrkh3CdOx254Rir0T7LKfTlLQ
laaqsqFPJpma5GFOR3j0NFreuLt2/vxiLaRHFs3v5wr9kmneOSfwlSOeWDYG9X1L
FM0/vM6LhAZNG6B7ZL8ofKSKNc6yGCXIAUmXtbJezrKqBemJSi3+tAEv8UxVCEjb
dEfFLLpgIlC5ZLRmXS/wEL/UjJaipa6gXZgx7aPsHN2VjBtA5u/WAy/G9IEWZjiO
Gdij38RQfagY272feur3ziJ91IMp7JypVRdaehRgVjPzY/YvEeF8WpaR2bw3Q4+e
zarhGo2FbJ8mZfWwu6T0wDK5GWhyiUr+YYG+bIYjz+TWHCEhXixfnmOPMnfG5fom
rDe7OvNrYsXo1ft/dGb3v+//Zq45z17Gu1ieENEyEvR8K7X4uDU=
=YhuW
-----END PGP SIGNATURE-----

--=-q53BkwNgoVdj81DfBC6y--

