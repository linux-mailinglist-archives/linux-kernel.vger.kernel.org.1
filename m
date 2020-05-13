Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863171D1768
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 16:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388955AbgEMOUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 10:20:24 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57907 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733142AbgEMOUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 10:20:23 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B6E745C0174;
        Wed, 13 May 2020 10:20:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 13 May 2020 10:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=H2UDzjWDd1EUmh5SZFNQe1gnXPY
        X3nwsxruPH2QTo3c=; b=SnO1oljPpLbHSyV9DkYCy9r0YGj/t5QQwJ4IgpURgMk
        lZQLZMyKF4Aht1H9vFWSirikNdxeXzkFCf9UcibnMgIWq5JYkempf1hlzvWG3w00
        mBlseSTaJHU9HWXtf1ADv/gx184JEcgyEAh1pl36riwpMFSRoqxL0wlCsjOb6TgJ
        xRwMqzvRU5cyS6eyoLXzddILbCPcoDozCdxjXVgk4bWB2+OGzfjiktCC29panzse
        fZpLNCPGYEjW1qGnsh0sxPqnvq9axDZA8ulUAHNisrmxvQAc6xzXnuM5janZUhcd
        JeX/oP4oiCDt7rXPxW9Hvf3ZyLD0kBy1pfOdcZQ6EzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=H2UDzj
        WDd1EUmh5SZFNQe1gnXPYX3nwsxruPH2QTo3c=; b=N2A59Zz608j7xl2RnVkBiO
        CKVuAn05JUk2PcWZfZ/VhewTSY45PvAZWC7ia/d4a1pk4GFAvY9LekflPIcW9n6d
        k7SVDAAEB2LGBU7TRZDxFoNMS3O7IuOV+aGGF7pVLWIsdQK/qKfZQhg4ikXyyeSr
        vmO9NXD0F6IB6bo9UKIQr1oQTGDTm6oAwJTVlgLTgv5rSdCgb3mOhFSrxLX2yv6T
        4qZFBXspktLXzxbGaxejs1H7bCgym0oCnNZMaUMtTFYuJll2M8QDox0sjb7Mjel2
        aF+ZpzkZTjtKCYtXilyFfQ138TKMn3hkOlzTOYQOQjnPj3BXyE2ROjMBLB8n0FXA
        ==
X-ME-Sender: <xms:JgK8XpVI00HGGWimKzxYkWYwFypqdBqtfZUtV7JtJhDgJAKEOy5mhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrleeggdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeeutdfgjeeuudehvefgvedvtedtudelfffgffekledtffekgedukeejueevieeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:JgK8XpnhfUGhYWyxvX11ZVSQchZ0gT-WfEwFYuUTraICfXdtFu7Xtg>
    <xmx:JgK8XlbctJlGHrpPGObtTlPofa4T-q5zlOvMvMhcBUOexH8JdKK0KA>
    <xmx:JgK8XsWAIugkpQD8QTRHyopU52EW-_N-oj1zr45CopwIE_8sb-_QGg>
    <xmx:JgK8XsB7djlcDt8z5NVhe0pEJzCUTPKCAu3ff51T6gisAoBQVHkK5g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D4C263066309;
        Wed, 13 May 2020 10:20:21 -0400 (EDT)
Date:   Wed, 13 May 2020 16:20:20 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: h6: Enable CPU opp tables for
 Tanix TX6
Message-ID: <20200513142020.uossnjz7g5sx32mf@gilmour.lan>
References: <20200508191035.24276-1-peron.clem@gmail.com>
 <20200508191035.24276-2-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7k3wey5tatwrtser"
Content-Disposition: inline
In-Reply-To: <20200508191035.24276-2-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7k3wey5tatwrtser
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 08, 2020 at 09:10:35PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> Enable CPU opp tables for Tanix TX6.
>=20
> Also add the fixed regulator that provided vdd-cpu-gpu required for
> CPU opp tables.
>=20
> This voltage has been found using a voltmeter and could be wrong.
>=20
> Tested-by: Jernej =C5=A0krabec <jernej.skrabec@gmail.com>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>

Applied both, thanks!
Maxime

--7k3wey5tatwrtser
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXrwCJAAKCRDj7w1vZxhR
xWsqAQCplDxqnHn7w9heLEuzvIWCfXkOpwY8JhUokblIIOzr/AEA1A549C/WG799
7csQ30uDQta1DukX8D6UgqdlG7QZjQE=
=0piT
-----END PGP SIGNATURE-----

--7k3wey5tatwrtser--
