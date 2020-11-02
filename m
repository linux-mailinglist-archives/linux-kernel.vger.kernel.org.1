Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21EF2A27C4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgKBKJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:09:55 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:46653 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728156AbgKBKJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:09:55 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E2AAD5EC;
        Mon,  2 Nov 2020 05:09:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 02 Nov 2020 05:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=D+Hx/PWdAsyxJNjfriAYbL4M0+L
        ryAHrgIAbEkOsp4w=; b=SyrDBetL6FVnOkQHEWtJIvMiaP+kQxX/P3CdMvLnLy0
        ck4SdLBrifaGg1FcbcSHbr+S1PiIzocvWwPOxao5LY+Wb6uXMc08c8/J08h0zA+y
        s97ZrowNt5dgyaJuUYiWxzr/XIHi8q+y8XO+E5/T2k6fgl/j9pbq6e39rOC8+6il
        QBRF7jA8e7k0UJsGbDLpvfpb/N8tUuvQYQzpZR3u9N/4cvKSwEhI0B2UYS0W4wpW
        xcBJr6V/6PGXz6Ie163sNy58Rxm13M03ZZzxzO5X/YgaVhF17wPYWuJjQElBpg0P
        OEf3mYwMF4ifCbvnn/MLuJL+oCOsqaGC92lsmHQp8IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=D+Hx/P
        WdAsyxJNjfriAYbL4M0+LryAHrgIAbEkOsp4w=; b=Ji08R2vdb2RxNtJ8oaHHqS
        gzg5kAZ3JTiyvql9D5jSfbUFlBFKCZVrF2C4GHZKDdZQFYIY0FGWI8K7A/xhq1z7
        jIH6R5gsVtgpxeCzOSo/osb/E/8lbfm61vxqjbPEwS9oAP1NpIbYZtC13EL7TIu1
        uqapGbmy3DANuPoKtiLR7S0IgkOMyPaevPAH0CN3Ryv5ZCntC9vRkeflcvXWfxyt
        Zmp2fEAI0VuPepthnp6qWLHLx7+t3H4EBnNjWIkwLAV2nvLpbbfi1O8QrWwYDdb1
        /aQg/0U0K5K2Ml1vq5pR1eXiFwlN5w4wGfkyXOV7Tz7iSmiWHi3RwydHexNAbRCA
        ==
X-ME-Sender: <xms:8dqfX6DFLV7vlRY7Kx0Ua3IUrs80zbKF_67uT8uGrOPNxEgP6tazgA>
    <xme:8dqfX0gBgXBT-beYPtwkgO8ZOIkgD-Lxw_d1n3p-hnH36-eoQRup0qkx2N-o21cPM
    KLGbLdAbpslvnESPb0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtuddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepheenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:8dqfX9mT1GO3GT1ucf5BagVKBqTHyKLgfXLm-bUbP_vYtyT0_7jq7w>
    <xmx:8dqfX4xVRz2lkuwxmY0YOQu_tjn94fk7JW-ZkG8XZHheC7NLsKBcKQ>
    <xmx:8dqfX_T4jq9uzvRF6M4m6QMKijlA3YLW9TgDaho84agQLka0hIvJew>
    <xmx:8dqfXwKRYAAbEdJBpRdZhoFDjo-klJ7Kn4Rx4egRDJj66PVzhv3Lsg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 109DB306467D;
        Mon,  2 Nov 2020 05:09:52 -0500 (EST)
Date:   Mon, 2 Nov 2020 11:09:52 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matteo Scordino <matteo.scordino@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 5/9] irqchip/sunxi-nmi: Add support for the V3s NMI
Message-ID: <20201102100952.a6ma334f4msnlvts@gilmour.lan>
References: <20201031182137.1879521-1-contact@paulk.fr>
 <20201031182137.1879521-6-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="injg4cfqgqushr2n"
Content-Disposition: inline
In-Reply-To: <20201031182137.1879521-6-contact@paulk.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--injg4cfqgqushr2n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2020 at 07:21:33PM +0100, Paul Kocialkowski wrote:
> The V3s/V3 has a NMI IRQ controller, which is mainly used for the AXP209
> interrupt. In great wisdom, Allwinner decided to invert the enable and
> pending register offsets, compared to the A20.
>=20
> As a result, a specific compatible and register description is required
> for the V3s. This was tested with an AXP209 on a V3 board.
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--injg4cfqgqushr2n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5/a7wAKCRDj7w1vZxhR
xSuYAQDunY+uNN2KKTu2GcOWUfvTmxWheh/U4qs6xQKOIeK3ZwD8CQDSb26iuwxz
BFSHfsZQPMtI46RgP/EvwYER0P1sWgE=
=fcKf
-----END PGP SIGNATURE-----

--injg4cfqgqushr2n--
