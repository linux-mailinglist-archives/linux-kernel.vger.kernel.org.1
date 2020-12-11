Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D49D2D726F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437267AbgLKI7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:59:10 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:56533 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389815AbgLKI64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:58:56 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 75CBD5C0042;
        Fri, 11 Dec 2020 03:58:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 11 Dec 2020 03:58:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=NE7CoxkV9xIWdvKFNNOT5b8lUb5
        o626SpXcV1/1X2SE=; b=LCD8locPAyG+DjU/r6IyHO9mFrxK34mcP/ryLMtOHFe
        v6spxUIAkT3ua8a/Hxudp2PQA6CtUqDoZaWKRGGzE+BbqLoSuYTkBv7TP5kxMMHw
        N9Ni8rKdw/K5s+MqfmkKxf/xUfs4C05EJr3VnGnJU/c56E54uIHG00ka1xDafIyj
        V8dTT256gLNYZmS4E8U5rhaVT0aretG3wJDImzJCx7O57zwP8Teeie0U1sYDxuP0
        UGEd2fndwljs6+nESdUTv0mU/4d5xXLSAVVJ2i/JT1Al+Oju4eAVonbAE96wsrjV
        x6oMPyM/+LmY6qyyGhh/ZNnaKiVxxaGCrIGCEquqkbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=NE7Cox
        kV9xIWdvKFNNOT5b8lUb5o626SpXcV1/1X2SE=; b=atNpGsJMsvI+Vk6vcucX+g
        SIVtQKrTyqIEKY0Eq328LGlt2aA5hAP/K3tUxfKMd6V2NzPoGNxm6gdAs2oHCPu1
        CM14QmfdNtbngTeeIJxOx0KkhODT3/B50iCZTjXILEo+AjBticX9YO8MQ91TgiDD
        11R9VPWDdkOSk+DAIyvXo/XKG6n2cmUvcXrYuVljrqZCC+bNSXaHQ+9Zhv/DOzQi
        Tkx4RuxYYrA3644nVErWRMerRAGzHkNF5C0Yw9pC8TWLAuawene8NYGWyICPhSVU
        0Epy812ZDMTD0kVup6W4P0u0o9p2lNFbj0S6Vf6vLDbZwT31DXAhGWX0QI5GDuqw
        ==
X-ME-Sender: <xms:lzTTX03nBLfgNC0KK9AGJTJNl9kq-m4UF4p1gksDXUlXp0aac_VgbQ>
    <xme:lzTTX_HF151UZxOL9MWNjdS6BtxnMhH1DUGR8BgvBHbUW_ItSavh9bsmRuvapj5_9
    NnaIlMQFaHZPGBEVqM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekuddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeffteetveeijeetuefhffegkeetgffhieelheehtdduudethffhjedtvddt
    udelvdenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppeeltddrke
    elrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:lzTTX84lQoDX44GhvUcF-GYOTCijXU1UKd6mQXZwTrB3ljfrtyiYYA>
    <xmx:lzTTX92Y7MzzVKYw5XflHTH94g5-YJLXA_6S55MLSs0BbkpJtglQBg>
    <xmx:lzTTX3FoE6BfzyQ_u26SMWnN-9Y6pCYf7BGUzJYxKRnMD57EtBeSTA>
    <xmx:mTTTX4NDbDde3-l3B0IVVVtujovc4_tinL_QAWpKiSwtv3kJC7nhMA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 88A5F108005B;
        Fri, 11 Dec 2020 03:57:59 -0500 (EST)
Date:   Fri, 11 Dec 2020 09:57:57 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v4 1/2] dt-bindings: hwlock: add sun8i_hwspinlock
Message-ID: <20201211085757.faumhyto7akeayeg@gilmour>
References: <cover.1607674518.git.wilken.gottwalt@posteo.net>
 <8b0c0b80bfc2dbb9010bac00fe0c90493ad8db09.1607674518.git.wilken.gottwalt@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ingsecl3s3ihldil"
Content-Disposition: inline
In-Reply-To: <8b0c0b80bfc2dbb9010bac00fe0c90493ad8db09.1607674518.git.wilken.gottwalt@posteo.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ingsecl3s3ihldil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 11, 2020 at 09:23:48AM +0100, Wilken Gottwalt wrote:
> Adds documentation on how to use the sun8i_hwspinlock driver for sun8i
> compatible SoCs.
>=20
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> ---
> Changes in v4:
>   - changed binding to sun8i-a33-hwpinlock
>   - added changes suggested by Maxime Ripard
>=20
> Changes in v3:
>   - changed symbols from sunxi to sun8i
>=20
> Changes in v2:
>   - fixed memory ranges
> ---
>  .../bindings/hwlock/sun8i-hwspinlock.yaml     | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwlock/sun8i-hwspin=
lock.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.ya=
ml b/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml
> new file mode 100644
> index 000000000000..76963d8abd5f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml

We usually have the schemas with the same name than the compatible=20

> @@ -0,0 +1,56 @@
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
> +description:
> +  The hardware unit provides sempahores between the ARM cores and the em=
bedded

                                ^ typo

> +  OpenRisc core on the SoC.

It's not just OpenRisc: there's some SoC that will have an xtensa core. May=
be we can replace
openrisc by secondary?

> +
> +properties:
> +  compatible:
> +    const: allwinner,sun8i-a33-hwspinlock
> +
> +    reg:
> +      maxItems: 1
> +
> +    clocks:
> +      maxItems: 1
> +
> +    clock-names:
> +      items:
> +        - const: ahb

clock-names is useless when you have a single clock

> +
> +    resets:
> +      maxItems: 1
> +
> +    reset-names:
> +      items:
> +        - const: ahb

and reset-names is useless as well when there's a single reset line

Maxime

--ingsecl3s3ihldil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX9M0kAAKCRDj7w1vZxhR
xexWAQCqZr/vl/JseCZvs8gaRdp8cMRY9dzgofiLGpjq8picugD/ZwT70zpx7q82
KNUnpg9g1kmJrkELe8S0X0iVbvgwtQ8=
=/jFb
-----END PGP SIGNATURE-----

--ingsecl3s3ihldil--
