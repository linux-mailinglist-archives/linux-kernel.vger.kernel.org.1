Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740602D95B4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 11:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403999AbgLNKBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 05:01:01 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:49861 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2395296AbgLNKAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 05:00:30 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 389305803BB;
        Mon, 14 Dec 2020 04:59:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 14 Dec 2020 04:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Zm8fI/GIZTZFYW1XBru+AWNOaHd
        6WmZmVXBg1GcD0gA=; b=jhK7Q6JB38iqE9wa9fN44p46Sc5heME6pJsafCuweEt
        0KHDmXPw5oAJhrvlRoLyLcJz/xqR3FUqrWAEjLTqqkvGpKHYRFyPelSCBH6gYFsH
        6OsQ2Wp7q1Qv8I+o58K7FR2RGzstSEF9pxeDTvDcVrJuGaU6tFBnRAfckWivY7Eu
        pFUxE8ZvG8UB7L3aYVoj2sH4Ge6mULVzoll7iPUKHYd3JCqS/nMalqhQMYdmay+R
        BsbZhN2GfNUKcxpnqqoTZ3wSDOjG3V0kqCbAYIADyNpBcCqaVRuVy4RtqCzXMhXD
        gx+Jq//IzlEm74V1WZBK8uvNXg83IsFdrYuqDJdXV3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Zm8fI/
        GIZTZFYW1XBru+AWNOaHd6WmZmVXBg1GcD0gA=; b=YRROqARC4Os10bAiOkTyjm
        OlbtKDrwbNFz2VVXcEqPYgOCSisy8lZ+6DUoEg7Pyu294cXaplpI6CS/wbVdtXgV
        A17dCFRDX34EPTO7Sxzhrok0z2N4W2j0nYH2Zs3X84L3TJe1WPxSCheEdO0mh2Cu
        RC2xotUIQD8XGXSE2vh6KIqW+eYg2awLZ5OTaZaW1okA2U5xgrkdtBfDcLgrxurS
        WIgwCJFq8LNQFs6NF7nvsgF1W9j56o5yWFDHkMPxyWMZf1GNkmd9d08KCVpoLqeF
        srAvNqawHfNDnIyxhYKTROdaNA+V/eK9kMwfroFN3cDYGuNJdZIdVYFahfMlx3KQ
        ==
X-ME-Sender: <xms:kDfXX0PZmcHnxGgu3yqBp5dtHlAWU5G0MXDVEdnTCjCBE12wFD1GcA>
    <xme:kDfXX6_PbVMNzRshoaCmWwO5dy6fVDIN7shW--xfIsW5hvr3Q9XnQ4lL_LDoeCoj2
    DMFolTszMXCGikuBHs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekkedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnheptdfggfelgeehieeuieegfefgueduudefheffhfejleekheefjeevveegueel
    ueefnecuffhomhgrihhnpehlihhnuhigqdhsuhhngihirdhorhhgnecukfhppeeltddrke
    elrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:kDfXX7T_DF2z63b7T9anxAfspXKkHF6TyNVbm5wlyJuDeITMJ3d0Tg>
    <xmx:kDfXX8sDGGMAZilzNg8iynU6Hj3OX7Ui1hxu9Rq47agAUaYLc6Fy2Q>
    <xmx:kDfXX8fDCYoiOlS6mbSgG2bO0DjUWP43slAfO09382Ws-NRA9gljiQ>
    <xmx:kDfXX9XVlAZGllqLDgx8p-6gSE9Cj0dnULzwpP_wvJg_eusNLb4nEA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C380924005E;
        Mon, 14 Dec 2020 04:59:43 -0500 (EST)
Date:   Mon, 14 Dec 2020 10:59:42 +0100
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
        linux-sunxi@googlegroups.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 21/21] arm64: dts: allwinner: Add OrangePi Zero 2 .dts
Message-ID: <20201214095942.fjtml5teo2jfvh6z@gilmour>
References: <20201211011934.6171-1-andre.przywara@arm.com>
 <20201211011934.6171-22-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7qi4u6c7kyjxats2"
Content-Disposition: inline
In-Reply-To: <20201211011934.6171-22-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7qi4u6c7kyjxats2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 11, 2020 at 01:19:34AM +0000, Andre Przywara wrote:
> The OrangePi Zero 2 is a development board with the new H616 SoC.
>=20
> It features the usual connectors used on those small boards, and comes
> with the AXP305, which seems to be compatible with the AXP805.
>=20
> For more details see: http://linux-sunxi.org/Xunlong_Orange_Pi_Zero2
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../allwinner/sun50i-h616-orangepi-zero2.dts  | 240 ++++++++++++++++++
>  2 files changed, 241 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-ze=
ro2.dts
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts=
/allwinner/Makefile
> index 211d1e9d4701..0cf8299b1ce7 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -35,3 +35,4 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-orangepi-one-pl=
us.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-pine-h64.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-pine-h64-model-b.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-tanix-tx6.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h616-orangepi-zero2.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts=
 b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> new file mode 100644
> index 000000000000..2afc036059b4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2020 Arm Ltd.
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h616.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/leds/common.h>
> +
> +/ {
> +	model =3D "OrangePi Zero2";
> +	compatible =3D "xunlong,orangepi-zero2", "allwinner,sun50i-h616";
> +
> +	aliases {
> +		ethernet0 =3D &emac0;
> +		serial0 =3D &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	leds {
> +		compatible =3D "gpio-leds";
> +
> +		power {

This isn't a valid node name

Maxime

--7qi4u6c7kyjxats2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX9c3jgAKCRDj7w1vZxhR
xa5JAP4iYeTuoCCPFOMTBGZLTaSADUxWwnzDCGgNRv28T5pdZQD/VlM0WJdUav+d
D8y/kY7jcFPSHNRqoD3enXhzxXLsbAg=
=yiW1
-----END PGP SIGNATURE-----

--7qi4u6c7kyjxats2--
