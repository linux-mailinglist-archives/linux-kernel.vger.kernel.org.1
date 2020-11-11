Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3114F2AFCEF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgKLBdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbgKKWqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 17:46:47 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B760C061A47;
        Wed, 11 Nov 2020 14:28:42 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id f16so3665818otl.11;
        Wed, 11 Nov 2020 14:28:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I7afwCU5Zz8A6AK7ziXO/mFlkl96qobpis0V/RHYr6g=;
        b=HllTtBb+9w+4/jezG3C+36OqM7mrWaU3vlR1uvVuiuMQtsHtsyBx9BOxhcqNl4IjAd
         fCkO9Sv+RZ/Q349f4wVGa6AGhqqGNxrUF5NASjD2czVuu/cWTMuUSLWNJn/cM2vI9O2u
         8wudHIn9sVgTFODGbXK8QEnMscVSAV9BnPjD5qfIGGBejXambW2mBZGCmP8AO/zmF5w+
         y8gg0YAt7t5aF7BmNlBzy4rHxxQFjp8nn++gB3kYsiqW6XAeO0zkF9UfyOesIJtijmp8
         4QYQJXntYLMOgyo2Y0qKKRUg6/81P3Hbs7XwJhQBNiRYHEZBTC6tRjtK9HnzSEltVPYc
         /K3Q==
X-Gm-Message-State: AOAM533fhiRiOTUJIADgfaxhq5O0Ro0YGmL49k/yUmZRMudj8uxwLnOw
        k6wOiwA4+d/NcGFmuqQ3IQ==
X-Google-Smtp-Source: ABdhPJzZzxj/l38ISSbGAqIMW+OGIR82Les8jqXmZTG7FPHFTvrMsSSQiM9e38zItHJEQCMCl/gmwQ==
X-Received: by 2002:a9d:3d3:: with SMTP id f77mr19065035otf.125.1605133421911;
        Wed, 11 Nov 2020 14:23:41 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t6sm828879ooo.22.2020.11.11.14.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 14:23:41 -0800 (PST)
Received: (nullmailer pid 2149138 invoked by uid 1000);
        Wed, 11 Nov 2020 22:23:40 -0000
Date:   Wed, 11 Nov 2020 16:23:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dongjiu Geng <gengdongjiu@huawei.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: hisilicon: Add clock driver for hi3559A SoC
Message-ID: <20201111222340.GA2143735@bogus>
References: <20201109202838.43105-1-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109202838.43105-1-gengdongjiu@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 08:28:38PM +0000, Dongjiu Geng wrote:
> Add clock drivers for hi3559A SoC, this driver controls the SoC
> registers to supply different clocks to different IPs in the SoC.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
>  drivers/clk/hisilicon/Kconfig                 |   7 +
>  drivers/clk/hisilicon/Makefile                |   1 +
>  drivers/clk/hisilicon/clk-hi3559a.c           | 873 ++++++++++++++++++
>  include/dt-bindings/clock/hi3559av100-clock.h | 173 ++++

Is there a binding for this? The header should be part of it.

>  4 files changed, 1054 insertions(+)
>  create mode 100644 drivers/clk/hisilicon/clk-hi3559a.c
>  create mode 100644 include/dt-bindings/clock/hi3559av100-clock.h
> 
> diff --git a/drivers/clk/hisilicon/Kconfig b/drivers/clk/hisilicon/Kconfig
> index 6a9e93a0bb95..5ecc37aaa118 100644
> --- a/drivers/clk/hisilicon/Kconfig
> +++ b/drivers/clk/hisilicon/Kconfig
> @@ -15,6 +15,13 @@ config COMMON_CLK_HI3519
>  	help
>  	  Build the clock driver for hi3519.
>  
> +config COMMON_CLK_HI3559A
> +	bool "Hi3559A Clock Driver"
> +	depends on ARCH_HISI || COMPILE_TEST
> +	default ARCH_HISI
> +	help
> +	  Build the clock driver for hi3559a.
> +
>  config COMMON_CLK_HI3660
>  	bool "Hi3660 Clock Driver"
>  	depends on ARCH_HISI || COMPILE_TEST
> diff --git a/drivers/clk/hisilicon/Makefile b/drivers/clk/hisilicon/Makefile
> index b2441b99f3d5..bc101833b35e 100644
> --- a/drivers/clk/hisilicon/Makefile
> +++ b/drivers/clk/hisilicon/Makefile
> @@ -17,3 +17,4 @@ obj-$(CONFIG_COMMON_CLK_HI6220)	+= clk-hi6220.o
>  obj-$(CONFIG_RESET_HISI)	+= reset.o
>  obj-$(CONFIG_STUB_CLK_HI6220)	+= clk-hi6220-stub.o
>  obj-$(CONFIG_STUB_CLK_HI3660)	+= clk-hi3660-stub.o
> +obj-$(CONFIG_COMMON_CLK_HI3559A)	+= clk-hi3559a.o
> diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/clk-hi3559a.c
> new file mode 100644
> index 000000000000..bd3921fc8c8e
> --- /dev/null
> +++ b/drivers/clk/hisilicon/clk-hi3559a.c
> @@ -0,0 +1,873 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Hisilicon Hi3559A clock driver
> + *
> + * Copyright (c) 2019-2020 HiSilicon Technologies Co., Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.

Don't need both this and SPDX tag. Kernel code should be GPL-2.0 (-only) 
generally.

> + *
> + * Author: Dongjiu Geng <gengdongjiu@huawei.com>

git will tell us this.

Same comments apply to the header. Though DT headers should be dual 
licensed.

Rob
