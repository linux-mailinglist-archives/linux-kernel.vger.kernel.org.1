Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1C22A30E5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbgKBRHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:07:19 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:57809 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727221AbgKBRHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:07:19 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E91AF134D;
        Mon,  2 Nov 2020 12:07:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 02 Nov 2020 12:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Ec9zfQK2l7ekZwDhh6zk7XfM1Lz
        tk9kkY+i12ojpsX4=; b=nfrjRBGlfYJtL+QnvypooXdReqVFL46Cc+IJygKvmuw
        6T539wkhCmLvFT/j+9xP+as9Je9efMX36waNTQIhlvIQXN8/Rmi0jUet9vINYQqm
        u20HxJshVQMLnZhFC4UESm5XBtq+nU2UvPPG+BlBsN23L+hibd1YlQ0sWJBJO4BR
        BzUuxLVtDFO1QlzBJxYSz6jCw2JKyrYgw1aL/Y7Wi0akgp+SkvDwZSLC7dc9Nyqp
        IElXQQzCQUWhAiqa+Tr8n68+nSJoxE1OrNuwqu/3fynXTIlD3UbTVa670FfRas3x
        iXQJ3gWl26nHwFKJn27NQib5WbrNNFDIeB0TXGpY7SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Ec9zfQ
        K2l7ekZwDhh6zk7XfM1Lztk9kkY+i12ojpsX4=; b=DnNwcM19k7h+vYo+IABs5Y
        GqTWqehg+jbMCIm6PfBppnw5WBdCqxNqmq6k/krJVlbmWXYq2ksWgLwR4/GjWhXI
        pU2jZL1A1VDHcKK2lWwelNnZ62KnhiP9QWXhWDHox89cfzCsBWXjlSzPIlqIXci1
        nv/dw+1B4zUzKMxtWGphuIJqIw+Ek3RqDz0NfvAbQdv340Y2fu50eE64xxaxKv1E
        RacE9jZaZDzbESymfdrXitlki/KPo2zLzkDaAfa2fShJU6a8F0u35p2R7puOBHwC
        P+3a+a3BgOv47k3g120RMO0lUCoNmYhhcaSV0cgQIA2f3DBbuEo2PbL4UP60+eXw
        ==
X-ME-Sender: <xms:xTygX2dqlGQ5FlY09akUvEgEfq0i8F_4e3D_6213VPkWDXsDEp1nNg>
    <xme:xTygXwP0s9tkUzOlgB4eDQLiJ_MeSaFCwYS6ovj0mBMi03EItZAGaTGWAip_8gE12
    lYReRgqD_ig-b39d8o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtuddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:xTygX3jv_bwikEp81ffYcbhvKX5QurMpYbn4ehAoaAZ5_fvS2RlJLA>
    <xmx:xTygXz8yyLQuKxiCL-a7jz4swHNfFMKLW72Q43HALI_H8KSrQh_Xug>
    <xmx:xTygXyvDuQY4LE8L2LuULo7YlEeq3n4_aGk80Exa6jO4v7jZ_SoBzQ>
    <xmx:xTygX2g3nTQNMffSp_QchRPD5-AaKG06Dpo9bVNYNe5hPqxuRVfveQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 07A6A3064610;
        Mon,  2 Nov 2020 12:07:16 -0500 (EST)
Date:   Mon, 2 Nov 2020 18:07:15 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Pablo Greco <pgreco@centosproject.org>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun8i: r40: bananapi-m2-berry: Fix dcdc1
 regulator
Message-ID: <20201102170715.gw424e6xxc2vmlqm@gilmour.lan>
References: <1604326755-39742-1-git-send-email-pgreco@centosproject.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xtrj2skuegmlnlxq"
Content-Disposition: inline
In-Reply-To: <1604326755-39742-1-git-send-email-pgreco@centosproject.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xtrj2skuegmlnlxq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2020 at 11:19:14AM -0300, Pablo Greco wrote:
> DCDC1 regulator powers many different subsystems. While some of them can
> work at 3.0 V, some of them can not. For example, VCC-HDMI can only work
> between 3.24 V and 3.36 V. According to OS images provided by the board
> manufacturer this regulator should be set to 3.3 V.
>=20
> Set DCDC1 and DCDC1SW to 3.3 V in order to fix this.
>=20
> Fixes: 23edc168bd98 ("ARM: dts: sun8i: Add board dts file for Banana Pi M=
2 Berry")
> Fixes: 27e81e1970a8 ("ARM: dts: sun8i: v40: bananapi-m2-berry: Enable GMA=
C ethernet controller")
> Signed-off-by: Pablo Greco <pgreco@centosproject.org>

Applied, thanks!
Maxime

--xtrj2skuegmlnlxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX6A8wwAKCRDj7w1vZxhR
xUMxAQCvmMUrAt8XX3BkeGMR//i+H+dcQ1/H5CrXMLebhsc98QEA5ge5BaD/Y856
j76YvQrjXL/mz40nK9M+Z84TsjEpggI=
=qDTw
-----END PGP SIGNATURE-----

--xtrj2skuegmlnlxq--
