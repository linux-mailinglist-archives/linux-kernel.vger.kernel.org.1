Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC48E2CC170
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 16:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgLBP5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 10:57:42 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:37101 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725979AbgLBP5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 10:57:42 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1C4B458033F;
        Wed,  2 Dec 2020 10:56:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 02 Dec 2020 10:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=voFpRetlbBwCZg41ULNXnGM0fG4
        XnIsMUrQNMwOslPo=; b=NwWbuoPEJcB2DbUf4340sNGSVyhJY4TMAa88T6asSGn
        QShwv6H4WeXjv+7G9yrla94szKX9qiSvroFxa3iS4wPDuUNY4yBbEbfuZT1ztA7v
        H7hL2SiLBjHU92Cxdx0QKDV6xcnJ3ZbDXHoDjLT28zIYS4lW1T/4hp/UXKwrWqTv
        BYgw+kpr597ttygKX9Ab7DQzg9Xwg0NcX29s7Yek2rWZCUtzTHfhjdCZfxNAKPlq
        LM3i782MKNHS7lO1i/iHbUNMVwY9R7pmiqdKxIHzNH1k9H/QM0PQJrn0WQJAxEhp
        bM6qMUOw9hqYmRwRiSouX1WrBCPDDJXOaHBoKki9oSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=voFpRe
        tlbBwCZg41ULNXnGM0fG4XnIsMUrQNMwOslPo=; b=BD5Y/qG9bYresDqqUmyxRY
        JOd3xGakUnrn1r8jCeeJ/MSc9aRW3K+fU4X/I/ed+wc26RK/5n+5fVzEt9zGZO0b
        U/qkpzIbvFrFV7/gE/U7Zz+J7ka4LtPi/bjcFGAo8hYg003Sx7xwaJDLkc8vCslc
        l6IjYBSbl8e1X+G+NTlNZcGWtjNYDZUv1HqXv5+iJhFzeaZcOqaCvohsBhv1wGqa
        WT8BGq5DuW5d2s/I2FBDvVGvDrUR9r9HGp9SQMbqxwliT5AyVwPCu2EpnMKziAzJ
        UPKcWWcQi+sTCNoY03i+sZgONZOLpHD2Bm8/fo9nuklJ7AISBnYrYYJiW0fmX7vQ
        ==
X-ME-Sender: <xms:RbnHX7MBOlBqApGWTn15ZBbeOk-EHGhKdy2iL1PZeIIQuxG0SHYvgg>
    <xme:RbnHX80Gn3sbeUKV6MGG-DCTAoX68PWz22YEx5EhnK25_gremkLCXaZI0squAMBYa
    4RrQw6N8SBTtz9Lc_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeigedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:RbnHX3OUX5hoOfx1J1l_TpqD6NUjm7C4kAjJtR3cqp6cuss-xPDmbg>
    <xmx:RbnHX82Q6MFweVL6rVSP_ENHsIIYbghGGUHucvmvvJrBHucCwkrHIg>
    <xmx:RbnHX-GVSCgen8noxQom0G-4cOma9ob5bDhCSk5PQeiT3GIWUfIVlg>
    <xmx:SLnHX32knjC-lSJPrAJzHUkErUOP-KkqHQyat_TsfA0MR7QwGRxn2g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1C40B240059;
        Wed,  2 Dec 2020 10:56:53 -0500 (EST)
Date:   Wed, 2 Dec 2020 16:56:51 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yangtao Li <frank@allwinnertech.com>,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 5/8] clk: sunxi-ng: Add support for the Allwinner H616 CCU
Message-ID: <20201202155651.vgbkrrrxlw55yq7x@gilmour>
References: <20201202135409.13683-1-andre.przywara@arm.com>
 <20201202135409.13683-6-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ynofnaw5enhpd4at"
Content-Disposition: inline
In-Reply-To: <20201202135409.13683-6-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ynofnaw5enhpd4at
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Dec 02, 2020 at 01:54:06PM +0000, Andre Przywara wrote:
> While the clocks are fairly similar to the H6, many differ in tiny
> details, so a separate clock driver seems indicated.
>=20
> Derived from the H6 clock driver, and adjusted according to the manual.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

The patch itself looks ok, but there's a bunch of checkpatch warning
you'll want to fix.

Maxime

--ynofnaw5enhpd4at
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX8e5QwAKCRDj7w1vZxhR
xaeDAP0VXbK3/zS+gC9m2/thTZDBih7mPelLmESXwK8URJQS7QEAl3yzyzqpWNGk
hkZe4Ua2yIFWQsZNw996qUTnSVnFmg8=
=02s5
-----END PGP SIGNATURE-----

--ynofnaw5enhpd4at--
