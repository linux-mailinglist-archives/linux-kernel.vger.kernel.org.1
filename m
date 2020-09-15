Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BE726A595
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgIOMve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgIOMmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:42:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536EAC061788;
        Tue, 15 Sep 2020 05:41:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A7AF729AD31
Subject: Re: [PATCH] arm64: dts: mt8173-elm: Remove ddc property from panel
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20200826090218.682931-1-enric.balletbo@collabora.com>
Message-ID: <ff5cf4e0-54dc-5e14-d76f-b674f6b0d884@collabora.com>
Date:   Tue, 15 Sep 2020 14:41:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200826090218.682931-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 26/8/20 11:02, Enric Balletbo i Serra wrote:
> The elm and hana devices uses an Embedded DisplayPort (eDP) as interface
> for its panel, so the DDC channel specified in the binding is useless.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

A gentle ping on this patch.

Thanks,
  Enric

> ---
> 
>  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> index a5a12b2599a4..1fe5dac24ba1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -86,7 +86,6 @@ volume_up {
>  	panel: panel {
>  		compatible = "lg,lp120up1";
>  		power-supply = <&panel_fixed_3v3>;
> -		ddc-i2c-bus = <&i2c0>;
>  		backlight = <&backlight>;
>  
>  		port {
> 
