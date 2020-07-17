Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DD42237DB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 11:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgGQJKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 05:10:08 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:54759 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGQJKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:10:08 -0400
X-Originating-IP: 90.65.108.121
Received: from localhost (lfbn-lyo-1-1676-121.w90-65.abo.wanadoo.fr [90.65.108.121])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 87555E0019;
        Fri, 17 Jul 2020 09:09:59 +0000 (UTC)
Date:   Fri, 17 Jul 2020 11:09:59 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com,
        bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/19] clk: at91: clk-generated: continue if
 __clk_determine_rate() returns error
Message-ID: <20200717090959.GI3428@piout.net>
References: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
 <1594812267-6697-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594812267-6697-2-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2020 14:24:09+0300, Claudiu Beznea wrote:
> __clk_determine_rate() may return error. Skip the current step
> in case of error.
> 
> Fixes: 1a1a36d72e3d3 ("clk: at91: clk-generated: make gclk determine audio_pll rate")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/clk/at91/clk-generated.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
> index 44a46dcc0518..995a13133cfb 100644
> --- a/drivers/clk/at91/clk-generated.c
> +++ b/drivers/clk/at91/clk-generated.c
> @@ -170,7 +170,8 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
>  
>  	for (div = 1; div < GENERATED_MAX_DIV + 2; div++) {
>  		req_parent.rate = req->rate * div;
> -		__clk_determine_rate(parent, &req_parent);
> +		if (__clk_determine_rate(parent, &req_parent))
> +			continue;
>  		clk_generated_best_diff(req, parent, req_parent.rate, div,
>  					&best_diff, &best_rate);
>  
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
