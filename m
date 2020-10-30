Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660BB29F991
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 01:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgJ3AST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 20:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ3AST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 20:18:19 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1752C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 17:18:18 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c16so1443259wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 17:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=yC8QOupSauHZavYsUjUVIqNfcGL6GE/jTv0R5N5Kzrw=;
        b=JymtVPNWgjhIwuT1y0WAJ41BB8mPF4egN1VSvUe0LMgYx/f4LcMSHRbfsVjb5pk+E3
         lgucZS28GuXHkijFk8r8Lq+igbcwxzU1lkubWGPZg0S9cwA5PxXSHQq10jVKTXWVj82t
         vFvINmpUyz5E4ftOf5nCq8Sk5sNg+UB1ZbWHCZqLDCYC3FScqTNaG3UgFP9w6NgvkDtr
         v1f84SUNVrU7lVu5UYSwB9OmzRVrKvRjkz4aHEqa3yRSMDCryZjV8OUeklSe5w/GV4Wn
         x1o1/58YBEC34VjEdOPMhRjtoxrR1aXhLQ7UIeYpd88vJKi3l5gBWiwuRO8P/dJH1Pch
         KPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=yC8QOupSauHZavYsUjUVIqNfcGL6GE/jTv0R5N5Kzrw=;
        b=teBoKOt48zEP2arDJgT/TV0MqqQN76xqaUrC6mB4TK4LAi7V6UAwrCsEE/Q3pobmgC
         gWX2QpIG5SsNB/lOB2A093c1auwJKHCYJ9Kt+l3w9V4pGm6TDdcUEwBhhByoa7/JlkvE
         offWVHDs3I3ftYH9kRbDBCFzRrDWIzwC8s7u0hiYxEaxY5Lw/F5Ixa1Hh0q7sCWjYqbV
         nZs3UJR8Co+FzhnaIWV+9dDBq2V1BI+tvIvoZsJG+7gcBBhXIqdROh0Nek0yI7NipRWs
         97riGW4lzOPyDD4eMnWIp8yvuCZX7WO44Q+tFlj9NLfj+AFqWcWXJ4EKYJKCXHBnwS6/
         3zSA==
X-Gm-Message-State: AOAM530ECL9JWpHLaO1JvzpWjrGDOxi8FmHlguAMJJp5ApMRDeVX6wQa
        TPHA7w97ETfQlot2HoihDk8=
X-Google-Smtp-Source: ABdhPJwgKMCrAquaodl4ujMqMmBlJ8PPkq/k9YuJxGF7NDykjIPCbtKhkY958Xab0vbO9F+VjASaFA==
X-Received: by 2002:a1c:7d0f:: with SMTP id y15mr1846810wmc.84.1604017097335;
        Thu, 29 Oct 2020 17:18:17 -0700 (PDT)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id l16sm7957315wrx.5.2020.10.29.17.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 17:18:16 -0700 (PDT)
Message-ID: <a44477771ede1aefd74eea404ad011cd15dbcae6.camel@gmail.com>
Subject: Re: [PATCH 3/5] ARM: dts: sun8i: s3: Add dtsi for the Elimo Impetus
 SoM
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 30 Oct 2020 00:18:14 +0000
In-Reply-To: <20201029100936.GC460689@aptenodytes>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
         <20201029022000.601913-4-matteo.scordino@gmail.com>
         <20201029100936.GC460689@aptenodytes>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-kiWXrusefHO84ILaiCsr"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kiWXrusefHO84ILaiCsr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Paul,

Thanks for reviewing!=20
It seems from the comments in [PATCH 4/5] that the consensus would be to=
=20
drop allwinner,sun8i-s3 and keep sochip,s3 (I guess due to the fact that
the S3 is distributed by Sochip).
And yes, you're right that it makes sense to add allwinner,sun8i-v3 at=20
the end.=20

So I guess I will resubmit with:
compatible =3D "elimo,impetus", "sochip,s3", "allwinner,sun8i-v3";

Regarding adding allwinner,sun8i-v3 to sunxi.c: I agree, but I would
hear Icenowy thinks (I think she added allwinner,sun8i-v3 in a patch
last month).

--=20
Matteo Scordino

On Thu, 2020-10-29 at 11:09 +0100, Paul Kocialkowski wrote:
> Hi,
>=20
> On Thu 29 Oct 20, 02:19, Matteo Scordino wrote:
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
> > diff --git a/arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi
> > b/arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi
> > new file mode 100644
> > index 000000000000..3550125cf334
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
> > +	compatible =3D "elimo,impetus", "sochip,s3", "allwinner,sun8i-s3";
>=20
> I'm wondering what to do about the SoC compatibles here:
> - Do we really need the "sochip,s3" compatible, as it seems redundant wit=
h
>   "allwinner,sun8i-s3"?
> - Could we add a "allwinner,sun8i-v3" compatible at the end since there i=
s no
>   functional difference between the two?
>=20
> Another thing is that we should probably add "allwinner,sun8i-v3" to
> mach-sunxi/sunxi.c so that it's matched by the DT_MACHINE_START.
>=20
> If that seems agreeable, I can craft a patch for the latter.
>=20
> What do you think?
>=20
> The rest of the dt looks good to me :)
>=20
> Cheers,
>=20
> Paul
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
> > +
> > +&usb_otg {
> > +	dr_mode =3D "otg";
> > +	status =3D "okay";
> > +};
> > +
> > +&usbphy {
> > +	usb0_id_det-gpio =3D <&pio 5 6 GPIO_ACTIVE_HIGH>;
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

--=-kiWXrusefHO84ILaiCsr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEzO0zAuXCENUlBKYqFH4A68XNhRoFAl+bW8YACgkQFH4A68XN
hRoSqxAAh0cTVYjKJnytXIOwRXEQ1aWO3NEz+LQQ9FEmI/IKErcNU8uzz12ka4Jx
aETeHBWgDqvcKBqhhQmEGZkFlhP45IuwcvgzIxiX8eBhpFFVu1oKIARFM9UsZqp5
rgymMVmHJVX95e4gaXm41rxok5fADlKmuG6aJnFxxRJnF6nEqi3G9aXPbDEBWwn6
x0r5IsHOieNxhxTmyUEEWhOjQmIyHd6Xt2MqtzAOG43WP/7xUC1cS4vVJgvjfIhC
4CHbtriucglnWs33i7G9xJRBYqnppnT3r3Lb5MzwZzD3rxS8uylxM4BSnE4nUfFS
Vo6VVq8ZkxUOqdV1r3zd5nV6ApuKl/VukC6rHXRIiiSLhDyritz2mkCKF8CHShl2
3/edfB0V5SXsuYQcKIMRGQgtWMwoL9goXwE8J41PCV4o3eQMKmi4+ZCtD3LlYVzz
WNM9BHSkNXyfku/hAAOxcFKrSZOM34sQxMIFIzFwh87J0BcNV96vKMUy81fe/eYt
DzKMaGI0vvpJLr0dWf5KYntq8Qm6RrO3pEpXMiD/LbchgKZsCR/1nolJKUj4yxzO
GCaYARpMVa4nxwOmcJrTRvoIdPBRZIal0RNrB5ccyit9DQan1r2Uf2V2pnGXuj9r
CdgVVRhqgUcs9Uvu1kNBfMVk9TvratsiYVXkK/0oCk/UBjVZDtc=
=orG8
-----END PGP SIGNATURE-----

--=-kiWXrusefHO84ILaiCsr--

