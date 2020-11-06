Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274412A9459
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgKFK3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgKFK3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:29:11 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24794C0613CF;
        Fri,  6 Nov 2020 02:29:11 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id s25so1198040ejy.6;
        Fri, 06 Nov 2020 02:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6KO3tpZd9fabNVI7knO854DR7pkC+nbJTMXJxRywBRA=;
        b=EMe3OMLoP1liYhjqmesTIm2OlSPEBZKFgyagolt5SDpky7xC2UVQ2bapJPCmi+Kjfk
         mkzYOS5nVmK8O6uv8ECa16gBtIxF/bt1YbWleozvTfWMQwdmqtuYYRNJAl3UnEopwhJK
         g26Zo2I7/PF8WPxGs96/n7IpzZWdOFycfw3faWxDO+MHdu0i5/jsQd6sMUZFhWVxkRmR
         fALhhgHAAWNafZUQkqPTSFfCQEGk0c3aLL383IhONAQmlj+uA2Zb7t9E4R8BjuXU8IMJ
         O0000TWi980w1YbmEGGbaEY+I4pkgfBGlFVu5lB4g8Ys9CkW0KgN0G+vOVjorrfmrMKy
         zkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6KO3tpZd9fabNVI7knO854DR7pkC+nbJTMXJxRywBRA=;
        b=GS4+rz/SQFyqPt4F1O9uFwifTzAjCGzSmX9k9pHjUtG3y3gAnHSbB64osDQJy51kpp
         5a4YRA4xfUjXkcPQVTiTMsXNcl/oo+K2BBii1cvVF4P3saYlHsafFo8rr943eC2FsZgL
         CundsXSDc6Jk16LgE8fiSPbubsGe7nGxwqb+9zddGyaC5WEyHazflpbuOIVuSflWgph6
         gqjVmc/8UsTfE5cMNvQLhx+saBNTrgGDs6QQeAJqZLlTLRUFRLlbMlQh4OZjHdWhYvtl
         T2Hu1GDDVoivMc0CHPp+T8a7ibaQ6MamYYy4HiEKrYbGS5fmpsfR0Cd1hrQ2lthytSKR
         wi+A==
X-Gm-Message-State: AOAM532V72dYuhVElvJ+qdO7sdCDVCNywUQAU6R0L+g/vegcEE34Mngm
        xX/9gF9GIJq3a9X0RNSft19EFf5ZoYE1lg==
X-Google-Smtp-Source: ABdhPJwaSNRdkwLPT5rKEBe1a0MIvWVbRI5fFAFSNm5F00QScRXq83ByBFNMbNKBobP+3nuKRcdVTg==
X-Received: by 2002:a17:906:4bc2:: with SMTP id x2mr1352791ejv.525.1604658549486;
        Fri, 06 Nov 2020 02:29:09 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id h4sm691028edj.1.2020.11.06.02.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 02:29:08 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: rockchip: Reorder LED triggers from mmc
 devices on rk3399-roc-pc.
To:     Markus Reichl <m.reichl@fivetechno.de>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     dianders@chromium.org, robin.murphy@arm.com, wens@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20201104192933.1001-1-m.reichl@fivetechno.de>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <db3986ed-e572-bdd1-6f04-3bb2d04d49fa@gmail.com>
Date:   Fri, 6 Nov 2020 11:29:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201104192933.1001-1-m.reichl@fivetechno.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

On 11/4/20 8:29 PM, Markus Reichl wrote:
> After patch [1] SD-card becomes mmc1 and eMMC becomes mmc2.
> Correct trigger of LEDs accordingly.
> 
> [1]
> https://patchwork.kernel.org/patch/11881427
> 
> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> index e7a459fa4322..20309076dbac 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
> @@ -74,14 +74,14 @@ diy_led: led-1 {
>  			label = "red:diy";
>  			gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
> -			linux,default-trigger = "mmc1";

> +			linux,default-trigger = "mmc2";

remove
>  		};
>  
>  		yellow_led: led-2 {
>  			label = "yellow:yellow-led";
>  			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
> -			linux,default-trigger = "mmc0";

> +			linux,default-trigger = "mmc1";

remove

>  		};
>  	};
>  
> 

The "mmc1" and "mmc2" options are custom values and invalid to the
automated dt check in the mainline kernel.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/leds/leds-gpio.yaml


  linux,default-trigger:
    description:
      This parameter, if present, is a string defining the trigger
assigned to
      the LED.
    $ref: /schemas/types.yaml#definitions/string

    enum:
        # LED will act as a back-light, controlled by the framebuffer system
      - backlight
        # LED will turn on (but for leds-gpio see "default-state"
property in
        # Documentation/devicetree/bindings/leds/leds-gpio.yaml)
      - default-on
        # LED "double" flashes at a load average based rate
      - heartbeat
        # LED indicates disk activity
      - disk-activity
        # LED indicates IDE disk activity (deprecated), in new
implementations
        # use "disk-activity"
      - ide-disk
        # LED flashes at a fixed, configurable rate
      - timer
        # LED alters the brightness for the specified duration with one
software
        # timer (requires "led-pattern" property)
      - pattern
