Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EF61C4882
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 22:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgEDUpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 16:45:17 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:46301 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgEDUpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:45:16 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 50374200005;
        Mon,  4 May 2020 20:44:47 +0000 (UTC)
Date:   Mon, 4 May 2020 22:44:47 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] clk: at91: allow setting PCKx parent via DT
Message-ID: <20200504204447.GL34497@piout.net>
References: <cover.1588623391.git.mirq-linux@rere.qmqm.pl>
 <fd853126e9971b9ef9bdcfe469ed3146a0cad92b.1588623391.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd853126e9971b9ef9bdcfe469ed3146a0cad92b.1588623391.git.mirq-linux@rere.qmqm.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2020 22:19:17+0200, Michał Mirosław wrote:
> This exposes PROGx clocks for use in assigned-clocks DeviceTree property
> for selecting PCKx parent clock.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
> v2: rebase and update to clk/clk-at91 branch
> v3: rebase
> v4: no changes
> v5: no changes
> v6: no changes
> ---
>  drivers/clk/at91/at91rm9200.c    |  6 ++++--
>  drivers/clk/at91/at91sam9260.c   |  5 ++++-
>  drivers/clk/at91/at91sam9g45.c   |  6 ++++--
>  drivers/clk/at91/at91sam9n12.c   |  6 ++++--
>  drivers/clk/at91/at91sam9rl.c    |  4 +++-
>  drivers/clk/at91/at91sam9x5.c    |  4 +++-
>  drivers/clk/at91/pmc.c           | 12 ++++++++++--
>  drivers/clk/at91/pmc.h           |  5 ++++-
>  drivers/clk/at91/sam9x60.c       |  4 +++-
>  drivers/clk/at91/sama5d2.c       |  4 +++-
>  drivers/clk/at91/sama5d3.c       |  6 ++++--
>  drivers/clk/at91/sama5d4.c       |  4 +++-
>  include/dt-bindings/clock/at91.h |  1 +
>  13 files changed, 50 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/clk/at91/at91rm9200.c b/drivers/clk/at91/at91rm9200.c
> index c44a431b6c97..8da88e9a95d8 100644
> --- a/drivers/clk/at91/at91rm9200.c
> +++ b/drivers/clk/at91/at91rm9200.c
> @@ -100,7 +100,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
>  
>  	at91rm9200_pmc = pmc_data_allocate(PMC_MAIN + 1,
>  					    nck(at91rm9200_systemck),
> -					    nck(at91rm9200_periphck), 0);
> +					    nck(at91rm9200_periphck), 0, 4);
>  	if (!at91rm9200_pmc)
>  		return;
>  
> @@ -159,6 +159,8 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
>  						    &at91rm9200_programmable_layout);
>  		if (IS_ERR(hw))
>  			goto err_free;
> +
> +		at91rm9200_pmc->pchws[i] = hw;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(at91rm9200_systemck); i++) {
> @@ -187,7 +189,7 @@ static void __init at91rm9200_pmc_setup(struct device_node *np)
>  	return;
>  
>  err_free:
> -	pmc_data_free(at91rm9200_pmc);
> +	kfree(at91rm9200_pmc);

I missed that in the previous review but shouldn't that change be part
of the previous patch for bisectability ?

>  }
>  /*
>   * While the TCB can be used as the clocksource, the system timer is most likely
> diff --git a/drivers/clk/at91/at91sam9260.c b/drivers/clk/at91/at91sam9260.c
> index 946f03a09858..7e5ff252fffc 100644
> --- a/drivers/clk/at91/at91sam9260.c
> +++ b/drivers/clk/at91/at91sam9260.c
> @@ -354,7 +354,8 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
>  
>  	at91sam9260_pmc = pmc_data_allocate(PMC_MAIN + 1,
>  					    ndck(data->sck, data->num_sck),
> -					    ndck(data->pck, data->num_pck), 0);
> +					    ndck(data->pck, data->num_pck),
> +					    0, data->num_progck);
>  	if (!at91sam9260_pmc)
>  		return;
>  
> @@ -434,6 +435,8 @@ static void __init at91sam926x_pmc_setup(struct device_node *np,
>  						    &at91rm9200_programmable_layout);
>  		if (IS_ERR(hw))
>  			goto err_free;
> +
> +		at91sam9260_pmc->pchws[i] = hw;
>  	}
>  
>  	for (i = 0; i < data->num_sck; i++) {
> diff --git a/drivers/clk/at91/at91sam9g45.c b/drivers/clk/at91/at91sam9g45.c
> index 38a7d2d2df0c..5d18eb04c218 100644
> --- a/drivers/clk/at91/at91sam9g45.c
> +++ b/drivers/clk/at91/at91sam9g45.c
> @@ -117,7 +117,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
>  
>  	at91sam9g45_pmc = pmc_data_allocate(PMC_MAIN + 1,
>  					    nck(at91sam9g45_systemck),
> -					    nck(at91sam9g45_periphck), 0);
> +					    nck(at91sam9g45_periphck), 0, 2);
>  	if (!at91sam9g45_pmc)
>  		return;
>  
> @@ -182,6 +182,8 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
>  						    &at91sam9g45_programmable_layout);
>  		if (IS_ERR(hw))
>  			goto err_free;
> +
> +		at91sam9g45_pmc->pchws[i] = hw;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(at91sam9g45_systemck); i++) {
> @@ -210,7 +212,7 @@ static void __init at91sam9g45_pmc_setup(struct device_node *np)
>  	return;
>  
>  err_free:
> -	pmc_data_free(at91sam9g45_pmc);
> +	kfree(at91sam9g45_pmc);

Ditto

>  }
>  /*
>   * The TCB is used as the clocksource so its clock is needed early. This means
> diff --git a/drivers/clk/at91/at91sam9n12.c b/drivers/clk/at91/at91sam9n12.c
> index 8bb39d2ba84b..3a2564c2f724 100644
> --- a/drivers/clk/at91/at91sam9n12.c
> +++ b/drivers/clk/at91/at91sam9n12.c
> @@ -129,7 +129,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
>  		return;
>  
>  	at91sam9n12_pmc = pmc_data_allocate(PMC_MAIN + 1,
> -					   nck(at91sam9n12_systemck), 31, 0);
> +					   nck(at91sam9n12_systemck), 31, 0, 2);
>  	if (!at91sam9n12_pmc)
>  		return;
>  
> @@ -198,6 +198,8 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
>  						    &at91sam9x5_programmable_layout);
>  		if (IS_ERR(hw))
>  			goto err_free;
> +
> +		at91sam9n12_pmc->pchws[i] = hw;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(at91sam9n12_systemck); i++) {
> @@ -228,7 +230,7 @@ static void __init at91sam9n12_pmc_setup(struct device_node *np)
>  	return;
>  
>  err_free:
> -	pmc_data_free(at91sam9n12_pmc);
> +	kfree(at91sam9n12_pmc);

Ditto

>  }
>  /*
>   * The TCB is used as the clocksource so its clock is needed early. This means
> diff --git a/drivers/clk/at91/at91sam9rl.c b/drivers/clk/at91/at91sam9rl.c
> index cc739d214ae3..bcf07f6a0e0e 100644
> --- a/drivers/clk/at91/at91sam9rl.c
> +++ b/drivers/clk/at91/at91sam9rl.c
> @@ -89,7 +89,7 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
>  
>  	at91sam9rl_pmc = pmc_data_allocate(PMC_MAIN + 1,
>  					   nck(at91sam9rl_systemck),
> -					   nck(at91sam9rl_periphck), 0);
> +					   nck(at91sam9rl_periphck), 0, 2);
>  	if (!at91sam9rl_pmc)
>  		return;
>  
> @@ -138,6 +138,8 @@ static void __init at91sam9rl_pmc_setup(struct device_node *np)
>  						    &at91rm9200_programmable_layout);
>  		if (IS_ERR(hw))
>  			goto err_free;
> +
> +		at91sam9rl_pmc->pchws[i] = hw;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(at91sam9rl_systemck); i++) {
> diff --git a/drivers/clk/at91/at91sam9x5.c b/drivers/clk/at91/at91sam9x5.c
> index aac99d699568..f13756b407e2 100644
> --- a/drivers/clk/at91/at91sam9x5.c
> +++ b/drivers/clk/at91/at91sam9x5.c
> @@ -151,7 +151,7 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
>  		return;
>  
>  	at91sam9x5_pmc = pmc_data_allocate(PMC_MAIN + 1,
> -					   nck(at91sam9x5_systemck), 31, 0);
> +					   nck(at91sam9x5_systemck), 31, 0, 2);
>  	if (!at91sam9x5_pmc)
>  		return;
>  
> @@ -227,6 +227,8 @@ static void __init at91sam9x5_pmc_setup(struct device_node *np,
>  						    &at91sam9x5_programmable_layout);
>  		if (IS_ERR(hw))
>  			goto err_free;
> +
> +		at91sam9x5_pmc->pchws[i] = hw;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(at91sam9x5_systemck); i++) {
> diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
> index ac46ea1b9fda..8a1577e2c2fd 100644
> --- a/drivers/clk/at91/pmc.c
> +++ b/drivers/clk/at91/pmc.c
> @@ -67,6 +67,10 @@ struct clk_hw *of_clk_hw_pmc_get(struct of_phandle_args *clkspec, void *data)
>  		if (idx < pmc_data->ngck)
>  			return pmc_data->ghws[idx];
>  		break;
> +	case PMC_TYPE_PROGRAMMABLE:
> +		if (idx < pmc_data->npck)
> +			return pmc_data->pchws[idx];
> +		break;
>  	default:
>  		break;
>  	}
> @@ -77,9 +81,10 @@ struct clk_hw *of_clk_hw_pmc_get(struct of_phandle_args *clkspec, void *data)
>  }
>  
>  struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsystem,
> -				   unsigned int nperiph, unsigned int ngck)
> +				   unsigned int nperiph, unsigned int ngck,
> +				   unsigned int npck)
>  {
> -	unsigned int num_clks = ncore + nsystem + nperiph + ngck;
> +	unsigned int num_clks = ncore + nsystem + nperiph + ngck + npck;
>  	struct pmc_data *pmc_data;
>  
>  	pmc_data = kzalloc(struct_size(pmc_data, hwtable, num_clks),
> @@ -99,6 +104,9 @@ struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsystem,
>  	pmc_data->ngck = ngck;
>  	pmc_data->ghws = pmc_data->phws + nperiph;
>  
> +	pmc_data->npck = npck;
> +	pmc_data->pchws = pmc_data->ghws + ngck;
> +
>  	return pmc_data;
>  }
>  
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index fc3ef772b9d9..df616f2937e7 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -24,6 +24,8 @@ struct pmc_data {
>  	struct clk_hw **phws;
>  	unsigned int ngck;
>  	struct clk_hw **ghws;
> +	unsigned int npck;
> +	struct clk_hw **pchws;
>  
>  	struct clk_hw *hwtable[];
>  };
> @@ -96,7 +98,8 @@ struct clk_pcr_layout {
>  #define ndck(a, s) (a[s - 1].id + 1)
>  #define nck(a) (a[ARRAY_SIZE(a) - 1].id + 1)
>  struct pmc_data *pmc_data_allocate(unsigned int ncore, unsigned int nsystem,
> -				   unsigned int nperiph, unsigned int ngck);
> +				   unsigned int nperiph, unsigned int ngck,
> +				   unsigned int npck);
>  
>  int of_at91_get_clk_range(struct device_node *np, const char *propname,
>  			  struct clk_range *range);
> diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
> index a7d4f648db26..db14e0427c7f 100644
> --- a/drivers/clk/at91/sam9x60.c
> +++ b/drivers/clk/at91/sam9x60.c
> @@ -185,7 +185,7 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
>  	sam9x60_pmc = pmc_data_allocate(PMC_MAIN + 1,
>  					nck(sam9x60_systemck),
>  					nck(sam9x60_periphck),
> -					nck(sam9x60_gck));
> +					nck(sam9x60_gck), 8);
>  	if (!sam9x60_pmc)
>  		return;
>  
> @@ -255,6 +255,8 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
>  						    &sam9x60_programmable_layout);
>  		if (IS_ERR(hw))
>  			goto err_free;
> +
> +		sam9x60_pmc->pchws[i] = hw;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(sam9x60_systemck); i++) {
> diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
> index b2560670e5af..ae5e83cadb3d 100644
> --- a/drivers/clk/at91/sama5d2.c
> +++ b/drivers/clk/at91/sama5d2.c
> @@ -169,7 +169,7 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
>  	sama5d2_pmc = pmc_data_allocate(PMC_I2S1_MUX + 1,
>  					nck(sama5d2_systemck),
>  					nck(sama5d2_periph32ck),
> -					nck(sama5d2_gck));
> +					nck(sama5d2_gck), 3);
>  	if (!sama5d2_pmc)
>  		return;
>  
> @@ -267,6 +267,8 @@ static void __init sama5d2_pmc_setup(struct device_node *np)
>  						    &sama5d2_programmable_layout);
>  		if (IS_ERR(hw))
>  			goto err_free;
> +
> +		sama5d2_pmc->pchws[i] = hw;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(sama5d2_systemck); i++) {
> diff --git a/drivers/clk/at91/sama5d3.c b/drivers/clk/at91/sama5d3.c
> index 88506f909c08..507eef6797f1 100644
> --- a/drivers/clk/at91/sama5d3.c
> +++ b/drivers/clk/at91/sama5d3.c
> @@ -127,7 +127,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
>  
>  	sama5d3_pmc = pmc_data_allocate(PMC_MAIN + 1,
>  					nck(sama5d3_systemck),
> -					nck(sama5d3_periphck), 0);
> +					nck(sama5d3_periphck), 0, 3);
>  	if (!sama5d3_pmc)
>  		return;
>  
> @@ -201,6 +201,8 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
>  						    &at91sam9x5_programmable_layout);
>  		if (IS_ERR(hw))
>  			goto err_free;
> +
> +		sama5d3_pmc->pchws[i] = hw;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(sama5d3_systemck); i++) {
> @@ -231,7 +233,7 @@ static void __init sama5d3_pmc_setup(struct device_node *np)
>  	return;
>  
>  err_free:
> -	pmc_data_free(sama5d3_pmc);
> +	kfree(sama5d3_pmc);
>  }
>  /*
>   * The TCB is used as the clocksource so its clock is needed early. This means
> diff --git a/drivers/clk/at91/sama5d4.c b/drivers/clk/at91/sama5d4.c
> index 4ca9a4619500..80692902b4e4 100644
> --- a/drivers/clk/at91/sama5d4.c
> +++ b/drivers/clk/at91/sama5d4.c
> @@ -142,7 +142,7 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
>  
>  	sama5d4_pmc = pmc_data_allocate(PMC_MCK2 + 1,
>  					nck(sama5d4_systemck),
> -					nck(sama5d4_periph32ck), 0);
> +					nck(sama5d4_periph32ck), 0, 3);
>  	if (!sama5d4_pmc)
>  		return;
>  
> @@ -224,6 +224,8 @@ static void __init sama5d4_pmc_setup(struct device_node *np)
>  						    &at91sam9x5_programmable_layout);
>  		if (IS_ERR(hw))
>  			goto err_free;
> +
> +		sama5d4_pmc->pchws[i] = hw;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(sama5d4_systemck); i++) {
> diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91.h
> index 38b5554153c8..c3f4aa6a2d29 100644
> --- a/include/dt-bindings/clock/at91.h
> +++ b/include/dt-bindings/clock/at91.h
> @@ -12,6 +12,7 @@
>  #define PMC_TYPE_SYSTEM		1
>  #define PMC_TYPE_PERIPHERAL	2
>  #define PMC_TYPE_GCK		3
> +#define PMC_TYPE_PROGRAMMABLE	4
>  
>  #define PMC_SLOW		0
>  #define PMC_MCK			1
> -- 
> 2.20.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
