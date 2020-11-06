Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E48B2A9525
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 12:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgKFLYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 06:24:19 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55487 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727050AbgKFLYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 06:24:17 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id ABCA95C016D;
        Fri,  6 Nov 2020 06:24:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 06 Nov 2020 06:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Z7GtEnyfPD4Tr6magiM/9iI85Uk
        W2DA92V9r6Z1Ss94=; b=sETp3awsl7G5UqvU35lK7x3MTLFnxfkbmbVJBfMTwrQ
        BayTA1Prvl5ThOGZTnNNkPc9R50dhSXVrRcuSElCHgasrvP2onFQAkjJiF77rXqY
        BCRuS9qPk2yy/ToZc4qOsTJsYgvnU1jbubwSM1RAEvPJrGaqcQGViTYrVqsArJNl
        az+EmvI3uY7/KRjrbxSPqd6bEprbzmrwqMiv6sZq6QFDHLs0I0YQsAjFuORK++tz
        OHwjEwuzAmm989Z+Vg/wDCHgDjPFOX1rEH319t3RgI2ykt3avC9Zw6q5YY8gEPuU
        wqgvOHj6nZfbClLGy2uyABCX6QOrb1j3qmLIBgoi6+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Z7GtEn
        yfPD4Tr6magiM/9iI85UkW2DA92V9r6Z1Ss94=; b=dPKOwB9luNzPtrOrWbYzNY
        eXcyQQr2QHuumu8jWOdPmx4htRstFnjDmvim0hEsWRsrplqrMrtdPcFRUe6A35q7
        dWFMJsO19WVBZYIszI0fJS23u2iBbNWC5GpvuqYdlB2E5d1gWM4RVujnDlTM2/Ug
        5uVwx5uszkLwuC0EU48wqMfJ5HVhb13nT5Jb1iQ7b1V2duVFbUI5glJj7QasfnSl
        OB8pjSqk1YHTHXjerGYEmPNIG58UCzb3jCREta2HGohIZYGE3h0hUOmFLhlX8jlU
        N0wDPiVEUMrqrPyjwEPYZULqT2OJvMUStxaa5Iwtxgbxcrj0llH+sSgfCnhe2seg
        ==
X-ME-Sender: <xms:XTKlXzjdz1AijziNj8NHaB8goGa9CM9-mnM2RIf6zwcwG_yoTn5k_Q>
    <xme:XTKlXwCd1_DWJOUMMeyw_XQ5ZLcraBq3HCZetMaG0JUAC6ZS2vaQyCEG899cgUnWq
    p9WZppkQv14hoo5Pj4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtledgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:XTKlXzExPPYHhqHbNjKPW9q1ebKHebAkxC9mpzFHHjPngc5uLy6wjA>
    <xmx:XTKlXwRk4gc-Yqn4dgMqE6hja_ZsZYuvuS3-qDqa6srmjIOcnN2cWg>
    <xmx:XTKlXwzyM6lPt-4OP7i2OpSu6o2Z02iwQ9DEPyaHXurX3BV6gZNMnA>
    <xmx:XjKlX_rVDy62AQEMpBwq6fk7JT0ZJ8mVAMYyvs8t5UKsItcQGM4yQQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7DC30328038D;
        Fri,  6 Nov 2020 06:24:13 -0500 (EST)
Date:   Fri, 6 Nov 2020 12:24:12 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: dts: allwinner: pinephone: Use generic sensor
 node names
Message-ID: <20201106112412.nanxxywh7s6iqqkj@gilmour.lan>
References: <20201106032055.51530-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o7piv2twhicpvhex"
Content-Disposition: inline
In-Reply-To: <20201106032055.51530-1-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o7piv2twhicpvhex
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2020 at 09:20:55PM -0600, Samuel Holland wrote:
> Instead of duplicating part of the compatible string in the node name,
> use generic names as recommended by (and listed in) section 2.2.2 of the
> Devicetree Specification.
>=20
> Suggested-by: Maxime Ripard <maxime@cerno.tech>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied, thanks!
Maxime

--o7piv2twhicpvhex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX6UyXAAKCRDj7w1vZxhR
xatGAP4vdTUYKMf7C2ve3hzaM3Rpm7yuxU086hWOPC1WD3ObygD/cve05ywhg5pl
OiKXXaViAmTHXrEreYCXVoxBGecuxAs=
=dRad
-----END PGP SIGNATURE-----

--o7piv2twhicpvhex--
