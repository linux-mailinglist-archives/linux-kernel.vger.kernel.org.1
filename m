Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860BD2AB7B1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 13:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgKIMCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 07:02:34 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2366 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKIMCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 07:02:33 -0500
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4CV8kN5hRxz52X9;
        Mon,  9 Nov 2020 20:02:20 +0800 (CST)
Received: from [10.140.157.68] (10.140.157.68) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 9 Nov 2020 20:02:30 +0800
Subject: Re: [PATCH V2] clk: hisilicon: Free clk_data and unmap region
 obtained by of_iomap
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>
References: <20201109180920.43193-1-gengdongjiu@huawei.com>
From:   Dongjiu Geng <gengdongjiu@huawei.com>
Message-ID: <eedf6ba7-90e0-c21c-a808-29bd69b1d423@huawei.com>
Date:   Mon, 9 Nov 2020 20:02:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20201109180920.43193-1-gengdongjiu@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.140.157.68]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add Markus

On 2020/11/10 2:09, Dongjiu Geng wrote:
> Free memory mapping and free clk_data, if clock initialization
> is not successful.
> 
> Fixes: 75af25f581b1 ("clk: hisi: remove static variable")
> Fixes: 62ac983b6141 ("clk: hisilicon: add hi3620_mmc_clks")
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
>  drivers/clk/hisilicon/clk-hi3620.c |  8 ++++++--
>  drivers/clk/hisilicon/clk.c        | 11 ++++++-----
>  2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
> index a3d04c7c3da8..864d2ddfc73c 100644
> --- a/drivers/clk/hisilicon/clk-hi3620.c
> +++ b/drivers/clk/hisilicon/clk-hi3620.c
> @@ -464,11 +464,11 @@ static void __init hi3620_mmc_clk_init(struct device_node *node)
>  
>  	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
>  	if (WARN_ON(!clk_data))
> -		return;
> +		goto unmap_io;
>  
>  	clk_data->clks = kcalloc(num, sizeof(*clk_data->clks), GFP_KERNEL);
>  	if (!clk_data->clks)
> -		return;
> +		goto free_clk_data;
>  
>  	for (i = 0; i < num; i++) {
>  		struct hisi_mmc_clock *mmc_clk = &hi3620_mmc_clks[i];
> @@ -478,6 +478,10 @@ static void __init hi3620_mmc_clk_init(struct device_node *node)
>  
>  	clk_data->clk_num = num;
>  	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +free_clk_data:
> +	kfree(clk_data);
> +unmap_io:
> +	iounmap(base);
>  }
>  
>  CLK_OF_DECLARE(hi3620_mmc_clk, "hisilicon,hi3620-mmc-clock", hi3620_mmc_clk_init);
> diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
> index 54d9fdc93599..da655683710f 100644
> --- a/drivers/clk/hisilicon/clk.c
> +++ b/drivers/clk/hisilicon/clk.c
> @@ -65,25 +65,26 @@ struct hisi_clock_data *hisi_clk_init(struct device_node *np,
>  	base = of_iomap(np, 0);
>  	if (!base) {
>  		pr_err("%s: failed to map clock registers\n", __func__);
> -		goto err;
> +		return NULL;
>  	}
>  
>  	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
>  	if (!clk_data)
> -		goto err;
> +		goto unmap_io;
>  
>  	clk_data->base = base;
>  	clk_table = kcalloc(nr_clks, sizeof(*clk_table), GFP_KERNEL);
>  	if (!clk_table)
> -		goto err_data;
> +		goto free_clk_data;
>  
>  	clk_data->clk_data.clks = clk_table;
>  	clk_data->clk_data.clk_num = nr_clks;
>  	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data->clk_data);
>  	return clk_data;
> -err_data:
> +free_clk_data:
>  	kfree(clk_data);
> -err:
> +unmap_io:
> +	iounmap(base);
>  	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(hisi_clk_init);
> 
