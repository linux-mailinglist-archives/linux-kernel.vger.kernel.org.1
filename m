Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B113E2F1757
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388375AbhAKOFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388198AbhAKOE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:04:58 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99900C061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:04:17 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n16so10940795wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6DV9eaBGiT/1toR+Kiob+2xXWfsRd9Dm9opipygdNwg=;
        b=jpxb5h9JmxaJiMs/aDOutUtoiMB98ZYrmCRkv0yDIj3yzkqhzBbSLQl6Kqgh2uXkl1
         TxMfa3s6060dL3MSErw8vcQ7PoELvtc24ayUBaWNhk9gEmnDtl5g/6xpRd3AHcI2fD5z
         CVES9ITwR3jAqyZ4vZimwtskV/0Y8sruSREEzPzMOMRxy2QQenT84W8bpiiHoP6HMmmQ
         lDCziRgRd4iDOIbLnH5rvr92tilYj835g4KOrJ/2VquMVtA9/GNo/EikuwpYatXV1PbT
         +/7ovIUy4e9+MTtFm9Tkzo5oTMHPcnCtwVlfUSusxAP/OGvePR6I/MJYiC3a/RU7Dd3d
         Xz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6DV9eaBGiT/1toR+Kiob+2xXWfsRd9Dm9opipygdNwg=;
        b=HP1FwzWKMkrTdLtspMSAt5KDV+3qjQNTSWKeY3BCK9INiXm/oEmUaYRUKe0FUlzvcb
         k5UVk2nSMZcXpft98At9VAXvtSlcTRYqV3o5+UHBVrZZvi/6emsysDIRujsIV+gJ8thM
         2WrpkT/p/8OEWkkKzKUGYDf3v9cHtWNc3fQZiIch5Mh3hzVN0xSvp7H11Da63nFjoxP6
         conWC0KXNpzf6doMDdWQD6EDJUOqH85z8OkBnazfSKxOfPTQWYfAyoomA5t34T9Od6lq
         1yTkIQpBBYiSo8Alf/wy2MBXGJ1WQnpUWxhmXsuc6UXwMZYp5Jv1HD7vM0U/yF/Aw61n
         01hg==
X-Gm-Message-State: AOAM531ZWzt2nsm7U5p0QGeGl/cdVWK54w4wSu4wFH+IHFnMwvaeMfB0
        XgECJIg3TreogLMatEXvtDU+PG3efUVwL88a
X-Google-Smtp-Source: ABdhPJyzrKQ4OZCxiaXI1a4DMxO8Ded0AtA1/WrPlvt8Ohw1YXA8eYVVVp1o/MpHR3j8v9QMYGFKCw==
X-Received: by 2002:a1c:27c3:: with SMTP id n186mr14743909wmn.96.1610373855767;
        Mon, 11 Jan 2021 06:04:15 -0800 (PST)
Received: from ?IPv6:2a01:e35:2ec0:82b0:7474:6cdc:8087:ca98? ([2a01:e35:2ec0:82b0:7474:6cdc:8087:ca98])
        by smtp.gmail.com with ESMTPSA id w18sm24507291wrn.2.2021.01.11.06.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 06:04:15 -0800 (PST)
Subject: Re: [PATCH 3/5] ARM: dts: meson8: add the thermal-zones with cooling
 configuration
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201221181306.904272-1-martin.blumenstingl@googlemail.com>
 <20201221181306.904272-4-martin.blumenstingl@googlemail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <93307a31-ea51-cc21-9470-859ffe0f1023@baylibre.com>
Date:   Mon, 11 Jan 2021 15:04:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201221181306.904272-4-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2020 19:13, Martin Blumenstingl wrote:
> The vendor kernel uses the following thermal-zone settings:
> <= 70°C:
> - CPU frequency limited to 1.608GHz
> - GPU limited to 511MHz and 5 cores (pixel processors)
> 
> <= 80°C:
> - CPU frequency limited to 1.2GHz
> - GPU limited to 435MHz and 4 cores (pixel processors)
> 
> <= 90°C:
> - CPU frequency limited to 0.804GHz
> - GPU limited to 328MHz and 3 cores (pixel processors)
> 
> Add simplified thermal configuration which is taken from the
> GXBB/GXL/GXM SoC family (which uses the same manufacturing process and
> has the same maximum junction temperature of 125°C). With this the
> thermal framework will try to keep the SoC temperature at or below 80°C
> which is identical to the vendor kernel (with the exception of one GPU
> pixel processor).
> 
> The number of GPU cores are not taken into account as this is not
> supported.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  arch/arm/boot/dts/meson8.dtsi | 54 +++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
> index 04688e8abce2..420324ea2ad7 100644
> --- a/arch/arm/boot/dts/meson8.dtsi
> +++ b/arch/arm/boot/dts/meson8.dtsi
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/power/meson8-power.h>
>  #include <dt-bindings/reset/amlogic,meson8b-clkc-reset.h>
>  #include <dt-bindings/reset/amlogic,meson8b-reset.h>
> +#include <dt-bindings/thermal/thermal.h>
>  #include "meson.dtsi"
>  
>  / {
> @@ -28,6 +29,7 @@ cpu0: cpu@200 {
>  			resets = <&clkc CLKC_RESET_CPU0_SOFT_RESET>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			clocks = <&clkc CLKID_CPUCLK>;
> +			#cooling-cells = <2>; /* min followed by max */
>  		};
>  
>  		cpu1: cpu@201 {
> @@ -39,6 +41,7 @@ cpu1: cpu@201 {
>  			resets = <&clkc CLKC_RESET_CPU1_SOFT_RESET>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			clocks = <&clkc CLKID_CPUCLK>;
> +			#cooling-cells = <2>; /* min followed by max */
>  		};
>  
>  		cpu2: cpu@202 {
> @@ -50,6 +53,7 @@ cpu2: cpu@202 {
>  			resets = <&clkc CLKC_RESET_CPU2_SOFT_RESET>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			clocks = <&clkc CLKID_CPUCLK>;
> +			#cooling-cells = <2>; /* min followed by max */
>  		};
>  
>  		cpu3: cpu@203 {
> @@ -61,6 +65,7 @@ cpu3: cpu@203 {
>  			resets = <&clkc CLKC_RESET_CPU3_SOFT_RESET>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			clocks = <&clkc CLKID_CPUCLK>;
> +			#cooling-cells = <2>; /* min followed by max */
>  		};
>  	};
>  
> @@ -190,6 +195,54 @@ power-firmware@4f00000 {
>  		};
>  	};
>  
> +	thermal-zones {
> +		soc {
> +			polling-delay-passive = <250>; /* milliseconds */
> +			polling-delay = <1000>; /* milliseconds */
> +			thermal-sensors = <&thermal_sensor>;
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&soc_passive>;
> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&mali THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +
> +				map1 {
> +					trip = <&soc_hot>;
> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&mali THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +
> +			trips {
> +				soc_passive: soc-passive {
> +					temperature = <80000>; /* millicelsius */
> +					hysteresis = <2000>; /* millicelsius */
> +					type = "passive";
> +				};
> +
> +				soc_hot: soc-hot {
> +					temperature = <90000>; /* millicelsius */
> +					hysteresis = <2000>; /* millicelsius */
> +					type = "hot";
> +				};
> +
> +				soc_critical: soc-critical {
> +					temperature = <110000>; /* millicelsius */
> +					hysteresis = <2000>; /* millicelsius */
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
> +
>  	mmcbus: bus@c8000000 {
>  		compatible = "simple-bus";
>  		reg = <0xc8000000 0x8000>;
> @@ -254,6 +307,7 @@ mali: gpu@c0000 {
>  			clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_MALI>;
>  			clock-names = "bus", "core";
>  			operating-points-v2 = <&gpu_opp_table>;
> +			#cooling-cells = <2>; /* min followed by max */
>  		};
>  	};
>  }; /* end of / */
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
