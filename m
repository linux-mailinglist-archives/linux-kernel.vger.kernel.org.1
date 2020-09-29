Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671D927C10E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgI2J0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgI2J0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:26:35 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DB7C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 02:26:35 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j2so4534051wrx.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 02:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YhPm+9XSIa063djb3KYBZcrsLNGALctT0yxUobnyP7g=;
        b=K5k7YwRiSFmd3dGvKV6HH2EfquMS34lxm3BxGaERUgAl9hK+82vNKpfzEl/9UTsJ2s
         pyEVBPGN3QJJwW4a7+Ki1NbhIAJAi9uZMSeV3NnfDq/0mYra4bDSFJ23G0FPtDdn6Qgg
         L2d8ArAHc6746je9dxTGpLbg7v2qu3WBnc3DKVTNYjUAzBzwG9CQvhGAI1TCOqzOtN4l
         Soax5kl1UfKQHsFmimuD3L0yVEmx+hORBefC7RvKoeaMsYOM17agRNnNRIOnT+fMjykz
         AXLShyDJPFKenrdfftaRAbEYk1pR1Z73gU06FWVvpX7TyhVzmgtNlSq7lax4x/7jlKMe
         oPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YhPm+9XSIa063djb3KYBZcrsLNGALctT0yxUobnyP7g=;
        b=ITdCEOF5z9UzGlh3ouJP9JkUo7NuauFwfbX1DIO9iSnP9PgqSjbWdn25dHLQKR5blU
         tKT2X4X99fPITv80d2RD//7JB4DXfao89dD4uOcpppBgx7/O64djHWD1lQXRmudqdpcV
         GlOSxA/qCBVAmMLFfi4MmsgebKQiP3bR8jskIdtYw1HIwTHLejXrfO/x11P0fqqT/hWI
         2rZPzdH9tx0tnmqyPBV7AA/BAD9mBEt1KsiClQjz+AJ+mW1Ci/25T7gWiByIOD+XmqKE
         5ju7R5Mmd/wvcbTjnfU3Kmp2A1AbWazhY44BAlCdv8bwPWOfzKfhQLR34A4xQ6nZi+4c
         M8jw==
X-Gm-Message-State: AOAM530dosjR8QxJZDe49VORvYtcS06raBizyMsbY2/MrKUIJZPV0NB0
        JLG5FC2VJC/H5t6EjFBpkWsqKA==
X-Google-Smtp-Source: ABdhPJwE1Z+6gxE1Cf6FS4vRe7b18sOoy0/iMBOvBXHUKz76KfpE2gNXLHz6Ev7i+ohcGkaoeoboGw==
X-Received: by 2002:a05:6000:118a:: with SMTP id g10mr3245186wrx.67.1601371594009;
        Tue, 29 Sep 2020 02:26:34 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:d50c:1ee4:fec5:ad12? ([2a01:e35:2ec0:82b0:d50c:1ee4:fec5:ad12])
        by smtp.gmail.com with ESMTPSA id s12sm4303519wmd.20.2020.09.29.02.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 02:26:33 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] usb: dwc-meson-g12a: Add support for USB on S400
 board
To:     khilman@baylibre.com, kishon@ti.com, balbi@kernel.org,
        martin.blumenstingl@googlemail.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20200917065949.3476-1-narmstrong@baylibre.com>
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
Message-ID: <5e69947c-8a91-af7f-ed86-996920109e79@baylibre.com>
Date:   Tue, 29 Sep 2020 11:26:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200917065949.3476-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

Is there anything to change in this serie ?

Thanks,
Neil

On 17/09/2020 08:59, Neil Armstrong wrote:
> The Amlogic AXG is close to the GXL Glue but with a single OTG PHY.
> 
> It needs the same init sequence as GXL & GXM, but it seems it doesn't need
> the host disconnect bit.
> 
> The Glue driver reuses the already implemented GXL & GXM work.
> 
> The USB2 PHY driver needs a slight tweak to keep the OTG detection working.
> 
> Changes since v1 at [1]:
> - s/close from/close to/g
> - collected review tags
> - added small comment about phy management in patch 3
> - removed status = "okay" in patch 4
> - removed invalid phy-supply of phy1 in patch 5
> 
> [1] http://lore.kernel.org/r/20200909160409.8678-1-narmstrong@baylibre.com
> 
> Neil Armstrong (5):
>   phy: amlogic: phy-meson-gxl-usb2: keep ID pull-up even in Host mode
>   dt-bindings: usb: amlogic,meson-g12a-usb-ctrl: add the Amlogic AXG
>     Families USB Glue Bindings
>   usb: dwc-meson-g12a: Add support for USB on AXG SoCs
>   arm64: dts: meson-axg: add USB nodes
>   arm64: dts: meson-axg-s400: enable USB OTG
> 
>  .../usb/amlogic,meson-g12a-usb-ctrl.yaml      | 22 +++++++-
>  .../arm64/boot/dts/amlogic/meson-axg-s400.dts |  6 +++
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi    | 50 +++++++++++++++++++
>  drivers/phy/amlogic/phy-meson-gxl-usb2.c      |  3 +-
>  drivers/usb/dwc3/dwc3-meson-g12a.c            | 18 +++++++
>  5 files changed, 97 insertions(+), 2 deletions(-)
> 

