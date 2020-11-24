Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659202C26FC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387909AbgKXNVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:21:09 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34515 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726714AbgKXNVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:21:09 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 082EC5C0107;
        Tue, 24 Nov 2020 08:21:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 24 Nov 2020 08:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=lzRzm4KvEYKdIaEdFXpNQf1V5ga
        7opO7foqqpcsFI7w=; b=AShZo6MPDXx8yioK6yjaWOKFRZRnukoAtWuCTNB/dZH
        +AwlqIjTKn3Rp3XzCQojew98wZVxiJRYKvliLNd6zjZIRrNB7X7IwgbOsLtXnFw/
        TVH/aFM95IN9ZRbt8lZadwyJ4CkVZfb1V8nB9HpFY+aF3D0IJGrM9bYu8DpW+vWq
        JerirhYSsZpNlvM+1qSVLl8TX3ZDEuBhgDgUod/6E4iaeD/Zg0glGMCX6JdPlyWu
        ZAUVo65xuZw2agWVXaomI5pdUjVp0g6Ff8JKNjtRtHSJ54ghyscwSxbA9R21tx06
        Sni6DemtRdhTeZ4E1+HnW+hnKI4xwps2webrW3AZhKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=lzRzm4
        KvEYKdIaEdFXpNQf1V5ga7opO7foqqpcsFI7w=; b=B+PtIFkrDlKCMcAyJR5V4T
        yGT6kdkWYNgkm0QciCYTZCJ0rD1vDzwyJd1qwUrJaN9tfJpghX+fK4add7TZ3NBT
        3Xlp9fQIjgk6BeV9FLf39S+lDH3W5ZzCcc5wHRbWJEs6tztZ5Exs/V3qf00lzIXQ
        zppyf6YcbebfDfPischlnQM/xyBJ68m/Cdh4jJYFSdqCQjNbLH15zCN9t2oAIBWS
        NTCupBAgS+z9dJkuZE8wtUglT9WGhUU4g+0ZS5UJb8gIy9dlCik4TuL919+vl1w5
        MI1O1dRrpp2Y11IjYrrdY4GiPYb+wet9CuKao5PjRJk4C099vn9lhnWdC8AUztfA
        ==
X-ME-Sender: <xms:wwi9X-up49qjyT6uX9Z8W_skA_RCd7mPBETjaFB5yXV_IfbiIOAEjA>
    <xme:wwi9XzeXMnQENC1BR2Bvi8hgCDbXYnMeXOKg8GP-YUg9EZ5puL2mDSrLBIelyPNIS
    GNZ7JFakyxk4z4XCOs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegkedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:wwi9X5wkev2OsE8NG6x297VyNXpnLcIGfiT2gLfZB--EVJFjbGBgXA>
    <xmx:wwi9X5MqmfbXqtmQfbFAnuVtQqZYN0LQ7p4fAVAtbDdRZrnw60kZIQ>
    <xmx:wwi9X-_2PpHAT1xrAuSNmcUoPiUw6AcwuPVyuZ6qosHHahXaEPodJg>
    <xmx:wwi9XyYxQrzDNMHKGad3fQ9jVKo6O-H-xDrKNr1qz80nCzB1xbKgDw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id BFF473280059;
        Tue, 24 Nov 2020 08:21:06 -0500 (EST)
Date:   Tue, 24 Nov 2020 14:21:05 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Michael Klein <michael@fossekall.de>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add
 gpio-poweroff to DT
Message-ID: <20201124132105.oai6gejdvdsnbzyx@gilmour>
References: <20201123161041.2304766-1-michael@fossekall.de>
 <4bf42c9e-9f70-bc30-1a88-44a127cd989a@sholland.org>
 <CAGb2v65=SoATrLDKvXH-EjdVJT3E4e+yQ6Ad0Nn1BQsB9aJvog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tp5irkdtwqk5souk"
Content-Disposition: inline
In-Reply-To: <CAGb2v65=SoATrLDKvXH-EjdVJT3E4e+yQ6Ad0Nn1BQsB9aJvog@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tp5irkdtwqk5souk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2020 at 12:41:37PM +0800, Chen-Yu Tsai wrote:
> On Tue, Nov 24, 2020 at 12:14 PM Samuel Holland <samuel@sholland.org> wro=
te:
> >
> > On 11/23/20 10:10 AM, Michael Klein wrote:
> > > Add gpio-poweroff node to allow the board to power itself off after
> > > shutdown by disabling the SYSTEM and CPUX regulators (U5 resp. U6).
> > > The RST button can be used to restart the board.
> >
> > The PSCI client will override this driver once the PSCI implementation
> > is upgraded to v0.2 or newer functions. So having this around should
> > cause no compatibility issues (although it would print an error in dmesg
> > at that point). This seems like a reasonable thing to do for the other
> > H2+/H3 boards that use a similar regulator layout.
>=20
> I wonder if this (gpio-poweroff) works if those regulators are also in th=
e DT?

It's probably not going to probe at all, since both would claim the
exclusive usage of the GPIO?

I guess we should model this properly using the regulator framework, and
regulator_force_disable allows to bypass any usage count

Maxime

--tp5irkdtwqk5souk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX70IwQAKCRDj7w1vZxhR
xVDgAQDtHkWRvMCy6Xtrt2MCroKwIz7m6pjWGS4rUDmBo/khsgEA+ketyMtNKirF
of9BbDNLz0A1dy0Lit5yoivYKfNsTwk=
=OxTb
-----END PGP SIGNATURE-----

--tp5irkdtwqk5souk--
