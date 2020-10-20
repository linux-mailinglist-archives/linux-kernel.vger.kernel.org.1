Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8AC293F2F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 17:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbgJTPDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 11:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731050AbgJTPDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 11:03:18 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9BBC061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 08:03:18 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id az3so1036562pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=DQj1vw5Q5iR2S7fc6h8mk0PeFNHHD7EB9QXujK3XyAc=;
        b=SYXXy70SGU+w+Up3SIREVdDig4z3khzULIce0mBbhmnDDMBwGIY8e57/XVbn+4zyRu
         kGiac/dMzNw60LTFL16pTuu2/+iN/FczvCKNOP8CJyKJYw6b94zu6g8WLjr4MQvUcEVu
         0Io3AugrfnfijxcP+4n4wBYePyUM13QYYFyC1IVaN3i65sUK+w6dFSg8KJxyu/SVKGJ/
         uerRL29ngMdh9HudoUd/uOL44dQDstfrcLEqvm02WXmfIjZV5onSDhvb0QPV2Z3jcyln
         2LS1MRlUdW+RG8oe+icX40OIpiB8AlpeFyDxpppTf+xdWE6iOgCNoKFaM4mzLsBXLCIq
         wn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=DQj1vw5Q5iR2S7fc6h8mk0PeFNHHD7EB9QXujK3XyAc=;
        b=jEPvdMRIMXoeJH9zkGggTHuteAuwWVn8jpa5ShNFXbzmFva21PV8T18ulnN3bCxffy
         6ndGKVZxSx9vYjN9B4DJrQINvRnaBmNzgGdrfmfQuj48aH0FFdHlinBlC8Qs5nCiw28G
         R4s6THF1qGWcDiXrkYUtUmcYzF7LEO2I9ZmvPJ9oXo+M354s7ZbxnofNpOgI670twKjT
         iveXnZkEMgjscCHMYeCYN/Hd/dd4JWZc6kNAyg3w4Ci/62oCt+KjZ4++PUvd0bBAjLM+
         nLU1Tj+wEFtSYKSe4GTj6JGEi3Nz7Ve2e808QhrO2+SV8OZhupyOAFrtxW3Wugaf/xwN
         fb3w==
X-Gm-Message-State: AOAM531BKtuol+IMzguYY9ISCUMpb0X0vVEb6tIm8LfZJVLlRr2iAhEy
        zpARFup2JUeYD2xUyD1pLhGkJovHanDq0vhi
X-Google-Smtp-Source: ABdhPJw47uzkbIxu8PDHL9D6AYEnUNBuYPrgkQ4Elau8tT01n2rh08OpwhViQ8uNYXwxXSAbjj1flg==
X-Received: by 2002:a17:902:8a97:b029:d4:d3f4:d209 with SMTP id p23-20020a1709028a97b02900d4d3f4d209mr3361281plo.35.1603206197714;
        Tue, 20 Oct 2020 08:03:17 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id v3sm2275686pfu.165.2020.10.20.08.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 08:03:17 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: meson: ship only the necessary clock controllers
In-Reply-To: <20201020075034.172825-1-jbrunet@baylibre.com>
References: <20201020075034.172825-1-jbrunet@baylibre.com>
Date:   Tue, 20 Oct 2020 08:03:16 -0700
Message-ID: <7hblgxkki3.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> There now the menu entries for the amlogic clock controllers.
> Do not select these when ARM64 is enabled so it possible to ship only the
> required.
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/Kconfig.platforms | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index cd58f8495c45..b22d1bdd6eb6 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -154,9 +154,6 @@ config ARCH_MESON
>  	bool "Amlogic Platforms"
>  	select PINCTRL
>  	select PINCTRL_MESON
> -	select COMMON_CLK_GXBB
> -	select COMMON_CLK_AXG
> -	select COMMON_CLK_G12A

This patch alone will break boot when using the default, upstream
defconfig because these options will all now be disabled and we'll have
no clock providers.

I think you also need a default value (e.g. `default y`) in
drivers/clk/meson/Kconfig for each of these entries to keep the same
defaults.   But these defaults could be overridden by SoC-specific
defconfigs leading to more flexibilty.

So, assuming you queue up a drivers/clk patch to go in when this
lands...

Acked-by: Kevin Hilman <khilman@baylibre.com>

