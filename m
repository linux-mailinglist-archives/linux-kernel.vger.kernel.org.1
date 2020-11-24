Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C55C2C1C9A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 05:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgKXEOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 23:14:49 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:55211 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728155AbgKXEOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 23:14:48 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C4E3415CD;
        Mon, 23 Nov 2020 23:14:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 23 Nov 2020 23:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=j
        A4ah2CMYgsd377/SA0s2RVNHVfzfBJJzqdBqULdqJ8=; b=G6voIAJ+kzoLQKsB7
        9qvGVriR5E1TG9UNzg0XV80gOiOApQ37SHsDWwNXmrU1N6r8kX1tF5ziZVijvNOY
        4g8AsePgeG6lTiA2zYkVpuZXN1289B/ViYhIcCCUgBsj5UD5jFDjk2mPeAjF0lqD
        mnYIvUPG3SC8g6JtFMeLB4gwybi664nL/wwsFx9TjC1hMuyNcUBVcmZRIlHOtPZU
        v7kXIgoAGBpsoek3C0gSD9Ddgswnx7OMrVYtNuKOwrgkOdSjhS/ikpiJNnWp7qK6
        fwZlqd7tjY5WoCJ1k+eF9UryIODx5Hwg12k6TXQxILlgQrxmkDunnSnQsvAB1SBk
        qJbHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=jA4ah2CMYgsd377/SA0s2RVNHVfzfBJJzqdBqULdq
        J8=; b=mMVsAErgT9rltMMz6YSqFahh7gX/lX7/1SHSkdBp/7fwSEwNCuIAfLz2M
        D/8IpM3IqYOTnX/VpzOuXRiP+i60snN9qVJhYilNqZrfAPdlwzZ15iZ5GXmoj4eO
        oVPvL+0MAfl93XmfiT5EUSHMv+ciKfoWP+odAhjvJ4z1TKFWOEDzxDwJY9E/jY/b
        CzbXi0ugPM6es0eUlvjR7BTZ7jmj4uNoPytDUVnD12Y1ZlgW/pwjsH/R24mkdUYG
        V5csy/ScWDETsZj1ZmzwutgQJtlfsRm8EqkGsDIz40PjmIuwN+RRNzx0IKjwmo41
        ULnxLWIesRx8GAI+IU2Z7lYfkECug==
X-ME-Sender: <xms:toi8Xxl1ziEUtNvwglL9Vi5GWgwBvgI0o7BfmT0uhcMEbrQBrhtQ5A>
    <xme:toi8X81tHssvgWqcuDM43ruge2nrK0fm7ZOANEdhVozsQ9664QvOgyLxfhV89Gfm1
    q7NmL1fcM3LIXPw9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegjedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfhfhffukffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvddttdejieduudfgffevteekffegffeguddtgfefkeduvedukeff
    hedtfeevuedvnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:toi8X3pG98jyQczQWLIVolZZ0thkOsqzRq53YXaMO4hEGcroQFA_lQ>
    <xmx:toi8XxkK9sM1HorHNbhuMoVloWe-N5MCCXE198K8adp04kyuP1khDw>
    <xmx:toi8X_2GJLZzhMqsguTFmVm_KXq6hmHVMxWcncY12XSckRnXRo_z5Q>
    <xmx:t4i8X6QMSlP7uxw8FXLNd_7RUxVjbxgWh3EbRqpFHjOwXWDnjQa9fg>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 215483064AB0;
        Mon, 23 Nov 2020 23:14:46 -0500 (EST)
To:     Michael Klein <michael@fossekall.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20201123161041.2304766-1-michael@fossekall.de>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add
 gpio-poweroff to DT
Message-ID: <4bf42c9e-9f70-bc30-1a88-44a127cd989a@sholland.org>
Date:   Mon, 23 Nov 2020 22:14:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201123161041.2304766-1-michael@fossekall.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/20 10:10 AM, Michael Klein wrote:
> Add gpio-poweroff node to allow the board to power itself off after
> shutdown by disabling the SYSTEM and CPUX regulators (U5 resp. U6).
> The RST button can be used to restart the board.

The PSCI client will override this driver once the PSCI implementation
is upgraded to v0.2 or newer functions. So having this around should
cause no compatibility issues (although it would print an error in dmesg
at that point). This seems like a reasonable thing to do for the other
H2+/H3 boards that use a similar regulator layout.

Reviewed-by: Samuel Holland <samuel@sholland.org>

> Signed-off-by: Michael Klein <michael@fossekall.de>
> ---
>  arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> index 4c6704e4c57e..76e79e6db733 100644
> --- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> @@ -46,6 +46,11 @@ sw4 {
>  		};
>  	};
>  
> +	gpio_poweroff {
> +		compatible = "gpio-poweroff";
> +		gpios = <&r_pio 0 8 GPIO_ACTIVE_LOW>; /* PL8 */
> +	};
> +
>  	reg_vdd_cpux: vdd-cpux-regulator {
>  		compatible = "regulator-gpio";
>  		regulator-name = "vdd-cpux";
> 

