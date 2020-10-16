Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC7D290CD0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 22:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407672AbgJPUoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 16:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407448AbgJPUoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 16:44:30 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E185BC061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 13:44:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k18so4332212wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 13:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=5XhpSIxhw7frhhWif6TnITOoeBwLv9Zj9L9MaPglXfE=;
        b=nLq4PCLnWAcna0PaJ322UevLhxmI/udpFGmNUyov5qb4+VvhuDEP4oBmVmMxHh5GZu
         UJmh6XlDGncgqz7PzVQXuh2ueeTy1Mqk3Ik6k3MkhMlBCfAmvgpHibXuHvVlwybDm2xn
         07BT1QtaWYfjedyh/kDAN7jClMLUdnxFYuzI7VzvsbdrfhoD/DSASiRI1ZSkkrPqDE/G
         /0tt6HL+OxQjlZa2+pHkA0qQqtPv4XqAP5GRfjV9AQjxF3o32HI20G4Wo1SBn0U4bJCQ
         B6vO0bqW2xc559jgjlwxkJwrCpoF8G1nOG1HUGX7XGJ/D8vqblxnDjwUcfJ/XhehkAgr
         N18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5XhpSIxhw7frhhWif6TnITOoeBwLv9Zj9L9MaPglXfE=;
        b=RpU1bS48UJ8+poFm4wZMMBKni2ARxibTBtkl+4eFhbkXKsj7jSqI+DhIVtlMoDuuS/
         boXr989kglFI1ClRvqMsPIMqaIeX7eGx84RMkZAlbzquh+lwkaE2QNnn1ROfl5Ly8vFd
         xwJK6YZy/Mm9QRX0zFZaU93H470HibMAa74WqDbawI4SKkhxl97sJGMLJoCiYP4rkBsu
         FHqmeeB8kFOKozGKG5D6CNWUtLwg1UYClRYYSY6vDU3zkUBri7alhOkMUB7/Oin9qCb9
         s/g3QAtOrFx5fvuVjXUlTkqcHL90iiNY+kg7Csrj6JC7NBwTNM40BOVo/TAgax76Fu/E
         cIqw==
X-Gm-Message-State: AOAM533L0gnA/EIZbgdqAKKmfyXUBl7q4K0fRblKwhKp6408qJRuQZga
        lL1UxUdyTmEiITT3azTFaA3r9wBUrUQj3T2EPj0=
X-Google-Smtp-Source: ABdhPJz/gQMlKhpXN309WQzLkG+ZLoJIfRABj2DFSggmC6KLOOX5BOV6MOJfENHwQRXwb1ZOdnCpFw==
X-Received: by 2002:a1c:9d87:: with SMTP id g129mr5476965wme.30.1602881068479;
        Fri, 16 Oct 2020 13:44:28 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id d2sm5001062wrq.34.2020.10.16.13.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 13:44:27 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, p.zabel@pengutronix.de
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] reset: meson: make it possible to build as a module
In-Reply-To: <20201013133943.412119-1-narmstrong@baylibre.com>
References: <20201013133943.412119-1-narmstrong@baylibre.com>
Date:   Fri, 16 Oct 2020 13:44:24 -0700
Message-ID: <7hd01h295j.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> In order to reduce the kernel Image size on multi-platform distributions,
> make it possible to build the reset controller driver as a module.
>
> This partially reverts 8290924e ("reset: meson: make it explicitly non-modular")
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/reset/Kconfig       | 4 ++--
>  drivers/reset/reset-meson.c | 7 ++++++-
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index d9efbfd29646..ab315617565f 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -94,8 +94,8 @@ config RESET_LPC18XX
>  	  This enables the reset controller driver for NXP LPC18xx/43xx SoCs.
>  
>  config RESET_MESON
> -	bool "Meson Reset Driver" if COMPILE_TEST
> -	default ARCH_MESON
> +	tristate "Meson Reset Driver"
> +	default ARCH_MESON || COMPILE_TEST
>  	help
>  	  This enables the reset driver for Amlogic Meson SoCs.
>  
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index 94d7ba88d7d2..434d5c0f877e 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
> @@ -9,6 +9,7 @@
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> +#include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset-controller.h>
>  #include <linux/slab.h>
> @@ -142,4 +143,8 @@ static struct platform_driver meson_reset_driver = {
>  		.of_match_table	= meson_reset_dt_ids,
>  	},
>  };
> -builtin_platform_driver(meson_reset_driver);
> +module_platform_driver(meson_reset_driver);

I tried this as as a module, and it never probed because it's missing
this on the compatible table:

   MODULE_DEVICE_TABLE(of, meson_reset_dt_ids);

With that minor change:

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin
