Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E742D95CB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 11:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406618AbgLNKFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 05:05:33 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34197 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727959AbgLNKEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 05:04:55 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 220505C00D4;
        Mon, 14 Dec 2020 05:04:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 14 Dec 2020 05:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=C8RetmLmqcDdToUcR6GaNwlQHeI
        55zHmNEuTFJfNQGM=; b=kXSjxHwJY6J+vyejKZGn7cyuM+YGb3GIvz65HJVF1ex
        AlW33R9xnTkrZm5fJL52ls+Z1spVRgfUpCNl7qdrfyM6o41vPmBjGYCCSMkQbnXg
        28dkuHIG3PsxoOqXPDGVqVcoVVRYvhfZd5Ymngz8SLIzyAqAXEwc4NYtOsq0u4Ar
        eo4l0XYbA35ZaAqPNy3alFPRf/wmz0FwUXZ1lqcWJU1O39E6iVmYpiNjLP20tRdW
        M2iFmYKxUkXkDXMli9eSm0K7fJgjNq+lIbKC5EuDt4/UOecnSZgy+9/uzVbJjcOO
        AnvazrQlxJeFZMCO87Z24aYYcvSYsau4uqr2fTqxTKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=C8Retm
        LmqcDdToUcR6GaNwlQHeI55zHmNEuTFJfNQGM=; b=OhnU8749mvcSo8JczLQtpj
        PmjhA5yR0T4a0gHvFEP5SJCS/2ZdveuAsP5g/fpCA1rJBq8DpsnvIyHEM4wP1ZsE
        7419t3cof+NXG1eNZF+8Hu3bianJDuLNUi1RGbvvhhXBU2HasPQlmlkE8qv2dkbC
        ZTDQYzlbmSiot2Sxp2dMK9zNX/mG1EQ72VU9NDVaj6ZNq1JdvOCKQq2nTUMZrv2H
        p60r66Bbi+mkkuhc0bdNR4yb9ESHrxE361MKqjK/ZRSY98VeTFtvOczINqCIz59z
        1XpXeAI5MQsJe8JEUc08nVRO2ie9D5ZPY51Wqv2M3pwyfhoo8bCwXY65dKEOtvPQ
        ==
X-ME-Sender: <xms:lzjXX0rSpWCYoMPji4YN4AgG-5DRSQyYz2bUktScyQd-2wf1xOG7aA>
    <xme:lzjXX6oht3F4W3zisETAPMXAMDDq6A6BVAvqNi2MD22ChLje5ZcwD7BWCP_rqgzaL
    _zBsbolTCgvQSX1hps>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekkedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepffetteevieejteeuhfffgeektefghfeileehhedtuddutefhhfejtddvtddu
    ledvnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepledtrdekle
    drieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:lzjXX5NpUF-IaVqQSUo_VDkCL4fJwb1M7AOyAhtCMW35xH4dx3rhtw>
    <xmx:lzjXX75xfuawgoNj-fJsHMQevlWojgsYx_GAZqPSGTVjhlQRQ6cyAg>
    <xmx:lzjXXz7mcpmXFq6mgRQohgBhAw1VtDlqLuf0cnpjOYFFmAnE85Pr3g>
    <xmx:mTjXX5SWxUXHHbMoJ1Xhsf3NDyhIUtNq3624II6WIACfIsqbk_DhKA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id EFCF6240066;
        Mon, 14 Dec 2020 05:04:06 -0500 (EST)
Date:   Mon, 14 Dec 2020 11:04:05 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v4 1/2] dt-bindings: hwlock: add sun8i_hwspinlock
Message-ID: <20201214100405.ajvwiw4dxaqjgaor@gilmour>
References: <cover.1607674518.git.wilken.gottwalt@posteo.net>
 <8b0c0b80bfc2dbb9010bac00fe0c90493ad8db09.1607674518.git.wilken.gottwalt@posteo.net>
 <20201211085757.faumhyto7akeayeg@gilmour>
 <20201211101311.654ac449@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v3hk2ivwl2kkfhgs"
Content-Disposition: inline
In-Reply-To: <20201211101311.654ac449@monster.powergraphx.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v3hk2ivwl2kkfhgs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 11, 2020 at 10:13:11AM +0100, Wilken Gottwalt wrote:
> On Fri, 11 Dec 2020 09:57:57 +0100
> Maxime Ripard <maxime@cerno.tech> wrote:
>=20
> > Hi,
> >=20
> > On Fri, Dec 11, 2020 at 09:23:48AM +0100, Wilken Gottwalt wrote:
> > > Adds documentation on how to use the sun8i_hwspinlock driver for sun8i
> > > compatible SoCs.
> > >=20
> > > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> > > ---
> > > Changes in v4:
> > >   - changed binding to sun8i-a33-hwpinlock
> > >   - added changes suggested by Maxime Ripard
> > >=20
> > > Changes in v3:
> > >   - changed symbols from sunxi to sun8i
> > >=20
> > > Changes in v2:
> > >   - fixed memory ranges
> > > ---
> > >  .../bindings/hwlock/sun8i-hwspinlock.yaml     | 56 +++++++++++++++++=
++
> > >  1 file changed, 56 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/hwlock/sun8i-hw=
spinlock.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/hwlock/sun8i-hwspinloc=
k.yaml
> > > b/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml new =
file mode 100644
> > > index 000000000000..76963d8abd5f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml
> >=20
> > We usually have the schemas with the same name than the compatible=20
> >=20
> > > @@ -0,0 +1,56 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/hwlock/sun8i-hwspinlock.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: SUN8I hardware spinlock driver for Allwinner sun8i compatible=
 SoCs
> > > +
> > > +maintainers:
> > > +  - Wilken Gottwalt <wilken.gottwalt@posteo.net>
> > > +
> > > +description:
> > > +  The hardware unit provides sempahores between the ARM cores and th=
e embedded
> >=20
> >                                 ^ typo
>=20
> Hmm, you are right. This is odd, the patch checking script didn't catch t=
hat one.
>=20
> > > +  OpenRisc core on the SoC.
> >=20
> > It's not just OpenRisc: there's some SoC that will have an xtensa core.=
 Maybe we can replace
> > openrisc by secondary?
> =20
> So there are actually different embedded cores? What about embedded
> companion core?

Companion core works for me

> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: allwinner,sun8i-a33-hwspinlock
> > > +
> > > +    reg:
> > > +      maxItems: 1
> > > +
> > > +    clocks:
> > > +      maxItems: 1
> > > +
> > > +    clock-names:
> > > +      items:
> > > +        - const: ahb
> >=20
> > clock-names is useless when you have a single clock
> >=20
> > > +
> > > +    resets:
> > > +      maxItems: 1
> > > +
> > > +    reset-names:
> > > +      items:
> > > +        - const: ahb
> >=20
> > and reset-names is useless as well when there's a single reset line
>=20
> So just drop the reset-names lines? I'm still a bit unsure about this dt
> yaml documentation format. I try to learn from the existing bindings, but
> the quality seems a bit mixed. So thank you for your patience.

Yeah, drop the reset-names and clock-names properties from the
properties section, required enum and your example

Maxime

--v3hk2ivwl2kkfhgs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX9c4lQAKCRDj7w1vZxhR
xTWEAP4qqfMWlCYuuDd1JE6/KS2fcKqf8SI2gkG0dBc/yFKNmAD/UL+pVIfqRhYf
ZmI03AEZ3cLCGxhu3tMrUU69tnnWGA4=
=CuUq
-----END PGP SIGNATURE-----

--v3hk2ivwl2kkfhgs--
