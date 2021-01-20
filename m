Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D8C2FCE3F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732714AbhATKTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:19:35 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:42677 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730805AbhATKBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 05:01:01 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4201C580645;
        Wed, 20 Jan 2021 04:59:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 20 Jan 2021 04:59:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=lp4bugowM8Cz89Jr9r+G1178edD
        DlUIF6dAKNP0Nskk=; b=UCjfDb+Kw3dJzbDn7icuH7AyBUbz5gCD8G7LQ1cFmyc
        OPsACPI7sq3DTrrSjp8m1XVScTf/p5zg/bLwFlhI529LQ5HVnm77vRtwZIuDaB5K
        3mpw4mNjClCblfd9ftPHlyzGjIIkWmq+1T4mWI4YOysszigQxencG12g+jNgW3Wq
        jxSJ9RF8TIZmT8d79IYoVN4AQ/x7T8ZLnILpr/TcrAevVVd1j6Pe+KI7wzgOszoh
        oqP8V4hg0j0dfNAXmfAnt/8HEN3a5P4yIWeLs4xzA/eBCvETJC9g1anbrlejfzlB
        SJ5SW2sz/6L4qyKtJXT57twUjt2IhyYnZmLniMuZ9rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=lp4bug
        owM8Cz89Jr9r+G1178edDDlUIF6dAKNP0Nskk=; b=HjIZWUTQ4H1dHSmZmPtC6J
        7Bmyye2tV/cC84hcXoMeSMU0Xm/VMiHYkhYEFY+ulo2mtUEupGrPP5gKLRudGaql
        FthHaCWiC4DTPbUrAz/+ZsXRgUywz6kg6Oo81Yw7vUSJrX7+Ka+55Ses0wpUYl5d
        QmJxV9AfdBTtSu1MZ9bIGmzd7vhGIZZGM0mxMbVPoW2yT/FhNjzEx4ektDZwxKOR
        SKzmgb7Uvl8DtBNBy5f6afOKOVMPddj7Z686V284Y+PquRaGaO3xyDc37y6wbyJj
        R5Qt/UPr5qDO0y+OZ6x7j2xjLbP0oStFzE175ZTvIPU16jUcc7c0wRSoUTQQvYlQ
        ==
X-ME-Sender: <xms:E_8HYFk3rBTVap5TR89voWytIg-zep14ZoeGrNPlCA-CT3-SqpGgaw>
    <xme:E_8HYA2jDwPfzNT3tv0OjZmXV4xeBL6-U_WUAIJ-d-PP3YO7n0lqLd7LJSuQBDsBy
    OBhMNFEa8QvzQ5MpqY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:E_8HYLpygufVehP4KQTi-ruk_T5BvjPDYctx471VNqgsAX_VoIwFzQ>
    <xmx:E_8HYFlh-RlAp9YspVqJu7WASwEzm1j6_DnNco1VMDZZvJa3qXznaw>
    <xmx:E_8HYD0t9ETO-LMxlzOp0W6J6GNJmGflhqydfVf2doZR9TD5Sehb8Q>
    <xmx:FP8HYMJ9-8BmIzjGlZCXGEpVUgcYD5nQAeVNY8bRndIfo2Iuetw_og>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 98279108005F;
        Wed, 20 Jan 2021 04:59:47 -0500 (EST)
Date:   Wed, 20 Jan 2021 10:59:46 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3] clk: sunxi-ng: h6: Fix clock divider range on some
 clocks
Message-ID: <20210120095946.nljah6r3e4qhxdup@gilmour>
References: <20210118000912.28116-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w3peknzrtioxirsb"
Content-Disposition: inline
In-Reply-To: <20210118000912.28116-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w3peknzrtioxirsb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 18, 2021 at 12:09:12AM +0000, Andre Przywara wrote:
> While comparing clocks between the H6 and H616, some of the M factor
> ranges were found to be wrong: the manual says they are only covering
> two bits [1:0], but our code had "5" in the number-of-bits field.
>=20
> By writing 0xff into that register in U-Boot and via FEL, it could be
> confirmed that bits [4:2] are indeed masked off, so the manual is right.
>=20
> Change to number of bits in the affected clock's description.
>=20
> Fixes: 524353ea480b ("clk: sunxi-ng: add support for the Allwinner H6 CCU=
")
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks
Maxime

--w3peknzrtioxirsb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYAf/EgAKCRDj7w1vZxhR
xXVZAQC7nSoPxbIFRmwjS4V4gw80kynjKfhejrOltrK4u+3NBAD8DprfSNKwiWpZ
UpnA7KjNyLZlKyBcuzrKBYgzwS0pbQg=
=WYor
-----END PGP SIGNATURE-----

--w3peknzrtioxirsb--
