Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707722A27D5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgKBKMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:12:15 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:49401 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728409AbgKBKMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:12:14 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 6DCB5559;
        Mon,  2 Nov 2020 05:12:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 02 Nov 2020 05:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=GN3WRS7er45XjCcUQLtIxcT5Yf4
        Sl2gBpyuxvnnmv44=; b=fhykfTYXJW9MCIXJeUizCXfx+3uxwRmkC88726natei
        a/+0izFOVzJs2WMmp99C7Ypdu/we8IVTny9m5yEd5wAt3uvJ2I1Qp92sCsZGmxxG
        I9+cpUeVdqhXNmAh9DEr3ySv6E/onsvSkczuFeNwW6mHNI42R1M1I37FXzhR9gZk
        QsYcUy/GW2XNvHzOq6yteFX0eUlh0j3h6wFvdN935cSLqK1uR2sty+LHuoY8ylpG
        dclehqkb/G4Lny/Qi7THEktN0vDjiDHFuyFI+TIE/d9nyJBYTFSObLwkK88JgwIB
        J7h8yIwo5pNoPOtK5UXFsWsICf4arqz4paPaAmfef9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=GN3WRS
        7er45XjCcUQLtIxcT5Yf4Sl2gBpyuxvnnmv44=; b=N/Va4/uKdJ+tbhd83dGEUF
        T8tb+6974uAYCEU80VPpm49eK3P2VqaL/l75jUDJAVAsInCrahix3krTsidHLssN
        YrQCMFIhgQO/P+iQa7dnUyaMlOFNQZz+YjyB/xFZVvAdIESf+mYgHD1BgCuEIqCx
        jNyvupMY8hM+LV/Qsfu3OEMnvvQrnM1vYWd5mRJKFGYAU6VVYdnDCfp/Bg/tCepY
        bu9uX6TluhivYzZH73cQyGuPybtSS1IKpiq5jaDjqp/TD9psJnLFvOdQOltG3xfF
        ypivNfkBelTJTGhFPjoqofU0Nar/3FgPk/ikDWEUNxXybhmgcVPKTvMvzRpJCQ3w
        ==
X-ME-Sender: <xms:fNufXz-Eo12rf85mpuXYkGIZu6wtIk_jue69DfHXZ9N2yZ7DoFL5qQ>
    <xme:fNufX_sEeptYrrI6O2L4S60msRBBj-5leCau07uU-yVeENh9DGAZ93FXjBpGEgZoY
    hYbNO0umUoG7LNcR3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtuddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:fNufXxD5MQz5WBiNqV1TSr8pMn2b-JqXmHfaz8livMRUQCzeFWzkAg>
    <xmx:fNufX_fXrtY_skU9eps5zJNf9VIlu0jf77LnS-z88kDakkjMSILVug>
    <xmx:fNufX4OicQRbQUW9kL7J-PVnEfADq4aKAPjCJugqbozmvbr8uKefgA>
    <xmx:fdufX313j2bpaC4RE6naErcFUTphejsxoSCuyl0hquWkhGbwslZqjQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 89B1D3280064;
        Mon,  2 Nov 2020 05:12:12 -0500 (EST)
Date:   Mon, 2 Nov 2020 11:12:11 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matteo Scordino <matteo.scordino@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 6/9] ARM: dts: sun8i-v3s: Add the V3s NMI IRQ controller
Message-ID: <20201102101211.wtkmgfm2rcm5gdyp@gilmour.lan>
References: <20201031182137.1879521-1-contact@paulk.fr>
 <20201031182137.1879521-7-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wpdtdu2hz4uf3vkp"
Content-Disposition: inline
In-Reply-To: <20201031182137.1879521-7-contact@paulk.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wpdtdu2hz4uf3vkp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 31, 2020 at 07:21:34PM +0100, Paul Kocialkowski wrote:
> The V3s/V3 has a NMI interrupt controller, mainly used for the AXP209.
> Its address follows the sytsem controller block, which was previously
> incorrectly described as spanning over 0x1000 address bytes.

Is it after, or right in the middle of it?

Maxime

--wpdtdu2hz4uf3vkp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5/bewAKCRDj7w1vZxhR
xTMIAQCoKAVDQ1+sUM8RV1+lHuTyXNM2j7Q6toOWnUnz4pb7EgEAwJ9cANi3jRvK
TcA8tdPnoXF621XPlQdBZF+amMYIGwI=
=FSxA
-----END PGP SIGNATURE-----

--wpdtdu2hz4uf3vkp--
