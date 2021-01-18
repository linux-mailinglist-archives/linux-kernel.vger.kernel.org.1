Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCE92FA509
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405953AbhARPcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:32:36 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:34619 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405940AbhARPbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:31:20 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4F979580794;
        Mon, 18 Jan 2021 10:30:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 18 Jan 2021 10:30:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=PSXtrd2c/tf/6/t7uPfgHtgY6KB
        UUffDbACWC+Qk0QQ=; b=dlzyie+Eed+c1ZQHiyVjcBZpfY+eL6ouXuKMjkHvx8s
        H11CG+E7snNGGkxMMWmm0pEWUHrIQ8qt4izNzy+vhGu0BIaLNXnlzqWWixhMzOVS
        M8PbrarMIbm8QJ+bOz8OR2455p2ujK2SLwGxudDiodu7IQpCEn8nw//AI/9GVmn0
        u7T1xdCe6FcvZ1swfS2khLSL48EgZdiGcQsLzhJ6IW+WEO2SykB5mVgVAwgMd5E+
        aLtTLfq3wuLYEmddAFiAEjkNZqvtkJQZvlbZ2/csHznkewq6CUPdGJd0nqiAQLF/
        xDiPtK7PN2i4T29KJVfkwZLRipS/HCNCdwqxIEpPtCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=PSXtrd
        2c/tf/6/t7uPfgHtgY6KBUUffDbACWC+Qk0QQ=; b=XgOkqoRugGDVePaN3jg+OR
        dadDEZy5nkJt/Ls9UqPwstZHRyrdBq8ZAcC6RTLbfdcaCVWosJ07ruktIguUv+W3
        O2S88yqjXFNWl/xOabiulm2TjtreAd5kAAHbCH8pz6TdPauH0o8je+AnFApeyYBX
        6Y03JNcv7+pb3WBixm3g6+2eaa/q0CzvZLbOX5THfuSHqZ8hcCqwmbSwR3BVl2Yl
        rZ/xNxtHbxrC0tJ4jm69/4VlSi0FVOL72L/tx0vuCRAiaMJKy0Pem8u4yvJoFbIe
        Zwu6rGEVsLCEXaptPBF4VE1lH42gcHpT1F0vBlQl5AoB7OCYa6dkoox6iJelK2UA
        ==
X-ME-Sender: <xms:hKkFYDkuLT_AbS7QbgNX3gcUv8z1WFyBmFG_TzXhYenquWEWPOIzrg>
    <xme:hKkFYLLP5yXEaj3iveipirN3ODJVJ_nmMpwUnRVhsfXAQHvsr29yopiUS1m9cj19y
    aE0cLFJ6pXnjkes9ko>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:hKkFYIwN-hd02IQO2m4JRazYjlZZ23l-bBApotHWjS74aVkFq8fbDA>
    <xmx:hKkFYDuEhXTjVuB4qsrOxazaFEcTXCrBcNer6likToud0uURi9t10w>
    <xmx:hKkFYHtXiNa-Y8JSrMttIzq6T33RozbZJjGh5SkDRpNurCk7kzj1QA>
    <xmx:hqkFYMTYJMNCqSzenn5jDnuMyeaDV9nPPr7GkAr6XTwMbUhcLl70fw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9DD59108005F;
        Mon, 18 Jan 2021 10:30:12 -0500 (EST)
Date:   Mon, 18 Jan 2021 16:30:11 +0100
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
        linux-sunxi@googlegroups.com, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v3 07/21] clk: sunxi-ng: Add support for the Allwinner
 H616 R-CCU
Message-ID: <20210118153011.yozwrkqxfemdradu@gilmour>
References: <20210118020848.11721-1-andre.przywara@arm.com>
 <20210118020848.11721-8-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="atpvsytfk2rxubn4"
Content-Disposition: inline
In-Reply-To: <20210118020848.11721-8-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--atpvsytfk2rxubn4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 18, 2021 at 02:08:34AM +0000, Andre Przywara wrote:
> The clocks itself are identical to the H6 R-CCU, it's just that the H616
> has not all of them implemented (or connected).
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--atpvsytfk2rxubn4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYAWpgwAKCRDj7w1vZxhR
xY8tAQD4eXu9Cqi6L/5+62I5kbMW15Dhl7gxyon0tJDMLTYuXQEA0XHhrbT4Vcnh
zZP/QXcWedWdad6lJerMH6FYjLVsIgk=
=jCyV
-----END PGP SIGNATURE-----

--atpvsytfk2rxubn4--
