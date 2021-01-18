Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8822FA1AB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392392AbhARNcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:32:16 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:45309 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392251AbhARNaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:30:10 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id F3E6258073C;
        Mon, 18 Jan 2021 08:28:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 18 Jan 2021 08:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=B+mFWeHglcc6c/sffz8BVhchAnh
        A48dtD3sY6T3zFdg=; b=Uyg8YUb8MaHLIuSUichX2W1imen9WWj1E6lKlTQisKL
        99yw8uxW8yTfNEdy1zZYgZgtRRskVzgMY/gQ60gfdCsE004tN5xv2GjTB4PhOkpH
        HRXx0DxbnGa0Z3rSxhAXLT3Vv2G2Y6paQKRqhqN8z1z9eQqszQDN+9/fUrHnjdAB
        TAHGUzZfg9iD7JtgT/WdA5sWtlUpFvIxpXAPT7lodI/lMSkQ6cVcoAtbrHHQ+top
        6Y8bJ2t807IJMId/67dNNNsPJDtJQ5Esbsgg4TUaoxwVLYmODU7HKhvP0zizyTZI
        jqC90ETMGLWoARyoC3gjNUsTqoUyyrGV0SsK4UBoRSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=B+mFWe
        Hglcc6c/sffz8BVhchAnhA48dtD3sY6T3zFdg=; b=AtVWA2LMHcvWP2ETLkl5nr
        Fht7jkLP83AR1YBBtbjYez5igNRPgcjHpxKV/ulcqC4ypf3KpY05hSDd0F10ZQPL
        FcM4lASock1T3/tIFq49MeOtwL5UlZXA1GdN5/OZNs8fBwOY8s92UD2KL7i8J02Y
        O9Hzi0Qrk9R8eTBLfmmY2mJAyT72mfZjtRc5UNhZRp34edqmZKaD96+MqHk6re4d
        k63j0dX/sZwsvFl/82hvpGtHhoHcZa4DI063eeJcCHhC8gDSWyRyB8r/633umI2C
        bw4Z2OW4TB5USxouvf01t2tPQ1fmh0zf56t5w6ETI83u2+gWqZiIiv+TGfUpv6oA
        ==
X-ME-Sender: <xms:GI0FYIXcLBmTyt6FX8ro1nHPFKvdTcWlO3PRlNdttOGVfg0-Sk7fnw>
    <xme:GI0FYMl-y-74aVfXIntqxqa2aesjNqYoeFjHJpoD7VeGizA9cPtrjtIGiEUqtjPAM
    S_UyZB8z2kLYBFsVCo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:GI0FYMbpOadaGlF_WGxXECCrG_MVRyTcIFHHSRkMBfCgOM_ex3a8zw>
    <xmx:GI0FYHXZG7e5LD2X8xEHQd7F4ABEG_LsQf73-NmFfqqDCGu6kp464A>
    <xmx:GI0FYCl5WiY9sZvHLj2rU4tDxSy5suC8sFFjxLH2uwTlQqyN4vTqMQ>
    <xmx:GY0FYLen5UgzSGQ8s0STc0VmAnoTl0EKWTOxGGvfKTJsIqxtll4uQw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6E2251080063;
        Mon, 18 Jan 2021 08:28:56 -0500 (EST)
Date:   Mon, 18 Jan 2021 14:28:54 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 02/21] mmc: sunxi: add support for A100 mmc controller
Message-ID: <20210118132854.yiwn7rnvcyexgqim@gilmour>
References: <20210118020848.11721-1-andre.przywara@arm.com>
 <20210118020848.11721-3-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="avhebb3ip7w3ctzx"
Content-Disposition: inline
In-Reply-To: <20210118020848.11721-3-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--avhebb3ip7w3ctzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 18, 2021 at 02:08:29AM +0000, Andre Przywara wrote:
> From: Yangtao Li <frank@allwinnertech.com>
>=20
> This patch adds support for A100 MMC controller, which use word address
> for internal dma.
>=20
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

We should also disable the timings setup in probe to derive them from
the DT. This is causing issues on some SoCs already, so it would be best
to not make the situation worse

Maxime

--avhebb3ip7w3ctzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYAWNFgAKCRDj7w1vZxhR
xW6pAQCnB6MXxIc1Rs1RQTywF1UDNcATt9gItVQFB7AgpvSeewD/RzcD6DesCH9J
+e+GWcGbXsYmtBZVqPvNbgQpJ6rj4gU=
=rIoP
-----END PGP SIGNATURE-----

--avhebb3ip7w3ctzx--
