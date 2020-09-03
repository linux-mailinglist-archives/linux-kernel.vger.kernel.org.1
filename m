Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0719D25BED1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 12:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgICKKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 06:10:05 -0400
Received: from regular1.263xmail.com ([211.150.70.203]:54950 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgICKKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 06:10:03 -0400
Received: from localhost (unknown [192.168.167.70])
        by regular1.263xmail.com (Postfix) with ESMTP id B0BA9815;
        Thu,  3 Sep 2020 18:03:19 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.120] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P24386T139658960819968S1599127397973724_;
        Thu, 03 Sep 2020 18:03:18 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <ed2ffba5f5a9bb96ee8f8d7b5adea992>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: huangtao@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v2 6/6] clk: rockchip: rk3399: Support module build
To:     Elaine Zhang <zhangqing@rock-chips.com>, heiko@sntech.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, xxx@rock-chips.com,
        xf@rock-chips.com, huangtao@rock-chips.com
References: <20200903063147.10237-1-zhangqing@rock-chips.com>
 <20200903063234.10639-1-zhangqing@rock-chips.com>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <dbe40332-12d1-05b2-6ee9-083016003a2a@rock-chips.com>
Date:   Thu, 3 Sep 2020 18:03:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903063234.10639-1-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/9/3 下午2:32, Elaine Zhang wrote:
> support CLK_OF_DECLARE and builtin_platform_driver_probe
> double clk init method.
> add module author, description and license to support building
> Soc Rk3399 clock driver as module.
>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>   drivers/clk/rockchip/clk-rk3399.c | 55 +++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
>
> diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
> index ce1d2446f142..40ff17aee5b6 100644
> --- a/drivers/clk/rockchip/clk-rk3399.c
> +++ b/drivers/clk/rockchip/clk-rk3399.c
> @@ -5,9 +5,11 @@
>    */
>   
>   #include <linux/clk-provider.h>
> +#include <linux/module.h>
>   #include <linux/io.h>
>   #include <linux/of.h>
>   #include <linux/of_address.h>
> +#include <linux/of_device.h>
>   #include <linux/platform_device.h>
>   #include <linux/regmap.h>
>   #include <dt-bindings/clock/rk3399-cru.h>
> @@ -1600,3 +1602,56 @@ static void __init rk3399_pmu_clk_init(struct device_node *np)
>   	rockchip_clk_of_add_provider(np, ctx);
>   }
>   CLK_OF_DECLARE(rk3399_cru_pmu, "rockchip,rk3399-pmucru", rk3399_pmu_clk_init);
> +
> +struct clk_rk3399_inits {
> +		void (*inits)(struct device_node *np);
> +};
> +
> +static const struct clk_rk3399_inits clk_rk3399_pmucru_init = {
> +	.inits = rk3399_pmu_clk_init,
> +};
> +
> +static const struct clk_rk3399_inits clk_rk3399_cru_init = {
> +	.inits = rk3399_clk_init,
> +};
> +
> +static const struct of_device_id clk_rk3399_match_table[] = {
> +	{
> +		.compatible = "rockchip,rk3399-cru",
> +		.data = &clk_rk3399_cru_init,
> +	},  {
> +		.compatible = "rockchip,rk3399-pmucru",
> +		.data = &clk_rk3399_pmucru_init,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, clk_rk3399_match_table);
> +
> +static int __init clk_rk3399_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	const struct of_device_id *match;
> +	const struct clk_rk3399_inits *init_data;
> +
> +	match = of_match_device(clk_rk3399_match_table, &pdev->dev);
> +	if (!match || !match->data)
> +		return -EINVAL;
> +
> +	init_data = match->data;
> +	if (init_data->inits)
> +		init_data->inits(np);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver clk_rk3399_driver = {
> +	.driver		= {
> +		.name	= "clk-rk3399",
> +		.of_match_table = clk_rk3399_match_table,
> +	},
> +};
> +builtin_platform_driver_probe(clk_rk3399_driver, clk_rk3399_probe);
> +
> +MODULE_DESCRIPTION("Rockchip RK3399 Clock Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:clk-rk3399");

This looks good to me, so

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,

- Kever



