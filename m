Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4F51A945E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 09:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635189AbgDOHhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 03:37:41 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:54295 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505530AbgDOHhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 03:37:18 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 7923E20000C;
        Wed, 15 Apr 2020 07:37:12 +0000 (UTC)
Date:   Wed, 15 Apr 2020 09:37:11 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] clocksource: atmel-st: remove useless 'status'
Message-ID: <20200415073711.GM34509@piout.net>
References: <20200414120238.35704-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414120238.35704-1-yanaijie@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2020 20:02:38+0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> drivers/clocksource/timer-atmel-st.c:142:6-12: Unneeded variable:
> "status". Return "0" on line 166
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/clocksource/timer-atmel-st.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksource/timer-atmel-st.c
> index ab0aabfae5f0..73e8aee445da 100644
> --- a/drivers/clocksource/timer-atmel-st.c
> +++ b/drivers/clocksource/timer-atmel-st.c
> @@ -139,7 +139,6 @@ static int
>  clkevt32k_next_event(unsigned long delta, struct clock_event_device *dev)
>  {
>  	u32		alm;
> -	int		status = 0;
>  	unsigned int	val;
>  
>  	BUG_ON(delta < 2);
> @@ -163,7 +162,7 @@ clkevt32k_next_event(unsigned long delta, struct clock_event_device *dev)
>  	alm += delta;
>  	regmap_write(regmap_st, AT91_ST_RTAR, alm);
>  
> -	return status;
> +	return 0;
>  }
>  
>  static struct clock_event_device clkevt = {
> -- 
> 2.21.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
