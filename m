Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC04B2A27B2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgKBKFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:05:44 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:43369 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728004AbgKBKFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:05:44 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 7D189E0E;
        Mon,  2 Nov 2020 05:05:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 02 Nov 2020 05:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=o8atrN0t4aj6oEDJHVTGVDQjWGF
        wZfrP0qvx6wTWTX0=; b=McSklZHmP8bMXpER927mdNi4lNMcE6YNiLriMFk053t
        OqvNLmhtbmWsl9zxYX7DKy8bLPkD9UiGlsQuV5TP2ImuKpkFSwLE8/gERviyf7U6
        boK80Psk/6gciPQ2ABxfH6y5M7QDK7Kqc3sV+riafua+wIo1JKCsPG2GlZZgHJXE
        B3yM5isQrQWFvcfFxBdf4y7cZBC3A/OXbQVa6fMANZeqXIM7l/N89/aSech3YDsk
        Tc6xZ25QYo5zZUcOC6+mUwz7unhxU64ZtGASI39x43jXGkYdf86JEinfosGif5AT
        JNo4QhL8OLqiO/9jnr0R4eDKNNYV22BB7utoc21uxJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=o8atrN
        0t4aj6oEDJHVTGVDQjWGFwZfrP0qvx6wTWTX0=; b=fmbD3JybVv0JowbaTXSI/8
        /1zLPQwZZWDmR83VKyQ9Y+BdLwGABAbgL/+QhyKzX5T4MPx3arj0OsnCF2wQ/yhu
        MXDTFzrcsCtz8mvTRM00/ewrAc1lVWHKGsKVaJXgUD+dy4GHV4rlh26jdzc9YhBM
        okFW0wFXAd7utW13qyIosz6G/bFvDX57fl5qQo4uOQUTUAv0i/UrCulYTDvH2imL
        sdh8jspM0J2VmrlarD+NNCZghoiwstAq9Z223nTDe0NUDAgYbmSc3BbI7ifZ4VPy
        SRhHR0504FKlMynRJGMYPQflp/gZFQzLtXVwKF2BLI45f0GXbt1Nzs5kQ4strf+Q
        ==
X-ME-Sender: <xms:9tmfXyCQ_pdNuM5ceNElW3KckNsJoXLhD13f1-Is9uMYzxoTXwuuAw>
    <xme:9tmfX8g5VlJggF6XFM0ZgR1TdPc1X8vp9OtLt0J3fywz-7TW0nqbnwKn8T2jrqxAP
    764TX1TtMhNEnqPAmk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtuddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:9tmfX1miYDKCvB7vQiIS7J79u2tF0Nl1CWFUF8WoAOPOW8qrYkRbGQ>
    <xmx:9tmfXwyC8GFh4_asmZPwbRpCYsguOO9KFjhbKsiL07Riw8BhuTFusw>
    <xmx:9tmfX3TrkU-L1pfnuNSbWxGV6NSCn_dfA9GsEA0gv4-_dZEvNqFbwA>
    <xmx:99mfXydzm7NeU4V0q4Fh0aB7AALkoWoAHp57XNgkDdoRc5H8QoNEDw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id DC82A3280066;
        Mon,  2 Nov 2020 05:05:41 -0500 (EST)
Date:   Mon, 2 Nov 2020 11:05:40 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Matteo Scordino <matteo.scordino@gmail.com>
Cc:     wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] ARM: dts: sun8i: s3: Add dtsi for the Elimo
 Impetus SoM
Message-ID: <20201102100540.wkqoy4nilmee7mpv@gilmour.lan>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
 <20201030234325.5865-4-matteo.scordino@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mpawecl3ammwjrw6"
Content-Disposition: inline
In-Reply-To: <20201030234325.5865-4-matteo.scordino@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mpawecl3ammwjrw6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Fri, Oct 30, 2020 at 11:43:22PM +0000, Matteo Scordino wrote:
> The Elimo Engineering Impetus is an Open Source Hardware System-on-Module
> based on the SoChip S3 SoC.
>=20
> It is meant for integration into carrier boards or, more generally,
> larger designs, and uses an M2 connector to facilitate that.
>=20
> Interfaces on the M.2/NGFF 42mm connector:
> WiFi IEEE 802. 11abgn (on-module Realtek)
> Bluetooth 4.2/BLE (on-module Realtek)
> RGB LCD Interface (on-module connector)
> MIPI Camera Interface (on-module connector)
> IEEE 802. 3u Ethernet MAC (external connecto)
> USB2.0 (Host, Device, OTG) (external connector)
> Audio Line In/Out (external connector)
>=20
> Signed-off-by: Matteo Scordino <matteo.scordino@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi
>=20
> diff --git a/arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi b/arch/arm/boo=
t/dts/sun8i-s3-elimo-impetus.dtsi
> new file mode 100644
> index 000000000000..f219188fc9ba
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2020 Matteo Scordino <matteo@elimo.io>
> + */
> +
> +/dts-v1/;
> +#include "sun8i-v3.dtsi"
> +#include "sunxi-common-regulators.dtsi"
> +
> +/ {
> +	model =3D "Elimo Impetus SoM";
> +	compatible =3D "elimo,impetus", "sochip,s3", "allwinner,sun8i-v3";
> +
> +	aliases {
> +		serial0 =3D &uart0;
> +		serial1 =3D &uart1;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +};
> +
> +&mmc0 {
> +	broken-cd;
> +	bus-width =3D <4>;
> +	vmmc-supply =3D <&reg_vcc3v3>;
> +	status =3D "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-0 =3D <&uart0_pb_pins>;
> +	pinctrl-names =3D "default";
> +	status =3D "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-0 =3D <&uart1_pg_pins>;
> +	pinctrl-names =3D "default";
> +	status =3D "okay";
> +};

What is uart1 used for? the BT chip?

Maxime

--mpawecl3ammwjrw6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5/Z9AAKCRDj7w1vZxhR
xcSYAP9CjHK5RugApcMiiaR7FMa/jM5wB1NFVWoM/5r+JdDBmgD/Sj18F1e9yLLo
5RDCl1mSA3StYNgruHOuiz4lqlV8xwg=
=aUoy
-----END PGP SIGNATURE-----

--mpawecl3ammwjrw6--
