Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B7F29F08F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbgJ2Pwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbgJ2Pwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:52:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BD2C0613CF;
        Thu, 29 Oct 2020 08:52:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s9so3300604wro.8;
        Thu, 29 Oct 2020 08:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5rqiFVQb3qlfcy/RMXrG6KMOgOP9hKGgbNSh4Mn0ao4=;
        b=C+asKu+9N2YOq2S3u6F4eJLJJqqtq56odjCV97nyjvlKnRPgmAYDEPtrq3n2EX25Fj
         T15RMMjC1gvouhGPaBm18G4dlY+Xf12qMrcR6k/ck+RmwFVWv5MSYV0kH75lv0SuKJvZ
         CgB0lzAA3WfmHp+wIfkQ5lb73wPt8b0ZvxaoFflOgfekOd7ZZ+jDWuyQr/j6XGBcGGiN
         LySimvGqX0haxEc1kdU4LsPOm5X0KFBG9i5n6txDKbJcXV1R1nPnJ4dJjGgqqwD8hUJr
         za/8ImFkISW7hONm6WdSFgzu4Oy/+75WbQzD7fExc22wr/CbLc7dQKkt58mm1pCG1gpj
         lWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5rqiFVQb3qlfcy/RMXrG6KMOgOP9hKGgbNSh4Mn0ao4=;
        b=OD7/NFnbXkV/AUFlr8ewkgUIRwaBdy6G2m0FPQppB37X3x3Ag/rhkyYZZ63GGCzzal
         qp7TFSKz6aXtYSwsJjoiIqLlfequ7niyk8PFzsY7fW7b1D7IERLzMlMib6MF84EYclIm
         nYPuwo5gpuBHaSyhpfIaCM4f1+SYCyARatZYJtC2BJAY3OMyfyHl++FzdyewBlgB/Bst
         U47QfLgLgX7bSgEcW0lQLCTnu/kwjSEJyL0XZl5hSZogLUsLdW1zXXAaR59tdKpt97kI
         bgk+A8/J8Z9JyrayTDbyIfIR9sZOkTn7IzFxsI3YAJrs+JvyErskoi52C+HzIIP61vld
         wNBA==
X-Gm-Message-State: AOAM5301UwJFZRv5qQsHMRfySW7y98ssyTgiZy/nAWQANnB/ceLcpeMo
        Gh3bvlQ9bDU2i7o42FqVfpPs9zGlL8wOHA==
X-Google-Smtp-Source: ABdhPJwZ4rmQGi43QL94t5ZBRH464nJAgvWHhIXxVa5hO5m8A980n7g2tcfbVRAaGyma9qlQPXQoKQ==
X-Received: by 2002:adf:f286:: with SMTP id k6mr6541511wro.34.1603986756011;
        Thu, 29 Oct 2020 08:52:36 -0700 (PDT)
Received: from ziggy.stardust ([213.195.117.206])
        by smtp.gmail.com with ESMTPSA id g4sm415538wmh.13.2020.10.29.08.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 08:52:35 -0700 (PDT)
Subject: Re: [RESEND PATCH v3] arm64: dts: mediatek: align GPIO hog names with
 dtschema
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201002163940.7837-1-krzk@kernel.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <8f3369aa-ebb2-0e4e-fc1f-109e54d63b7d@gmail.com>
Date:   Thu, 29 Oct 2020 16:52:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201002163940.7837-1-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/10/2020 18:39, Krzysztof Kozlowski wrote:
> The convention for node names is to use hyphens, not underscores.
> dtschema for pca95xx expects GPIO hogs to end with 'hog' suffix.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Pushed to v5.10-next/dts64

Thanks!

> ---
>   .../boot/dts/mediatek/pumpkin-common.dtsi     | 26 +++++++++----------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> The dt-schema changes were applied.
> 
> diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> index 29d8cf6df46b..351a1905a074 100644
> --- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
> @@ -63,91 +63,91 @@
>   		gpio-controller;
>   		#gpio-cells = <2>;
>   
> -		eint20_mux_sel0 {
> +		eint20-mux-sel0-hog {
>   			gpio-hog;
>   			gpios = <0 0>;
>   			input;
>   			line-name = "eint20_mux_sel0";
>   		};
>   
> -		expcon_mux_sel1 {
> +		expcon-mux-sel1-hog {
>   			gpio-hog;
>   			gpios = <1 0>;
>   			input;
>   			line-name = "expcon_mux_sel1";
>   		};
>   
> -		mrg_di_mux_sel2 {
> +		mrg-di-mux-sel2-hog {
>   			gpio-hog;
>   			gpios = <2 0>;
>   			input;
>   			line-name = "mrg_di_mux_sel2";
>   		};
>   
> -		sd_sdio_mux_sel3 {
> +		sd-sdio-mux-sel3-hog {
>   			gpio-hog;
>   			gpios = <3 0>;
>   			input;
>   			line-name = "sd_sdio_mux_sel3";
>   		};
>   
> -		sd_sdio_mux_ctrl7 {
> +		sd-sdio-mux-ctrl7-hog {
>   			gpio-hog;
>   			gpios = <7 0>;
>   			output-low;
>   			line-name = "sd_sdio_mux_ctrl7";
>   		};
>   
> -		hw_id0 {
> +		hw-id0-hog {
>   			gpio-hog;
>   			gpios = <8 0>;
>   			input;
>   			line-name = "hw_id0";
>   		};
>   
> -		hw_id1 {
> +		hw-id1-hog {
>   			gpio-hog;
>   			gpios = <9 0>;
>   			input;
>   			line-name = "hw_id1";
>   		};
>   
> -		hw_id2 {
> +		hw-id2-hog {
>   			gpio-hog;
>   			gpios = <10 0>;
>   			input;
>   			line-name = "hw_id2";
>   		};
>   
> -		fg_int_n {
> +		fg-int-n-hog {
>   			gpio-hog;
>   			gpios = <11 0>;
>   			input;
>   			line-name = "fg_int_n";
>   		};
>   
> -		usba_pwr_en {
> +		usba-pwr-en-hog {
>   			gpio-hog;
>   			gpios = <12 0>;
>   			output-high;
>   			line-name = "usba_pwr_en";
>   		};
>   
> -		wifi_3v3_pg {
> +		wifi-3v3-pg-hog {
>   			gpio-hog;
>   			gpios = <13 0>;
>   			input;
>   			line-name = "wifi_3v3_pg";
>   		};
>   
> -		cam_rst {
> +		cam-rst-hog {
>   			gpio-hog;
>   			gpios = <14 0>;
>   			output-low;
>   			line-name = "cam_rst";
>   		};
>   
> -		cam_pwdn {
> +		cam-pwdn-hog {
>   			gpio-hog;
>   			gpios = <15 0>;
>   			output-low;
> 
