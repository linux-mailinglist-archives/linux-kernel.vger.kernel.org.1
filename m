Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569942EC0A4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 16:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbhAFPsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 10:48:37 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46885 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726682AbhAFPsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 10:48:36 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 37F525C00E0;
        Wed,  6 Jan 2021 10:47:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 06 Jan 2021 10:47:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=iz01rTxLDHDFoDdajwyu5KVmVmB
        +J6MIi+WXxRE03MA=; b=P3DkGNQvT/RqaAIsSKpLU/o3exrlg4vhiskmvMwlMdT
        YOpJijm6KOpaAgvq07j/CBePfUkKOYR7yy+cMN/UeNzTjtLyG880Wu4Sbqy0wFqP
        suHM2rjGA7IPVomqkVJPHrPZGHaSyxJ7Lx195qtqqH9vFZbpBvtiY35apTAoU+rN
        eEfOvwiVqC922h3VS9D1bhg/XErRW4ddNb6S13YdNFhH4cW/7+LBouyorsan2D6b
        gtmeROVNq6f3pnAV9IPncd7w6ZuM/ZGW6iL3W2fINDWOMHfBsXireT5cYmQgr7FY
        yr3EH7BBzMHSl+0p0kqLUcdkKsxh6FKt1AGGfASU79Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=iz01rT
        xLDHDFoDdajwyu5KVmVmB+J6MIi+WXxRE03MA=; b=oHJFr6Ux4KsFiUe3zDPEFX
        prXAH/onV1Re8c8lmSeU7YCmh/XKnbquEDhgglp4ur8PzJw30W+qjQ6SY+eVLkZO
        RaWJELoaxXBSur2Sy6dBh7Ma6JthL3EmCNzYNWCa7Hp74Q2MXvAg+NvkKJgOv/Rc
        vvhsrvBeT5l6lpAEeC9aJ4II4E29ctLHtyDWeuZ6PrUlt5/EP0r40q/zcKoqPGfW
        2bh78tBvpxxoCEb2JejPFW7o48boor42zJOq9ONsjXiniOH47mTDsj11UkQWr/KC
        1nPIJokD/nH3hLLAbH5N9uDBQw0chbWMzg7a0R87BkmQ6+1nc2encGOPaQvAvuSg
        ==
X-ME-Sender: <xms:kNv1X0VtE_LYbPtGZXPnRHZp1Tu_n5bBhU0k1vMK8-OKS2NJsCMOIQ>
    <xme:kNv1X6nvL5QIhaGd_zAxbOtDfbXwnehhlfaGsCrX-dVdNFLUHSH-9pM_MR20dzxJU
    i9BbZAKQwRFPJMvTB4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefledgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtudenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrgigihhmvgestggv
    rhhnohdrthgvtghhqeenucggtffrrghtthgvrhhnpeduvdduhfekkeehgffftefflefgff
    dtheffudffgeevteffheeuiedvvdejvdfgveenucfkphepledtrdekledrieekrdejieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigih
    hmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:kNv1Xxxi_A_tBO2Fr6eXMiCBheuWhvqtmbsLPcxgyAYu4Kk9AkfO-Q>
    <xmx:kNv1X1jjj-miMNxZnlGc22Wxzw7AARkhuZZUiWw-5CDif5df2E-KxQ>
    <xmx:kNv1X2XJT1-Scv3BS_F6vPTE3ARRMUjXWwB7zobZOu5rd01Y5Q-P_Q>
    <xmx:ktv1X5A7NkCJe4kbfAkK9mqQIfYMO_e2b5wkldG8UGGnsAilVj3dYg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id AF398108005C;
        Wed,  6 Jan 2021 10:47:28 -0500 (EST)
Date:   Wed, 6 Jan 2021 16:47:27 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Sergio Sota <pikaslabs@gmail.com>
Cc:     robh+dt@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts sunxi: add A10s/A13 display frontend support
 fallback
Message-ID: <20210106154727.6sljxothf6ofhwyv@gilmour>
References: <0ab34d17-625b-aee1-b77e-c4a9cdb019d7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mrwrbpzxr5dcvytz"
Content-Disposition: inline
In-Reply-To: <0ab34d17-625b-aee1-b77e-c4a9cdb019d7@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mrwrbpzxr5dcvytz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Thanks for your patch

The prefix in your commit title should be ARM: dts: sun5i

It looks like your patch has been wrapped. Make sure you send it through
git send-email, or at least that your mailer don't mangle it.

On Wed, Dec 23, 2020 at 08:58:15PM +0100, Sergio Sota wrote:
> From d5fcc1d4aec82ffe6de78cc40a6f53910e2e88ba Mon Sep 17 00:00:00 2001
> From: Sergio Sota <pikaslabs@gmail.com>
> Date: Wed, 23 Dec 2020 20:03:55 +0100
> Subject: [PATCH] ARM: dts sunxi: add A10s/A13 display frontend support
> =A0fallback
>=20
> The A10s/A13 display frontend driver is not implemented
> The A10 has a compatible display frontend driver

You should expand a bit on this one. At the DT level, compatible means
that the entire A13 controller can be driven just like the one found on
the A10, for every feature (including the ones we don't support).

Given that the documentation for it is sparse on the A10, I'm assuming
that you instead tested the current driver and found that it was working
for you. However, it doesn't mean that it's the case for each feature
supported by the controller and thus we can't really make that claim.

We should instead add the support for the A13 compatible in the driver.

Maxime

--mrwrbpzxr5dcvytz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX/XbjwAKCRDj7w1vZxhR
xTz4AQCwta7p+9sbvlKP//33v2CVPveTTZYCxL8yWkaLY30FUAEAwbRM/2b94OpK
cRiAYXLyXYFCVN7kzEighDIF+ZHPxAQ=
=mIq/
-----END PGP SIGNATURE-----

--mrwrbpzxr5dcvytz--
