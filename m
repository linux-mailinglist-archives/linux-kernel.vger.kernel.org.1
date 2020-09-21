Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F42E271FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgIUKF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgIUKF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:05:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863A1C061755;
        Mon, 21 Sep 2020 03:05:58 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o5so12056606wrn.13;
        Mon, 21 Sep 2020 03:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uB9lgh9yJlLcF4TAFLn2cbmVn5XoptteUACXhtU5Bic=;
        b=LRchwCbJPnQ3FfwWq6KxXaJuPvw2bpddGbkNTXelOPiv5wu8K/WyIv3DPwV0rp3xZ7
         NvPCvZnqiI6OpKif3vcyspZZLq/jFphm1Cdvg6W/ZWAZSyZty8nDm5Za0QGg3e/ccm7l
         tzgryxgODHOsy6oOMQaAVECig51STcIIfAJMYnRkENyTVDAGIDAuapFnCJJ2zHfpSSGp
         ufFdM823BArb7o+Vcm/POXm3A7fHOXfnHR6FlnU8ZJKxAeqvJgmSwJ5vSUaSZ93dJxWC
         fvcHQTjVoddHr8kcSlcuSgo9B/fiik7PgeUoTHMJ+6Q+ZBMzBwE+lNCIHacnHGf2rOnw
         u8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uB9lgh9yJlLcF4TAFLn2cbmVn5XoptteUACXhtU5Bic=;
        b=P2jnbbuSHbhc2JMFqsKAnN28C64TWVLQTN6Xf/hkFu6846F/fYAGdYwEOgOdIk0Y7m
         /yC/5THNnaJmHg3/IUsup4bV+ZIEKWrzyHynVke3gX3kd1g1i4SgPV7CwLKREpH4w6IZ
         r/4rl/vsr3c+gY7dc6cSxESKP/0YpfEmHEF30QEFieP1/NZ3t1yoh7TQeZrlsE9ZytUb
         uOWTcvOHCvDuaHSur6Ckjkw5gQOlS145V1tXlPEDU17XbK0EllBgsP6+vPdYubAq6im5
         sMK1tyoZuIeWddLbOBWmQTRXvtM45N9CoppZA/Vyibx+G0ZeEN3Au1NbBUdeSWy9vSML
         ol7g==
X-Gm-Message-State: AOAM531Om02Kd/Y9po3tUepy9fgf3tt2FQpvKA/x0BtEmHqkZEc2I0ow
        XZERh72ODn6RUQXvhtoLA6bgTO4KxfNX8g==
X-Google-Smtp-Source: ABdhPJznjBjQq9Ooy+DA0/ORvc9hcl6mLcPMKwkNC+WvnFsAwgjChcVdQBOflj+aNKPJao7ewsbwog==
X-Received: by 2002:adf:f245:: with SMTP id b5mr53928403wrp.288.1600682757069;
        Mon, 21 Sep 2020 03:05:57 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id p1sm35592072wma.0.2020.09.21.03.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 03:05:56 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: mt8173: elm: Fix nor_flash node property
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200727074124.3779237-1-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <9ac41633-0133-b6f1-2615-adb5a7c98ed7@gmail.com>
Date:   Mon, 21 Sep 2020 12:05:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200727074124.3779237-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/07/2020 09:41, Hsin-Yi Wang wrote:
> bus-width and non-removable is not used by the driver.
> max-frequency should be spi-max-frequency for flash node.
> 
> Fixes: 689b937bedde ("arm64: dts: mediatek: add mt8173 elm and hana board")
> Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Applied to v5.9-next/dts64

Thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> index a5a12b2599a4..01522dd10603 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -431,12 +431,11 @@ &nor_flash {
>   	status = "okay";
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&nor_gpio1_pins>;
> -	bus-width = <8>;
> -	max-frequency = <50000000>;
> -	non-removable;
> +
>   	flash@0 {
>   		compatible = "jedec,spi-nor";
>   		reg = <0>;
> +		spi-max-frequency = <50000000>;
>   	};
>   };
>   
> 
