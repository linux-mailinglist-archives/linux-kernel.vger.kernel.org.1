Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5595229E8A5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgJ2KNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:13:10 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49001 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725809AbgJ2KNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:13:09 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E9C945C0054;
        Thu, 29 Oct 2020 06:13:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 29 Oct 2020 06:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=rYsJB0Ni4Mc0mp+yF2jlzjmLYVg
        HkKIiuDaNCcantYE=; b=oeAe5bsVv0ivmMRlc57TUNPFb9FGgJdaOuX/s5CZ1af
        k8H9g4z8XIIGEvBr8FCP/dVveKU2hOs3kCoqd+OoKMYRivykzIL4tgUMzCOUW1/K
        Cy+/jPmbBtVJq/gEew7MO3yZIN8lqoX4ufBwiK0UIdllonYzJ9bDqiK4GHnQtU4V
        +alnD/33NzCs+DYUBMVW68d+hyrC5kaTEF4pDp1HxIEV7oWsp9hoA7GPQDLnv1ME
        DlcZOjLwUs5oBviiIMyHOwbiysykopZzdB+gXgU1xL8sViMGTk7LpX+k8UbmCAuB
        DwdocxK4471L9D7YrlVMLm2PLFWZ/DbQlGkE2XT/xeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=rYsJB0
        Ni4Mc0mp+yF2jlzjmLYVgHkKIiuDaNCcantYE=; b=p15BRphwQiBk9UNkkEEcj/
        Zkqu2kJYL5Ya5YfNDOCu8jM7iCdCp6uV874ZjwL+xsD9lPIwXuAeO94TLTJYenEp
        CqKlhzEkIMHLbXd1WjDE0CJ2tqX9t1rj49KrPiQmj+AGiyUvnK/4ijsBCww4VSbo
        7mOIt4ZgZMyIw7xr3on3sqd0yLrMneCCQo2UV3Q8vuJm7KZtvfEWZGLoVyR8E33j
        vtZ6gtuwyp6Pbnn10oscSQRVKUeJdLFo6C5zzRXkaCmtkcR9+UfBQO+h4tBQe1Bn
        S0aQeAuVsZiimuFgHwqQ5pDTrfjNJD5mYFunEQcv2rxW+bSinR8bA4HmQ/y/71cA
        ==
X-ME-Sender: <xms:spWaX_nx3q_Bm9ACUzpcQnUHbKAVCMUtuWDJ1HrxRWaoYgmqlPELcw>
    <xme:spWaXy3Z1HabtJ_YapY2KM3OFbUkHVirlFfCl4yyPFK13vFQqb3gdZv8cVHiSnVhs
    Q8JhVu9JqoRUQskx9k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleefgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:spWaX1o-mwZABOtHWj1E06YfU5OxGOPLEChADZsCtRQ3G0xBMs9m5A>
    <xmx:spWaX3nU-RU-VrND0anoYY5ou16UrBdbvVscjNPTDQoqaFtFYA6itw>
    <xmx:spWaX93xE9qDMQJcjY5rj7oPj2ZTE2Aznls0Oy2oJUw1Pt8bC-piCw>
    <xmx:tJWaX4R-EpJ3Qy-64uOYb5UGH1-O9sNpk5v3J17q_YZrzhoUyj-fug>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id BA3E83280063;
        Thu, 29 Oct 2020 06:13:05 -0400 (EDT)
Date:   Thu, 29 Oct 2020 11:13:04 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Matteo Scordino <matteo.scordino@gmail.com>
Cc:     wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 4/5] dt-bindings: arm: sunxi: add Elimo bindings
Message-ID: <20201029101304.yja4m747pc62re34@gilmour.lan>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
 <20201029022000.601913-5-matteo.scordino@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tfkoq4gmrgzotfz5"
Content-Disposition: inline
In-Reply-To: <20201029022000.601913-5-matteo.scordino@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tfkoq4gmrgzotfz5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 29, 2020 at 02:19:59AM +0000, Matteo Scordino wrote:
> Document board compatible names for Elimo Engineering Impetus and Initium
>=20
> Signed-off-by: Matteo Scordino <matteo.scordino@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documenta=
tion/devicetree/bindings/arm/sunxi.yaml
> index 0f23133672a3..55405809ec91 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -898,3 +898,13 @@ properties:
>          items:
>            - const: xunlong,orangepi-zero-plus2-h3
>            - const: allwinner,sun8i-h3
> +
> +      - description: Elimo Engineering Impetus SoM
> +        items:
> +          - const: elimo,impetus
> +          - const: allwinner,sun8i-s3
> +
> +      - description: Elimo Engineering Initium
> +        items:
> +          - const: elimo,initium
> +          - const: allwinner,sun8i-s3

This should be ordered alphabetically, and most importantly, must match
the ones you have in the DT.

Here, we have kind of a mess already: the Lichee Zero+ uses
,sipeed,lichee-zero-plus, sochip,s3, allwinner,sun8i-v3, while the
pinecube uses pine64,pinecube, allwinner,sun8i-s3

IIRC the S3 and V3 are pretty much the same SoCs, so the first one seems
to make more sense to me, but then we should fix the pinecube.

Maxime

--tfkoq4gmrgzotfz5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5qVsAAKCRDj7w1vZxhR
xVVIAQDmDDS/BMkDYVHnPMF1XcIGfuy3Sko7fl3gm9DEwtOe2wD+N68SO2iPczRJ
cwHDi17y9WbYOszqnj5SSrRBe3KFig4=
=43AT
-----END PGP SIGNATURE-----

--tfkoq4gmrgzotfz5--
