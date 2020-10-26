Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FA1298DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 14:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780042AbgJZNaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 09:30:11 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45819 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780010AbgJZNaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 09:30:09 -0400
Received: by mail-oi1-f193.google.com with SMTP id j7so10448223oie.12;
        Mon, 26 Oct 2020 06:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=55mmDZwvwfu3pBHO1p8hdZSEV0EaVu21eFAlZpXqlsE=;
        b=aq2l5z+4WylCLi0PWh/S9uiFSGu4o2NEs22Z2SKUvz0tWCqmdDDtMfNEea5o8PNF56
         fn3e3aktyVpz20/gcKjoXoLjbHtMwegq0er13ZTMw84EpFyt0EEOh7qJEQYZtqENUNvA
         hqjWGjE1s8mA07BI5jyRJ4o14JqZ62Jd8YtNN4CcutaY2tBj6Cjego7lFfjkBEuV+4xK
         1tO0DTOE1vwdJQl5PbCPc/LVX0f5/g5AEMpA/EKad0AThpPjl9NMzx2TAojkSH+PSSnk
         33CJZLB2noDfZ50xjkZFzttp26NSqYonzSKQU7ZuV6gijWseSvhq4i9civNYMpBKdgFb
         1eLQ==
X-Gm-Message-State: AOAM532TM0B35SPS5lWVtFl2Tz3znUtfFytd3tV+e+me9lersHPDMKls
        JtKtJ64nCK6HYDK9IS76SQ==
X-Google-Smtp-Source: ABdhPJx0tSc7GtNFGJCgVxd1q41YYXbi/LbclPPEyv6mtyiUIy3cALbdZC5ZrMbTq4kiKwYJvwmytQ==
X-Received: by 2002:aca:e185:: with SMTP id y127mr13913476oig.57.1603719007873;
        Mon, 26 Oct 2020 06:30:07 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h32sm3525486oth.2.2020.10.26.06.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 06:30:07 -0700 (PDT)
Received: (nullmailer pid 32618 invoked by uid 1000);
        Mon, 26 Oct 2020 13:30:06 -0000
Date:   Mon, 26 Oct 2020 08:30:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
        tglx@linutronix.de, daniel.lezcano@linaro.org
Subject: Re: [PATCH 2/2] clocksource: mediatek: add clk13m and bus clock
 support
Message-ID: <20201026133006.GA29275@bogus>
References: <20201017153857.2494845-1-fparent@baylibre.com>
 <20201017153857.2494845-2-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201017153857.2494845-2-fparent@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17, 2020 at 05:38:57PM +0200, Fabien Parent wrote:
> Some MediaTek SoC like MT8516 need to enable additional clocks
> for the GPT timer. Enable them if present.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  drivers/clocksource/timer-mediatek.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
> index 9318edcd8963..42e2d2090484 100644
> --- a/drivers/clocksource/timer-mediatek.c
> +++ b/drivers/clocksource/timer-mediatek.c
> @@ -9,6 +9,7 @@
>  
>  #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
>  
> +#include <linux/clk.h>
>  #include <linux/clockchips.h>
>  #include <linux/clocksource.h>
>  #include <linux/interrupt.h>
> @@ -278,8 +279,19 @@ static int __init mtk_syst_init(struct device_node *node)
>  
>  static int __init mtk_gpt_init(struct device_node *node)
>  {
> +	struct clk *clk_13m, *clk_bus;
>  	int ret;
>  
> +	/* Optional clock*/

Then use the optional api variant.

> +	clk_13m = of_clk_get_by_name(node, "clk13m");
> +	if (!IS_ERR(clk_13m))

And then you can drop this check (or handle it for any error other than 
clock is not present).

> +		clk_prepare_enable(clk_13m);
> +
> +	/* Optional clock*/
> +	clk_bus = of_clk_get_by_name(node, "bus");
> +	if (!IS_ERR(clk_bus))
> +		clk_prepare_enable(clk_bus);
> +
>  	to.clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
>  	to.clkevt.set_state_shutdown = mtk_gpt_clkevt_shutdown;
>  	to.clkevt.set_state_periodic = mtk_gpt_clkevt_set_periodic;
> -- 
> 2.28.0
> 
