Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C79A2FA56C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404709AbhARP67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:58:59 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:45167 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405841AbhARPbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:31:48 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id A16EC58079C;
        Mon, 18 Jan 2021 10:31:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 18 Jan 2021 10:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=NvUEhU6J4Ii+xfqC5c+MJMvRl3f
        ZuGnBjGBkusrqzHM=; b=LffEcGhWz/vgQpEkk+1xT8K5OwteDK8Bu/awFb9jqeV
        Z4/x0R/81LdjJNFyD/1HnBDInymthjNkAzixoZepENtnOhA+uauERldOZDNeQSgN
        ZjYHA7JtF4Rpdaa9OtJMFlMNAMiYEwqFOKZ7nAdFzAHiG+HnmggziU/DKSOd2VNV
        Ijw7Mrg23ZlnP4cw3IqrpVQB9kvyqfAmHxfcG9Ivg26uNBLN0YWjzxz6+bVwS5dT
        8Lie+hzWzz8dLifSeRi+YCwjOtMhvBirk45kru9sHP7lC6ryOfoVZx9bAoNaWpre
        xDtTHdbz64riPO6f7FSWU9OxIccYWdi/NNfLb+b1mbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=NvUEhU
        6J4Ii+xfqC5c+MJMvRl3fZuGnBjGBkusrqzHM=; b=IxqPS8Q4n3U57pUQVF2oKF
        ND0FX0ha1OnILuUsaMXs/7axa+HHVz17qQh0zXhTr5L/bSnTdtbdJpCIYDjHEN5u
        WMZVD3ycSD9KnAUqVt4Q5d8S0LtHUCIVqKeLW40SrL9I0XK4uBXL+hgozbhy+AcY
        Pnc6LU4VcpQMA+wMsRgBZ648zTGlM8aU/0JRsRO8LwFGZLNxJ5986gG6uVyAdLEc
        7/HYuf0PUq3GMj+NqGUz9IZ6wYtx8HekKCE/tMm2J2GSUcPpHt4G4VMLXmOsMUn7
        pmv+0Be2MUWbAkQ5a4m5nCd846L6H3ZnPoepBS+0ULMHfHkiW+ZYcHCn7g4nu8Ag
        ==
X-ME-Sender: <xms:tKkFYPz8kvvS5xqNyVjyA_5i18NYLbV2SFnhSoRSV8Y5kgZPLy53KA>
    <xme:tKkFYNlnmYAQYasYbOpqQnmdiZoan4yBiOLpld0U5XhZj2r1KFf5Tsn5-s_RYH35M
    _3QCLPHd02yyZ0apVI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:tKkFYPWiNnAqtAhrGPAQB7Up6LWPgNIJfalcrbL_sNoemPIX0tKA4A>
    <xmx:tKkFYG0hhOwm5XSAq5QQkYbE6LHHui1LXfU-x30ne7elPTPkIDX_xg>
    <xmx:tKkFYHm-Jv_i_VpQXbmnlVecIDwjOqg_8qe9EGk2aNSLjhUfbM2IBw>
    <xmx:takFYD7XRgb1QK9kwydtMIyiICj2pyvRKoa462khbELkf4DqlLoSQg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id EF11A240064;
        Mon, 18 Jan 2021 10:30:59 -0500 (EST)
Date:   Mon, 18 Jan 2021 16:30:58 +0100
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
        linux-sunxi@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v3 08/21] clk: sunxi-ng: Add support for the Allwinner
 H616 CCU
Message-ID: <20210118153058.26da4guhglb7s5sc@gilmour>
References: <20210118020848.11721-1-andre.przywara@arm.com>
 <20210118020848.11721-9-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yru5s5mpaath3ljh"
Content-Disposition: inline
In-Reply-To: <20210118020848.11721-9-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yru5s5mpaath3ljh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 18, 2021 at 02:08:35AM +0000, Andre Przywara wrote:
> While the clocks are fairly similar to the H6, many differ in tiny
> details, so a separate clock driver seems indicated.
>=20
> Derived from the H6 clock driver, and adjusted according to the manual.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--yru5s5mpaath3ljh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYAWpsgAKCRDj7w1vZxhR
xYcHAPwO+F7YjxEwkb5SFICrOUsqTS4NibyNY07M8YBgtHcBXQEAlOZdhp/4T3yM
ESRlpJTvxbKpE6aaMLmK4CzMkguHLAg=
=QR7V
-----END PGP SIGNATURE-----

--yru5s5mpaath3ljh--
