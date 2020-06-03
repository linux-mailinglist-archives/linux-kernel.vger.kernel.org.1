Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A6E1ECC6F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 11:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgFCJTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 05:19:41 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:59694 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgFCJTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 05:19:39 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 7AA73803083B;
        Wed,  3 Jun 2020 09:19:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xlDcL2gyq2Ni; Wed,  3 Jun 2020 12:19:35 +0300 (MSK)
Date:   Wed, 3 Jun 2020 12:19:34 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Colin King <colin.king@canonical.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH][next] clk: baikal-t1: fix spelling mistake
 "Uncompatible" -> "Incompatible"
Message-ID: <20200603091934.vt5skqdzy6gnc5rk@mobilestation>
References: <20200602121030.39132-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200602121030.39132-1-colin.king@canonical.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 01:10:30PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a pr_err error message. Fix it.

Thanks!

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/clk/baikal-t1/clk-ccu-div.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/baikal-t1/clk-ccu-div.c b/drivers/clk/baikal-t1/clk-ccu-div.c
> index b479156e5e9b..f141fda12b09 100644
> --- a/drivers/clk/baikal-t1/clk-ccu-div.c
> +++ b/drivers/clk/baikal-t1/clk-ccu-div.c
> @@ -316,7 +316,7 @@ static struct ccu_div_data *ccu_div_create_data(struct device_node *np)
>  		data->rst_num = ARRAY_SIZE(sys_rst_map);
>  		data->rst_map = sys_rst_map;
>  	} else {
> -		pr_err("Uncompatible DT node '%s' specified\n",
> +		pr_err("Incompatible DT node '%s' specified\n",
>  			of_node_full_name(np));
>  		ret = -EINVAL;
>  		goto err_kfree_data;
> -- 
> 2.25.1
> 
