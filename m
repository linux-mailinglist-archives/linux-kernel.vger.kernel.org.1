Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E54280FAD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 11:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgJBJRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 05:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJBJRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 05:17:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E15C0613D0;
        Fri,  2 Oct 2020 02:17:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k10so967276wru.6;
        Fri, 02 Oct 2020 02:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dIX1QnSd8Sm6GMg/Obp/yg2Em8bvCIKWhcgetLs0oPc=;
        b=SKMk2YIFw/7mFo49CvNuLB++JAjObQQWwzsb7eLvuUFYxejU2zZpfYU7p+rrLA1fgy
         sLwKtg8kDuxdSiTogM4+kNDr7nt4zNVc7mew7jhxVDvdID4m/z0EBknkYHsuScHxwllj
         pIFHDZ8MKg1Om5efa/bGhY0A9puDwcTSepLInpvBdPkPzjAQILHuY5q0zE3YOIghBdar
         I/DdduQzDzRjXTXEkjHeA6zFGFc6mSjeAUqO6Xik6NirBcCArLEKYAspJA5s8eybVD9J
         bPFl7JjX1QxbM+SNg7ZN4bIX13AW+ewfF8ZRSwcr1KA7AVjdFxHVvN8GiTRkE7dpBrMa
         mDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dIX1QnSd8Sm6GMg/Obp/yg2Em8bvCIKWhcgetLs0oPc=;
        b=YZYLpJvbp4GxBG1tpfpd+J/63hTv90cNYBCsOMN+FolD9N5xMDNTq2DaMKiHEq1ix6
         U7pz9e214VQN8/2hM8GrN55LZ3X9DlsvxHW7IEBwTqrAdDMbcHU+P3Kt2KNwxm7ybO+Q
         /1gWMrKpBGl4YCWxCm0h5tT/Vjgk7nNdWmGdi04Jjyh8m44Yg0uJCt2UZekseyHwKOjm
         uMfTpZeVsy6/+3awlOzSF4NDY6bUKPP1e3JgJWXQ/PYl0wYLksFCFLa+HZAfV3U1w9XQ
         eM/LFX2NK5S8J/fl8iKHzUQcy7RwDhstWX4ysbHWnPhVN4A7l2FjoSM75Rg+EYe+nSgh
         4Jmw==
X-Gm-Message-State: AOAM530WKZJKqupIXnywV2gudJohEDPOtu+W/aE4OWPqhaoJE2cy8gtQ
        CGjR5F+DTxJYxK8GPU6mUcA=
X-Google-Smtp-Source: ABdhPJweC7f5XPBbqWwxBlys1kcLJBUypBWOTuPXbrHo9UUwrGb4Ucz6TMjRsiFp7J0u0qYQfXy/bw==
X-Received: by 2002:adf:91c2:: with SMTP id 60mr2042425wri.292.1601630269185;
        Fri, 02 Oct 2020 02:17:49 -0700 (PDT)
Received: from ziggy.stardust ([213.195.119.110])
        by smtp.gmail.com with ESMTPSA id t10sm1071439wmi.1.2020.10.02.02.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 02:17:48 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: mediatek: Add smi_common node for MT8183
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, weiyi.lu@mediatek.com,
        drinkcat@chromium.org, hsinyi@chromium.org, fparent@baylibre.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201001162823.3592352-1-enric.balletbo@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <d937daf7-469f-8d74-4267-057b89cf1dd1@gmail.com>
Date:   Fri, 2 Oct 2020 11:17:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201001162823.3592352-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/10/2020 18:28, Enric Balletbo i Serra wrote:
> The SMI (Smart Multimedia Interface) Common is a bridge between the m4u
> (Multimedia Memory Management Unit) and the Multimedia HW. This block is
> needed to support different multimedia features, like display, video
> decode, and camera. Also is needed to control the power domains of such
> HW blocks.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index c2fd141afcf6..9082bc65e15e 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -916,6 +916,16 @@ mmsys: syscon@14000000 {
>   			#clock-cells = <1>;
>   		};
>   
> +		smi_common: smi@14019000 {
> +			compatible = "mediatek,mt8183-smi-common", "syscon";
> +			reg = <0 0x14019000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_SMI_COMMON>,
> +				 <&mmsys CLK_MM_SMI_COMMON>,
> +				 <&mmsys CLK_MM_GALS_COMM0>,
> +				 <&mmsys CLK_MM_GALS_COMM1>;
> +			clock-names = "apb", "smi", "gals0", "gals1";
> +		};
> +

Having a look at the bindings description, it states that the power-domains 
phandle is a required property.
So I suppose you have to base this on the power domains series.

Regards,
Matthias

>   		imgsys: syscon@15020000 {
>   			compatible = "mediatek,mt8183-imgsys", "syscon";
>   			reg = <0 0x15020000 0 0x1000>;
> 
