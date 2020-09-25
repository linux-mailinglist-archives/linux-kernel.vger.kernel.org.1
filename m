Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB23278F51
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 19:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbgIYREz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 13:04:55 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44359 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbgIYREy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 13:04:54 -0400
Received: by mail-ed1-f67.google.com with SMTP id b12so3177995edz.11;
        Fri, 25 Sep 2020 10:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7H2Bk9gpg/w+wUoObaKvu/mtCEHvMrdXma3hhs6oCPA=;
        b=g5ROF5GAZPfAatV61rQHJl341YAEAuOoWj3mA6fNWcvgEmeRA6AnzPWUCO0meGlFZB
         5KWvHRCasYK+eri7tronQb7RMA6EjerGe3dPGvDQrP8XOGpCDpwx5c5vNo5L0b+b2WLn
         /tgT0HzC1h0k4+gX9EsyTsi9GKFSc/jYD5GJq327/1puQLvc4GcngZCOafQdbe5wJmXA
         Xbx0kSWFux7hZOAJpIeQYYlGLr808OU9Q5Jujdmfz/JOqvYjqjR6mRI2XRPK3EZIGkFN
         tQjBYnO5s6o1bhDMOO2bpRKSBtAU7EfqP0ziDkDbFkVAqP7HsSvLciIAM8JU13BDTS1B
         dDyQ==
X-Gm-Message-State: AOAM531KgPhYkHpSXfqzYrPTdY5ofujCN9WgzTIFINEzwsPM0UffJp+A
        lOh5HK1TZrxoAAqzYWBTDLg=
X-Google-Smtp-Source: ABdhPJzshXZU4mumXpaaqCcRqza8EX1pZ67x1HLojNLckvWgfrfQH6BmnBoLuzW1ylscuLUKq7fF/A==
X-Received: by 2002:a50:c8cd:: with SMTP id k13mr2333610edh.387.1601053492597;
        Fri, 25 Sep 2020 10:04:52 -0700 (PDT)
Received: from kozik-lap ([194.230.155.132])
        by smtp.googlemail.com with ESMTPSA id 40sm2174254edr.67.2020.09.25.10.04.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Sep 2020 10:04:51 -0700 (PDT)
Date:   Fri, 25 Sep 2020 19:04:49 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: host: fix depends for MMC_MESON_GX w/ COMPILE_TEST
Message-ID: <20200925170449.GA18717@kozik-lap>
References: <20200925164323.29843-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200925164323.29843-1-rdunlap@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 09:43:23AM -0700, Randy Dunlap wrote:
> Fix build errors for meson-gx-mmc.c when CONFIG_COMMON_CLK is not
> set/enabled. This can happen when COMPILE_TEST is set/enabled.
> 
> ERROR: modpost: "clk_divider_ops" [drivers/mmc/host/meson-gx-mmc.ko] undefined!
> ERROR: modpost: "devm_clk_register" [drivers/mmc/host/meson-gx-mmc.ko] undefined!
> ERROR: modpost: "clk_mux_ops" [drivers/mmc/host/meson-gx-mmc.ko] undefined!
> ERROR: modpost: "__clk_get_name" [drivers/mmc/host/meson-gx-mmc.ko] undefined!
> 
> Fixes: 54d8454436a2 ("mmc: host: Enable compile testing of multiple drivers")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: linux-amlogic@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/mmc/host/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20200925.orig/drivers/mmc/host/Kconfig
> +++ linux-next-20200925/drivers/mmc/host/Kconfig
> @@ -425,6 +425,7 @@ config MMC_SDHCI_IPROC
>  config MMC_MESON_GX
>  	tristate "Amlogic S905/GX*/AXG SD/MMC Host Controller support"
>  	depends on ARCH_MESON|| COMPILE_TEST
> +	depends on COMMON_CLK

I received a report from kbuild about this when I posted the patchset
but somehow I was not able to reproduce it... or I skipped this for
reason I do not remember now, my bad.

Anyway, thanks for fixing, looks ok:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Also please for the credits (as Kbuild did report it to me):
Reported-by: kernel test robot <lkp@intel.com>

Best regards,
Krzysztof

>  	help
>  	  This selects support for the Amlogic SD/MMC Host Controller
>  	  found on the S905/GX*/AXG family of SoCs.  This controller is
