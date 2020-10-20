Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CD1294566
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 01:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410558AbgJTXSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 19:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410551AbgJTXSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 19:18:33 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBBDC0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 16:18:33 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 144so332986pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 16:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=2wqgvG8HHvOH4aVEaKKNvxTjnCsiFpKpB4iBa9voxnM=;
        b=fKVYaGX7WM+dPst1qT3K6kcPzLP81IP/ceU8fyBoqKHqaa+l6FhVzKrogLJ4DxdW/w
         VLxbKL2j+3LivkFel5Yn/DCrkxTslkOBBEzFGCqum4HBzK9x4gDMCfdGvn4zjPwW4Nwm
         YHMQT8bPIpbcXtKFN3/sK1c/aLQqtgeyZpsSNjXWy/U1KALs8hWmO30nHLt2iI+Ohv14
         xHbkQamrxEi30Hxd7haxzXX1guOcLYWO88E6ppfkTpFbKk4HxPJOStazQBfcQFJK75AH
         OdiW5tpR8Uj0hwz3/AV80KsR52MGss1ktc8kLM6IUlZycIF7BMdDLGQWMNs4nqnyc31e
         OoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=2wqgvG8HHvOH4aVEaKKNvxTjnCsiFpKpB4iBa9voxnM=;
        b=UAVNfM88zk3t+imJy3+UA4UWB9RfYTy/vMqnNN4I/7aHgDq0AaBYrsKVnjcMO+R65T
         7VK08doblwMGOZ3A+SzaVA4pFTzKicSN2203rsZz5V7qZPefb5WqmP6llE2aX+Gy8z6E
         A5mE8XEB59NgsVN02kn4JCLalIJCXC+aw6OxSd8iuAOmf4ZfsREnYKkkXBR/iuQ9YP1U
         m0HmISRxIS6bsAKPWRJflyYAtH8zpo58Tc2SLH7GhnqJ9Pm19tGEgNElMk+8BvmgAK9f
         sCwOGEdITvjI24u7Fpsmd4uTRUjGIiDHMWjQxcmO4Gkl9HW+S65IexYd4gNvIUjYkP4z
         mdLA==
X-Gm-Message-State: AOAM531Opzp26KIqXR4S+IzB0onoG+RIyo8cDQeHbtsPO++C4rXvDP8t
        RaWtYZAVfiqFTmG4cdBoDEPkvA==
X-Google-Smtp-Source: ABdhPJzwAtKxmBx7kSlE0opZP+bvVbWO0/UxsnavNinj1fSw1OPF6+Mb2m3pQiwt6vpbJh13wnWaxg==
X-Received: by 2002:a62:1844:0:b029:152:80d3:8647 with SMTP id 65-20020a6218440000b029015280d38647mr412213pfy.18.1603235913131;
        Tue, 20 Oct 2020 16:18:33 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id n2sm185306pja.41.2020.10.20.16.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 16:18:32 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, maz@kernel.org
Cc:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/2] arm64: meson: remove MESON_IRQ_GPIO selection
In-Reply-To: <20201020072532.949137-3-narmstrong@baylibre.com>
References: <20201020072532.949137-1-narmstrong@baylibre.com> <20201020072532.949137-3-narmstrong@baylibre.com>
Date:   Tue, 20 Oct 2020 16:18:31 -0700
Message-ID: <7hv9f4ij08.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Selecting MESON_IRQ_GPIO forces it as built-in, but we may need to build it
> as a module, thus remove it here and let the "default ARCH_MESON" build as
> built-in by default with the option to switch it to module.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

I'll queue this one via the amlogic tree since we'll likely be removing
the rest of these selects soon too.

Kevin

> ---
>  arch/arm64/Kconfig.platforms | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index cd58f8495c45..dfb66917f665 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -157,7 +157,6 @@ config ARCH_MESON
>  	select COMMON_CLK_GXBB
>  	select COMMON_CLK_AXG
>  	select COMMON_CLK_G12A
> -	select MESON_IRQ_GPIO
>  	help
>  	  This enables support for the arm64 based Amlogic SoCs
>  	  such as the s905, S905X/D, S912, A113X/D or S905X/D2
> -- 
> 2.25.1
