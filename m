Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37FDC278361
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 10:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgIYI6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 04:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgIYI6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 04:58:04 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C2DC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 01:58:04 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id r7so2554197ejs.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 01:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=eJsaR2S9c0RCFooPTqi2lQWjWsZMnHQ41gMbagMVzj0=;
        b=v8Y6GM9jKWXqAqyb8w0DpE3RFacTvtkMdVeac5CRaQtMbsw+wR0etpMczPxG5gBtu9
         RHXxUsXmlRG4uxuJCXthVTPqu1f1YqrWBogZOHjkPTDeWKKSObQAx7RT/D5zRz4+nOIj
         fRN9ixM4MpZml9LA9kZ0ERsJuRULY++2lfEI9Z7Ung1lZgZ6dUh6cKfScxWMNeKeF083
         4kl3t2JbvH0mWzmCL6unvpJ1ptbA4NPXc3OnU6dGDD9ATUoQ8KmEyQ0yWcIHvIoWpKhv
         r+f1IXAgcgGGFH7dM4b9/4l5Y6cS3VDIoZ3jumAF+qjjbmRDz2LntqkChCKW7+vrvnRU
         y9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=eJsaR2S9c0RCFooPTqi2lQWjWsZMnHQ41gMbagMVzj0=;
        b=V6fpOVtCSj0ScDy4Q+cXnAqgcPvjT1xzKaqgBRiD6sevHkF1Sxh3avch/zplbtusb0
         82RyajK+5iPHSEImpGb21Y2NpfZn32oaizLeaSXbTSiWxI0MEVA2mTVkBHgGbUv2cGT2
         fySZDC7ALgnj3anPZukNA1qvuCiyTalIggY0G9GMwssbH5i0YmpKKkn3hRZOVKoB28kc
         HNA7G+ixqmkqIpHhAg/ZJVO52OyOdZsaNusQe+7RBfMpuW4k7qpC9HehC5Swb21ZbyHS
         GfwKh9Zwf4jSzhuYNmNQ7WzlhGE7xoc10JSazxytwpEqogTFd3DlYcoYhOrNQjSF8c+H
         vnxA==
X-Gm-Message-State: AOAM533wW6vIodOnaI4ayi39dV76lFpW6sTrZwObQR7rbH5jczG49zHJ
        Ad5pUNEbX2x3XV4FhuUjRLzYCA==
X-Google-Smtp-Source: ABdhPJz0C9RFuiseiwDk9qPjhkaxw7fXHw7IIbLa0ThW1vPCU2JlQrYGn/aJNpj2EFBaYnhOocYgvg==
X-Received: by 2002:a17:906:3ca2:: with SMTP id b2mr1736707ejh.460.1601024282799;
        Fri, 25 Sep 2020 01:58:02 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id cf7sm1330341edb.78.2020.09.25.01.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 01:58:01 -0700 (PDT)
References: <20200925033017.1790973-1-art@khadas.com> <20200925033017.1790973-9-art@khadas.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Artem Lapkin <email2tema@gmail.com>, narmstrong@baylibre.com
Cc:     khilman@baylibre.com, robh+dt@kernel.org,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Subject: Re: [PATCH 8/8] arm64: dts: meson: enable RTC for VIM2 meson-gxm-khadas-vim2
In-reply-to: <20200925033017.1790973-9-art@khadas.com>
Date:   Fri, 25 Sep 2020 10:58:00 +0200
Message-ID: <1j1riq9qsn.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 25 Sep 2020 at 05:30, Artem Lapkin <email2tema@gmail.com> wrote:

> enable RTC for VIM2 meson-gxm-khadas-vim2
>
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> index 70343da2811..76b7e34a9a3 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> @@ -229,7 +229,7 @@ &i2c_B {
>  
>  	rtc: rtc@51 {
>  		/* has to be enabled manually when a battery is connected: */

If going for this change, this comment should have been removed

> -		status = "disabled";
> +		status = "okay";

Unless the VIMs are provided with a battery by default, I believe this
should be kept disabled and only enabled by the bootloader if necessary.

If you think differently, feel free to resubmit with a complete commit
description and some details as to how this would be an improvement.

>  		compatible = "haoyu,hym8563";
>  		reg = <0x51>;
>  		#clock-cells = <0>;

