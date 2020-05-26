Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2462A1C5B18
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 17:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbgEEP1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 11:27:50 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:39397 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729403AbgEEP1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:27:50 -0400
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 051DDFF81C;
        Tue,  5 May 2020 15:27:06 +0000 (UTC)
Date:   Tue, 5 May 2020 17:27:06 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] clk: at91: optimize pmc data allocation
Message-ID: <20200505152706.GS34497@piout.net>
References: <cover.1588630999.git.mirq-linux@rere.qmqm.pl>
 <fc6f6d67b8cee0beace4a9d9cca7431e5efa769d.1588630999.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc6f6d67b8cee0beace4a9d9cca7431e5efa769d.1588630999.git.mirq-linux@rere.qmqm.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2020 00:37:56+0200, Michał Mirosław wrote:
> Alloc whole data structure in one block. This makes the code shorter,
> more efficient and easier to extend in following patch.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> v2: rebase and update to clk/clk-at91 branch
> v3: use struct_size() and C99 trailing array
>     as suggested by Stephen Boyd
> v4: fixed sign-off
> v5: no changes
> v6: no changes
> v7: pull all pmc_data_free() from second patch (a rebase artifact)
> ---
>  drivers/clk/at91/at91rm9200.c  |  2 +-
>  drivers/clk/at91/at91sam9260.c |  2 +-
>  drivers/clk/at91/at91sam9g45.c |  2 +-
>  drivers/clk/at91/at91sam9n12.c |  2 +-
>  drivers/clk/at91/at91sam9rl.c  |  2 +-
>  drivers/clk/at91/at91sam9x5.c  |  2 +-
>  drivers/clk/at91/pmc.c         | 34 ++++++++--------------------------
>  drivers/clk/at91/pmc.h         |  3 ++-
>  drivers/clk/at91/sam9x60.c     |  2 +-
>  drivers/clk/at91/sama5d2.c     |  2 +-
>  drivers/clk/at91/sama5d3.c     |  2 +-
>  drivers/clk/at91/sama5d4.c     |  2 +-
>  12 files changed, 20 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
> index c44a431b6c97..6f4e1151553d 100644
> --- a/drivers/clk/at91/at91rm9200.c
> +++ b/drivers/clk/at91/at91rm9200.c
> @@ -187,7 +187,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
>  	return;
>  
>  err_free:
> -	pmc_data_free(at91rm9200_pmc);
> +	kfree(at91rm9200_pmc);
>  }
>  /*
>   * While the TCB can be used as the clocksource, the system timer is most likely
> diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
> index a9d4234758d7..946f03a09858 100644
> --- a/drivers/clk/at91/at91sam9260.c
> +++ b/drivers/clk/at91/at91sam9260.c
> @@ -462,7 +462,7 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
>  	return;
>  
>  err_free:
> -	pmc_data_free(at91sam9260_pmc);
> +	kfree(at91sam9260_pmc);
>  }
>  
>  static void __init at91sam9260_pmc_setup(struct device_node *np)
> diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
> index 38a7d2d2df0c..53e8252b8a63 100644
> --- a/drivers/clk/at91/at91sam9g45.c
> +++ b/drivers/clk/at91/at91sam9g45.c
> @@ -210,7 +210,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
>  	return;
>  
>  err_free:
> -	pmc_data_free(at91sam9g45_pmc);
> +	kfree(at91sam9g45_pmc);
>  }
>  /*
>   * The TCB is used as the clocksource so its clock is needed early. This means
> diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
> index 8bb39d2ba84b..f3ae1cd3cb8d 100644
> --- a/drivers/clk/at91/at91sam9n12.c
> +++ b/drivers/clk/at91/at91sam9n12.c
> @@ -228,7 +228,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
>  	return;
>  
>  err_free:
> -	pmc_data_free(at91sam9n12_pmc);
> +	kfree(at91sam9n12_pmc);
>  }
>  /*
>   * The TCB is used as the clocksource so its clock is needed early. This means
> diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
> index 77fe83a73bf4..cc739d214ae3 100644
> --- a/drivers/clk/at91/at91sam9rl.c
> +++ b/drivers/clk/at91/at91sam9rl.c
> @@ -166,6 +166,6 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
>  	return;
>  
>  err_free:
> -	pmc_data_free(at91sam9rl_pmc);
> +	kfree(at91sam9rl_pmc);
>  }
>  CLK_OF_DECLARE_DRIVER(at91sam9rl_pmc, "atmel,at91sam9rl-pmc", at91sam9rl_pmc_setup);
> diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
> index 086cf0b4955c..aac99d699568 100644
> --- a/drivers/clk/at91/at91sam9x5.c
> +++ b/drivers/clk/at91/at91sam9x5.c
> @@ -278,7 +278,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
>  	return;
>  
>  err_free:
> -	pmc_data_free(at91sam9x5_pmc);
> +	kfree(at91sam9x5_pmc);
>  }
>  
>  static void __init at91sam9g15_pmc_setup(struct device_node *np)
> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> index b71515acdec1..ac46ea1b9fda 100644
> --- a/drivers/clk/at91/pmc.c
> +++ b/drivers/clk/at91/pmc.c
> @@ -76,48 +76,30 @@ struct clk_hw *of_clk_hw_pmc_get(struct of_phandle_args *clkspec, void *data)
>  	return ERR_PTR(-EINVAL);
>  }
>  
> -void pmc_data_free(struct pmc_data *pmc_data)
> -{
> -	kfree(pmc_data->chws);
> -	kfree(pmc_data->shws);
> -	kfree(pmc_data->phws);
> -	kfree(pmc_data->ghws);
> -}
> -
>  struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsystem,
>  				   unsigned int nperiph, unsigned int ngck)
>  {
> -	struct pmc_data *pmc_data = kzalloc(sizeof(*pmc_data), GFP_KERNEL);
> +	unsigned int num_clks = ncore + nsystem + nperiph + ngck;
> +	struct pmc_data *pmc_data;
>  
> +	pmc_data = kzalloc(struct_size(pmc_data, hwtable, num_clks),
> +			   GFP_KERNEL);
>  	if (!pmc_data)
>  		return NULL;
>  
>  	pmc_data->ncore = ncore;
> -	pmc_data->chws = kcalloc(ncore, sizeof(struct clk_hw *), GFP_KERNEL);
> -	if (!pmc_data->chws)
> -		goto err;
> +	pmc_data->chws = pmc_data->hwtable;
>  
>  	pmc_data->nsystem = nsystem;
> -	pmc_data->shws = kcalloc(nsystem, sizeof(struct clk_hw *), GFP_KERNEL);
> -	if (!pmc_data->shws)
> -		goto err;
> +	pmc_data->shws = pmc_data->chws + ncore;
>  
>  	pmc_data->nperiph = nperiph;
> -	pmc_data->phws = kcalloc(nperiph, sizeof(struct clk_hw *), GFP_KERNEL);
> -	if (!pmc_data->phws)
> -		goto err;
> +	pmc_data->phws = pmc_data->shws + nsystem;
>  
>  	pmc_data->ngck = ngck;
> -	pmc_data->ghws = kcalloc(ngck, sizeof(struct clk_hw *), GFP_KERNEL);
> -	if (!pmc_data->ghws)
> -		goto err;
> +	pmc_data->ghws = pmc_data->phws + nperiph;
>  
>  	return pmc_data;
> -
> -err:
> -	pmc_data_free(pmc_data);
> -
> -	return NULL;
>  }
>  
>  #ifdef CONFIG_PM
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index 9b8db9cdcda5..fc3ef772b9d9 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -24,6 +24,8 @@ struct pmc_data {
>  	struct clk_hw **phws;
>  	unsigned int ngck;
>  	struct clk_hw **ghws;
> +
> +	struct clk_hw *hwtable[];
>  };
>  
>  struct clk_range {
> @@ -95,7 +97,6 @@ struct clk_pcr_layout {
>  #define nck(a) (a[ARRAY_SIZE(a) - 1].id + 1)
>  struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsystem,
>  				   unsigned int nperiph, unsigned int ngck);
> -void pmc_data_free(struct pmc_data *pmc_data);
>  
>  int of_at91_get_clk_range(struct device_node *np, const char *propname,
>  			  struct clk_range *range);
> diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
> index cc19e8fb83be..a7d4f648db26 100644
> --- a/drivers/clk/at91/sam9x60.c
> +++ b/drivers/clk/at91/sam9x60.c
> @@ -299,7 +299,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
>  	return;
>  
>  err_free:
> -	pmc_data_free(sam9x60_pmc);
> +	kfree(sam9x60_pmc);
>  }
>  /* Some clks are used for a clocksource */
>  CLK_OF_DECLARE(sam9x60_pmc, "microchip,sam9x60-pmc", sam9x60_pmc_setup);
> diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
> index ff7e3f727082..b2560670e5af 100644
> --- a/drivers/clk/at91/sama5d2.c
> +++ b/drivers/clk/at91/sama5d2.c
> @@ -350,6 +350,6 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
>  	return;
>  
>  err_free:
> -	pmc_data_free(sama5d2_pmc);
> +	kfree(sama5d2_pmc);
>  }
>  CLK_OF_DECLARE_DRIVER(sama5d2_pmc, "atmel,sama5d2-pmc", sama5d2_pmc_setup);
> diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
> index 88506f909c08..914e6f225510 100644
> --- a/drivers/clk/at91/sama5d3.c
> +++ b/drivers/clk/at91/sama5d3.c
> @@ -231,7 +231,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
>  	return;
>  
>  err_free:
> -	pmc_data_free(sama5d3_pmc);
> +	kfree(sama5d3_pmc);
>  }
>  /*
>   * The TCB is used as the clocksource so its clock is needed early. This means
> diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
> index a6dee4a3b6e4..4ca9a4619500 100644
> --- a/drivers/clk/at91/sama5d4.c
> +++ b/drivers/clk/at91/sama5d4.c
> @@ -267,6 +267,6 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
>  	return;
>  
>  err_free:
> -	pmc_data_free(sama5d4_pmc);
> +	kfree(sama5d4_pmc);
>  }
>  CLK_OF_DECLARE_DRIVER(sama5d4_pmc, "atmel,sama5d4-pmc", sama5d4_pmc_setup);
> -- 
> 2.20.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
