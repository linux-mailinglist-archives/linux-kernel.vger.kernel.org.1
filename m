Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AA62DB5C1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 22:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgLOVR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 16:17:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:55352 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbgLOVRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 16:17:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73D62AC93;
        Tue, 15 Dec 2020 21:16:56 +0000 (UTC)
Message-ID: <6773252eb539f09383f2b31118467b0be23e592a.camel@suse.de>
Subject: Re: [PATCH 1/6] dt-bindings: nvmem: Add bindings for rmem driver
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Date:   Tue, 15 Dec 2020 22:16:54 +0100
In-Reply-To: <CAL_JsqK7zZdWi0orXoqPWqvvxP3H6n7=JRqhdeAiAYAHRS3WHQ@mail.gmail.com>
References: <20201215155627.2513-1-nsaenzjulienne@suse.de>
         <20201215155627.2513-2-nsaenzjulienne@suse.de>
         <CAL_JsqK7zZdWi0orXoqPWqvvxP3H6n7=JRqhdeAiAYAHRS3WHQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-HRNIWeNhFPTeTIs+fz/7"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HRNIWeNhFPTeTIs+fz/7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-12-15 at 14:25 -0600, Rob Herring wrote:
> On Tue, Dec 15, 2020 at 9:56 AM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> >=20
> > Firmware/co-processors might use reserved memory areas in order to pass
> > data stemming from an nvmem device otherwise non accessible to Linux.
> > For example an EEPROM memory only physically accessible to firmware, or
> > data only accessible early at boot time.
> >=20
> > Introduce the dt-bindings to nvmem's rmem.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > ---
> > =C2=A0.../devicetree/bindings/nvmem/rmem.yaml       | 35 ++++++++++++++=
+++++
> > =C2=A01 file changed, 35 insertions(+)
> > =C2=A0create mode 100644 Documentation/devicetree/bindings/nvmem/rmem.y=
aml
> >=20
> > diff --git a/Documentation/devicetree/bindings/nvmem/rmem.yaml b/Docume=
ntation/devicetree/bindings/nvmem/rmem.yaml
> > new file mode 100644
> > index 000000000000..3037ebc4634d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/nvmem/rmem.yaml
> > @@ -0,0 +1,35 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/nvmem/rmem.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Reserved Memory Based nvmem Device
> > +
> > +maintainers:
> > +  - Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nvmem-rmem
> > +
> > +  memory-region:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      phandle to the reserved memory region
>=20
> There's no need for this indirection. Just add a compatible to the
> reserved-memory node. See ramoops for example.
>=20
> Please make the compatible specific enough to define what the memory
> contains. If you want 'nvmem-rmem' as a fallback that's fine.

Ok, I'll look into it.

Regards,
Nicolas


--=-HRNIWeNhFPTeTIs+fz/7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl/ZJ8YACgkQlfZmHno8
x/6DEgf+Ir9Z/EAoImzzkz0WNDBqJRFShxXJ3Z6YrpJ/j5p/I4owZX9Xtpwjh+k3
Sk5ZQcjw9MFcs6X9Kka2oLL5O6TspqD3YDHF/Afm0Uo5TXLU69hfcVh5Jx0NIyaG
2Cll+fLE0ozkyfViIXKwCvL5P7BIB6VWZVXpZSfOr3sxhvgXOGw4O2ivWD3s3LsL
BsWllvWIXSLZfDAcZr3MVBBOuR2fByCLtyWWMfB+T9SIQodxFVVMYpUuRiHKTn8B
zCfhsl+Wxsp/WADK+EoIl1euIbBgkzI+9Ws7xq8O3NBTLFanJHxJt/b+IXS7cZw+
Dub6IRL35RjvAN6O/Ras4aJF9jzvgA==
=OefD
-----END PGP SIGNATURE-----

--=-HRNIWeNhFPTeTIs+fz/7--

