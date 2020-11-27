Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36032C60EB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 09:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgK0IeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 03:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgK0IeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 03:34:13 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED426C0613D1;
        Fri, 27 Nov 2020 00:34:12 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 10so4382043wml.2;
        Fri, 27 Nov 2020 00:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8YrOJTHLtcyBPxE1lVFupdOc3UITMpGz5WVfIQMw4pc=;
        b=NIAvA/ceYfuVeLpQWNASN6GHR40y6WySR3d4tQldhIJJtjHijw8Tx5rEoprL/KsFlx
         UwnTIfRMfrP9Apl4a8Hgv3ASjDVwzy8K+6ENiUQzvWUPqDAILVwghMngwaNWfVKP0/O0
         dNsT41HT3sc46Vkp/IKUM4gl7aolsvQz4Id177677BPQ411jqs1xqRnJcm8cGI/iw5g3
         AGM0Cnh/hZoqK3YMhzl8rk9VWMOIGc/HAejwgrydNZxd8LVGvIMMG6dL5mrLYo53V3hR
         V6DYWru4ZbXnmnjccW1wzDtLp3QnwVwnupAR21dgIQm90jchTCdsKleAERCM7ChK53T7
         E4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8YrOJTHLtcyBPxE1lVFupdOc3UITMpGz5WVfIQMw4pc=;
        b=MHrEgPOdn/Jk3O1zw+oNEmseJ9bt/90XVNCGeaosrH5y5pgPn1PUvmFSUFclOZxCIS
         8ds0UfskHgfOo7rqgOSE4xfgnqDwevJspJBbrURa1WpdQUBSNAptTHFeAk+TOgp+TWWP
         oEVH2Djn/Coj7/yhn7oAPP9Z73o26luxPVfMsMASUSD4O+EOvf1sWMNddUvTbzcDHNo3
         eP7DukrZnTBHSdWwBmR54/kY4nTjVC8CMuC+STZiTloEEgkXGs2op9YI3ooY1RhuP3zq
         PBTnMmRKzkz6YtigLjjj3IFXjPNy3n5dp+q47oMSVV9sGq6G7/z6XSjYX7CmvdTt08c4
         iUoQ==
X-Gm-Message-State: AOAM530K1Lx3xV1PuOjlkiCmxmaLSFb5JgEEpNFJN5szN0aArp0x9DyD
        PK2a8w05YkIPUbqSxERuD5I=
X-Google-Smtp-Source: ABdhPJx7wCV6lvX4kuYDrgqjQ2zwj8fqZZkR8YvZ2PpgI+xeOBGWUH4Cn2wuk2UmG5r0eoRyHn9rrA==
X-Received: by 2002:a1c:e0d4:: with SMTP id x203mr7877923wmg.68.1606466051687;
        Fri, 27 Nov 2020 00:34:11 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id l10sm6091285wme.42.2020.11.27.00.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 00:34:10 -0800 (PST)
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt8516: add efuse node
To:     Fabien Parent <fparent@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, srinivas.kandagatla@linaro.org
References: <20201016171837.3261310-1-fparent@baylibre.com>
 <20201016171837.3261310-2-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <34955ee3-3505-9445-709e-34d95ea37dbb@gmail.com>
Date:   Fri, 27 Nov 2020 09:34:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201016171837.3261310-2-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/10/2020 19:18, Fabien Parent wrote:
> Add node to support e-fuses on MT8516
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8516.dtsi | 7 +++++++
>   1 file changed, 7 insertions(+)
> 

Applied to v5.10-next/dts64

Thanks!

> diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> index 89af661e7f63..18ddea519be2 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
> @@ -237,6 +237,13 @@ pio: pinctrl@1000b000 {
>   			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>   
> +		efuse: efuse@10009000 {
> +			compatible = "mediatek,mt8516-efuse", "mediatek,efuse";
> +			reg = <0 0x10009000 0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +		};
> +
>   		pwrap: pwrap@1000f000 {
>   			compatible = "mediatek,mt8516-pwrap";
>   			reg = <0 0x1000f000 0 0x1000>;
> 
