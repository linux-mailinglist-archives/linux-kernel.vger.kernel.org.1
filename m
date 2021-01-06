Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D3A2EC0A7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 16:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbhAFPuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 10:50:00 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:37613 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726251AbhAFPuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 10:50:00 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1EC325C0150;
        Wed,  6 Jan 2021 10:49:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 06 Jan 2021 10:49:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=rc62QdcxpNDY4KBpsnf9RnI8jTf
        gX+ZfHNysQibrWOw=; b=MMmKZ7JWFDvhWgjBP80mX0Tcl+k/uo47vRujiqCteXa
        2+xSnJ5dKLhUFmgL7+eSgr9RNlq4jnp8bKmIe+CEt3ke6VYplh1LNOceDyWWnW3u
        Yeqp4hyMJLAe/kO9h1Urm8dmAONzylHhYzq9JYzQbPc2Om6zMcZzFzj68v7s8dUq
        xpoljYAoXKkyQq2V7UcBdXpAFZnZjNfexG0H1N0xhuV/N2nHAHg4NKC3oQFPYcXU
        wk+F8Q56pLLsTgkn45olJ0/NwLqYlmFyG/ft4uDsrWE6lxIheVLUdTiGPzUhUfuD
        kzUPetOXx1A6sMEV2IgXKQBQcduv2o90/2N8Ad00fyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=rc62Qd
        cxpNDY4KBpsnf9RnI8jTfgX+ZfHNysQibrWOw=; b=EhwgHHpfxLg8AtBR4+d/Ex
        bSv2z+H32+9LikH1QRuHxwAt3UfQXICQ/mq00/kmprVDhG7i88Rnt7KsBECucDth
        3Y8iKddm5bCNn70UP6KsgwXDBnU/zSlK3fhTzbgq/Z3IC50QgnMnnDBctL0qBRgo
        qTMS55Yu1CiX8rFOMp8/5l0u8GVvIfkNRZO5+yLjKqWPAG1GBdL9nsoWGs3ZdIrs
        BSqF9+gXRMbIDSuznKe/L2Nsc2g6ZKfSuyv2xUZjRXe9hTPWHfs0PHon1dF0OsaZ
        Ac0uJkF06KPwj2MuMDeKMjdxDFnfM1SaSC1K0SritOV/v7aHRscL0DIKxyxtbjBA
        ==
X-ME-Sender: <xms:-Nv1X0e8CMhzZRkOIb6vgQe0HMOEkCJq-UqUVUs9QQlk-c-Wskzwsw>
    <xme:-Nv1X_JNUCypNfTVseqOsey8chcjOHuxEo8G78SA18qqB7UUCbJxv31FKfF2nFh_s
    wKTl2iQlQAhLruD-1M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefledgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrgigihhmvgestggv
    rhhnohdrthgvtghhqeenucggtffrrghtthgvrhhnpeelkeeghefhuddtleejgfeljeffhe
    ffgfeijefhgfeufefhtdevteegheeiheegudenucfkphepledtrdekledrieekrdejieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigih
    hmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:-Nv1XxHkiRGUQVde-EgZH5CI02516NIlZyanzeEIvJ2jHAO0Qvf8aA>
    <xmx:-Nv1X6Ciuk8bKMlRR7dqyWGrJMC2h9OTiXRXL_5T_TWmTHm0uDFGfQ>
    <xmx:-Nv1X89Y1pRfNhCRDXGcxAJns8X2PtUtZfWShm-YgjSoixSqQ5Y_nA>
    <xmx:-tv1X9VruoDcEQjQOWHJQa2BmyI-90inKhHlJPwJ6TMYDET_sCuXAg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D7DAC24005D;
        Wed,  6 Jan 2021 10:49:11 -0500 (EST)
Date:   Wed, 6 Jan 2021 16:49:10 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Sergio Sota <pikaslabs@gmail.com>
Cc:     robh+dt@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts sunxi: add A10s/A13 mali gpu support
Message-ID: <20210106154910.3muk4vmchitzg4gs@gilmour>
References: <eeba726d-40fd-48cf-9587-8f801f3d6cf7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ethe37pra2fpp773"
Content-Disposition: inline
In-Reply-To: <eeba726d-40fd-48cf-9587-8f801f3d6cf7@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ethe37pra2fpp773
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 23, 2020 at 09:08:47PM +0100, Sergio Sota wrote:
> From c45753026b4868e32132348f8f2bf59e6ce5c820 Mon Sep 17 00:00:00 2001
> From: Sergio Sota <pikaslabs@gmail.com>
> Date: Wed, 23 Dec 2020 21:00:35 +0100
> Subject: [PATCH] ARM: dts sunxi: add A10s/A13 mali gpu support
>=20
> The A10s/A13 mali gpu was not defined in device tree
> The A10 has a compatible mali gpu driver (same device)
>=20
> Signed-off-by: Sergio Sota <pikaslabs@gmail.com>

The same formatting issues that were in your previous patch are in this
one as well.

Mentioning how you tested it would be great too

Maxime

--ethe37pra2fpp773
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX/Xb9gAKCRDj7w1vZxhR
xRhgAP9wv632bLqIa3evAaYYi6T3guFTxC46P7jMDNpyCsziPwD7B5jpDRo1L7i5
hhLjCcjuWNmrklmmUq1bvawXtWefgAo=
=vPi4
-----END PGP SIGNATURE-----

--ethe37pra2fpp773--
