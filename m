Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6652A27AC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgKBKDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:03:18 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:51617 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728189AbgKBKDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:03:17 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id D9DCEEC4;
        Mon,  2 Nov 2020 05:03:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 02 Nov 2020 05:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=ilkKT/++KksT4+jo5rc67rfyyuN
        WnKoBLRe+EEltXqk=; b=Pb/5woQ/aHGcnJW/1hpj/jdvPa7bCmNxn6fSWd4ibfL
        nfgkYPMOvk26UbeLSoEi0T0Im7rghZ4Vr8V11tTKVqrOuJbs9prSom0sZ4Es7JL5
        L95a1W+bDQan7TuTbs/DMF1GA76ppSeiOC6qotDCbHCR9xlj6CcpIIECaOQMUlK+
        JGBxSqtYucIAXD/nQqKfERGRsfwgf4Opqm0wjmtKWy4b3EDGM1dZ2+lFSXE+zuHS
        qwo+RqYhRtLQv/5lZqGoNmujaLnC499iYi1bYmKOQXb3oKSYIWWX73DjcHK0Qk4g
        wepTBz1mz1lYq5UD+q2Pl0XawhGEUy9kn/3jpaAX7eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ilkKT/
        ++KksT4+jo5rc67rfyyuNWnKoBLRe+EEltXqk=; b=SlctLSWu042qpIrRiV9LJZ
        1Qq1AfIz4CbS0x1oPt+MDulOix475lH5ieq5X5zDQKGBoflEq2lGPn1FN5Dz+V/1
        kki1wtEfkRNBa8io5j2/8WlSz45mrReHOnUmSncMqQzo0j1RWoICGif4C2gJf4FT
        d6TvWuhOwIy24WM5+F0MaGhXInnX2RTjMyQzCZuXPbJfbpmHQB84lOQx2ixUzIQK
        6q6TyDzl4MVOVb0U3L3VRWqYcfId/91XWdATs2Q3U5Zrp3g9B6gdGAPR7/ZV42BC
        KFIJzQ/y5zPpa3ZDJz6oCY1oJX5PIprBDGHDLARYZdpZe74w1EbkHV0mw6LwBvRw
        ==
X-ME-Sender: <xms:ZNmfX8rlynQCm0wEcCEvcAPvfsH6wBmXRZRnv_vgLDDw_6vfXKeiUA>
    <xme:ZNmfXypvBU93Ygm-IV9rdLoSTkhjLtOmxtQNS8vNNu1sudl3QHTgpZzRaDIuI2eCY
    -wDz9KTxT2Stw7XZSI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtuddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:ZNmfXxNpSGV9Brh1XX5_sG8jatRG4BCuiGgEphyYsZzdUwoHilmZgg>
    <xmx:ZNmfXz47o8r3BID84W5n4KndxMOkSerWTRPH6FYaUjfj4WJ0Neu74w>
    <xmx:ZNmfX76xJYzyMPxCHJzgvNnHttWAxY_1B97xqYPTZqBtwy2vCHqlCQ>
    <xmx:ZNmfX7H4gekPm1gtzqKmOGrYoCG2LzMx-4DFsIKTdGvbqrQPp3JpAA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id E68D43064684;
        Mon,  2 Nov 2020 05:03:15 -0500 (EST)
Date:   Mon, 2 Nov 2020 11:03:14 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Matteo Scordino <matteo.scordino@gmail.com>
Cc:     wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] ARM: dts: sun8i: V3/S3: Add UART1 pin definitions
 to the V3/S3 dtsi
Message-ID: <20201102100314.cshyfax6cjthyo55@gilmour.lan>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
 <20201030234325.5865-3-matteo.scordino@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xgxhhhhz73qrziqw"
Content-Disposition: inline
In-Reply-To: <20201030234325.5865-3-matteo.scordino@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xgxhhhhz73qrziqw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 11:43:21PM +0000, Matteo Scordino wrote:
> The Allwinner V3 and S3 can use PG6/7 as RX/TX for UART1. Since no other
> functions are assigned to those pins, they are a convenient choice for
> a debugging or application UART.
> This is specific to V3/S3 as the V3s's non-BGA package did not have
> those pins.
>=20
> Signed-off-by: Matteo Scordino <matteo.scordino@gmail.com>

Applied, thanks

Maxime

--xgxhhhhz73qrziqw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5/ZYgAKCRDj7w1vZxhR
xe8kAQD0FNBzey8cgKLzuOkCFV7cg5vuXzit8D18XhcuksmV6QEAxMu0wb9i8x+e
2J3OFzhs6AatlXGPJ92bZUFOvUrMsQ8=
=6EOs
-----END PGP SIGNATURE-----

--xgxhhhhz73qrziqw--
