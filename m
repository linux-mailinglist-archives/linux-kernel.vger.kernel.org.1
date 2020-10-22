Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022FA29625D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 18:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895792AbgJVQKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 12:10:04 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45999 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2895440AbgJVQKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:10:04 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 20FF75C0144;
        Thu, 22 Oct 2020 12:10:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 22 Oct 2020 12:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Dxs+IJPaOZW5RpEI46Ejy/9a5zm
        xksy9228WToYAQKA=; b=pgGLOl7KmDKV6PWClPPromj3LoWpQRvj53mn2YuBcaP
        oKH6pFfNkFv/DekcmuPGYOTQz6J7Z43H083Oorha3zo+rT4TtSbNHdScMAOVsVdM
        xo+UHlB9eQY/d1I1VMYImZr6eyPDIfCqMhm2aPJw8ypb1ZVvBqqpaUmSDnmMqSWF
        AG5HHNh0e2VBjdbyn/lHUnftLYJ+l4SsUXlQMFIf4zhZFS0dqYAEqzBCpfOa7l5C
        0WQgJ4xtIxf8Ax9F2Mei+cl1AuGJAbLbEnSpeOh2xLiAkLjQySrZ5R4OCmeLVHQo
        y4M8LJZhqc1XhdtEI9ps6C+aVJQ5jWx7RsTguDbp9aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Dxs+IJ
        PaOZW5RpEI46Ejy/9a5zmxksy9228WToYAQKA=; b=gPYkfCaqMytcupmz+CvyXI
        8/nYjm9LWb6d+vpMnXmlM5Z559E9PmmrKI9M4OBCwPGL6KPPwIGcpCb7vakoEOtg
        c9dq0KkCOWyXmKmnzgpnpUE7HG5sq6Et/xS9NWgZslk3TWxTsCj7c+gonDOITMLk
        /TJCC9PMuMKJWb39cp5fUKntA/Vz3aAdeszv+5oqyakFcGeNAIYQsHD+hR+XWpfw
        Ttk5P+B4L/xnvp9VP8A5k/OMDG7pWOhvwgzTavZPlH+VaZaJBV/Pe15MUZja/DG7
        cPzuCpO8lpEhc+ncfzgVkOCQ4rtWWZwMT1kGcxXeYM0THAGEqe0qN5CTUFbOwZTg
        ==
X-ME-Sender: <xms:2a6RX8S7VTKwqPH9dA-fhSJ7gqabKOArl5BYo8kNLbYKq-aXcm3NSw>
    <xme:2a6RX5wm2c3ce4lCh4wMTd35qTFV3LKRSymcs0j2_K9u6ZfMsjTpg4Lx1ZEyzyaS6
    ilqzwNAFXPJhyoQRdk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeekgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:2a6RX53wVZUZziVu3FEqEAabOh5OgAlAsvw7AmoAxjR4oYL_LEOoew>
    <xmx:2a6RXwDtYwd4B0TBxX80lcSaNyNt4n42Wp7HIJRW3bp9Z9Yoe3-7pg>
    <xmx:2a6RX1itvaSgxn7f0ysUoxHwIwcuKEYjkPPRqQ5fMgI6TwKxbxskpA>
    <xmx:266RX4sNoH1myJYJcp7nB8yC8dPAf1d_PLLLCAWHfRk5Tc1pXvmnUQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D509D3280069;
        Thu, 22 Oct 2020 12:10:00 -0400 (EDT)
Date:   Thu, 22 Oct 2020 18:09:59 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: Pine H64: Enable both RGMII RX/TX
 delay
Message-ID: <20201022160959.4gmu3r3pjwh7xtlq@gilmour.lan>
References: <20201019063449.33316-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n5nq2p7sw4cdfly3"
Content-Disposition: inline
In-Reply-To: <20201019063449.33316-1-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n5nq2p7sw4cdfly3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2020 at 06:34:49AM +0000, Corentin Labbe wrote:
> Since commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay c=
onfig"),
> the network is unusable on PineH64 model A.
>=20
> This is due to phy-mode incorrectly set to rgmii instead of rgmii-id.
>=20
> Fixes: 729e1ffcf47e ("arm64: allwinner: h6: add support for the Ethernet =
on Pine H64")
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Queued as a fix for 5.10, thanks!
Maxime

--n5nq2p7sw4cdfly3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5Gu1wAKCRDj7w1vZxhR
xZt4AQDpFTAOXmtkaBeFHDpMOZDvKZ83CBZBd1e5o8C8TbwLwwEAnA/YB8xKDp3n
etOOzcaknTJmgBIMBFTM8y4N9Sl2lAM=
=3juI
-----END PGP SIGNATURE-----

--n5nq2p7sw4cdfly3--
