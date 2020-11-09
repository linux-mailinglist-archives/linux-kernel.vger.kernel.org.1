Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00EE82AC800
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 23:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbgKIWFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 17:05:46 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36025 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbgKIWFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 17:05:46 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so10557003otm.3;
        Mon, 09 Nov 2020 14:05:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=52NYZ271dr+PKdWpg4JTe6Y+p4BKdJ9pDbLvzjgDFuc=;
        b=jkk4dXYXIdOvpOmPWGPQfplKkH8ReoC052bm++oFlctccOBxlR4q6G1IJkqX2qEedt
         xrOghoDavHbI9sfdjN09Bdfn+02quEPO5l8PGa4qi+LZOViK0/JVokU1LaO3L2317jXQ
         jXUGhsOw+BU+vpHxgUIXeRd9STXI6BBHrwTF6YaHfHHAMeSARAlBufhDdnEnD1usMYxh
         6wIuFX+i5BstKiwuDRNK/vkU3bf/gT/dZDsRj1w/VNCBA0zvxePOLYR9J4KXQJKmE783
         lEQkNO3EvA3dmp0nHNcJeCO6Rj0DzKFSI2PWv22QsZ4+hojxCYiKHE/xzAnx55Sb+m41
         CMnA==
X-Gm-Message-State: AOAM531EQhdWSYL7yDryoQ6MM8qkC6vlXMFLjYDT2FmxapmC0zspABFQ
        a5lG+1NVxA8+lndOPZtRjg==
X-Google-Smtp-Source: ABdhPJxx4SE/QHPlDjjGj+QgeFGayPPDmyrll7ozw0tT+d61+YMddA1OvZIQaqNq3R3mJqhxC0OBmw==
X-Received: by 2002:a9d:3b84:: with SMTP id k4mr12695420otc.4.1604959545107;
        Mon, 09 Nov 2020 14:05:45 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b92sm2802672otc.70.2020.11.09.14.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 14:05:44 -0800 (PST)
Received: (nullmailer pid 1838533 invoked by uid 1000);
        Mon, 09 Nov 2020 22:05:43 -0000
Date:   Mon, 9 Nov 2020 16:05:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        "Y . b . Lu" <yangbo.lu@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v3 3/9] clk: qoriq: provide constants for the type
Message-ID: <20201109220543.GA1835644@bogus>
References: <20201108185113.31377-1-michael@walle.cc>
 <20201108185113.31377-4-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201108185113.31377-4-michael@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 08, 2020 at 07:51:07PM +0100, Michael Walle wrote:
> To avoid future mistakes in the device tree for the clockgen module, add
> constants for the clockgen subtype as well as a macro for the PLL
> divider.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Changes since v2:
>  - new patch
> 
>  drivers/clk/clk-qoriq.c                        | 13 +++++++------
>  include/dt-bindings/clock/fsl,qoriq-clockgen.h | 15 +++++++++++++++
>  2 files changed, 22 insertions(+), 6 deletions(-)
>  create mode 100644 include/dt-bindings/clock/fsl,qoriq-clockgen.h
> 
> diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
> index 46101c6a20f2..70aa521e7e7f 100644
> --- a/drivers/clk/clk-qoriq.c
> +++ b/drivers/clk/clk-qoriq.c
> @@ -7,6 +7,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <dt-bindings/clock/fsl,qoriq-clockgen.h>
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/clkdev.h>
> @@ -1368,33 +1369,33 @@ static struct clk *clockgen_clk_get(struct of_phandle_args *clkspec, void *data)
>  	idx = clkspec->args[1];
>  
>  	switch (type) {
> -	case 0:
> +	case QORIQ_CLK_SYSCLK:
>  		if (idx != 0)
>  			goto bad_args;
>  		clk = cg->sysclk;
>  		break;
> -	case 1:
> +	case QORIQ_CLK_CMUX:
>  		if (idx >= ARRAY_SIZE(cg->cmux))
>  			goto bad_args;
>  		clk = cg->cmux[idx];
>  		break;
> -	case 2:
> +	case QORIQ_CLK_HWACCEL:
>  		if (idx >= ARRAY_SIZE(cg->hwaccel))
>  			goto bad_args;
>  		clk = cg->hwaccel[idx];
>  		break;
> -	case 3:
> +	case QORIQ_CLK_FMAN:
>  		if (idx >= ARRAY_SIZE(cg->fman))
>  			goto bad_args;
>  		clk = cg->fman[idx];
>  		break;
> -	case 4:
> +	case QORIQ_CLK_PLATFORM_PLL:
>  		pll = &cg->pll[PLATFORM_PLL];
>  		if (idx >= ARRAY_SIZE(pll->div))
>  			goto bad_args;
>  		clk = pll->div[idx].clk;
>  		break;
> -	case 5:
> +	case QORIQ_CLK_CORECLK:
>  		if (idx != 0)
>  			goto bad_args;
>  		clk = cg->coreclk;
> diff --git a/include/dt-bindings/clock/fsl,qoriq-clockgen.h b/include/dt-bindings/clock/fsl,qoriq-clockgen.h
> new file mode 100644
> index 000000000000..ddec7d0bdc7f
> --- /dev/null
> +++ b/include/dt-bindings/clock/fsl,qoriq-clockgen.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef DT_CLOCK_FSL_QORIQ_CLOCKGEN_H
> +#define DT_CLOCK_FSL_QORIQ_CLOCKGEN_H
> +
> +#define QORIQ_CLK_SYSCLK	0
> +#define QORIQ_CLK_CMUX		1
> +#define QORIQ_CLK_HWACCEL	2
> +#define QORIQ_CLK_FMAN		3
> +#define QORIQ_CLK_PLATFORM_PLL	4
> +#define QORIQ_CLK_CORECLK	5
> +
> +#define QORIQ_CLK_PLL_DIV(x)	((x) - 1)

This is not used and doesn't seem like part of the ABI (shared with dts 
files).

> +
> +#endif /* DT_CLOCK_FSL_QORIQ_CLOCKGEN_H */
> -- 
> 2.20.1
> 
