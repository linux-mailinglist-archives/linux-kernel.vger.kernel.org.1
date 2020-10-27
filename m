Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB5D29C3D9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1822595AbgJ0Ruj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:50:39 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:59047 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1822577AbgJ0Rue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:50:34 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id BBAA758042B;
        Tue, 27 Oct 2020 13:50:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 27 Oct 2020 13:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=kPMv8+Zh/KORhD0njYgb8hgRSSw
        25d4PaOM70L8xwDI=; b=pZavBYKnU6QF++QvfUtkZbvkk3P6HwQ7RgBfrXlRTj2
        ihaY2pqIXFyVR/3c0j3m0XxqGhdTshoXx03rZsY6vEmi7SADFoEluUvHevMcGV/R
        /NyzuD4ulB2zeAE3dU3oMZ+QwgLEZRQuMpGg9vl07CgxfhYYeBAi2UVlSi6mH4A9
        srxmcWGGMwneP0lanBI7CdrXos7a33YvU4BSf31P18VAjgZg29pIqzpHzb2HPIG6
        9s4VEXylVtWrjdVJJ2yL0yFuF9yZvxUJTeES7v/ApeqrOpqcwhNC3Peo5FKMip/j
        6W9jG1oolzdTSVq1KYvLvoF9HtEcpdIpg8TetBPzYog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=kPMv8+
        Zh/KORhD0njYgb8hgRSSw25d4PaOM70L8xwDI=; b=UfPHz7w8O+SL/X1bbZLia3
        sfk6aQQoDswyqW2Jctbo/nCS5EnpBVCfqDuhZdJ2p/TIkpxgBNa/OO2or4PI2xHI
        EQbISu/jUrr90WO7333EdYrHiqElYLZ7SWtSLThx3zJUm3p1wvrd0USN23saETRo
        4CHq5MPHYu1KFumHHw6//p5iq++sJzsYuFdVDRwO+SJLNjrVmMfn5UC9pVwV0Z9Z
        4X7JNSJD8iKlOWirQe9Iz8c1ffEJLBqwE48USHTcFm9QtWlcGgsRQNsg8taso1Mm
        TDnNXO6AhKmNxVtBQGlyNaftBlsQQXHBDNSQG91bV1MDSVVD+veCiA43KxmG9epw
        ==
X-ME-Sender: <xms:6V2YX6nF12HN4Yc-Hjs3uBMLwi7-0s9pT7WsiOJTzx385S_OTEBz3A>
    <xme:6V2YXx0bN5LpU0PvzGy5C27VurdkX_07JJtqURwYrV5YlYgSkFdxIQ53DEVlv7CBt
    KBQ0wAvTPWFv1kdaro>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkeelgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuddvudfhkeekhefgffetffelgffftdehffduffegveetffehueeivddvjedv
    gfevnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:6V2YX4rx7t9S8VHHEkuntODg1QT8ePcxxXZXZYe3DNeOXLadvibwFA>
    <xmx:6V2YX-k_2qFesZ9uK9j3Z4CKtdM1ikwWRZGaTMtMy4t3Ay4B3W5rtg>
    <xmx:6V2YX41QaDS1-eABAl5OoXH-I5g_jp5xN2jPw7xYbtwNunEY_0klmA>
    <xmx:6V2YX9v1j1NAGXL5DmsslAmOIubDBKLFl7bgg06LwhwhRcunfAKbwQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2CEBF306467E;
        Tue, 27 Oct 2020 13:50:33 -0400 (EDT)
Date:   Tue, 27 Oct 2020 18:50:32 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v8 04/14] ASoC: sun4i-i2s: Set sign extend sample
Message-ID: <20201027175032.utw23rtbds6fwrbw@gilmour.lan>
References: <20201026185239.379417-1-peron.clem@gmail.com>
 <20201026185239.379417-5-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y7eb4ufvmwjptweo"
Content-Disposition: inline
In-Reply-To: <20201026185239.379417-5-peron.clem@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y7eb4ufvmwjptweo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 07:52:29PM +0100, Cl=E9ment P=E9ron wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>=20
> On the newer SoCs such as the H3 and A64 this is set by default
> to transfer a 0 after each sample in each slot. However the A10
> and A20 SoCs that this driver was developed on had a default
> setting where it padded the audio gain with zeros.
>=20
> This isn't a problem while we have only support for 16bit audio
> but with larger sample resolution rates in the pipeline then SEXT
> bits should be cleared so that they also pad at the LSB. Without
> this the audio gets distorted.
>=20
> Set sign extend sample for all the sunxi generations even if they
> are not affected. This will keep consistency and avoid relying on
> default.
>=20
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--y7eb4ufvmwjptweo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5hd6AAKCRDj7w1vZxhR
xZqpAP9enB//96j/jv0+jG66uQta3FVLXyXrsFR+yA3EJWQGlwEAqa2gc/mmLsQF
O71Gw/GubfFkbyT8hscPCLiGcG3HxA4=
=NGld
-----END PGP SIGNATURE-----

--y7eb4ufvmwjptweo--
