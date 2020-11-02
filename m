Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999852A27F2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgKBKNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:13:37 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:46077 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728005AbgKBKNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:13:36 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 473E6D70;
        Mon,  2 Nov 2020 05:13:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 02 Nov 2020 05:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=10J83T1RFS8TmTl/ZzIDq65+QD3
        rIov5ANW6VGwR7Mg=; b=vPJNA4eEBplYKgpEDUa0I8qJmSb1+kaoueGPLXsxOB5
        mbfTwQQXbryZdxqfaI/45fr9Tf0T2LKvxUCTdfVVOl4mpdT+n3+HVRJtij0Po+wj
        n6NFLeklkWXyX6tF20rQLFB7ZCbXyHcJWpVjOM1gv4f1U1MLolw2RNJtHu4mamIn
        Xx3DHsQCeW06CgMBqvESLtp7qSNzoanyFElFx+GtmgNmdW7mEtOw6s3YzId6cylD
        Nab0wsbh2zlmo/McRJmmRLXYx/fOw5VtqqCVcnglr/rGIE9DwLIYuimmMGXcyOuw
        UO24CHaeaDmCKQBOyxZ2ftRU/8G2a7Xu9aMH5BcyELQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=10J83T
        1RFS8TmTl/ZzIDq65+QD3rIov5ANW6VGwR7Mg=; b=kHpgJ2prcOsmpIlouIYQbW
        /ym2MHAbBLE3/7Gfe0p/iGjMAtPLL+QUrvhb81X7x3826i2PT+neHph3zzq1ykkn
        Qx3jfh+OP29WV2QpO4fIPQ0tqajdM81ur9plHSnPeTdyd0B8tBd5O+6RVZ2Qq9xb
        r0IRNsQG1iSiDq1gfaeE4ECPOLnlGFdf3qUbANhD+UAOSNRAabUecXt+laibYIod
        tvuS+lGrVEUfjkw/U1RD+IxjFDzCL5oKiKdIvB9T4LOOOZnWbVsqFyn1GxhvVY1P
        QLJPx4OfLtH5MS2D8krdyKfzThPKEIqyQNRwgsj8KT5u0RlzLpfTDIqxVcdCCy4g
        ==
X-ME-Sender: <xms:ztufX3hyBjvJb2hH-fBpSxKM4qBv996AXmVckcnpPdiw7DtN7udHAg>
    <xme:ztufX0CpLMv4JN6c4UwV46Vebrft6NgfMWJX1oqL_JbNwPIpAjgiS1WtumDGOO-2x
    jPqmEIx1H47h9-hQ8o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtuddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:ztufX3HocyDFsTQkHKyAr5uHcU3buSmqs91VaoCpYPi2K_rdsGTvtQ>
    <xmx:ztufX0TqPn-UW_rWh0RoKPF4TKu_-yVUuDKsEWzlUBo83LVcgf2KzQ>
    <xmx:ztufX0ybNt_7pi3EQAp6a0WQM3zUG2f0dtsC0zboZCcJMGvsbLfbxQ>
    <xmx:ztufXzqI2ZE3D5rpfnZYtqmnhUyegoWS1pWpH7RxsraIae5COdt1BA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4EAA63064685;
        Mon,  2 Nov 2020 05:13:34 -0500 (EST)
Date:   Mon, 2 Nov 2020 11:13:33 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matteo Scordino <matteo.scordino@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 8/9] dt-bindings: arm: sunxi: Add SL631 with IMX179
 bindings
Message-ID: <20201102101333.4bm2lfqpqnbpyp63@gilmour.lan>
References: <20201031182137.1879521-1-contact@paulk.fr>
 <20201031182137.1879521-9-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vt3swrzx5fe4gwkc"
Content-Disposition: inline
In-Reply-To: <20201031182137.1879521-9-contact@paulk.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vt3swrzx5fe4gwkc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2020 at 07:21:36PM +0100, Paul Kocialkowski wrote:
> Document the compatible strings for the SL631 Action Camera with IMX179.
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documenta=
tion/devicetree/bindings/arm/sunxi.yaml
> index afa00268c7db..0fa0c0b5d89f 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -754,6 +754,12 @@ properties:
>            - const: sinlinx,sina33
>            - const: allwinner,sun8i-a33
> =20
> +      - description: SL631 Action Camera with IMX179
> +        items:
> +          - const: unknown,sl631-imx179
> +          - const: unknown,sl631
> +          - const: allwinner,sun8i-v3
> +

unknown is not a valid vendor (and you should explain why you picked
that vendor name in the first place).

Maxime

--vt3swrzx5fe4gwkc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5/bzAAKCRDj7w1vZxhR
xXlTAQCtakHTsGL/lVoBZ1D8Kq6UBKteAITkBi70XtnFzEBIRwEA5bgkK47Hz68b
67T12Nx1hbPxUVCc2JxhuQh5ldvWiAo=
=DSmd
-----END PGP SIGNATURE-----

--vt3swrzx5fe4gwkc--
