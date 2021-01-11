Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB7D2F175F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388374AbhAKOFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729958AbhAKOFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:05:17 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA284C061795
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:04:36 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 3so15178087wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KTs2HBhwh7moZ5CeZAKMljzz63C9NOrlB8lqTJNcmTQ=;
        b=Mx+MpUmSSDsU10hZD/59sC8hDb5zVkgA2AqZcVmgLjMUOvxVuJiCpcWR/mzE5ZbS4P
         qv43VWprWKtZgk7UtYwijxhzA+UHIqsBJw2+PEs/3HRz4BhVfVis4Qq6KkyAY2a98N/+
         30Uoswm8z6F9rEF8aZTzE3dExAu8zaA+fdIXJkf0Ncojf0J37bbXxjbfY7+MsFsp/5+B
         E78BmEeoYQ+kgwq6eM35uQoMw+1N0Sp5T3kRXh9GlnYtM7fMNrRiq2qM9vqYfdA7/OOd
         nrXG7W08pdzBclSMC0RD/LcaqCTpJ/va06MgDGvIN2JHmTgZvhqiMwKAoBthufkETrXW
         Dnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KTs2HBhwh7moZ5CeZAKMljzz63C9NOrlB8lqTJNcmTQ=;
        b=RCSSieVBYjhHEDiT3tx01sw7WVlWezbFE6nTgCtS3Ui8e8po6vvxZ2ma4h7rWUrqUs
         0dwp1kL7Ng0zhKqr08aUfcJ1bMrYjc7PIiA3csuQ+heiJDshQ1ZXKcKqZb9bSWpasYY3
         NTFEJtf0z0cSLD+GhagkLJav6cBeBf2rUV+ajaxRZVDGO9EG6oZlVUrfNbA/NwzdvORV
         3smoiQJiUCEecc0CbVzQ7i1vUZoBlXaSaF7x71TDpR1VaDInCy/jH2+WEJ0XG5gSCdG5
         45M/JxyzI5RbVq8NhIXR8nmWcPjTN/xXKJQa7N07aQrVUd3vNAhZsm0dohBVUv9wAq9l
         gUjA==
X-Gm-Message-State: AOAM533z6w+vSDUtpw4+t9hBNHR6lS24YSWCK3jr7vRIWVDsBlCDGt1K
        6KKYih+AyLWv8+s1U5UZTpgUs8OiOWYbaDG9
X-Google-Smtp-Source: ABdhPJyERn3K8LWbc+cMWCEwUJ3JFyIBmcZKml4pSdEDWmgSvb+ETSs8bP2yNMjFHIgN7Ls8fmv9EQ==
X-Received: by 2002:a1c:6383:: with SMTP id x125mr14764462wmb.46.1610373874936;
        Mon, 11 Jan 2021 06:04:34 -0800 (PST)
Received: from ?IPv6:2a01:e35:2ec0:82b0:7474:6cdc:8087:ca98? ([2a01:e35:2ec0:82b0:7474:6cdc:8087:ca98])
        by smtp.gmail.com with ESMTPSA id z21sm21041584wmk.20.2021.01.11.06.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 06:04:33 -0800 (PST)
Subject: Re: [PATCH 4/5] ARM: dts: meson8b: add the thermal-zones with cooling
 configuration
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201221181306.904272-1-martin.blumenstingl@googlemail.com>
 <20201221181306.904272-5-martin.blumenstingl@googlemail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 mQENBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAG0KE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT6JATsEEwEKACUC
 GyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJXDO2CAhkBAAoJEBaat7Gkz/iubGIH/iyk
 RqvgB62oKOFlgOTYCMkYpm2aAOZZLf6VKHKc7DoVwuUkjHfIRXdslbrxi4pk5VKU6ZP9AKsN
 NtMZntB8WrBTtkAZfZbTF7850uwd3eU5cN/7N1Q6g0JQihE7w4GlIkEpQ8vwSg5W7hkx3yQ6
 2YzrUZh/b7QThXbNZ7xOeSEms014QXazx8+txR7jrGF3dYxBsCkotO/8DNtZ1R+aUvRfpKg5
 ZgABTC0LmAQnuUUf2PHcKFAHZo5KrdO+tyfL+LgTUXIXkK+tenkLsAJ0cagz1EZ5gntuheLD
 YJuzS4zN+1Asmb9kVKxhjSQOcIh6g2tw7vaYJgL/OzJtZi6JlIW5AQ0ETVkGzwEIALyKDN/O
 GURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYpQTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXM
 coJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hi
 SvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY4yG6xI99NIPEVE9lNBXBKIlewIyVlkOa
 YvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoMMtsyw18YoX9BqMFInxqYQQ3j/HpVgTSv
 mo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUXoUk33HEAEQEAAYkBHwQYAQIACQUCTVkG
 zwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfnM7IbRuiSZS1unlySUVYu3SD6YBYnNi3G
 5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa33eDIHu/zr1HMKErm+2SD6PO9umRef8V8
 2o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCSKmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+
 RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJ
 C3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTTQbM0WUIBIcGmq38+OgUsMYu4NzLu7uZF
 Acmp6h8guQINBFYnf6QBEADQ+wBYa+X2n/xIQz/RUoGHf84Jm+yTqRT43t7sO48/cBW9vAn9
 GNwnJ3HRJWKATW0ZXrCr40ES/JqM1fUTfiFDB3VMdWpEfwOAT1zXS+0rX8yljgsWR1UvqyEP
 3xN0M/40Zk+rdmZKaZS8VQaXbveaiWMEmY7sBV3QvgOzB7UF2It1HwoCon5Y+PvyE3CguhBd
 9iq5iEampkMIkbA3FFCpQFI5Ai3BywkLzbA3ZtnMXR8Qt9gFZtyXvFQrB+/6hDzEPnBGZOOx
 zkd/iIX59SxBuS38LMlhPPycbFNmtauOC0DNpXCv9ACgC9tFw3exER/xQgSpDVc4vrL2Cacr
 wmQp1k9E0W+9pk/l8S1jcHx03hgCxPtQLOIyEu9iIJb27TjcXNjiInd7Uea195NldIrndD+x
 58/yU3X70qVY+eWbqzpdlwF1KRm6uV0ZOQhEhbi0FfKKgsYFgBIBchGqSOBsCbL35f9hK/JC
 6LnGDtSHeJs+jd9/qJj4WqF3x8i0sncQ/gszSajdhnWrxraG3b7/9ldMLpKo/OoihfLaCxtv
 xYmtw8TGhlMaiOxjDrohmY1z7f3rf6njskoIXUO0nabun1nPAiV1dpjleg60s3OmVQeEpr3a
 K7gR1ljkemJzM9NUoRROPaT7nMlNYQL+IwuthJd6XQqwzp1jRTGG26J97wARAQABiQM+BBgB
 AgAJBQJWJ3+kAhsCAikJEBaat7Gkz/iuwV0gBBkBAgAGBQJWJ3+kAAoJEHfc29rIyEnRk6MQ
 AJDo0nxsadLpYB26FALZsWlN74rnFXth5dQVQ7SkipmyFWZhFL8fQ9OiIoxWhM6rSg9+C1w+
 n45eByMg2b8H3mmQmyWztdI95OxSREKwbaXVapCcZnv52JRjlc3DoiiHqTZML5x1Z7lQ1T3F
 8o9sKrbFO1WQw1+Nc91+MU0MGN0jtfZ0Tvn/ouEZrSXCE4K3oDGtj3AdC764yZVq6CPigCgs
 6Ex80k6QlzCdVP3RKsnPO2xQXXPgyJPJlpD8bHHHW7OLfoR9DaBNympfcbQJeekQrTvyoASw
 EOTPKE6CVWrcQIztUp0WFTdRGgMK0cZB3Xfe6sOp24PQTHAKGtjTHNP/THomkH24Fum9K3iM
 /4Wh4V2eqGEgpdeSp5K+LdaNyNgaqzMOtt4HYk86LYLSHfFXywdlbGrY9+TqiJ+ZVW4trmui
 NIJCOku8SYansq34QzYM0x3UFRwff+45zNBEVzctSnremg1mVgrzOfXU8rt+4N1b2MxorPF8
 619aCwVP7U16qNSBaqiAJr4e5SNEnoAq18+1Gp8QsFG0ARY8xp+qaKBByWES7lRi3QbqAKZf
 yOHS6gmYo9gBmuAhc65/VtHMJtxwjpUeN4Bcs9HUpDMDVHdfeRa73wM+wY5potfQ5zkSp0Jp
 bxnv/cRBH6+c43stTffprd//4Hgz+nJcCgZKtCYIAPkUxABC85ID2CidzbraErVACmRoizhT
 KR2OiqSLW2x4xdmSiFNcIWkWJB6Qdri0Fzs2dHe8etD1HYaht1ZhZ810s7QOL7JwypO8dscN
 KTEkyoTGn6cWj0CX+PeP4xp8AR8ot4d0BhtUY34UPzjE1/xyrQFAdnLd0PP4wXxdIUuRs0+n
 WLY9Aou/vC1LAdlaGsoTVzJ2gX4fkKQIWhX0WVk41BSFeDKQ3RQ2pnuzwedLO94Bf6X0G48O
 VsbXrP9BZ6snXyHfebPnno/te5XRqZTL9aJOytB/1iUna+1MAwBxGFPvqeEUUyT+gx1l3Acl
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <11cd42bd-6b5f-f126-d53e-e06693b8000b@baylibre.com>
Date:   Mon, 11 Jan 2021 15:04:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201221181306.904272-5-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2020 19:13, Martin Blumenstingl wrote:
> The vendor kernel uses the following thermal-zone settings:
> <= 70°C:
> - CPU frequency limited to 1.488GHz
> - GPU limited to 511MHz and 2 cores (pixel processors)
> 
> <= 80°C:
> - CPU frequency limited to 1.2GHz
> - GPU limited to 435MHz and 2 cores (pixel processors)
> 
> <= 90°C:
> - CPU frequency limited to 0.804GHz
> - GPU limited to 328MHz and 1 core (pixel processor)
> 
> Add simplified thermal configuration which is taken from the
> GXBB/GXL/GXM SoC family (which uses the same manufacturing process and
> has the same maximum junction temperature of 125°C). With this the
> thermal framework will try to keep the SoC temperature at or below 80°C
> which is identical to the vendor kernel (with the exception of one CPU
> frequency step from 1.488GHz to 1.536GHz).
> 
> The number of GPU cores are not taken into account as this is not
> supported.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  arch/arm/boot/dts/meson8b.dtsi | 54 ++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
> index 2401cdf5f751..dbf7963b6c87 100644
> --- a/arch/arm/boot/dts/meson8b.dtsi
> +++ b/arch/arm/boot/dts/meson8b.dtsi
> @@ -10,6 +10,7 @@
>  #include <dt-bindings/power/meson8-power.h>
>  #include <dt-bindings/reset/amlogic,meson8b-reset.h>
>  #include <dt-bindings/reset/amlogic,meson8b-clkc-reset.h>
> +#include <dt-bindings/thermal/thermal.h>
>  #include "meson.dtsi"
>  
>  / {
> @@ -26,6 +27,7 @@ cpu0: cpu@200 {
>  			resets = <&clkc CLKC_RESET_CPU0_SOFT_RESET>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			clocks = <&clkc CLKID_CPUCLK>;
> +			#cooling-cells = <2>; /* min followed by max */
>  		};
>  
>  		cpu1: cpu@201 {
> @@ -37,6 +39,7 @@ cpu1: cpu@201 {
>  			resets = <&clkc CLKC_RESET_CPU1_SOFT_RESET>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			clocks = <&clkc CLKID_CPUCLK>;
> +			#cooling-cells = <2>; /* min followed by max */
>  		};
>  
>  		cpu2: cpu@202 {
> @@ -48,6 +51,7 @@ cpu2: cpu@202 {
>  			resets = <&clkc CLKC_RESET_CPU2_SOFT_RESET>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			clocks = <&clkc CLKID_CPUCLK>;
> +			#cooling-cells = <2>; /* min followed by max */
>  		};
>  
>  		cpu3: cpu@203 {
> @@ -59,6 +63,7 @@ cpu3: cpu@203 {
>  			resets = <&clkc CLKC_RESET_CPU3_SOFT_RESET>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			clocks = <&clkc CLKID_CPUCLK>;
> +			#cooling-cells = <2>; /* min followed by max */
>  		};
>  	};
>  
> @@ -167,6 +172,54 @@ hwrom@0 {
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
> @@ -221,6 +274,7 @@ mali: gpu@c0000 {
>  			clocks = <&clkc CLKID_CLK81>, <&clkc CLKID_MALI>;
>  			clock-names = "bus", "core";
>  			operating-points-v2 = <&gpu_opp_table>;
> +			#cooling-cells = <2>; /* min followed by max */
>  		};
>  	};
>  }; /* end of / */
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
