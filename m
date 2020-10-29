Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F81F29E75D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgJ2JaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:30:25 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55405 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726572AbgJ2JaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:30:10 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BE5785C01AA;
        Thu, 29 Oct 2020 05:30:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 29 Oct 2020 05:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=B9HVFfK78gWzwjefFFkxjqk9NIL
        7X7Ncx/gsFLgBXrs=; b=lX1yvNfn6/X43VERQVtbuIfoVYcYiPdSmzuBn8b6LPg
        mZEJ+mpf4/NFIzx/p1zjV6KeUHqJsLrmLggV0dZIQNS0Wh9sABO2XIz2cKMhV3ON
        Aiy8Jcqdz9tjijxT9B6CLEfRlw5r/kQt/+6MQmU2wXFPrhKt8jO0BWl75T9rqgMj
        1D36T/wzlv/9i9N2k7xUVMXdmo+fK/g/5KDSBeIMfNohe9F2su0RHjC4rEnk+f4b
        K/kAIaoskzmFuySB+bUvZNe1dyaAEl1E9VPGux9FPLlChAuPWUi7YwbwTXcwmbxo
        7oCut7+BapZoaUCghOyj2TQaT/X2Rcm+mNybSqldFIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=B9HVFf
        K78gWzwjefFFkxjqk9NIL7X7Ncx/gsFLgBXrs=; b=EW1g13J1FgOJhtZvKe+8IG
        TgVaJB46uZiO5J/d2EoE9gzz2Jm0IU7kutkSjkXIlN8B4IiXCgBJr3kT53lX0jOF
        9FdTZw0xBo1OyIUoeLGV3osOW/RMV/2f2fyh0zgSIdg6zVPqlGVfplDSAWbY4CU0
        d5EaQ0ByPtlKl12nwt+3E0/y2cgOG8pVc2EOX3XWldwrRW4xb+CiCsrQOZKnbzc1
        7H2c23ip4ObioWdbh1byivCG8pFfEO4F5CcBjFUWHZArbH55aL77bwOfKAjhWKnm
        Q+GdoBI7Y2DyVsLwrnhuQMRCbSrokCAV+d4TIA/IF1EBd5f7qqtYbfMtsa9o01iw
        ==
X-ME-Sender: <xms:n4uaX5ZrQTKn-POXjiBfvH9R3BwHCd-SYD_0wzaV0e9BwbvXdOjQ3w>
    <xme:n4uaXwavwbZ3FPcNieb0YnTMOOMLeGe6HeXjJ-0CHRAiqWgezlB-wLOlQMI-iumdy
    Z7ilmpzRbgQNpo1s2k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrleefgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedvnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:n4uaX79Bn1geFrssuVgB-mGE0PIniIPTp7PB-s5DSn984PmWJUV_jQ>
    <xmx:n4uaX3oE2FNS9a-s1w-XEVoiYi3bYJISQ2ssMvNZzoxaY3YQTdh70w>
    <xmx:n4uaX0pIu-98cobmZStLxxguUFTJCcOO24b87HwNhnGOEVM-CQxf2A>
    <xmx:oIuaX5BsQzTRRsXno9W6K_ebFmhETy9_Qi-mhpNZ9fN9-Vxloz2Szw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D2A3B306467D;
        Thu, 29 Oct 2020 05:30:06 -0400 (EDT)
Date:   Thu, 29 Oct 2020 10:30:05 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nenad Peric <nperic@gmail.com>
Cc:     wens@csie.org, jernej.skrabec@siol.net, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] arm64: dts: allwinner: h5: OrangePi Prime: Fix ethernet
 node
Message-ID: <20201029093005.zqqfm4hrnd47ubtw@gilmour.lan>
References: <20201028115817.68113-1-nperic@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gt3y7bhi7puxtroq"
Content-Disposition: inline
In-Reply-To: <20201028115817.68113-1-nperic@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gt3y7bhi7puxtroq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2020 at 12:58:17PM +0100, Nenad Peric wrote:
> RX and TX delay are provided by ethernet PHY. Reflect that in ethernet
> node.
>=20
> Fixes: 44a94c7ef989 ("arm64: dts: allwinner: H5: Restore EMAC changes")
> Signed-off-by: Nenad Peric <nperic@gmail.com>

Applied, thanks!
Maxime

--gt3y7bhi7puxtroq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5qLnQAKCRDj7w1vZxhR
xeMkAP9Z82bSfh19Xtopub9pjCVyWGepSHh1HM18hFw22LzTCwEAyxUkz9etcfKL
SltyWoS2O4WrB1Gtw/apb3ab61TULwg=
=Ajj/
-----END PGP SIGNATURE-----

--gt3y7bhi7puxtroq--
