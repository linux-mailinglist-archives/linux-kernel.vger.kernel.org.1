Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A682DD544
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 17:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgLQQbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 11:31:34 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:47733 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727877AbgLQQbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 11:31:34 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A0340C8B;
        Thu, 17 Dec 2020 11:30:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 17 Dec 2020 11:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=R
        wyjTIzzAC7fG3iGATSvz2APR89Rfjp6vFhip3R2HAQ=; b=J4gbKnhJ3qSlXon0p
        +auxGXnffCdAwB2fr1UXm1Y4fJIWmt81pu3hYOjaNoF3Zof9HYV+JCvd3WgIfBeN
        Kp4LIY22vlIgzWGATWJaZ50WLP1OT2dOKwDNYIWMMHzk+ZPsBy3r0A1YRDV+5DJG
        B6uTr8cDyLZevcvYE7j1HdlUbK5U7NKpSBu+XXPSNqBTLEKRftMkSPovk3KlHk5e
        5w03p9qg5PIHN+zM6MwXehxijq+e+2e4nt6L7TJZAUl/IbtdtXCemANdSGbW4I3x
        LCF+XIx4BA+Cmb+b5VK+o3yHDzcrLIOEmEZO7QiYFrn734Y/rRJqN85/XOfktO/5
        DjgKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=RwyjTIzzAC7fG3iGATSvz2APR89Rfjp6vFhip3R2H
        AQ=; b=hz7WYXjD5hNRV7M3A4Zsh2V0+qQwqtF2cfl2THISTB7fM4E2XijiSqR2J
        hiCch84xHZ+RDetoaQMNzRJzpxRGA9JA1/BG+mhn2QhV3yVep50Uiw6NAs5gBy3v
        eck6OLzuv55WZrmwWm9f94ASWITBZDlXQtxZq53nhzlAWJzkFJgiGHKr6PqmzrEb
        grJLCjcIh8sJBjfG5d998IIoBrE9wqgfGmZMpeqIfU6lL/ExhV8etiFD4Ko+4ZLM
        AjG0NAa8twwFZe3zOHwBkec2BtUpwpyR6tA4+JYME19BnLRsEHuLXn5TRqi2nF3Z
        Nj0JvmMf1oCgDMq++PhXeOK9bGRBw==
X-ME-Sender: <xms:tofbX5oAbaqQKRxZpHoqOwtFNLRvAzjGqlJk8avfAIp-nZ_N-PXNBQ>
    <xme:tofbX7q54eAZ0UhvY0rRQ1DQHtPTNOMYyLuEDcpiV7KLDOGm19qY7CSTQAXzgLa_l
    Mee_XhW2LZzVlLtWio>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudelgedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpefgjeettdejgffgffdvteeutdehtdehgeehueetkeefgefhtdetjeekledu
    gedvudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:tofbX2OI0Qegx4Ax3WplXQ2HvKuKIsvyPkSJ-rzZSD79TXFdbefU7A>
    <xmx:tofbX05w525RD7apY4qht2SNfmPbSXv4Ri2Pml_x5E7K75sTjm96SQ>
    <xmx:tofbX46pnI85H8DhKHFFmWAb4c_XkHuXdLCDMaNi5L2FoJp3rEM2HA>
    <xmx:t4fbX2k4MLnaulKacFBoSZvDcd6M2QKwSNra5dDpaS7NKoiM_nPduA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2F1631080057;
        Thu, 17 Dec 2020 11:30:46 -0500 (EST)
Date:   Thu, 17 Dec 2020 17:30:45 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH] ARM: dts: sun8i-v3s: Add PWM controller and pins
 definitions
Message-ID: <20201217163045.i5o5sb4pls4gn52g@gilmour>
References: <20201217112031.2243683-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201217112031.2243683-1-contact@paulk.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 17, 2020 at 12:20:31PM +0100, Paul Kocialkowski wrote:
> This introduces definitions for the PWM controller found in the V3s,
> as well as associated pins. This fashion of the controller has two PWM
> outputs and is register-compatible with the A20.
>=20
> Both PWM outputs were tested on a Lichee Pi Zero with a simple
> transistor-LED setup.
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  arch/arm/boot/dts/sun8i-v3s.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v=
3s.dtsi
> index a9f5795d4e57..34a4e638c762 100644
> --- a/arch/arm/boot/dts/sun8i-v3s.dtsi
> +++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
> @@ -398,6 +398,16 @@ spi0_pins: spi0-pins {
>  				pins =3D "PC0", "PC1", "PC2", "PC3";
>  				function =3D "spi0";
>  			};
> +
> +			pwm0_pin: pwm0-pin {
> +				pins =3D "PB4";
> +				function =3D "pwm0";
> +			};
> +
> +			pwm1_pin: pwm1-pin {
> +				pins =3D "PB5";
> +				function =3D "pwm1";
> +			};
>  		};
> =20
>  		timer@1c20c00 {
> @@ -416,6 +426,14 @@ wdt0: watchdog@1c20ca0 {
>  			clocks =3D <&osc24M>;
>  		};
> =20
> +		pwm: pwm@1c21400 {
> +			compatible =3D "allwinner,sun7i-a20-pwm";

We should have a (documented) v3s compatible there along with the A20

Thanks!
Maxime
