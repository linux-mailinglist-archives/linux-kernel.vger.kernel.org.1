Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FC92C7262
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387609AbgK1VuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:50:18 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:43239 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733136AbgK1SLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:11:47 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id DB920C0C;
        Sat, 28 Nov 2020 05:38:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 28 Nov 2020 05:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=a6k8h7G8DbGWnMKaT2VTyNF8NDZ
        ouXZ50EDpqHXOUU0=; b=nubncwe+PToM4qt1WkE4kZ3UpKtInXR5GXjcTcl1JiZ
        YsBLwGE7NBlXsBStGoOCmV8ICqLoplLj7GJXU9zU0xNGve/S3ci379avO3qB8SeO
        N7zk4ZMDfMjksFtzbehisI/gntkZCoTawoRfwD4cT4k7n0rB8ZGmONEh8z9oxvpe
        3EUelJ8MKeuGzFH2rdx9uwzAjrgK2sJ7yLYTZR8Dp8tDNqZJQhbqIfEWgIKiZ9VA
        ZEAGK5hgt/s8intBN5gdpR8Fm7F1GYXRCuqjgNAB92r5iMYq2OOl8sEj/AJIiLKr
        VeFC3JGSrWgw3ukZNs5PsvE2zCT02XPcREsPVcWpdXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=a6k8h7
        G8DbGWnMKaT2VTyNF8NDZouXZ50EDpqHXOUU0=; b=IQ6G7L4lPz+emL/XcxljQs
        eK3gnZfkJJR5/CVEbNqTW9zsQsLogokMmoFUMbYBYKaL/8WAP12krwQ1c0sJeaaU
        UzJrqiHbKKR/hItG9QX4LrDpYdcryZhobt6n8uEBFaRMhorDHCCFOFREmTAFpnmF
        83aTiKTVp7zxchkZWEFvblB05ilvO7sndhN9/ZD0J2n16WB/AJut4R0OcXhDq18y
        K/RsWIH/mZ1SEQPS5zUKfjRxFSjGX7NUV27haVLAutve5WdliQah9HqwMq8i2YS6
        EliDJvkFKz0zK1YNqH2uLI9W2N2Cpd5hr2UGilm9k4C7RyRY3cE6WrsY678uThiw
        ==
X-ME-Sender: <xms:pSjCX2tdjXH_yoTpI1epKSrg3_fb0k64fY-M8gTB9UcOd4dHemDbOg>
    <xme:pSjCX7cEuYtQeyd8yEJ3Q7CULobcl503vujolh25-chLY4PBaWUUxaQ2E-3tV-DfT
    UgxRU75FgU71OXsGdo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudehiedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:pSjCXxzEF7rYHG4DZC1BaQbE2agDg5_uOWnNOkmEf1rA3HOBUlCCHQ>
    <xmx:pSjCXxMUA-2OrW-z5dpWI7Kh3VZpjOj7ip_y-Ab1G2w84xD8MorM0g>
    <xmx:pSjCX29iIOZKt-WpQIn3bM0Cw1gYjxf4fti0hrBCrOurqzpfIrKGlA>
    <xmx:pijCX2zziA8mDQIWUBeVcWq1dFGnomMoBJybzo86C0nAq4_MJxcCyw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7728E3064AB2;
        Sat, 28 Nov 2020 05:38:29 -0500 (EST)
Date:   Sat, 28 Nov 2020 11:38:27 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [linux-sunxi] Re: [PATCH 3/3] arm64: allwinner: dts: a64: add DT
 for PineTab developer sample
Message-ID: <20201128103827.d6sfc2eumli2betx@gilmour>
References: <6175E674-E8BC-4199-8BE8-A983065C32D5@aosc.io>
 <20201116155508.364dg6ycklwylswe@gilmour.lan>
 <8FFC1A6C-9CA4-4F94-91C4-F111A7519979@aosc.io>
 <20201120155939.3ajmbny2pka2vsnf@gilmour>
 <A8E91BA0-22FD-47F4-A5B2-A80A38FE9A0E@aosc.io>
 <38ee5feb-e35d-801f-99a1-65e23618e73b@sholland.org>
 <20201123111512.y7lbwsipbkcpuleb@gilmour>
 <97E2037C-3C3C-4B0B-8462-39B9E38CB3BB@aosc.io>
 <20201123125332.2p5z3ew7svszvyfs@gilmour>
 <009A22D9-AF20-45C4-9674-13334B3EFFBA@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rmpcrvovirbkiyir"
Content-Disposition: inline
In-Reply-To: <009A22D9-AF20-45C4-9674-13334B3EFFBA@aosc.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rmpcrvovirbkiyir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2020 at 09:10:38PM +0800, Icenowy Zheng wrote:
> >> >> > Okay. But I'm not satisfied with a non-public sample occupies
> >> >> > the pinetab name. Is rename it to pinetab-dev and add a
> >> >> > pinetab-retail okay?
> >> >>
> >> >> To me, naming the production version anything but "pinetab" isn't
> >> >> satisfying either.
> >> >
> >> >I understand where you're coming from, but the point I was making my
> >> >previous mail is precisely that it's not really possible.
> >> >
> >> >You want to name the early adopter version _the_ production
> >> >version. Let's assume the hardware changes again between the early
> >> >adopter and mass-production version. Which one will be _the_
> >> >production version? The early-adopter or the mass-produced one?
> >> >
> >> >There's really no good answer here, and both would suck in their
> >> >own way. The only way to deal with this is to simply avoid
> >> >defining one version as the one true board, and just loading the
> >> >proper DT in u-boot based on whatever clue we have of the hardware
> >> >revision.
> >
> > > Then will it be okay to rename current pinetab DT to
> > > pinetab-sample and then introduce new DTs all with suffixes?
> >
> > No. From my previous mail:
>=20
> It can be seen as dropping the PineTab DT and introduce new DTs with
> suffix.
>=20
> Do we have rule that we cannot drop boards?

Are you really arguing that removing a DT and then adding an identical
one under a different name is not renaming it?

--rmpcrvovirbkiyir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX8IoowAKCRDj7w1vZxhR
xUVQAP9w4zKVWYrg14myVhyPLb+tvoKG3yXY0Mm7bfZ1HUpu4gD/Xku3FSK3YUYw
azv2bYxaZ+A0ewygD1XDiQwVsLHGsw0=
=em7W
-----END PGP SIGNATURE-----

--rmpcrvovirbkiyir--
