Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E59297087
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 15:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464864AbgJWNbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 09:31:11 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49217 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S464855AbgJWNbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 09:31:10 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 560E15C006E;
        Fri, 23 Oct 2020 09:31:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 23 Oct 2020 09:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=gBX1SOcRIpyKDdvmJu7Rn4Ykp1G
        Z6AGptc0Us6mPswE=; b=Tsi8PhOjTFGPhbcPWvprdgSb72FDYjNm+K6FJkDRSMo
        CCH7lIV8soY6BY+QAdwZd1bb3M/Hs9cceIGB+yiVhkGUfm859c3TyNwwk+xeCAbo
        2oDQb+smK+pVu4qrx/SUgfdh9XWlSSIYCAC4njNersoBLxOo3eN1Xoeaho4g2YkE
        MTYItE8TYqlGUI/cUJnKocy7Tq2JaTUGrPUzSB5Gt+h/R+n3WxsioBH7L8sZ91t4
        4ypyqNgKcFRzy2cM+u+CA8YP9iVm+AlnU/FgwYW8cEbmHwsBkdsyFSwYEPXlE+Q4
        DKvrDhOiPLUAK5UW4sxz8CFqSw2c/QRGiZKrRbRgumg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=gBX1SO
        cRIpyKDdvmJu7Rn4Ykp1GZ6AGptc0Us6mPswE=; b=DsjmaFLW31p2xH3ZHtDin+
        WjGB50VRd87dbDF3UubacWucYhJdMSlfNdnosrqCmatzJBUU9SZHa4eQmD6x84IM
        SAW2qvhwRNTbYsTgrzdzfQw00aTCZIfsN5iG60qQHj3hNEOL4YHB3Y2CA4nFmKE6
        IRpLpLCUeKhrOUh1cITp5qytiR0dNjNPE15jCp/VnZx/wXzwU0nSvFx5RQ/DRD41
        t0FMeZjmic5YN+C6oK7ufWz2H6Ql8BDjeWv1k+CFO5t/4omjPPmZQWS+isBIEN6Z
        6KdAH3RegonDYvxHGPwmiEr+0yW6BGA6fY/6Ycnl8otyEiZgJSP06E+rvg1+eU6g
        ==
X-ME-Sender: <xms:HNuSXyovqGuvfevz9G_UkdRU7VbnpwdOLopiFAttnu4hKFrmATtUVA>
    <xme:HNuSXwrtqR-pMFXc1ZTipGPj4yB27KxuR1rsYWEauiAhoPRvMU3PRhjMrzHMTCHyh
    oTGDr9EtSCrk7kvt28>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrkedtgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghr
    nhhordhtvggthheqnecuggftrfgrthhtvghrnhepleekgeehhfdutdeljefgleejffehff
    fgieejhffgueefhfdtveetgeehieehgedunecukfhppeeltddrkeelrdeikedrjeeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimh
    gvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:HNuSX3NB6U4erW5VYSxt2ElRQs9E1wmWnLwuNfRQzjij5kfPPfIOvw>
    <xmx:HNuSXx6cBX9xY3OD5TpIkJQewv06IsFBXzOLls3S48u7MeA6BM3oIA>
    <xmx:HNuSXx4xkksz606dMGhPNsMBhX9zAQjsKBGnlocflUvRMxwoHa44jg>
    <xmx:HduSX7kKsyDkvo2VvRZ0An9AUUEJBITsWiFaAT1q99OfuVUuQJGG1w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5862D3280059;
        Fri, 23 Oct 2020 09:31:08 -0400 (EDT)
Date:   Fri, 23 Oct 2020 15:31:07 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Yu-Tung Chang <mtwget@gmail.com>
Cc:     robh+dt@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ARM: dts: sun8i: add FriendlyArm ZeroPi support
Message-ID: <20201023133107.mx4nwnqzvufuxacl@gilmour.lan>
References: <20201023090908.10659-1-mtwget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kmdrk2jofrm56os3"
Content-Disposition: inline
In-Reply-To: <20201023090908.10659-1-mtwget@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kmdrk2jofrm56os3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for your patch

On Fri, Oct 23, 2020 at 05:09:08PM +0800, Yu-Tung Chang wrote:
> The ZeroPi is another fun board developed
> by FriendlyELEC for makers,
> hobbyists and fans.
>=20
> ZeroPi key features
> - Allwinner H3, Quad-core Cortex-A7@1.2GHz
> - 256MB/512MB DDR3 RAM
> - microsd slot
> - 10/100/1000Mbps Ethernet
> - Debug Serial Port
> - DC 5V/2A power-supply
>=20
> Signed-off-by: Yu-Tung Chang <mtwget@gmail.com>
> ---
>  .../devicetree/bindings/arm/sunxi.yaml        |  5 ++
>  arch/arm/boot/dts/Makefile                    |  1 +
>  arch/arm/boot/dts/sun8i-h3-zeropi.dts         | 69 +++++++++++++++++++
>  3 files changed, 75 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-h3-zeropi.dts
>=20
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documenta=
tion/devicetree/bindings/arm/sunxi.yaml
> index efc9118233b4..9392a9a3f7e7 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -246,6 +246,11 @@ properties:
>            - const: friendlyarm,nanopi-neo-plus2
>            - const: allwinner,sun50i-h5
> =20
> +      - description: FriendlyARM ZeroPi
> +        items:
> +          - const: friendlyarm,zeropi
> +          - const: allwinner,sun50i-h3
> +
>        - description: Gemei G9 Tablet
>          items:
>            - const: gemei,g9
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 4572db3fa5ae..f05e54257947 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1187,6 +1187,7 @@ dtb-$(CONFIG_MACH_SUN8I) +=3D \
>  	sun8i-h3-orangepi-plus2e.dtb \
>  	sun8i-h3-orangepi-zero-plus2.dtb \
>  	sun8i-h3-rervision-dvk.dtb \
> +	sun8i-h3-zeropi.dtb \
>  	sun8i-h3-emlid-neutis-n5h3-devboard.dtb \
>  	sun8i-r16-bananapi-m2m.dtb \
>  	sun8i-r16-nintendo-nes-classic.dtb \
> diff --git a/arch/arm/boot/dts/sun8i-h3-zeropi.dts b/arch/arm/boot/dts/su=
n8i-h3-zeropi.dts
> new file mode 100644
> index 000000000000..388ad6b6da2b
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-h3-zeropi.dts
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2020 Yu-Tung Chang <mtwget@gmail.com>
> + */
> +
> +#include "sun8i-h3-nanopi.dtsi"
> +
> +/ {
> +	model =3D "FriendlyARM ZeroPi";
> +	compatible =3D "friendlyarm,zeropi", "allwinner,sun8i-h3";
> +
> +	aliases {
> +		ethernet0 =3D &emac;
> +	};
> +
> +	reg_gmac_3v3: gmac-3v3 {
> +		compatible =3D "regulator-fixed";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&gmac_power_pin_nanopi>;
> +		regulator-name =3D "gmac-3v3";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		startup-delay-us =3D <100000>;
> +		enable-active-high;
> +		gpio =3D <&pio 3 6 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +&ehci0 {
> +	status =3D "okay";
> +};
> +
> +&ohci0 {
> +	status =3D "okay";
> +};
> +
> +&pio {
> +	gmac_power_pin_nanopi: gmac_power_pin@0 {
> +		pins =3D "PD6";
> +		function =3D "gpio_out";
> +	};
> +};

You don't need that node, it's going to be done automatically with the
GPIO you defined earlier.

> +&external_mdio {
> +	ext_rgmii_phy: ethernet-phy@1 {
> +		compatible =3D "ethernet-phy-ieee802.3-c22";
> +		reg =3D <7>;

That address doesn't match the unit-adress in the DT node name.

> +	};
> +};
> +
> +&emac {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&emac_rgmii_pins>;
> +	phy-supply =3D <&reg_gmac_3v3>;
> +	phy-handle =3D <&ext_rgmii_phy>;
> +	phy-mode =3D "rgmii";

Have you tested the network with the 5.9 kernel? There's been a lot of
DT broken due to a change in the PHY setup.

Maxime

--kmdrk2jofrm56os3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX5LbGwAKCRDj7w1vZxhR
xVxCAQDKEjT6V5CPsm03GS/W3DYu1F/BrunJ2Yt8mIlGVhF2TAD9GjG6UZ97/LTq
DOXlwEm1uWsYhvXTAUYiLCS8Rv1h8A0=
=DoFu
-----END PGP SIGNATURE-----

--kmdrk2jofrm56os3--
