Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47ABA2D9672
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 11:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407098AbgLNKih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 05:38:37 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59455 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405720AbgLNKiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 05:38:17 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 77AD75C0156;
        Mon, 14 Dec 2020 05:37:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 14 Dec 2020 05:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=BQY9ckE/AoI0OoVhzNkSJcsng4u
        Fi8d1msnI5pSchPw=; b=M0wd6kt4mF9Et5oUsNM490xcMYybcZZLP2VypZ6BqVL
        kHq4e/v7TysyDJZPkrJ/T9gdcOd+d7jNeKjlJAhAznd3wv6PRJ03i0/12K1AOj5y
        vyoUJ+xi4YhOI6tuNaYrGwy/UabWuZMDn4Clp68DOSJdBqGP8zmHjlt9OwA751Tc
        7e4oZCBfywBMyRWzj6i93wXYF2twMYbMQWSf+9kH/QMb6JzsXosqgxUwddX2UGO1
        ort+NPT76Q74IkjdhjRrbAZry4ln0B52cOPwtC2wtM/Fnk93dQTl/xPdcL/oBRay
        JC8gq6E28D0VZKtwkAQMbAH4oesUMdPA8yvFejElUXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=BQY9ck
        E/AoI0OoVhzNkSJcsng4uFi8d1msnI5pSchPw=; b=C2hwyvMqNOeOMPZd+ZVEXQ
        3ay09v0EmxHJmhzQdjhZhnduHfwQhbDjrjUduFlqd5+PnaswSnA3aLWLZ5ZxPIw2
        QXQ3qgUqXnh5evlwloieuzFw/Ap/ni2+3jlopU6zL+uYq72k+I4QSz4jxsr9zCI5
        iGnuDx+aQRrfFumCGcf0lX2MGw1iedaPjLIpmRaX6cAzeCvGW0dtPieGNDfFFqjt
        RPhCVVTMimccVchyOwOAojp7b+u5uMEja8pyFuu2TQA/3yd29lWddC/0168soiaZ
        tI7rKwp0hkhxt8ar37n5QqS6y3dtAdbIHkANcf+jqm/SmS/lYq8u2+kr/wk1tfFg
        ==
X-ME-Sender: <xms:UkDXX8mVcyL00yFTUj4GJpZIGAu9JLq1ZJc4mGvWKCsB1ctAPZsgPw>
    <xme:UkDXX714Cy9Lnb-BZUxjjyK_IzFzMaJUERpX0C12d8q7QzzmK-ehTFq8fI-gK05W5
    pV3zJs_HBincO1KT18>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekkedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:UkDXX6qO-IF_sR0MSS2lHFDKK7Z9-JEGcQFUNZ8NaEPiGwLwhaWqwQ>
    <xmx:UkDXX4nmnNyPNGL1C0fIv5JDBt4RD6cX-ix-cKzCvCFzJZwHshN6dA>
    <xmx:UkDXX60CfXYdsomV1QqZHUR-TkTsrJgXnuR3AOYZCRDyK3OQ3-DYOw>
    <xmx:VEDXX0r_BZGebfBxhY-R6oGd4L7PZfuMOkLfudfWlSBhi3FTRFWI5g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id DB3E6108005C;
        Mon, 14 Dec 2020 05:37:05 -0500 (EST)
Date:   Mon, 14 Dec 2020 11:37:04 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/3] dt-bindings: arm: sunxi: add PineTab new panel DT
 binding
Message-ID: <20201214103704.bkgwh4bdelrtovgd@gilmour>
References: <20201210083722.1912981-1-icenowy@aosc.io>
 <20201210084232.1913871-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jypi6ln6e6jthjwh"
Content-Disposition: inline
In-Reply-To: <20201210084232.1913871-1-icenowy@aosc.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jypi6ln6e6jthjwh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 10, 2020 at 04:42:32PM +0800, Icenowy Zheng wrote:
> Early adopters' PineTabs (and all further releases) will have a new LCD
> panel different with the one that is used when in development (because
> the old panel's supply discontinued).
>=20
> Add a new DT compatible for it.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documenta=
tion/devicetree/bindings/arm/sunxi.yaml
> index 6db32fbf813f..73a6c8421172 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -700,6 +700,11 @@ properties:
>            - const: pine64,pinetab
>            - const: allwinner,sun50i-a64
> =20
> +      - description: Pine64 PineTab with new LCD panel
> +        items:
> +          - const: pine64,pinetab-new-panel
> +          - const: allwinner,sun50i-a64
> +

We're on the right track, but new panel seems a bit too vague. What is
going to happen when they will change the panel again?

pinetab-early-adopter seems more robust there

Maxime

--jypi6ln6e6jthjwh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX9dAUAAKCRDj7w1vZxhR
xY3uAPwIOL8SxCSyIM1zUHuDEuyjbgPAbZ6jyJnIgY8dOhO0CwD+NGmV9Kc113Q+
BM1jdGb7U1m6WrQVCweD5rvLGl/nGgs=
=ewmA
-----END PGP SIGNATURE-----

--jypi6ln6e6jthjwh--
