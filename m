Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4295A2FA525
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393490AbhARPut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:50:49 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:50061 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405991AbhARPe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:34:26 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id B9B2E580779;
        Mon, 18 Jan 2021 10:33:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 18 Jan 2021 10:33:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=pJ156Jbce4QNGr49mKfGsQNR4eC
        aEDZTREQ5pf0KrJk=; b=bkKjlbaj57bQBuRtXm6cS0L6vrNZIFWJ4VJDo3RSf2C
        yXkD4ocU7/u55uOvIgyHCEwIrDULJKoK8IrfZj3qIf8KwcGjMHFgae3oToI6jLes
        +Euuet4BB43pvUHxMlJghS4w23QEwCnj8B9Xq+Caow3rX/0jw0vbUeYQ6h3DdHLc
        KO+r6s2W+He6RKJPXObMt7TLDKbg9M+gs76NWRV+U3qvFzSSjHJbqU6qzYrHIskv
        JDnLZq2BN8XHIfOk0SbFX6/p4M75vlje936HQ1PRzdbHvd9iMQy22f2K88zs+gYE
        oWf6L066K4QOoSGaDRgysrYJXBRO/3+kC/jCkF98yzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=pJ156J
        bce4QNGr49mKfGsQNR4eCaEDZTREQ5pf0KrJk=; b=BOncumW2Eg5zr/G3oV2hk9
        BO2oQevqVYqS8nuUEwX8z30E6QcSR1iVhaYK1iLc4yDMFMGfrNtLow4B2n6zJkni
        cb8B9K7u+oQihmQ07/e2Wfyr5XhZ/3JA1KsvjgPjP9BWLz9erTZ+UJNoqKmbasZj
        w5b8JspKiCxUzIGsWmQLooFpA7YPAnKVULRbSTwRfEwL78lRin+gXhGh9f0lPK+3
        /NDibBLbkkGn2EjwgLhpTS8vbEBn/DZaeWNEWByDXr8PR01b/XFRT4wYAOxV7a0C
        Bub2qFg0VzGNIlaPHvnYC8+Ngtzb/q1XAUHQ3Awj1dpYpjK99+uCWy0id0CCevqQ
        ==
X-ME-Sender: <xms:R6oFYDiNadl2Q_FbRn0TLlzNsZSW3jVY-Puin50VjhedqWjCVEByng>
    <xme:R6oFYACNZ24O89KX_BPN8ngKGLnDwEvXlsJaQ6g-AhRGue6nid9LXylkD9Cv3tyQn
    nEdwE0TlKv8EPCC4OQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:R6oFYDFhJf4wZS4308I031PqcwHd77yyg6kukvDWX2_kcx256cmQpg>
    <xmx:R6oFYATUSyekY61FXomNKlA6rvsiPBipU0e8l23hyDE6TVOHTug4pw>
    <xmx:R6oFYAyiuAOSFOiWZi-Izz1Fw-tOEFojiSCiLsFL23gvz5T8-Z18Qg>
    <xmx:SKoFYMho5LyGUu-D_OTXqA9Hghrx-oEVTs7iwlbqhXfyYtSnzQ6sJg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id BF35824005C;
        Mon, 18 Jan 2021 10:33:26 -0500 (EST)
Date:   Mon, 18 Jan 2021 16:33:25 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 14/21] dt-bindings: usb: Add H616 compatible string
Message-ID: <20210118153325.pilglx5m767qronv@gilmour>
References: <20210118020848.11721-1-andre.przywara@arm.com>
 <20210118020848.11721-15-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m4roapjkb5si7l5o"
Content-Disposition: inline
In-Reply-To: <20210118020848.11721-15-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m4roapjkb5si7l5o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 18, 2021 at 02:08:41AM +0000, Andre Przywara wrote:
> The H616 has four PHYs as the H3, along with their respective clock
> gates and resets, so the property description is identical.
>=20
> However the PHYs itself need some special bits, so we need a new
> compatible string for it.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../devicetree/bindings/phy/allwinner,sun8i-h3-usb-phy.yaml   | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun8i-h3-usb=
-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun8i-h3-usb-ph=
y.yaml
> index 60c344585276..f6f2dcb6dc1e 100644
> --- a/Documentation/devicetree/bindings/phy/allwinner,sun8i-h3-usb-phy.ya=
ml
> +++ b/Documentation/devicetree/bindings/phy/allwinner,sun8i-h3-usb-phy.ya=
ml
> @@ -15,7 +15,9 @@ properties:
>      const: 1
> =20
>    compatible:
> -    const: allwinner,sun8i-h3-usb-phy
> +    oneOf:
> +      - const: allwinner,sun8i-h3-usb-phy
> +      - const: allwinner,sun50i-h616-usb-phy

While equivalent, enums produce errors that are easier to read. It would
be better to switch to one here

Maxime

--m4roapjkb5si7l5o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYAWqRQAKCRDj7w1vZxhR
xQzuAP96uuX7O5e8UAyOprEQwE8N+AHt7Fy2Ol4huAfv13hCOAD7B1dPFoZzwgfA
/AbqKUGTwNkqAU7KF1jVSkTkKSU0rAs=
=x9D0
-----END PGP SIGNATURE-----

--m4roapjkb5si7l5o--
