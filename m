Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC03B2A4B68
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 17:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgKCQ2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 11:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgKCQ2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 11:28:31 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D558C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 08:28:31 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id k18so13369344wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 08:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=K2K7ZVRD9BA18hlrtxInGmokftlIRLIfMZ1QNfSK0cY=;
        b=XdYfJJUOCttjvBR95tYU7drWhNkSoz4HrFrJjxBTJZQEu9ELrelI6mTsxSKHKb5FzQ
         lqQhX3c9aaY0tw+5xC6D5wXhorMLQ/BhSzNULzetBx/m+1a1p3WTuodwtuKr/jl4ZbR1
         xg2ArobFMqBBkV/BkZ1H1/qT+WvVXtY8Rt5JnKsTj7eWhnCz5dsyiKG6+apWukToA+0M
         r7OxrYbsT6rH0b36OZMWlegfVgREleFwnYVGVW1vS96dA0TywuEEkRXegcYTbHdzWU8G
         kTyQmMi+7Kc2gIZsRI+mRL0pMrujYDYoRC0Qp4GxPbuWqWU8IKcOE9TKdLoLPNzkNoPC
         tKqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=K2K7ZVRD9BA18hlrtxInGmokftlIRLIfMZ1QNfSK0cY=;
        b=L6Bf9dKTtZJ8HPgrCt4TsWdSVXaUM1gjQ6a/ajZLzNJYSKGbG02ynQRiME84j5nf+W
         QpFuZetC7/tHFtV8npuTDD2+22d31jhm4l8XZ4v9lxIOfHBIzAWyjTGR1g0a8t9m9TkG
         Dux0vD8DweT613JKy82g84uz5rKlmMqBkH6TAgz8J5y2Mmh7vtH3ujFZ4obm3XKFkKEl
         9dqS/nhWpyP2IkoUcqXda7eGdjB8p7AYrTyQw2uyNrH6e62yAhDDtZ5lFY8mweLHllqt
         ks+8bFmyzELHDwP9fmpmVre/F9w/BaOYWPxJGpIlDg63LPPvqZdnns+mA2BQF1V7NLMO
         u7/A==
X-Gm-Message-State: AOAM532kWysj19aHCwoWsXpPl2mB4G3POj65GY0g5Bq6jYrGZ+nqpB3a
        4Sri7ZfsvdCt+rgOtaGWxPo=
X-Google-Smtp-Source: ABdhPJyidN0ztnsF+MRkznBxcSEAQgVpLLZNOh9dKPsEI7QQVOYUXTrtxuS0q4mmEK46GxnhurLa5Q==
X-Received: by 2002:a1c:5401:: with SMTP id i1mr615336wmb.124.1604420909706;
        Tue, 03 Nov 2020 08:28:29 -0800 (PST)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id h128sm3589690wme.38.2020.11.03.08.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 08:28:28 -0800 (PST)
Message-ID: <5ea8344baa73068f30945ca5c76f582ca4844b3e.camel@gmail.com>
Subject: Re: [PATCH v2 3/6] ARM: dts: sun8i: s3: Add dtsi for the Elimo
 Impetus SoM
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 03 Nov 2020 16:28:27 +0000
In-Reply-To: <20201102100540.wkqoy4nilmee7mpv@gilmour.lan>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
         <20201030234325.5865-4-matteo.scordino@gmail.com>
         <20201102100540.wkqoy4nilmee7mpv@gilmour.lan>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-wbx2wFjDKrNK7WkR3NQx"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wbx2wFjDKrNK7WkR3NQx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

--=20
Matteo Scordino / Embedded Software Consultant
Mobile: +44 (0)7463701446

On Mon, 2020-11-02 at 11:05 +0100, Maxime Ripard wrote:
> Hi!
>=20
> On Fri, Oct 30, 2020 at 11:43:22PM +0000, Matteo Scordino wrote:
> > The Elimo Engineering Impetus is an Open Source Hardware System-on-Modu=
le
> > based on the SoChip S3 SoC.
> >=20
> > It is meant for integration into carrier boards or, more generally,
> > larger designs, and uses an M2 connector to facilitate that.
> >=20
> > Interfaces on the M.2/NGFF 42mm connector:
> > WiFi IEEE 802. 11abgn (on-module Realtek)
> > Bluetooth 4.2/BLE (on-module Realtek)
> > RGB LCD Interface (on-module connector)
> > MIPI Camera Interface (on-module connector)
> > IEEE 802. 3u Ethernet MAC (external connecto)
> > USB2.0 (Host, Device, OTG) (external connector)
> > Audio Line In/Out (external connector)
> >=20
> > Signed-off-by: Matteo Scordino <matteo.scordino@gmail.com>
> > ---
> >  arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi | 51 +++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi
> >=20
> > diff --git a/arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi b/arch/arm/b=
oot/dts/sun8i-s3-elimo-impetus.dtsi
> > new file mode 100644
> > index 000000000000..f219188fc9ba
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi
> > @@ -0,0 +1,51 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (C) 2020 Matteo Scordino <matteo@elimo.io>
> > + */
> > +
> > +/dts-v1/;
> > +#include "sun8i-v3.dtsi"
> > +#include "sunxi-common-regulators.dtsi"
> > +
> > +/ {
> > +	model =3D "Elimo Impetus SoM";
> > +	compatible =3D "elimo,impetus", "sochip,s3", "allwinner,sun8i-v3";
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
> > +&mmc0 {
> > +	broken-cd;
> > +	bus-width =3D <4>;
> > +	vmmc-supply =3D <&reg_vcc3v3>;
> > +	status =3D "okay";
> > +};
> > +
> > +&uart0 {
> > +	pinctrl-0 =3D <&uart0_pb_pins>;
> > +	pinctrl-names =3D "default";
> > +	status =3D "okay";
> > +};
> > +
> > +&uart1 {
> > +	pinctrl-0 =3D <&uart1_pg_pins>;
> > +	pinctrl-names =3D "default";
> > +	status =3D "okay";
> > +};
>=20
> What is uart1 used for? the BT chip?
>=20
> Maxime

No, BT is provided over SDIO by a Cypress 43455.
When used with the Initium carrier board, UART1 goes to an FTDI bridge that=
 is
connected to the same USB-C connector that is used for power.
The idea being, if want an application that uses the UART to communicate wi=
th a
PC, it's convenient to provide power+connectivity on a single port.

I guess your point is that we would be better off only defining this in the=
 DTS
of the carrier board?

--=-wbx2wFjDKrNK7WkR3NQx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEzO0zAuXCENUlBKYqFH4A68XNhRoFAl+hhSsACgkQFH4A68XN
hRoC9A//acjWor4uoQfnXZAxIuLZXZl5Er0aJ43+XTEhJbZ7/+n4NDV1BgxmadNa
fy3vh5TLBwYDI0hWGOcqCES2Jb9KKHevNl18xh7ON03y23PDowEei8fR1Dm1/3Lp
EZCogWg+xi3OKhE6zAfUHCZP6mA7Ff51m91ThyUbxeLDTbFjyJOCOEYSqImuBGQM
NCuNoScC3SFuiiCye7qRE3kz9PkdPQ7Ku8SB+d7vtfLMg7BHsqyrMJKrJezFePR9
BDWMH/mDO9lb0YACITAByNyvh7yYy0fTwCGvOxM7kYA3boiCnVL1Yghj9P48uxPq
6CehqH5mrmpIhrxlNgvq5Jr2AmO3yQS7rFUG/n0psxgwH9fG35/gHDIMjx2j3+mP
+7fdGm4R+F7mIsQhaEBh84Tk39sIKt2Fb3OruPjCibFDx/brGM1Iy3H26iPWo59P
ugzr1TfVgBuiDl7HEa8S0PaCX6QEIbmfSA0hUbOyWPUaetn53yVnpXeC6d6Yj0Lj
HCg0uFpT+LBQzN1zmL3uSEKVXnflDsKxnx2eY8kG94h1vnbDxkYP8tM4L6vx+UG0
FP1knNQQ2wtfv/yl2ZSXBWTF+5dlthOplmgSX1mrF0SEc6pia7d6QD03G/ibrQK4
PEqKuPKFgGTLs+Qqpxm0+s6bZuPc0P4s85hWMJjt00mct54ZjY4=
=A6vS
-----END PGP SIGNATURE-----

--=-wbx2wFjDKrNK7WkR3NQx--

