Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11BF2A6321
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 12:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgKDLRe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Nov 2020 06:17:34 -0500
Received: from aposti.net ([89.234.176.197]:49088 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729427AbgKDLRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:17:22 -0500
Date:   Wed, 04 Nov 2020 11:17:02 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] clk: ingenic/TCU: Remove NULL pointer check before
 clk_enable/disable
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.or, linux-kernel@vger.kernel.org
Message-Id: <ECR9JQ.NFV4ZB9VUP182@crapouillou.net>
In-Reply-To: <20201104071114.6322-1-vulab@iscas.ac.cn>
References: <20201104071114.6322-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mer. 4 nov. 2020 à 7:11, Xu Wang <vulab@iscas.ac.cn> a écrit :
> Because clk_enable and clk_disable already checked NULL clock 
> parameter,
> so the additional checks are unnecessary, just remove them.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/clk/ingenic/tcu.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/ingenic/tcu.c b/drivers/clk/ingenic/tcu.c
> index 9382dc3aa27e..ffcb3667fd2b 100644
> --- a/drivers/clk/ingenic/tcu.c
> +++ b/drivers/clk/ingenic/tcu.c
> @@ -445,8 +445,7 @@ static int __maybe_unused tcu_pm_suspend(void)
>  {
>  	struct ingenic_tcu *tcu = ingenic_tcu;
> 
> -	if (tcu->clk)
> -		clk_disable(tcu->clk);
> +	clk_disable(tcu->clk);
> 
>  	return 0;
>  }
> @@ -455,8 +454,7 @@ static void __maybe_unused tcu_pm_resume(void)
>  {
>  	struct ingenic_tcu *tcu = ingenic_tcu;
> 
> -	if (tcu->clk)
> -		clk_enable(tcu->clk);
> +	clk_enable(tcu->clk);
>  }
> 
>  static struct syscore_ops __maybe_unused tcu_pm_ops = {
> --
> 2.17.1
> 


