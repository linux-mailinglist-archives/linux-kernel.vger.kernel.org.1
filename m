Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3E125BED2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 12:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgICKKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 06:10:08 -0400
Received: from regular1.263xmail.com ([211.150.70.198]:54170 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgICKKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 06:10:05 -0400
Received: from localhost (unknown [192.168.167.235])
        by regular1.263xmail.com (Postfix) with ESMTP id 2421469D;
        Thu,  3 Sep 2020 18:02:56 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.120] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P22906T140608907769600S1599127375479297_;
        Thu, 03 Sep 2020 18:02:56 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <6bb291034bbe847a99370295b139c33b>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: huangtao@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v2 4/6] clk: rockchip: Export some clock common APIs for
 module drivers
To:     Elaine Zhang <zhangqing@rock-chips.com>, heiko@sntech.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, xxx@rock-chips.com,
        xf@rock-chips.com, huangtao@rock-chips.com
References: <20200903063147.10237-1-zhangqing@rock-chips.com>
 <20200903063147.10237-5-zhangqing@rock-chips.com>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <ee161596-0e21-63a6-8ed9-4ef85f237bfa@rock-chips.com>
Date:   Thu, 3 Sep 2020 18:02:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903063147.10237-5-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/9/3 下午2:31, Elaine Zhang wrote:
> This is used by the Rockchip clk driver, export it to allow that
> driver to be compiled as a module.
>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>   drivers/clk/rockchip/clk.c | 52 ++++++++++++++++++++++----------------
>   1 file changed, 30 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
> index b51f320e5733..b7664224e64a 100644
> --- a/drivers/clk/rockchip/clk.c
> +++ b/drivers/clk/rockchip/clk.c
> @@ -359,8 +359,9 @@ static struct clk *rockchip_clk_register_factor_branch(const char *name,
>   	return hw->clk;
>   }
>   
> -struct rockchip_clk_provider * __init rockchip_clk_init(struct device_node *np,
> -			void __iomem *base, unsigned long nr_clks)
> +struct rockchip_clk_provider *rockchip_clk_init(struct device_node *np,
> +						void __iomem *base,
> +						unsigned long nr_clks)
>   {
>   	struct rockchip_clk_provider *ctx;
>   	struct clk **clk_table;
> @@ -392,14 +393,16 @@ struct rockchip_clk_provider * __init rockchip_clk_init(struct device_node *np,
>   	kfree(ctx);
>   	return ERR_PTR(-ENOMEM);
>   }
> +EXPORT_SYMBOL(rockchip_clk_init);
>   
> -void __init rockchip_clk_of_add_provider(struct device_node *np,
> -				struct rockchip_clk_provider *ctx)
> +void rockchip_clk_of_add_provider(struct device_node *np,
> +				  struct rockchip_clk_provider *ctx)
>   {
>   	if (of_clk_add_provider(np, of_clk_src_onecell_get,
>   				&ctx->clk_data))
>   		pr_err("%s: could not register clk provider\n", __func__);
>   }
> +EXPORT_SYMBOL(rockchip_clk_of_add_provider);
>   
>   void rockchip_clk_add_lookup(struct rockchip_clk_provider *ctx,
>   			     struct clk *clk, unsigned int id)
> @@ -407,8 +410,9 @@ void rockchip_clk_add_lookup(struct rockchip_clk_provider *ctx,
>   	if (ctx->clk_data.clks && id)
>   		ctx->clk_data.clks[id] = clk;
>   }
> +EXPORT_SYMBOL(rockchip_clk_add_lookup);
>   
> -void __init rockchip_clk_register_plls(struct rockchip_clk_provider *ctx,
> +void rockchip_clk_register_plls(struct rockchip_clk_provider *ctx,
>   				struct rockchip_pll_clock *list,
>   				unsigned int nr_pll, int grf_lock_offset)
>   {
> @@ -431,11 +435,11 @@ void __init rockchip_clk_register_plls(struct rockchip_clk_provider *ctx,
>   		rockchip_clk_add_lookup(ctx, clk, list->id);
>   	}
>   }
> +EXPORT_SYMBOL(rockchip_clk_register_plls);
>   
> -void __init rockchip_clk_register_branches(
> -				      struct rockchip_clk_provider *ctx,
> -				      struct rockchip_clk_branch *list,
> -				      unsigned int nr_clk)
> +void rockchip_clk_register_branches(struct rockchip_clk_provider *ctx,
> +				    struct rockchip_clk_branch *list,
> +				    unsigned int nr_clk)
>   {
>   	struct clk *clk = NULL;
>   	unsigned int idx;
> @@ -564,14 +568,15 @@ void __init rockchip_clk_register_branches(
>   		rockchip_clk_add_lookup(ctx, clk, list->id);
>   	}
>   }
> -
> -void __init rockchip_clk_register_armclk(struct rockchip_clk_provider *ctx,
> -			unsigned int lookup_id,
> -			const char *name, const char *const *parent_names,
> -			u8 num_parents,
> -			const struct rockchip_cpuclk_reg_data *reg_data,
> -			const struct rockchip_cpuclk_rate_table *rates,
> -			int nrates)
> +EXPORT_SYMBOL(rockchip_clk_register_branches);
> +
> +void rockchip_clk_register_armclk(struct rockchip_clk_provider *ctx,
> +				  unsigned int lookup_id,
> +				  const char *name, const char *const *parent_names,
> +				  u8 num_parents,
> +				  const struct rockchip_cpuclk_reg_data *reg_data,
> +				  const struct rockchip_cpuclk_rate_table *rates,
> +				  int nrates)
>   {
>   	struct clk *clk;
>   
> @@ -586,9 +591,10 @@ void __init rockchip_clk_register_armclk(struct rockchip_clk_provider *ctx,
>   
>   	rockchip_clk_add_lookup(ctx, clk, lookup_id);
>   }
> +EXPORT_SYMBOL(rockchip_clk_register_armclk);
>   
> -void __init rockchip_clk_protect_critical(const char *const clocks[],
> -					  int nclocks)
> +void rockchip_clk_protect_critical(const char *const clocks[],
> +				   int nclocks)
>   {
>   	int i;
>   
> @@ -600,6 +606,7 @@ void __init rockchip_clk_protect_critical(const char *const clocks[],
>   			clk_prepare_enable(clk);
>   	}
>   }
> +EXPORT_SYMBOL(rockchip_clk_protect_critical);
>   
>   static void __iomem *rst_base;
>   static unsigned int reg_restart;
> @@ -619,10 +626,10 @@ static struct notifier_block rockchip_restart_handler = {
>   	.priority = 128,
>   };
>   
> -void __init
> +void
>   rockchip_register_restart_notifier(struct rockchip_clk_provider *ctx,
> -					       unsigned int reg,
> -					       void (*cb)(void))
> +				   unsigned int reg,
> +				   void (*cb)(void))
>   {
>   	int ret;
>   
> @@ -634,3 +641,4 @@ rockchip_register_restart_notifier(struct rockchip_clk_provider *ctx,
>   		pr_err("%s: cannot register restart handler, %d\n",
>   		       __func__, ret);
>   }
> +EXPORT_SYMBOL(rockchip_register_restart_notifier);


This looks good to me, so

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,

- Kever



