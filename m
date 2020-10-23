Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF48297061
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 15:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464748AbgJWN0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 09:26:16 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60463 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S373868AbgJWN0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 09:26:15 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7705D5C00BA;
        Fri, 23 Oct 2020 09:26:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 23 Oct 2020 09:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=r8ZA3WnrO8RxN3A1cXHOtcgEXpl
        21Bv6y2GjCKhEua4=; b=o0VqI9StDw89GGVUTyJ1d2ygzQZmyU5lbQpSt+wMdDb
        XFzWVYEqUEVIpkdasXTM4x9PlMtb++KYvbrVDBD5HJ4JItymaVIp4riD/PcwbkOg
        NGIYt4eiy7yyil3bvTDLlLD3L/dxoxjA1UoHTA6k4SXEXupD2XfQ2I/Kj4rnb+Em
        /6ZlkqiOKIysBej6ygBAxNITiMl6hZnQNsBltFvhXTgdkkR71gKpSE6nOEn0v2zg
        ckIUIy+SsW08h0FaK9XCuJfeIvNbbCdRCCdLmCzk9tUaad3pEKjTdT2YsRTZ8aqC
        QA94+aQ6F4QnnPdk+mC5gkeXTS5+BUQvG+3OiwOavKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=r8ZA3W
        nrO8RxN3A1cXHOtcgEXpl21Bv6y2GjCKhEua4=; b=h65TxWDY4IX2zhv4X8+Zsy
        2YEtLqBvUz1RHdPHGSTcGxSgqUQqNQQvhgKgj7vFmT80dzyOgn0sKOJtRpbSdVUC
        c8jo9vXB6lZTqEWUh/dgCU9EHkr1cvff6MpyO1lMJDJyWmZZ7eQ23ZGfliQZNuzq
        P5uwtyxZtWDJIq/A/1hNHi33wJwBWkRXDcH2ILMWeBlZmaIi2pN++Q/oQn96OngF
        2BcQOlOvqzOu1QrLHldB52wh58AvztyJY0TbOSSqaGMuKoUFLmX0krklYQz4U8tV
        rVzV1paeZ6I86QHWB2YcydhNXcVJxp0eczedHEFqmR8w9GhxWwTExWKCZ6hL1bDA
        ==
X-ME-Sender: <xms:9dmSX5AuBFqVtJxWQiQW3e4BtWkV3YSJXjf5p7eKt9iC2JBtJpACYg>
    <xme:9dmSX3hPUyrZjkJXZnyBtbQfeAYceamlbnm6BzckYXZ3jKJPSBvCLY8lEP6Yb33rl
    d53InDPIYJujZUv_c0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkedtgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:9dmSX0n-3ihfFI_1h5LbNFcbkGX09lAx_z31jE96foFUDx2Vgp1mag>
    <xmx:9dmSXzxHl72kWGmWrjQZUNl18eDGOo7ypEziERzgWb6K00uq67fJ0Q>
    <xmx:9dmSX-QA_ZI_l39G_nwAy7_8mC6Hw-p8T9Auy5tAU0HIfrSLgYqPaQ>
    <xmx:9tmSX0NrRHGdffvSwvWugUmhaTyfNMkNeFCuQqiVzxFzVWfd-IocyA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 68F333280067;
        Fri, 23 Oct 2020 09:26:13 -0400 (EDT)
Date:   Fri, 23 Oct 2020 15:26:12 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Pine64 Plus: Fix ethernet
 node
Message-ID: <20201023132612.77qidiwlyk7n5iux@gilmour.lan>
References: <20201022211301.3548422-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ew3t7kbo7kn6mu4r"
Content-Disposition: inline
In-Reply-To: <20201022211301.3548422-1-jernej.skrabec@siol.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ew3t7kbo7kn6mu4r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2020 at 11:13:01PM +0200, Jernej Skrabec wrote:
> According to board schematic, PHY provides both, RX and TX delays.
> However, according to "fix" Realtek provided for this board, only TX
> delay should be provided by PHY.
> Tests show that both variants work but TX only PHY delay works
> slightly better.
>=20
> Update ethernet node to reflect the fact that PHY provides TX delay.
>=20
> Fixes: 94f442886711 ("arm64: dts: allwinner: A64: Restore EMAC changes")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Queued as a fix for 5.10, thanks!
Maxime

--ew3t7kbo7kn6mu4r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5LZ9AAKCRDj7w1vZxhR
xV7ZAQD3wUwbIE4Knt/WYaWAUfKgHxYBar5txj+NghLDNnnUCwEAnco/iiT84xxn
oLCxBPnFmwkaPjsXWlK1jxU4knW7IQo=
=3sK4
-----END PGP SIGNATURE-----

--ew3t7kbo7kn6mu4r--
