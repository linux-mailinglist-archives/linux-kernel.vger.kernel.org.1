Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0882D95AD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 11:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391257AbgLNJ74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 04:59:56 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:37111 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389596AbgLNJ7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 04:59:40 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3CA3A5803BB;
        Mon, 14 Dec 2020 04:58:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 14 Dec 2020 04:58:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=tJ2pBUOM7HX4mNiASke0sXCrwwH
        JFY+XjGMRsMytx4k=; b=DptJaIkFb6xX4pJjpS++AJfUOg/jdt9emOQbsI3Uepg
        bTujXaxpsN6t0DWiut47wtx6uy+Zo/m4gkdHCHJqU+Ozk9ulgUAqS7GCtMwsLY2i
        +vEBZmgnV4IpLjzk5W2G0IJXS8xFLG/T08sRnZAEF8z8O0IEltUaX42d5CsnqohN
        ZhDizDMoFafHstIdgsclQSq19jsi58hgbfB6C1LrGJcs4IWuEOwGTinkOM2d1+uY
        0Sh8LUFM4KwRiMaQUmIONNZs4K1O1DIW+BSSX1EmJmORJPnE3Ce4G811IZ540Jpm
        6Y2HO4jKnutiI1liozirCzueawI2tlbYEkH2OgkKKbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=tJ2pBU
        OM7HX4mNiASke0sXCrwwHJFY+XjGMRsMytx4k=; b=NtuD3qaGRjepmalY9wKp/d
        oarGmSmmpJlbU9+X/NDkxFhbJERI02urR4c1N2RjoZMZGWhuCTpMaO8ZFQZPbWyZ
        koP0p7yI/xgQa40AJ6jvc10kal6gSSNYGG6Q3dPYa14zPh5HuJjh19zk5JtZ5CrS
        J++slUPo0KVX7sTXLkLF5ilQCYfw0jEAyc7whxFniN/cjTfQ85sp7LRgADHounWB
        81quNb94cBc0v8KmiTWfxZ64pxapbv86djal1OpiaQGcTv6QlJsU0baWHjkfbmih
        pjS05JlIe1DZ9MnIrns95PuASYKBKsCONfAaNYtEtx6Vf+N6QuFV2mls36vpa1kQ
        ==
X-ME-Sender: <xms:SDfXXxFrwWun1pEriALHay9upJXzeqqTR1nqACxMQr04RWowDfTVMA>
    <xme:SDfXX2X4LWGIj8VNdOsyC99J6Xj0gm5W89K8wfeMJsy7S6wE48RMqT74qTwiZ-ePV
    Fc-ytoKTtH5wDiKSxI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekkedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:SDfXXzLZOTiVmtZLZx7Qd4-1TCxTJzt_cy1XJRNDQJi7PFC9w9DpqA>
    <xmx:SDfXX3HSv8Qi1n8BRUXeQ9G3E2nyZQ7r1FAkxa14Jh04DnIjisXcyQ>
    <xmx:SDfXX3XkLVcBDw2JNJ4y-gt9ApBznxIRO7QPxRdUmfyP2GQMSw5h-g>
    <xmx:SjfXXwN-2nMVPjSCpcRQyVWsUXDPqG3r-qBIL-30ZswIGPzQSIQ0qg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7A7891080067;
        Mon, 14 Dec 2020 04:58:32 -0500 (EST)
Date:   Mon, 14 Dec 2020 10:58:31 +0100
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
Subject: Re: [PATCH v2 19/21] arm64: dts: allwinner: Add Allwinner H616 .dtsi
 file
Message-ID: <20201214095831.j63nks3fqxlaw75w@gilmour>
References: <20201211011934.6171-1-andre.przywara@arm.com>
 <20201211011934.6171-20-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jmg23eet7qynkol6"
Content-Disposition: inline
In-Reply-To: <20201211011934.6171-20-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jmg23eet7qynkol6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 11, 2020 at 01:19:32AM +0000, Andre Przywara wrote:
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* 512KiB reserved for ARM Trusted Firmware (BL31) */
> +		secmon_reserved: secmon@40000000 {
> +			reg = <0x0 0x40000000 0x0 0x80000>;
> +			no-map;
> +		};
> +	};

This should still be set by the firmware

> +		mmc0: mmc@4020000 {
> +			compatible = "allwinner,sun50i-h616-mmc",
> +				     "allwinner,sun50i-a100-mmc";
> +			reg = <0x04020000 0x1000>;
> +			clocks = <&ccu CLK_BUS_MMC0>, <&ccu CLK_MMC0>;
> +			clock-names = "ahb", "mmc";
> +			resets = <&ccu RST_BUS_MMC0>;
> +			reset-names = "ahb";
> +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&mmc0_pins>;
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};

Somewhat related: we shouldn't set the MMC speed flags in the drivers.
This is biting us on the already supported SoCs, so it would be great to
not repeat the same mistake with the new ones

Maxime

--jmg23eet7qynkol6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX9c3RwAKCRDj7w1vZxhR
xXu0APoConMhf8h8N9MOCajqUe5V9OCrgurcic0u5jtok4MyqwD/Rf2JY8Z+NPZ1
4Hpj8og3koEatyEEARPelpEgEOUaHAk=
=p8vW
-----END PGP SIGNATURE-----

--jmg23eet7qynkol6--
