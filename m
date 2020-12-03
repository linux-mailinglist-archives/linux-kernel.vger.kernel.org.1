Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273202CCD39
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 04:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgLCDRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 22:17:38 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:38813 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726276AbgLCDRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 22:17:38 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0BD92580307;
        Wed,  2 Dec 2020 22:16:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 02 Dec 2020 22:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=c
        gJ/TsRJBaRDzx8MdnyAEwfSEaMJToTmA0O7gCafcTg=; b=kWKxhUbIGL1Mh5BP4
        WUaGxoGqwK0SulgLE89GuS8Gw0hVrZsr/14vky1h5I8O0kBiZTVCTj9pllJE1asb
        xklBMDuag8IFA0hG+N7fcJROEXnn+ZCBpw18BbTTxmkLzNEZJ8n3o6CC1IwB8Ds5
        52BFWyzEgvEe4b6kst1W94g8HSBWRbroliwla+1mIQ2RjExwoUKGf+rnB+c1h7WV
        R3Bi4k22fcr7a/K/UA4zCkt4x4uuMxyrri0at7aeUKp2utaM8NXolgRHXuiLggC3
        q0n9kjrXS13XKrzvhPkOlMh8LWF1fidI6M07pSFehymonWV96E6UrVgpTMZmciEn
        CA6Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=cgJ/TsRJBaRDzx8MdnyAEwfSEaMJToTmA0O7gCafc
        Tg=; b=ngfYa96K1n1UR+Z8zJr6fAxhSWrVTvLtWDNWNLagIrumaH7iy1cZiRhO6
        ZxbqLL0AUB1Md9gc+KMyelXn3HoOgZKQIgt6n8/n/UZBwDSiLO6EmDjeehDThgK8
        exCavdWzSXUfDYliRbRRgDIXWijFwnnM5InSG4uKmZQIhsowFMKVo0AxojUTKPvC
        8IZop6aqxnttc9GRenKnTByaBZ/mRgVDlYAYNVTb3oLHcqbr47eq16K0/QnpnZ4/
        p38GmBxM034fG37hpio3th7hTH6RWDgDnj+JQnPp5AzYzPmu60JdLW+m1wTjcf7T
        GWQOonESiJaL6vgi9tM9V3u375OVw==
X-ME-Sender: <xms:oljIX8PO3xLbWXMaLJpXW_9RzOFasMpwOvYC2F6oQjUGcigNfg0--A>
    <xme:oljIX5_7ADb7mPzKkjBzthhTv2THi33KASiqPRxrVNjZkHIFpZYJEp3e17C-N5mY2
    4dtMpxwnY2Kptn6jw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeihedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:oljIX4QK-ib49kfpTb8WJ3ysmP2yQv6Rl-rARwnqMA9Wa0C8GgHl3A>
    <xmx:oljIXzkguUDgyX_40cuKIPhlsNJO9pCiM1RKmvD2oQxQ49dBTtVLFQ>
    <xmx:oljIXwQkk7FV8bNocrcI6AS3jam4cywOv7c61hr6ic7NyI7_n1TRcA>
    <xmx:pFjIX_MZKWi2lcvvNoktCxeVNeiwoC9iXdHiD4Wydtl8zTJE7IArIg>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4E01E24005E;
        Wed,  2 Dec 2020 22:16:50 -0500 (EST)
Subject: Re: [PATCH 7/8] arm64: dts: allwinner: Add Allwinner H616 .dtsi file
To:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Rob Herring <robh+dt@kernel.org>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Yangtao Li <frank@allwinnertech.com>,
        linux-arm-kernel@lists.infradead.org
References: <20201202135409.13683-1-andre.przywara@arm.com>
 <20201202135409.13683-8-andre.przywara@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <3b4f4bf6-2fba-5d35-bdf5-74b8ced10357@sholland.org>
Date:   Wed, 2 Dec 2020 21:16:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201202135409.13683-8-andre.przywara@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andre,

On 12/2/20 7:54 AM, Andre Przywara wrote:
...
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x0 0x0 0x40000000>;
> +
> +		syscon: syscon@3000000 {
> +			compatible = "allwinner,sun50i-h616-system-control",
> +				     "allwinner,sun50i-a64-system-control";
> +			reg = <0x03000000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			sram_c: sram@28000 {
> +				compatible = "mmio-sram";
> +				reg = <0x00028000 0x30000>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 0x00028000 0x30000>;
> +			};
> +
> +			sram_c1: sram@1a00000 {
> +				compatible = "mmio-sram";
> +				reg = <0x01a00000 0x200000>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 0x01a00000 0x200000>;
> +
> +				ve_sram: sram-section@0 {
> +					compatible = "allwinner,sun50i-h616-sram-c1",
> +						     "allwinner,sun4i-a10-sram-c1";
> +					reg = <0x000000 0x200000>;
> +				};
> +			};
> +		};

You mentioned that you could not find a SRAM A2. How were these SRAM ranges
verified? If you can load eGON.BT0 larger than 32 KiB, then presumably NBROM
uses SRAM C, and it is in the manual, but I see no mention of SRAM C1.

Cheers,
Samuel
