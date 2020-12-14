Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEF92D967F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 11:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407260AbgLNKk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 05:40:28 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39599 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407238AbgLNKk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 05:40:27 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id DD4B45C0156;
        Mon, 14 Dec 2020 05:39:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 14 Dec 2020 05:39:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=kf9WzYleura+y67ZTIVqK/D/+zF
        BiyYpm6sNj97nVIg=; b=WrZu8TeRMpP4GGCypTIuMQzdoG5zFTa/+sqDWFXsM/+
        Jz8qadyQPQi1UlUcax9wVr8WIYRe8RYvBohAIq6DrVUHN+9gu80Pxb9yTJLcrB5q
        z8/E7fCE4428ZoAPklDFz0rCdz+clfgii4xYP7C8gTED6zH4avUMhPYWZqJ1sdAf
        66/EYsfCBi8TqtWM2miTasAUSUSX6rjdCO31XSnVdYRJOoytalKQrHGSHXpGuo5T
        KfednWh6rIlBaZ3kGv4QulOiymbJpBl+3hL5pqkg3Hkh4PofZDtMzBI8ZShPbh7q
        HVkg1F8tv2QKGxsqeQFpHZLsFRqlU0D/kqmXzGMvCOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=kf9WzY
        leura+y67ZTIVqK/D/+zFBiyYpm6sNj97nVIg=; b=mXqATlVA/V0//+HYckAGHU
        9yXo0UEWy0ClX5AeYNwUn2o0GpTkjILlWxpIqc3/gdIt/RLq9qODGOjMf/wEqQUK
        N43xBdI/XYKAzWM2MmIvhlNxhS+pq0WcXI3ySly3s2hVqdcLYYn7CTHVWTiqLj4F
        rCnU0o6Rspnuqrhdg9/vDztzXCgOztjPSVPczpzOZfguWFauyOhUxyEtsxtn40Gr
        TQqFozvyLw33kL/l1E/69BXxtxQUyFcRSU8VqbOsD6Qf/x1VWQaJT84DVrnZ3AJs
        XwALF3nR6zzpDdAZmveU0/+thBQtaDjD1wMPAIovm5YY49FGNJi+7QAKizaFntiw
        ==
X-ME-Sender: <xms:2UDXX4IawkzEbT8CCDT-cnF-eUzWLDX1S9aCnPSS86JkICfIn0zkzQ>
    <xme:2UDXX4IxRIYAi_zSJeRZ7nOzOukaooqVXTD6wAs-xg38PGzE5Ccv3nzK28LPGdIR3
    dK89WzcmjPlO7ipfhk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekkedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:2UDXX4s4vMYRaWE2pELTJR6zOxl4WOM7YuUs2B5P7lbX-WVZ37FZ2g>
    <xmx:2UDXX1Zh-KdGfD-IDQk5-ytlRoCDes6gQVwAbvMrgKWoPWVSG8UuRQ>
    <xmx:2UDXX_Z5wDeAJMY3yWMPz13lVQ1dTfJrJmgkf0s7rB2l6kQ3KDAVUg>
    <xmx:2UDXX0Mk028Sk2AQg3s-zAviLV9vr9cWB6HZ7ZZnRiY_egOC0Pf7yw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4254E240062;
        Mon, 14 Dec 2020 05:39:21 -0500 (EST)
Date:   Mon, 14 Dec 2020 11:39:19 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 3/3] dt-bindings: arm: sunxi: note that old PineTab
 compatible has old panel
Message-ID: <20201214103919.l2fw5z2bhoapphf2@gilmour>
References: <20201210083722.1912981-1-icenowy@aosc.io>
 <20201210084558.1917246-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g3put2ecpvbxmkps"
Content-Disposition: inline
In-Reply-To: <20201210084558.1917246-1-icenowy@aosc.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g3put2ecpvbxmkps
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 10, 2020 at 04:45:58PM +0800, Icenowy Zheng wrote:
> As the old LCD panel used by PineTab developer samples are discontinued,
> there won't be furtherly any more units of the sample, and this should
> be noted in the document.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documenta=
tion/devicetree/bindings/arm/sunxi.yaml
> index 73a6c8421172..9f29b5811aa1 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -695,7 +695,7 @@ properties:
>            - const: pine64,pinephone-1.2
>            - const: allwinner,sun50i-a64
> =20
> -      - description: Pine64 PineTab
> +      - description: Pine64 PineTab (developers' sample with old discont=
inued LCD panel, discontinued)

I'm not sure it's worth mentioning it's discontinued, making it clear
it's for the developers sample is enough

Maxime

--g3put2ecpvbxmkps
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX9dA1wAKCRDj7w1vZxhR
xbKVAP94C6bgdQ+a/d6e5hoBuvMK+6rU7kIB5KIJmjD8U/G9kwD6Aihfsyh8Idc/
ql9iEKZMMmcGXGY/wCYuQuJ7wAUh2gU=
=i2dC
-----END PGP SIGNATURE-----

--g3put2ecpvbxmkps--
