Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435A62C2971
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388695AbgKXOZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:25:15 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52725 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730558AbgKXOZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:25:14 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9361D5C01E1;
        Tue, 24 Nov 2020 09:25:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 24 Nov 2020 09:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=sitk3GTsxspTPI3ycVReJOlcRgA
        UlRjje2GEEm0ppZk=; b=WWWRBfdNLyhpXLr9rE1tCZAaVuR94z4qSBa0qZHK+/u
        9UPg/JCSyKbb8fmTMA1Fin+JCD8CTtZ5OHGz+HapiFTy8rVv4fRw/g06V4OnJcNU
        u8rZ4AUkzJKWMlLNMf3pZdF/xewH9jX8aI0AGWvTJXH5BTnRfawUS3DkrTkRps/f
        D3Bh6O29REy8lllyIfalQFbGKW+C9/tBhY0wg8GSRoKVNh5Ubi7uFGC+O4AkIc74
        LoGOLltmVmJS4D/gmCsHe+XDSsLxSzAJL6Egi4yy3E2cdV6ud/0BTFk3CEwygTwi
        uCDnrjB/FoWEsMx5gjTcyOgZwe7xo1jOmZTx1zRNqOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=sitk3G
        TsxspTPI3ycVReJOlcRgAUlRjje2GEEm0ppZk=; b=akhWCepZn/1XRJQ7ET60x6
        Vz+Q8szVOrppPb4G3A4xzGZNOQHTJZ0eEJN/ShtHmQsfj3TDRYfk36pTfgJywnkC
        LdMOVsXq9k7Un7pgn6dT61y6fRIOtSh9FhG1+q9dbvq40emlXsVvGqARRY4KARiF
        SbsVlKYJ9r/Q6ZEZgd+fxoTwgnYfXkQ5JO+15Je5KGUDKT/t//JDWaDtJy7klzhZ
        Hsf7/KTwzPPGEuA1mWKFV/TuaU336TUnZZLovQeAh2xHN7dMw63sR5+9lHUIS5Ty
        fKBFD8SPtUADumJWyDCd+7lROOKSiWfYtmnhS7XCJZd5jSrhhuFhQI/Bz1qCYWJA
        ==
X-ME-Sender: <xms:yBe9XyWZfV1ecWMslUWoJKlCBZMzHaxEAA0zp63RFCTqA_gnWzKazQ>
    <xme:yBe9X-mOIzJpbF4mM7tl8wZI0_BD_ccziDopjcwH2biIKZkktuaBfLYUSZJBztjNe
    RhSgDDBXgaBIO-1NSo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegkedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvffukfhfgggtuggj
    sehgtderredttddvnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimh
    gvsegtvghrnhhordhtvggthheqnecuggftrfgrthhtvghrnhepgfffieeiudduveefjeel
    geelhefgtdelgffhkeefjeefvdeviefhheekgeeivddunecuffhomhgrihhnpegsrghnrg
    hnrgdqphhirdhorhhgpdhgohhoghhlvgdrtghomhenucfkphepledtrdekledrieekrdej
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    igihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:yBe9X2aHtQ88nTnDcGWZxdqMnhyeYRcAJcLspr-1nf0AMXJSW35GRw>
    <xmx:yBe9X5W221I4I6eRtVqXZwliNxQLtNL3NcTIKNPiaTsDWazNN_EoRQ>
    <xmx:yBe9X8lfNnGQ-iIyaFY25fkT07_xVQf33PPo7f_fh53rjRcS4xMsGQ>
    <xmx:yRe9X2g2SK7wdVEKK9_Wj_S9_b6z40OweVzVoVOePb_AV4RKhKRDog>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 89BB33064AB6;
        Tue, 24 Nov 2020 09:25:12 -0500 (EST)
Date:   Tue, 24 Nov 2020 15:25:11 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Michael Klein <michael@fossekall.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add
 gpio-line-names
Message-ID: <20201124142511.rbzzrsmjx55ykgjm@gilmour>
References: <20201123094300.GA3699@a98shuttle.de>
 <20201123114535.1605939-1-michael@fossekall.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6sbmkps4knxhdg62"
Content-Disposition: inline
In-Reply-To: <20201123114535.1605939-1-michael@fossekall.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6sbmkps4knxhdg62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2020 at 12:45:35PM +0100, Michael Klein wrote:
> Add gpio-line-names as documented in the Banana Pi wiki [1] and in the
> schematics [2].
>=20
> [1]: http://wiki.banana-pi.org/Banana_Pi_BPI-M2_ZERO#GPIO_PIN_define
> [2]: https://drive.google.com/file/d/0B4PAo2nW2KfnMW5sVkxWSW9qa28/view
>=20
> Signed-off-by: Michael Klein <michael@fossekall.de>

Applied, thanks

Maxime

--6sbmkps4knxhdg62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX70XxwAKCRDj7w1vZxhR
xQ8JAQDog3kxhpSUVogruy/T1cwOfvj965+eQQo54PuVRUsXZgD7Boo/5JqErY8/
TPeA00zvD/njGPRzZMLsmj6fXKFWpQw=
=K0ff
-----END PGP SIGNATURE-----

--6sbmkps4knxhdg62--
