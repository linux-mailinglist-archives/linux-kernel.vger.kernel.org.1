Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AF22FA512
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405154AbhARPqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:46:49 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:48961 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406002AbhARPeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:34:36 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 94DC15806D8;
        Mon, 18 Jan 2021 10:33:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 18 Jan 2021 10:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=FoqMHt7gYp1OuPWSg+McBubYh5f
        JwhBcVDnnZsbPWmo=; b=pWE9yrItSVWTtW7n9cU2pgG83mBy05I0liXPbKmF4cf
        iTsia/4iqcUom5StFTktqurKZB0ZLD0NURl3ehX9Sa1L5FOfODMqzBLDleG+qNgP
        JCG2HT0HPb4Ej9CD/b4+jCaaRC4tzXjcDcuNO8rfEkyHvuJgGtatJSj/3tMxoD/A
        NsU/uonZR+nyByr/Z4ZvknniezlvoeF8vNB/NyL0ycpvrne7gsrDCZnzgj8Qddqv
        YxYgHXWdmwHhcHHsldBb5CLBiomcTIGzGlvZNLoLj+S7PHU21MSMqpcKXB34kLXu
        j5tNjTMvS3eqsU58Zlg1ikIwj8wIBB8BKW5aqZG2Lkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=FoqMHt
        7gYp1OuPWSg+McBubYh5fJwhBcVDnnZsbPWmo=; b=FTN1WFO8otdhupklABgfSo
        cbjCDQ8BynXSXBrhtpxI6mpdYRQkL6UZ+aUMVm9dtkX/ljzO/cuY2Ic5sTzLTYnn
        qF5Xr6EQfOIdr/TCPuHQLkxNHa4QSXTh0/p7nV1ZWEVHK0ZfaokbsgbcxWsX30Lu
        FMEgzTsZgTgtV5fqmCxQ8yAmZHtyI6gaaYW3AOYxDsyvVGIVWVW0O6UqjbKpe32B
        rhn9akN5KhBNhuFMv6W2B/tM0OI0PVDhG6J/7Pjvwmrn82TPbQ85Xt47W2qFk64a
        uPA0vvqTrB2T15enZMyyMzNGEKfaAZvnkiB//I2v1dk3QaEqwF4rNQwIo41DVnmw
        ==
X-ME-Sender: <xms:WaoFYD1bhl5s2wreVHxmhzEjTYDdXG9ImyzfrXKlmpVeUcpdSd794g>
    <xme:WaoFYI33LHogkts8Hj82vEzi4-naP5qxP8ZBkC8ovnD02bk-Kne2bNaf5rMw2Q0_8
    cYFpHV2CPAssgI94Tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:WaoFYFr1PRoJX2m0zniKJ2iov0RjfPCNyLbPJuWtxPIMu5KDk3uqWg>
    <xmx:WaoFYEgo5pgdbna_pzF9SV-XVjmU_iYHGudLmdrtufhra1X83gwFJw>
    <xmx:WaoFYB-MHIJiOu0C7Zfz47AvMIbDTNigSz99BSto9FgM2-H6qOstew>
    <xmx:W6oFYNVjYbSsVn4W15Blfn5TRprWm5BT-rZftPkmLgZ1jJtqvAyIaA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id F170C240066;
        Mon, 18 Jan 2021 10:33:44 -0500 (EST)
Date:   Mon, 18 Jan 2021 16:33:43 +0100
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
        linux-sunxi@googlegroups.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 15/21] dt-bindings: usb: sunxi-musb: Add H616
 compatible string
Message-ID: <20210118153343.5z3jervyeyb5eykz@gilmour>
References: <20210118020848.11721-1-andre.przywara@arm.com>
 <20210118020848.11721-16-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4ykgfxhs5nsm2eo7"
Content-Disposition: inline
In-Reply-To: <20210118020848.11721-16-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4ykgfxhs5nsm2eo7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 18, 2021 at 02:08:42AM +0000, Andre Przywara wrote:
> The H616 MUSB peripheral is presumably compatible to the H3 one.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--4ykgfxhs5nsm2eo7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYAWqVwAKCRDj7w1vZxhR
xYjzAQDLk/EpbRCVz8VDYaLgPBBPS1yRXybtHbVMCb1qOUrsRQEAtE503egZAWiC
n+1wt1hg5a/g8gj+mBEfPSOpFyH4Kw4=
=BGtH
-----END PGP SIGNATURE-----

--4ykgfxhs5nsm2eo7--
