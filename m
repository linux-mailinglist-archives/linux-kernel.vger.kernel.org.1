Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577AC2DC0A6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgLPNBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:01:07 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:32837 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725813AbgLPNBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:01:06 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 43EA55C01D2;
        Wed, 16 Dec 2020 08:00:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 16 Dec 2020 08:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=zZQYllv64ts7nO+7r+OzfETd3YG
        5MEC5zdQvS3P3f6k=; b=qiMhtJAa5ZeYhdZnfCblg9TcZwZhRLeeYGykW4xaJm3
        +9fwvyttaIniYdnoOAY6w6Baydeg3A9UNLF13z4WoZveXFxr1NSC9yKM48Po7LCi
        ks/hWF/Kjfo4ADjcDFS6gAzXfNKe2Ayclrr2ZoSTMcKpE+ltxZgpuAqzU3uP9Omr
        wU0+ODHOJzDr8CR1JrlZ+kHKsNBhL/52C0gkHMyGoLu8JhYagtPw+aQOiaQA6Reu
        H60RX47bn8elqwM5lnZn6QENxz7u5CWTwxFnxLKTGgQ8VGk1CRDLZ9ZflGtqO4f8
        C91ew/rT1FtTZAqtTkEoSVReJDnn4ZsaoKEwDmzo32A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=zZQYll
        v64ts7nO+7r+OzfETd3YG5MEC5zdQvS3P3f6k=; b=S07W9PoZpOnZLzZoOkgNoI
        yJahqXDRuXjtGLMdYNm++x9F0Asc5sJSNKVlKCVgKELu8OPIVHvbnyIjw5b3o3Tx
        rja8yX4U1jbUyA9L/tlJ2Vz+50XziRHFBaI4p0hxlHKRk9p6qs8XGYqpHygq/lNf
        idYMA8kXJmnPW/IkEiy8/FuAi+00OquYLJE+w1FYfZxDbXpIyeIgmHtpUDCasp1d
        2FCc1ejCunkNfzmzEnjP4uN/JOnSt5Ak+bOQv9kmm/pvD/KtS1cl8MWeUSX3exSD
        /RVW71Dj3NTmEF44xofuik+AqA8ay8IggOuoBkBhpGuktLnU+NI7MVLxATD7V96Q
        ==
X-ME-Sender: <xms:3gTaX_G51ZxIWZDlJXFgZ0UB67Fyk7rHMHYVHoN5lR9ZZmbDsJBxIg>
    <xme:3gTaX4Px93xaFrwBNb2sQZrpUQVbvVBhhYZheUvmbydsFhJLORo9roxL8DcZEahne
    cC9raXCsUGsUZNBKJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudelvddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuedtgfejueduheevgfevvdettdduleffgfffkeeltdffkeegudekjeeuveei
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:3gTaX5-XLaluSmyfvAmaUYPAMThleNjreRrxJaoWfiKCE3gOz2pCvQ>
    <xmx:3gTaX167_nW1EVHfRwmMnU77WdHIglAd4mOBz4BLj0Zw5jQjMbJRpg>
    <xmx:3gTaX-VMvVctbyIPkTi-cAeucv9C6seb-gVlOZlQOX2w3AJGKDuy2w>
    <xmx:3wTaXxcS8pNciiapQp0M4iQqhj4ucb8WMTwUJx5C7l-iDnPGn2v_Xg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 08DBD240068;
        Wed, 16 Dec 2020 08:00:13 -0500 (EST)
Date:   Wed, 16 Dec 2020 14:00:12 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] Re: [PATCH 1/3] dt-bindings: arm: sunxi: add
 PineTab new panel DT binding
Message-ID: <20201216130012.jah7ubzbjx5g632n@gilmour>
References: <20201210083722.1912981-1-icenowy@aosc.io>
 <20201210084232.1913871-1-icenowy@aosc.io>
 <20201214103704.bkgwh4bdelrtovgd@gilmour>
 <7C38287D-F4E7-412A-A7F2-3787A1B04573@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t4zuf4bwdzbehgqa"
Content-Disposition: inline
In-Reply-To: <7C38287D-F4E7-412A-A7F2-3787A1B04573@aosc.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t4zuf4bwdzbehgqa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 15, 2020 at 06:59:33AM +0800, Icenowy Zheng wrote:
> =E4=BA=8E 2020=E5=B9=B412=E6=9C=8814=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=886:37:04, Maxime Ripard <maxime@cerno.tech> =E5=86=99=E5=88=B0:
> >On Thu, Dec 10, 2020 at 04:42:32PM +0800, Icenowy Zheng wrote:
> >> Early adopters' PineTabs (and all further releases) will have a new
> >LCD
> >> panel different with the one that is used when in development
> >(because
> >> the old panel's supply discontinued).
> >>=20
> >> Add a new DT compatible for it.
> >>=20
> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> ---
> >>  Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>=20
> >> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml
> >b/Documentation/devicetree/bindings/arm/sunxi.yaml
> >> index 6db32fbf813f..73a6c8421172 100644
> >> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> >> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> >> @@ -700,6 +700,11 @@ properties:
> >>            - const: pine64,pinetab
> >>            - const: allwinner,sun50i-a64
> >> =20
> >> +      - description: Pine64 PineTab with new LCD panel
> >> +        items:
> >> +          - const: pine64,pinetab-new-panel
> >> +          - const: allwinner,sun50i-a64
> >> +
> >
> >We're on the right track, but new panel seems a bit too vague. What is
> >going to happen when they will change the panel again?
> >
> >pinetab-early-adopter seems more robust there
>=20
> This name will only match a batch.

Look, I know the situation sucks. Can we actually move forward?

Maxime

--t4zuf4bwdzbehgqa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX9oE3AAKCRDj7w1vZxhR
xQe/AQCnWdhfDabnL6i3aD5UY8eeM0yyJ1YLfl4XX49B3LcfTQD4hANM1suCeFvi
hzq9FyQUn5oz0hypNRv55URXdf0xDg==
=9wUh
-----END PGP SIGNATURE-----

--t4zuf4bwdzbehgqa--
