Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A95723447C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 13:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732641AbgGaLVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 07:21:01 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37458 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732104AbgGaLVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 07:21:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 6CC63299217
Subject: Re: [PATCH] arm64: dts: mt8173: elm: Fix nor_flash node property
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200727074124.3779237-1-hsinyi@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <8aedcc7e-fea5-367c-e3a8-8a013cf629c1@collabora.com>
Date:   Fri, 31 Jul 2020 13:20:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727074124.3779237-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Thank you for your patch.

On 27/7/20 9:41, Hsin-Yi Wang wrote:
> bus-width and non-removable is not used by the driver.
> max-frequency should be spi-max-frequency for flash node.
> 
> Fixes: 689b937bedde ("arm64: dts: mediatek: add mt8173 elm and hana board")
> Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> index a5a12b2599a4..01522dd10603 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -431,12 +431,11 @@ &nor_flash {
>  	status = "okay";
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&nor_gpio1_pins>;
> -	bus-width = <8>;
> -	max-frequency = <50000000>;
> -	non-removable;
> +
>  	flash@0 {
>  		compatible = "jedec,spi-nor";
>  		reg = <0>;
> +		spi-max-frequency = <50000000>;
>  	};
>  };
>  
> 
