Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCA92C9FEB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 11:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbgLAKfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 05:35:51 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:53925 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbgLAKfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:35:51 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E015012D0;
        Tue,  1 Dec 2020 05:34:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 01 Dec 2020 05:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=5m18PRLWtaimO+q1UUFuUi8NXA9
        74ewXvxH7+nu0bR0=; b=LADaYtXqt+8nH1F/u9Htl+7vziGwJn6ivXcXDyzaqND
        4CM0X7+PCxYkLsoz7yWMjgGDiF7MMR05GPEziJdAA2pup3vaI9UtGREtEKI/dUBa
        VedNdI4bhVvdMvtivPSohNcvsnzDuzSMK2YAfE07gYoCQ3F0LNHSpZUQgYc6Ia9t
        v2RVsVfbO2AplSLaIs9GwWjNH+hWk8WxKC1HIaoCAuuyCIvMfiGrBNa0z4GArTM+
        cODcsUYVODuuPlxFlwEN4UyNkSa2vagjoQ4eaesU3jhFRg2h9Z3G4ik02I8MCdV2
        XqwyK+ln1y8I+ca3eb8xwAW2Nz0yVRiKfLvlC2BaYhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=5m18PR
        LWtaimO+q1UUFuUi8NXA974ewXvxH7+nu0bR0=; b=aLNyjTOauZRur2lV0TwbTG
        o5Rkk3Y4ExdSNyUQuuxRvZe9Cd5V4ULtHStGDyoNkP1GuuPipFyzC/S89517yyLp
        Gm4qyornD+o3ImQPftvVgsxEzCfAdgPBLRTJZPl32uoUEKEdl9qIB8gNrLD5NYoZ
        h7UVMPbEH5l/u77sLZ5IAgob1g/ByefLi5CC4bgeUnOzBqnHObswH9rH1Yv/GdQ3
        gZ4TTtRf2CFfB/GBXFIpkAasY4vl62OE7tcDs/IibYUggWlLsVUaMlgODn3xMHyI
        HzYETA/vqMvs6afwc4dmwyXfrEl1EAtI2Rl6QSzySLSjFw2A6Ij//57VGh+vpeQg
        ==
X-ME-Sender: <xms:QxzGX75BBfYm3Q10RpKjwQ5VEaFJYvMxCtT_SRt9mAy_wSNdnv9SIg>
    <xme:QxzGXw7OayDENTQGwiBYQBhQxAlLAMa9WHSUH1TBLJIhcaNBQf-g7CKY3fnxbjhzg
    SjfHOE-jEHMBZhIkAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeivddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepudelvdehjeehgfegueejhfethfdtudekudeuteevkeegvefhffeuteekhfdt
    ieetnecuffhomhgrihhnpegsrghnrghnrgdqphhirdhorhhgnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:QxzGXyeoT7npG9nYUkI3okVzFEXrUFdhCvxCkMirc0AMpuawR5MJJw>
    <xmx:QxzGX8IO1ZI1FXKUiTwWRiuabli_0hxEtiKbRF9vB_LjqH-bN4IE0A>
    <xmx:QxzGX_JYFQNRbaeETByMXuii4mDEQvH__tivGYzOic5ce1YqE8gPVA>
    <xmx:RBzGX8FOaVn475IUuJb21QaUuGecDdzuMTKi0qyNez-VVOKx2_Huig>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id AC94E108005A;
        Tue,  1 Dec 2020 05:34:43 -0500 (EST)
Date:   Tue, 1 Dec 2020 11:34:42 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Michael Klein <michael@fossekall.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add regulator
 nodes vcc-dram and vcc1v2
Message-ID: <20201201103442.mrkvdpxbd3w5fqjx@gilmour>
References: <20201130183841.136708-1-michael@fossekall.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ymu5urn7ll62ykxn"
Content-Disposition: inline
In-Reply-To: <20201130183841.136708-1-michael@fossekall.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ymu5urn7ll62ykxn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 30, 2020 at 07:38:43PM +0100, Michael Klein wrote:
> Add regulator nodes vcc-dram and vcc1v2 to the devicetree. These
> regulators correspond to U4 and U5 in the schematics:
>=20
> http://forum.banana-pi.org/t/bpi-m2-zero-schematic-diagram-public/4111
>=20
> Signed-off-by: Michael Klein <michael@fossekall.de>

Queued for 5.12, thanks!
Maxime

--ymu5urn7ll62ykxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX8YcQgAKCRDj7w1vZxhR
xYNsAP45CogsisGt6V0owzTri7tN1Y/P5xEk4lJHFABW8MuDKAD8CXdYneNqLIPW
EvbCIs+eQ/dDGnI8ZH5Q6HAqBmTTkQs=
=Rmdt
-----END PGP SIGNATURE-----

--ymu5urn7ll62ykxn--
