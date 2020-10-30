Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F179C29F99C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 01:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgJ3AYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 20:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ3AYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 20:24:08 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC42C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 17:24:08 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e2so1457715wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 17:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=YNnS/YJ8N68iSv5kAg6sby1XsShG2der/Nd+Gj+mfF0=;
        b=CivX32qk/16ZNURBt9IvEAJLVp9ocD0cjIraI1IgqtCBnHKrETuEE8b9z7FHllGN9G
         NruVN9SHRF9SqsFLGbngQe0IEMgx8SfxLNxI9nzrpnWgxUdNR5VrvvspsTMEcTxDdraQ
         MCvF/naKu9joUTeuzSF8JKWNcrOrY6uy2n7J/RPgrdIEo2IJJpHtWVSSQ2ofmCXRvGOY
         lRMZI202tB+v6siUol3ikZUkGmSccEslkB6POspQy31FzdYrHNQpn/ftMPZ0gGFqVthc
         pAw8PZrq35nWJmh8DdoZudLQ9fmdK4rG9yavTuYbRmQ3Z+0MuCDNRgYKU2NGxfLTryDa
         fDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=YNnS/YJ8N68iSv5kAg6sby1XsShG2der/Nd+Gj+mfF0=;
        b=VQOguIK1JREYcxz+gzbTkIYxpgU3e5Gy8PJ907ZeqHCtDD8bPz2Mq2G+cijUVbsq/6
         1hJh6oAZhdYdelbFXR2E00Lzxk+Any+CyDQmS7KNNP46WDrqmKfuE2xkPxdTDlhqdlO1
         hkjy0ppocCwq1vw3Hfq8gS3D+dllc5rvokgVudkMSCV38nBf4tWUNDQQe1gyQWysnr6C
         2S7hOGuT8XTpZkiqikFKziRtJndMJ8RpB3ZAaCpICv7Rkkfcal0YcEM8uphvpqRVMXga
         FwmUg6tZuel2ofo5DIAazC9jc9Gs3pqWQ33EXTXwCcFLtVK8XT1eQagoMppUqvudrk2j
         KjRA==
X-Gm-Message-State: AOAM531z9uXITlQCviYXRaMm2M6UhW4pqYmFNq3zi9Q3Rwo5siqKXMVe
        WOMIGfVOr2PGu6xeVuleMQI=
X-Google-Smtp-Source: ABdhPJykU410uCBLhAxx/6xgrGbuEhezzDnikW1Bqxhhpj8F9LTDf/kRfmfW+bINtbHZjCBSq1hpnQ==
X-Received: by 2002:a7b:c055:: with SMTP id u21mr1871895wmc.27.1604017446878;
        Thu, 29 Oct 2020 17:24:06 -0700 (PDT)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id p4sm8423149wrf.67.2020.10.29.17.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 17:24:06 -0700 (PDT)
Message-ID: <ea5967cdbd6281557d6a739c0eb63a979351b453.camel@gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: arm: sunxi: add Elimo bindings
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     Icenowy Zheng <icenowy@aosc.io>, Maxime Ripard <maxime@cerno.tech>
Cc:     wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Date:   Fri, 30 Oct 2020 00:24:04 +0000
In-Reply-To: <92612D42-FF4C-450C-ADB1-A220B94838CB@aosc.io>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
         <20201029022000.601913-5-matteo.scordino@gmail.com>
         <20201029101304.yja4m747pc62re34@gilmour.lan>
         <92612D42-FF4C-450C-ADB1-A220B94838CB@aosc.io>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-evPyYgMHR665r73TzY1g"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-evPyYgMHR665r73TzY1g
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

thank you both for reviewing.

I didn't realise the file was kept in alphabetical order, I will fix that.
And I agree that board/som + "sochip,s3, allwinner,sun8i-v3" makes sense,
I will resubmit the patch with those (and sync them with the dt bindings fi=
le).

Should I submit a patch to update the pinecube to use "sochip,s3,
allwinner,sun8i-v3", too?

--=20
Matteo Scordino

On Thu, 2020-10-29 at 18:24 +0800, Icenowy Zheng wrote:
>=20
> =E4=BA=8E 2020=E5=B9=B410=E6=9C=8829=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=886:13:04, Maxime Ripard <maxime@cerno.tech> =E5=86=99=E5=88=B0:
> > Hi,
> >=20
> > On Thu, Oct 29, 2020 at 02:19:59AM +0000, Matteo Scordino wrote:
> > > Document board compatible names for Elimo Engineering Impetus and
> > Initium
> > > Signed-off-by: Matteo Scordino <matteo.scordino@gmail.com>
> > > ---
> > >  Documentation/devicetree/bindings/arm/sunxi.yaml | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml
> > b/Documentation/devicetree/bindings/arm/sunxi.yaml
> > > index 0f23133672a3..55405809ec91 100644
> > > --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> > > @@ -898,3 +898,13 @@ properties:
> > >          items:
> > >            - const: xunlong,orangepi-zero-plus2-h3
> > >            - const: allwinner,sun8i-h3
> > > +
> > > +      - description: Elimo Engineering Impetus SoM
> > > +        items:
> > > +          - const: elimo,impetus
> > > +          - const: allwinner,sun8i-s3
> > > +
> > > +      - description: Elimo Engineering Initium
> > > +        items:
> > > +          - const: elimo,initium
> > > +          - const: allwinner,sun8i-s3
> >=20
> > This should be ordered alphabetically, and most importantly, must match
> > the ones you have in the DT.
> >=20
> > Here, we have kind of a mess already: the Lichee Zero+ uses
> > ,sipeed,lichee-zero-plus, sochip,s3, allwinner,sun8i-v3, while the
> > pinecube uses pine64,pinecube, allwinner,sun8i-s3
> >=20
> > IIRC the S3 and V3 are pretty much the same SoCs, so the first one
> > seems
> > to make more sense to me, but then we should fix the pinecube.
>=20
> I agree with this.
>=20
> PineCube is originally designed for S3L (which is branded under Allwinner=
)
> but switch to S3 finally, so I may made error when adapting.
>=20
> > Maxime

--=-evPyYgMHR665r73TzY1g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEzO0zAuXCENUlBKYqFH4A68XNhRoFAl+bXSQACgkQFH4A68XN
hRpM5Q//UJnI+IjrtmbNAAyPAySRteRqbEWgk/NBsrxGZdwPpvPmhlKfDYYj3H4X
96z1CiSbWqiiQtCWOvfySYMAi4wjsmqiGMX9d2Ip/TWXtGUSQEciyrbnEY73tuo5
yWsNK1xWkjpnGS4YB/ZTRxW+f7XKene6HJkLzDojtAnGTac05QRcMV3Irzu4fT7c
zvnBr0Ezikv+//UC7hx6y7wQjBZr/PbMwzm+RySEAwHkTcUh8Wg+jY0Mow++rh1Z
foj776Zylu1lUYWDKHEBqbOLLLq+yA8668guRB07YTF5niewS7OIQT3FNwfL89A1
0ci56X/iC6Kh+zRrIlqEcNZEPQGUj/Rw04qMeCAVRwjd+4ouXUh66G5B97kBcINJ
rzHHpotOXjyBMzwllPtF2K0OUHrwGVagH4QdWn/axO94LpztHsoJjoz2y1qteLkP
bmkb/o17YrjkXen/9xmLn4MX7Xisvb2VdCAiRknThHSCQC7rHWBVnkISQZ18nBvf
t0r3ZT8FQY801XT4sDea1FKPe9xsZSUn0Wfyh+VP3w/vFTCNoAWYsHvVMskXwHL3
alKyS+9LX0EGyvuGVxP0SXvvQUP7tXQijFbUHmv/cMOTboloC3S8kJFnULeOhjH4
NDZls4IfI9SskgahlBNr0jWHg4OOuWUy1VmMnluEmAET0HrLTLU=
=LOmK
-----END PGP SIGNATURE-----

--=-evPyYgMHR665r73TzY1g--

