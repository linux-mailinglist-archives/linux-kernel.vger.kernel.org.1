Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815AA2C26FA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387889AbgKXNTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:19:39 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60625 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387656AbgKXNTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:19:39 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 69E395C01F1;
        Tue, 24 Nov 2020 08:19:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 24 Nov 2020 08:19:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Liv2Tg4dxwWGDAPx6JYe8qYxq0e
        OHM4KZCyMPZMi0KY=; b=jlZAg0W/pQbbtd8Y/9yhQJlmnrFj4otpRIbrsfxkh6p
        WfVE+3NZbY4Zi2RY76IiIytkj7MtPjdeQHkHX5sVK7Jtg1Zmngdg37BYpzRnMCSD
        cokcK42XnTyDwbvmeeqNCMAAl3B7WgraRbQoaqN1yNVoXWe7UxmiYic8iG9fqGZE
        DyS6HnA387WKrzmK8uzGzNijxyEE5RkRUzzMV+vVetCvsfiT0j7sqBd2tT+AWEoP
        G+mIolLmZ2ewf4aX+nO/97rK02qPcy/kzcQEwy6yNan9AQHRssvLSJMyw1/6AElw
        BJtyNtfQ4erunm/pw3HGfc/BlPp3/8A76sn1UurxMNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Liv2Tg
        4dxwWGDAPx6JYe8qYxq0eOHM4KZCyMPZMi0KY=; b=V3dHCI2zwwdaBUGIg/CVl2
        AX4fTERUgTwrAml1bMsutKiI7truHRnXkJ0Kbuf6WUoaML6oqrX/GiHHT9suupup
        ipu9q8KvjWpeN7XpSFkn5NladPRH8dgF4y2VSlDx+EzdlFHtj0LdHW4GeWqXtyQ8
        FzznaaAW0XAF+rfai8xLo6cHlnmvV6UZQFbzolRMLLfO5HGikTMkrpgp2eyGn9Ej
        hd/TNpA8EaDUFkBdFtMSA4pwMbRrzYWxHBFbDaISrWsY+iU+CzucqBRpIvlmvcqg
        JlWVeO6kkUSFz2h03jsoBdmSe5EVZIIn1tNbFJ0yMwoJcH0OGvTikJJi+yfnjSDQ
        ==
X-ME-Sender: <xms:Zwi9X9VJ267v5jJiLzdfw-cnwMwPZv6sfaD4triSesIyB88fpRdQSg>
    <xme:Zwi9X9npBYYpbn6AAbqQRewj9EEqHGVf54FUbksLz6k-iFGc5txK9heTUmCSUGWzY
    hG7lz4C9VtWsOU9NKo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegkedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:Zwi9X5bfCRrWXMGN8jET96r1eGmtojhiUZeZwZQFIwdtcc7SPV8JpQ>
    <xmx:Zwi9XwVjQGyW6uWbapjJ80h5q3-HiYijpaU21oPdgK1QBE0Jrm7L_g>
    <xmx:Zwi9X3lrQMsAbsh2cEBRUDTF8e-BfhAXcMUjfh2_1X610UBE-0gFIw>
    <xmx:aQi9X1ie_gp1lD6nDxcqJRx2RzEiAzGKAvgtittUXD8WkL1WxheBFg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 42B663064AA7;
        Tue, 24 Nov 2020 08:19:35 -0500 (EST)
Date:   Tue, 24 Nov 2020 14:19:33 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Michael Klein <michael@fossekall.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add
 gpio-poweroff to DT
Message-ID: <20201124131933.2l2go6z6ltar5fpa@gilmour>
References: <20201123161041.2304766-1-michael@fossekall.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x7hbwfpmtn6n7ith"
Content-Disposition: inline
In-Reply-To: <20201123161041.2304766-1-michael@fossekall.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x7hbwfpmtn6n7ith
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2020 at 05:10:41PM +0100, Michael Klein wrote:
> Add gpio-poweroff node to allow the board to power itself off after
> shutdown by disabling the SYSTEM and CPUX regulators (U5 resp. U6).
> The RST button can be used to restart the board.
>=20
> Signed-off-by: Michael Klein <michael@fossekall.de>
> ---
>  arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/=
arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> index 4c6704e4c57e..76e79e6db733 100644
> --- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> @@ -46,6 +46,11 @@ sw4 {
>  		};
>  	};
> =20
> +	gpio_poweroff {

DT nodes are not supposed to have an underscore in their name. The name
should also be the class of the "device", so I guess we can simply use
poweroff here?

Maxime

--x7hbwfpmtn6n7ith
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX70IZQAKCRDj7w1vZxhR
xTcMAQCA8sFX9ljONbPtxXUKdTcSQ5qw9fZ+ZDyOBsCJUsCEIwEAq6XHTlqg9VAj
8ShG1OQrzL5I9RbtA50e2zzulQ/3ZQY=
=nl/w
-----END PGP SIGNATURE-----

--x7hbwfpmtn6n7ith--
