Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270C62D958B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 10:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgLNJx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 04:53:56 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:39819 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726216AbgLNJxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 04:53:42 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8E60E580248;
        Mon, 14 Dec 2020 04:52:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 14 Dec 2020 04:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=OrY8HhQn+4QD7YB2uLYluM8SGzm
        bRX6vUSKW+v+/3kE=; b=re6P5xH4O2aCB8IFgs0VuxmQ4xIFnuPQBsu1a9AOB1O
        /iefy+L6JzbYZ/linXtnXs53rvcg4YA0kY0UprtUpLjRdIrznmDa7BOVF/N/iQGA
        HyriJvFbRsUdNvENcCqcfYBoMrn7mKfCTdDXuoB8Ngi/v48+JnMGIEKlTxTjrfdd
        Ovq2fHXhrCUIgsz1/3SQsnvM9t6xs1Oi82WgsBqMQ/SOLIJ7OgIzVayvQ8yjVwHd
        U7xxmcwIKLFEHZhqLoAKj+EGMLbdGvakzvBnFKnyReTV2QtTqTWcQLG1CedF6Yym
        lsKM6GM90fEsKZBdrMO2FkKhaBgMEbz5mxylUuz8LNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=OrY8Hh
        Qn+4QD7YB2uLYluM8SGzmbRX6vUSKW+v+/3kE=; b=qCJ3lvPztFhEXcJo8qTeiZ
        8zr/f8AIFjpUF1hJXayvYBCIjBFbagpcI518Aa5j8LN6huz2MS2B47VPnReZc/ik
        k2TK6TTEz5a7blQYyzpgajoHCY6pS5UYkWad9ImlkZvBTrxy/yJzOINJ6jlzi+ZE
        /7Bdg/Xzu8pNBozAYkm8GGE4ZNigJ7XkoA/qUb+SPRVfZ7ojbct+NvI8W6MRx/CJ
        Qi3sozaXvTzLkACFmbKYDvGkDr4sV3iZpMAR1B0qZ9Th0ZD0Q88r4oxCPewD6dIZ
        dRUjiMf5VWM3ae26/o2OSXG6FoX7IY5OZVwnIbWEGjhLHEkP3BQ6YQ5oV4cjBKMQ
        ==
X-ME-Sender: <xms:4jXXX-19vytQozBf_m7-rNESyX0E-1jzcFN2b6hAS5E5yG1avG6I6Q>
    <xme:4jXXXxGoHZCxfrNmRPe4GU4k-amffjPrKgcdFjZ53UZ307mOPguOEumjcAXfiQPkM
    -cxoFraLjo2-OmzR7k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekkedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:4jXXX24trKYxGV4XEEpWSRR7s_jK0XT2InWnssJfSAZCkmLnyI9A_g>
    <xmx:4jXXX_2XazKLEuVyJrsxhhVwjdW0XTmf0LUUE_kz6Tw4oedhlA6ikw>
    <xmx:4jXXXxHJ3OExOtwxNem680REY2YTSMGjs8JzErRNQnNow0cKxRoR7w>
    <xmx:5DXXXw9T-FoJLGJfvTMRuruLJUZrSsfaj78qMcL8-ODYkzfZpMx8CQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 16B3B1080059;
        Mon, 14 Dec 2020 04:52:34 -0500 (EST)
Date:   Mon, 14 Dec 2020 10:52:32 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 15/21] phy: sun4i-usb: Add support for the H616 USB PHY
Message-ID: <20201214095232.xgclim6ssrd4ngyv@gilmour>
References: <20201211011934.6171-1-andre.przywara@arm.com>
 <20201211011934.6171-16-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="imxvm4zbeobw63ig"
Content-Disposition: inline
In-Reply-To: <20201211011934.6171-16-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--imxvm4zbeobw63ig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 11, 2020 at 01:19:28AM +0000, Andre Przywara wrote:
> The USB PHY used in the Allwinner H616 SoC inherits some traits from its
> various predecessors: it has four full PHYs like the H3, needs some
> extra bits to be set like the H6, and clears a different bit in the
> PMU_UNK1 register like the A100.
>=20
> Name all those properties in a new config struct and assign a new
> compatible name to it.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

It looks like you forgot the binding for that one?

Maxime

--imxvm4zbeobw63ig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX9c14AAKCRDj7w1vZxhR
xRhLAP9uUe47JO49+zYAi2qHvQofZPaV4bW5UWMOmHnxKoCK2QEAznzuW9uBXRQa
Z7B2iWnSGkCXa3o2CSlKrZA4+LSM4AU=
=h2MY
-----END PGP SIGNATURE-----

--imxvm4zbeobw63ig--
