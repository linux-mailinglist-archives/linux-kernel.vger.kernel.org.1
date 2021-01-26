Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECEF303C9C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392447AbhAZMJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:09:54 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:57723 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392375AbhAZMJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:09:05 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 380BF580A39;
        Tue, 26 Jan 2021 07:07:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 26 Jan 2021 07:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=QUyt3/dgldt/tdvZh/hG8wZxPsW
        OAv/sd+Q9HBtink4=; b=CUlZZuUqT9na2warOael0n3m/sQ6j67n+/Xf96ffQTY
        MCe4AWVc2df9apfHPSUqnIpbvvzTyZTO6wVbBg4rdHyPr37zFHXAl+b05oAGTIYn
        dFELdzHJ8Br9tMGrUxvxH9ekjVDkqMyxUmaHd/utOj1Hwk252Z/u0ETyPSnXG45D
        it/ZnxpQabfvRpVaPLIvjPIi/nQ3xn8g/qsWFfEf1uD4fGtCwpRSp2Aw+Fm+gWkd
        AFgZOtYlvBYzTZ6OH/s8IFz8eSTXqCFf39qZvmiGen8vFlTYJGvl/NjnoUXT1t/M
        xzTVtv27diRd8tdxZRvOqGuXKw7chf3/5lna0K1PsPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=QUyt3/
        dgldt/tdvZh/hG8wZxPsWOAv/sd+Q9HBtink4=; b=S2Xi5goCCcYnHAwgIpUoO3
        5j+fyOpBXUT6C+b7apejORRYO6TYvVFwoCGWwm8q+PXe746s1sbTj50EtX33rfeS
        k8npb20ijpREk7gK4Jr41JjLI4b3c3MU2tN0eAOdCUgq//CIkiKvDvhhYNPuEvyH
        IzzC6+GfzdvlmnuekgXFlMVbRVUHvTwzgzRwMEjBsffdn+qdCzrkZ98vbe7onVGh
        qfHiqZARV2ZLIoHPnPJ9dI3+0JGHGveE0gpLfxxzUBu2H6ttNNW5e8EO7AcjhrSt
        q+mt+Wp/WC1wszwg54isSEX1I3VTKaYfrVd6bWiXOVRCGKWTum/DgdlY8e12I2ng
        ==
X-ME-Sender: <xms:FgYQYMWOijkffGRz63lFfbGVDKsVf2kALPJbflaIbRVuSmeUbImuQQ>
    <xme:FgYQYAnk1bfMpNHIh8rFgI3FTJISbDqEQDsXLRVaIrIBX1c2h_2cbF7yJPDibbfhS
    FxkZrFdo-9h6joh8HY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:FgYQYAaGnm6iTGYV6YH_phRzAXMtkRTLkbmvJdrb40MgAoOefENDAQ>
    <xmx:FgYQYLXgU4x7u6iZhfQs_itqoIGkH7u_HKeP8_fw7aBPBvjqJ6M3Iw>
    <xmx:FgYQYGkPuXTGzXuS7SZoArS6G1q9zqKRFtkZTMd7bs9Cs6kafwbUCA>
    <xmx:GAYQYIckvcYcrpj2tfUBksyrOJ-0UUA8_uLmr1XQUrX3pcGv9z223g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 72102108005F;
        Tue, 26 Jan 2021 07:07:50 -0500 (EST)
Date:   Tue, 26 Jan 2021 13:07:47 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh@kernel.org>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 00/21] arm64: sunxi: Initial Allwinner H616 SoC support
Message-ID: <20210126120747.zvsk2ttowruemefu@gilmour>
References: <20210125151811.11871-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="utbabqblxcrheixh"
Content-Disposition: inline
In-Reply-To: <20210125151811.11871-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--utbabqblxcrheixh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 25, 2021 at 03:17:50PM +0000, Andre Przywara wrote:
> Hi,
>=20
> an update from the v3 last week, to add support for the Allwinner H616
> SoC. Still based on the (updated) sunxi/for-next branch.
> I am omitting the MMC and pinctrl patches now, as they have been taken
> by Ulf and LinusW already into their trees.
>=20
> I addressed the comments from the list, though not sure if the HOSC clock
> coming from the RTC is really a good idea (didn't change it).
>=20
> I was hoping that at least the clock and AXP patches (01/21-06/21) could
> make it into 5.12 still? That would allow booting boards from SD card.
> I am happy to strip the .dtsi and .dts patch to only contain the devices
> that we actually support then, if needed.
>=20
> For the changes: I split the joint DT bindings patch into subsystem
> specific ones, hopefully this simplifies merging. There is a new fix
> for the axp20x-pek driver, and the AXP IRQ fix has been amended as well
> (according to Samuel's comments).
>=20
> I eventually got USB to work, by requiring PHY 2 for [EO]HCI 1 & 3 as wel=
l.
> Not sure this is the right fix, it might be just one clock or reset
> line from that PHY that is needed for the others as well. Will do further
> experiments.
>=20
> For a more detailed changelog, see below.

With your series applied:

ARCH=3Darm64 make -j18 dtbs_check =20
arch/arm64/Makefile:25: ld does not support --fix-cortex-a53-843419; kernel=
 may be susceptible to erratum
arch/arm64/Makefile:33: LSE atomics not supported by binutils
arch/arm64/Makefile:44: Detected assembler with broken .inst; disassembly w=
ill be unreliable
  DTC     arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dtb
  DTC     arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dt.yaml
  CHECK   arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dt.yaml
/home/max/Work/allwinner/build/arm64/arch/arm64/boot/dts/allwinner/sun50i-h=
616-orangepi-zero2.dt.yaml: clock@3001000: clocks: [[7], [8, 0], [8, 2]] is=
 too long
	From schema: /home/max/Work/repos/linux/Documentation/devicetree/bindings/=
clock/allwinner,sun4i-a10-ccu.yaml
/home/max/Work/allwinner/build/arm64/arch/arm64/boot/dts/allwinner/sun50i-h=
616-orangepi-zero2.dt.yaml: clock@3001000: clock-names: ['hosc', 'losc', 'i=
osc'] is too long
	From schema: /home/max/Work/repos/linux/Documentation/devicetree/bindings/=
clock/allwinner,sun4i-a10-ccu.yaml
/home/max/Work/allwinner/build/arm64/arch/arm64/boot/dts/allwinner/sun50i-h=
616-orangepi-zero2.dt.yaml: ethernet@5020000: compatible: 'oneOf' condition=
al failed, one must be fixed:
	['allwinner,sun50i-h616-emac', 'allwinner,sun50i-a64-emac'] is too long
	Additional items are not allowed ('allwinner,sun50i-a64-emac' was unexpect=
ed)
	'allwinner,sun8i-a83t-emac' was expected
	'allwinner,sun8i-h3-emac' was expected
	'allwinner,sun8i-r40-emac' was expected
	'allwinner,sun8i-v3s-emac' was expected
	'allwinner,sun50i-a64-emac' was expected
	'allwinner,sun50i-h6-emac' was expected
	From schema: /home/max/Work/repos/linux/Documentation/devicetree/bindings/=
net/allwinner,sun8i-a83t-emac.yaml
/home/max/Work/allwinner/build/arm64/arch/arm64/boot/dts/allwinner/sun50i-h=
616-orangepi-zero2.dt.yaml: clock@7010000: clocks: [[7], [8, 0], [8, 2], [2=
, 4]] is too long
	From schema: /home/max/Work/repos/linux/Documentation/devicetree/bindings/=
clock/allwinner,sun4i-a10-ccu.yaml
/home/max/Work/allwinner/build/arm64/arch/arm64/boot/dts/allwinner/sun50i-h=
616-orangepi-zero2.dt.yaml: clock@7010000: clock-names: ['hosc', 'losc', 'i=
osc', 'pll-periph'] is too long
	From schema: /home/max/Work/repos/linux/Documentation/devicetree/bindings/=
clock/allwinner,sun4i-a10-ccu.yaml
/home/max/Work/allwinner/build/arm64/arch/arm64/boot/dts/allwinner/sun50i-h=
616-orangepi-zero2.dt.yaml: rsb@7083000: compatible: 'oneOf' conditional fa=
iled, one must be fixed:
	['allwinner,sun50i-h616-rsb', 'allwinner,sun8i-a23-rsb'] is too long
	Additional items are not allowed ('allwinner,sun8i-a23-rsb' was unexpected)
	'allwinner,sun8i-a23-rsb' was expected
	'allwinner,sun8i-a83t-rsb' was expected
	From schema: /home/max/Work/repos/linux/Documentation/devicetree/bindings/=
bus/allwinner,sun8i-a23-rsb.yaml
/home/max/Work/allwinner/build/arm64/arch/arm64/boot/dts/allwinner/sun50i-h=
616-orangepi-zero2.dt.yaml: leds: led-0:default-state:0: 'on' is not of typ=
e 'array'
	From schema: /home/max/Work/repos/linux/Documentation/devicetree/bindings/=
leds/leds-gpio.yaml

The last one is not related to your changes, but the rest must be fixed

Maxime

--utbabqblxcrheixh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYBAGEwAKCRDj7w1vZxhR
xbxpAQDooyOVFcH4ZlnmKmIr4Hg45/fF9O/ZV1zEFvo3ZcFFZAD9FwRA3PdXfre3
DVXOHitaJv66Rp26yVrBxBb0/cJvQQ0=
=KFyx
-----END PGP SIGNATURE-----

--utbabqblxcrheixh--
