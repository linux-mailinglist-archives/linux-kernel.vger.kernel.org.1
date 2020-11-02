Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C0E2A30EA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgKBRHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:07:42 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:53069 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727150AbgKBRHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:07:40 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id B27821396;
        Mon,  2 Nov 2020 12:07:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 02 Nov 2020 12:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=belBut/IjfCe+Zspk1KQvjfVDOP
        23hqCux2qUZseddw=; b=RtNWP2DOsbZNFKCEDv5hKkyeVJR1S8+adTeHkOKbEQ2
        HnjmV310C381XjX3atRIvfIv373pUQpFZRSRDASRthGosQjpHJmnzwT7rJiL22bT
        mWSaNdpyeGSAmNsPwu9sqeKoj+6G40NHukjNvDlY8p0QUYX1tK6zXjVZ0E6dKhyy
        eXIO/mdiRj41XFHy+6hTgj2zctVRxAHXVyhceaV7mcAhKS9yN3kYwx2il2wFgF4M
        B5298YM9f1H3VmUP3N8WdK1AlV0EtJTUbTJjC0KoQhHKySBLpHrxhxkt9tTLwBod
        cP63XXJG5ocVXXo/jDFbp2hsPPPb3uKaUfo/UV8dVrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=belBut
        /IjfCe+Zspk1KQvjfVDOP23hqCux2qUZseddw=; b=ZNtfMkxQMk0GjxHCiNyRHS
        PrPX0EH8HHkivT4lpwpW6ZeNYCaPlJisySDVNuZxfWKxlSc7ZIBWxAvTFNdhu7KN
        GA75OezgYZ8lIzbmL96Y8pAkyJjsL5M1xU7ej01V1pXOzxCCqXpfZwwlWz1kob9x
        dPUswv7aV1qrgN8BLsqLfl0pnxWjHDTntjOuDpJ9iyKIx7Pw266CZqhLjQplADBO
        oEEAPWrgNkHC7xmGDWUsnqw2UxynROrPdOEHTxjCNtjiDbsTMn8CmVypfBqE6xOe
        lIaQBNTJ+iZy+NtG+3jx7OxybdA1d7gUUzpqxlAi89iHB9j6bFTLppf9Z0gjZCJg
        ==
X-ME-Sender: <xms:2zygX6kd3-S0NEyX8YytC3oyoWdIgyw_GDfREHF2MQB1t2924UCCjg>
    <xme:2zygXx2TZxVvpk0RkRwyEWlXzSbyA8DVO6rR_Fe08GanAcrww254vAFFpIxaryqFd
    2CUbQCXzE1GVe-RGlU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtuddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:2zygX4oJYud9edCtFCCONm8jO7_zTAEHy3ddqTIdaXlNVC7kAj9x0A>
    <xmx:2zygX-l3a1VeW2hrF_opSU365vRmeFPLKX59zjGY0tIFPwUbxbuKbw>
    <xmx:2zygX40ojcEIRqLnqCalwA2X3xKihdBeADKBjXCrXPn5MNVLvADWlA>
    <xmx:2zygX8-0jtcS165KQLO1v84Uz0bZqJy7PaHS9fh8N4I5swZhImzdow>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C522C3064683;
        Mon,  2 Nov 2020 12:07:38 -0500 (EST)
Date:   Mon, 2 Nov 2020 18:07:37 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Pablo Greco <pgreco@centosproject.org>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun8i: v40: bananapi-m2-berry: Fix ethernet
 node
Message-ID: <20201102170737.fqcx2hzuazojr72b@gilmour.lan>
References: <1604326769-39802-1-git-send-email-pgreco@centosproject.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2jn44me55dk3k4hb"
Content-Disposition: inline
In-Reply-To: <1604326769-39802-1-git-send-email-pgreco@centosproject.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2jn44me55dk3k4hb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2020 at 11:19:29AM -0300, Pablo Greco wrote:
> Ethernet PHY on BananaPi M2 Berry provides RX and TX delays. Fix ethernet
> node to reflect that fact.
>=20
> Fixes: 27e81e1970a8 ("ARM: dts: sun8i: v40: bananapi-m2-berry: Enable GMA=
C ethernet controller")
> Signed-off-by: Pablo Greco <pgreco@centosproject.org>

Applied, thanks!
Maxime

--2jn44me55dk3k4hb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX6A82QAKCRDj7w1vZxhR
xTwBAP9U5uL7CZ5nEes/4V0v23JTWzPGlxjTouVfaJVy66wg2QD7BxPHEAvTsQu7
SWNvurd/mplFB/GePVh1pU3jhK+sOgw=
=97Sv
-----END PGP SIGNATURE-----

--2jn44me55dk3k4hb--
