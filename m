Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12332C3E56
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 11:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgKYKqI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Nov 2020 05:46:08 -0500
Received: from aposti.net ([89.234.176.197]:44500 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgKYKqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 05:46:08 -0500
Date:   Wed, 25 Nov 2020 10:45:51 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] clocksource/drivers/ingenic: Fix section mismatch
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        zhouyanjie@wanyeetech.com, paul@boddie.org.uk, hns@goldelico.com,
        kernel test robot <lkp@intel.com>
Message-Id: <FWLCKQ.NKKU1E0NS7SQ2@crapouillou.net>
In-Reply-To: <20201125102346.1816310-1-daniel.lezcano@linaro.org>
References: <202011251435.7F0RQBXw-lkp@intel.com>
        <20201125102346.1816310-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Le mer. 25 nov. 2020 à 11:23, Daniel Lezcano 
<daniel.lezcano@linaro.org> a écrit :
> The function ingenic_tcu_get_clock() is annotated for the __init
> section but it is actually called from the online cpu callback.
> 
> That will lead to a crash if a CPU is hotplugged after boot time.
> 
> Remove the __init annotatation for the ingenic_tcu_get_clock()
> function.

One 'ta' too many ;)

> 
> Fixes: f19d838d08fc (clocksource/drivers/ingenic: Add high resolution 
> timer support for SMP/SMT)
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

With the above fixed:
Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/clocksource/ingenic-timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/ingenic-timer.c 
> b/drivers/clocksource/ingenic-timer.c
> index 58fd9189fab7..905fd6b163a8 100644
> --- a/drivers/clocksource/ingenic-timer.c
> +++ b/drivers/clocksource/ingenic-timer.c
> @@ -127,7 +127,7 @@ static irqreturn_t ingenic_tcu_cevt_cb(int irq, 
> void *dev_id)
>  	return IRQ_HANDLED;
>  }
> 
> -static struct clk * __init ingenic_tcu_get_clock(struct device_node 
> *np, int id)
> +static struct clk *ingenic_tcu_get_clock(struct device_node *np, int 
> id)
>  {
>  	struct of_phandle_args args;
> 
> --
> 2.25.1
> 


