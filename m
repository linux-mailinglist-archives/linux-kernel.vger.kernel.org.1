Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847A32D15C2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgLGQNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:13:50 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54479 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726408AbgLGQNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:13:49 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 1D3CF5C00B9;
        Mon,  7 Dec 2020 11:13:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 07 Dec 2020 11:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Pi55HhHcgumstUcmjVA38GivxwX
        rj/SAaO5BPaGV9Go=; b=uxCfv5As6ODcVPF+oPIwxYwGxnW9g1/qGYSV9T18ZXH
        CpTZ1ZLmXjKu5I+7yna+cOTyzWcRc7iUkaqr6u5iboo/NyjlYeqePAGhlyexrWoS
        p3sqwHYKGsL5ZnlliIkAgEkmVyzvveuU7lKsnacabJ5f7QgUQGRoq4TDavsZBeGx
        I8seYlaBEIKA6Dh+I1Hsap4+qOnMi5boseRwCbE2TYuskQXg0z4cGBD0mwnpMrP1
        fYkQ246RTd87wT9ZGyrUwhR0KwOsA3PGvO0n7pBNXdqkxIzxnaMep9yTd3FizU78
        nF5NY02wNTV3D39X43QkGONxVRdo8/vAfriX2P6JnNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Pi55Hh
        HcgumstUcmjVA38GivxwXrj/SAaO5BPaGV9Go=; b=FeW/ul7/ljED89G/+IkQJL
        8u71lBDp1Jj/fUbLacYoWZ5gphB/bsVJdRep+EBzcQ6YryGPBaSGJPI5xdWiDymf
        J0yztr/5hp2k8xtfmmRrc6xJDa4Fn6JLTRG/elLX7MIkj+C+D/+J2BkU0CC0KAGV
        3uE35VwCzc/pVScsIqvXGAJvg2GofGt8UX31ddLhZivehHKTYjX4UJTwI2wg8GL9
        gWBdF3vfbga9QhhzWveZShyoH3sA/O3WFyFFSlvqN7pgEiURZcD1TE1SIlqOBJbR
        xS/G2uKzG5dOgZFDbbPWC1KcLU0VDzDRrWjHfrZqZPCfFrbbLsw/sG7eP789PTuQ
        ==
X-ME-Sender: <xms:jFTOX0Q4JRofI_pB65ME_NhjhIXMxgVA4AQUbGNGoXJ5JNTFScfKvw>
    <xme:jFTOXxwpDLEoPxc-BeQ70-L_6OGzUA8zTdoB2GnjSI2Yzf5E_h3T3LOjNliHcoK4y
    PEdE2q3LlcUjnbIGRU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejgedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepffetteevieejteeuhfffgeektefghfeileehhedtuddutefhhfejtddvtddu
    ledvnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepledtrdekle
    drieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:jVTOXx0BTXS7A0hpq9dbIz-o8Pv8OhEpc44rFA8ML3YuMY1oDBeHJg>
    <xmx:jVTOX4DzaCUwYkZ5nQ6cBF3-vU5qEmifLn8Y5dX8o5RDRULK2e2l0Q>
    <xmx:jVTOX9hxuO5OylpAzC1oLGENNUIECjJuT7JBh03vjIqhDJ9hXk99TA>
    <xmx:j1TOX7YMhqx5VH8OgoKFfc87yHpqLW9-Tqh-N7foL3MElLgQJ-Ru1w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id AE9FE240057;
        Mon,  7 Dec 2020 11:13:00 -0500 (EST)
Date:   Mon, 7 Dec 2020 17:12:59 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v3 1/2] dt-bindings: hwlock: add sun8i_hwspinlock
 documentation
Message-ID: <20201207161259.z6no7m2xqwb2jrju@gilmour>
References: <cover.1607353274.git.wilken.gottwalt@posteo.net>
 <ac2c2b279be52876d66c91826a1ccebd08fe4810.1607353274.git.wilken.gottwalt@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ynnxhoar6alqdnre"
Content-Disposition: inline
In-Reply-To: <ac2c2b279be52876d66c91826a1ccebd08fe4810.1607353274.git.wilken.gottwalt@posteo.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ynnxhoar6alqdnre
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 07, 2020 at 05:05:03PM +0100, Wilken Gottwalt wrote:
> Adds documentation on how to use the sun8i_hwspinlock driver for sun8i
> compatible SoCs.
>=20
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> ---
>  .../bindings/hwlock/sun8i-hwspinlock.yaml     | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwlock/sun8i-hwspin=
lock.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.ya=
ml b/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml
> new file mode 100644
> index 000000000000..2954ee0b36a7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwlock/sun8i-hwspinlock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SUN8I hardware spinlock driver for Allwinner sun8i compatible SoCs
> +
> +maintainers:
> +  - Wilken Gottwalt <wilken.gottwalt@posteo.net>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - allwinner,sun8i-hwspinlock

This can be a const instead of an enum, and since it was introduced with
the A33 it should be sun8i-a33-hwspinlock. There's a lot of SoCs in that
family, some without that IP, and we could even see new SoCs in that
family with a different IP at some point.

> +
> +    reg:          # 0x01C18000 (H2+, H3, H5), 0x03004000 (H6), length 0x=
1000
> +      maxItems: 1

There's no need for those comments

> +
> +    clocks:       # phandle to the reference clock

This should be the description, and it's fairly obvious so you don't
really need that comment.

> +      maxItems: 1
> +
> +    clock-names:  # name of the bus ("ahb")
> +      maxItems: 1

You don't need clock-names if there's a single clock

> +
> +    resets:       # phandle to the reset control
> +      maxItems: 1

Same thing than for the clocks

> +
> +    reset-names:  # name of the bus ("ahb")
> +      maxItems: 1
> +

Ditto

> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +
> +additionalProperties: false
> +
> +examples:
> +
> +  - |
> +    /* H2+ based OrangePi Zero */
> +    hwspinlock: hwspinlock@1C18000 {

Unit-address's are lowercase

> +      compatible =3D "allwinner,sun8i-hwspinlock";
> +      reg =3D <0x01c18000 0x1000>;
> +      clocks =3D <&ccu CLK_BUS_SPINLOCK>;
> +      clock-names =3D "ahb";
> +      resets =3D <&ccu RST_BUS_SPINLOCK>;
> +      reset-names =3D "ahb";
> +    };
> +
> +    /* H6 based OrangePi 3 */
> +    hwspinlock: hwspinlock@3004000 {
> +      compatible =3D "allwinner,sun8i-hwspinlock";
> +      reg =3D <0x03004000 0x1000>;
> +      clocks =3D <&ccu CLK_BUS_SPINLOCK>;
> +      clock-names =3D "ahb";
> +      resets =3D <&ccu RST_BUS_SPINLOCK>;
> +      reset-names =3D "ahb";
> +    };

Different examples should be different items on that list, but both are
essentially the same binding so you can drop one.

Maxime

--ynnxhoar6alqdnre
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX85UiwAKCRDj7w1vZxhR
xe9lAP9RwP8NEfConaF1Xt7H1BHl3LM2FkYPw6HtlK8/hCkcdgD+Mf221eTBnS6z
8symJ+diEIRCht9Wh1qUZr1qzK8t6AM=
=kYoS
-----END PGP SIGNATURE-----

--ynnxhoar6alqdnre--
