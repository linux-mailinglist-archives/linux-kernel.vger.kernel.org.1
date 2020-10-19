Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A732925BA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 12:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgJSK00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 06:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgJSK00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 06:26:26 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0FDC0613CE;
        Mon, 19 Oct 2020 03:26:25 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s9so10741736wro.8;
        Mon, 19 Oct 2020 03:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CSFSoiR2kJzHsrWAKRK/Ut+Hlk5kE7JUM9hjKMQmGRw=;
        b=obkwTA2DFeVTQnEWisa4neWookHBPbVwGq3WSQodi3oUf3SElhmcFt3m7u5dWWug15
         Asz+OdW5hWRDucIsPrWLgZBfZ62ELluqL2IbbtkBuuuTOKel+Wlg75lSHTFbVGOjnrZu
         uqaazjkxamiSbUVXKmq3PH+Y5FLqVYS2Ht39pS0WqXRrcKSEtRxzg97hblAIgzpNG1O5
         lZBM1Ji9agdIgF8hyU+HnxvykkDSV8YOLQyDJ8QVLmjp8iNspYlRZ9eObZPqEAq7ZeCi
         CvXr7xemNw2OQAzKRntoc9Rrryy0Juml8ntenShaIIQMYxtnzUcr3GbQ1lFry67Z/9Gc
         dLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CSFSoiR2kJzHsrWAKRK/Ut+Hlk5kE7JUM9hjKMQmGRw=;
        b=FT8oFnutQmqQg6P/v0Y08vkFM2myUVhaZMuMsJ52lyRICc0O2uUp7NZUHUW+2/asAu
         B5KH8WwHv5+X37JqClGtf6UyiRKg3GsJkOcC0j1zFniTvH5cbJeldCmFQRhTlb5jcMXQ
         u173rpj3hWqcRIxzDpjMjwk8J/xnqMXYYDsfQTk6sgd5vVZy2w+jc5YOu51NRwLsjxgb
         qPYHKAoxxZi4PBpQJwgvX8pfj/dHeT9FPtA12vfolx8P5Cg52q8lDr0wbDuotMglJHKD
         ekgn47JK1AXTW+uR6UG/zvsXz5Pya8UObMXk4+8Yqu5rT/XCIraZvxBprJgabJZYh/dF
         Gjdg==
X-Gm-Message-State: AOAM532RYx1ZowSNRp1Beek6MWZKejc1cIZDq3smg78md5BRflQa7FtM
        hdeb/9BNqrXOXXyZh62165A=
X-Google-Smtp-Source: ABdhPJy8+YMruJQW57HunDCnKkl6sQa+5912udPLIa8YPWx3CfbHC/Ux2jidWwCooqsBwazhJONZcQ==
X-Received: by 2002:a5d:6341:: with SMTP id b1mr911619wrw.373.1603103184718;
        Mon, 19 Oct 2020 03:26:24 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id k6sm12185969wmk.16.2020.10.19.03.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 03:26:24 -0700 (PDT)
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt8516: add usb1 node
To:     Fabien Parent <fparent@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org
References: <20201014162404.1312544-1-fparent@baylibre.com>
 <20201014162404.1312544-2-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <d2dc75dd-04ec-d1ec-a84b-f7c5cccafa73@gmail.com>
Date:   Mon, 19 Oct 2020 12:26:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201014162404.1312544-2-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/10/2020 18:24, Fabien Parent wrote:
> The MT8516 has 2 USB instances. Add support for the second USB instance.
> usb1 can only work in host mode.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Applied to v5.10-tmp/dts64

Thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8516.dtsi | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> index 50049b6c1ba7..eca7969e15ab 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> @@ -455,6 +455,20 @@ usb0: usb@11100000 {
>   			status = "disabled";
>   		};
>   
> +		usb1: usb@11190000 {
> +			compatible = "mediatek,mtk-musb";
> +			reg = <0 0x11190000 0 0x1000>;
> +			interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_LOW>;
> +			interrupt-names = "mc";
> +			phys = <&usb1_port PHY_TYPE_USB2>;
> +			clocks = <&topckgen CLK_TOP_USB>,
> +				 <&topckgen CLK_TOP_USBIF>,
> +				 <&topckgen CLK_TOP_USB_1P>;
> +			clock-names = "main","mcu","univpll";
> +			dr_mode = "host";
> +			status = "disabled";
> +		};
> +
>   		usb_phy: usb@11110000 {
>   			compatible = "mediatek,generic-tphy-v1";
>   			reg = <0 0x11110000 0 0x800>;
> @@ -469,6 +483,13 @@ usb0_port: usb-phy@11110800 {
>   				clock-names = "ref";
>   				#phy-cells = <1>;
>   			};
> +
> +			usb1_port: usb-phy@11110900 {
> +				reg = <0 0x11110900 0 0x100>;
> +				clocks = <&topckgen CLK_TOP_USB_PHY48M>;
> +				clock-names = "ref";
> +				#phy-cells = <1>;
> +			};
>   		};
>   
>   		auxadc: adc@11003000 {
> 
