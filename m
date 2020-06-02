Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8B81EC5A3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 01:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgFBXZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 19:25:47 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57768 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgFBXZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 19:25:44 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 94DAA803083B;
        Tue,  2 Jun 2020 23:25:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HqrrXw53g8GN; Wed,  3 Jun 2020 02:25:40 +0300 (MSK)
Date:   Wed, 3 Jun 2020 02:25:40 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Colin King <colin.king@canonical.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: baikal-t1: remove redundant assignment to variable
 'divider'
Message-ID: <20200602232540.dn5p5wpduyrcgv75@mobilestation>
References: <20200602172435.70282-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200602172435.70282-1-colin.king@canonical.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 06:24:35PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable divider is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.

Right. Thanks.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/clk/baikal-t1/ccu-div.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/baikal-t1/ccu-div.c b/drivers/clk/baikal-t1/ccu-div.c
> index bd40f5936f08..4062092d67f9 100644
> --- a/drivers/clk/baikal-t1/ccu-div.c
> +++ b/drivers/clk/baikal-t1/ccu-div.c
> @@ -248,7 +248,7 @@ static int ccu_div_var_set_rate_fast(struct clk_hw *hw, unsigned long rate,
>  				     unsigned long parent_rate)
>  {
>  	struct ccu_div *div = to_ccu_div(hw);
> -	unsigned long flags, divider = 1;
> +	unsigned long flags, divider;
>  	u32 val;
>  
>  	divider = ccu_div_var_calc_divider(rate, parent_rate, div->mask);
> -- 
> 2.25.1
> 
