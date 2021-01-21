Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F7D2FE07B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 05:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbhAUEQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 23:16:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbhAUENE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:13:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF77C238E5;
        Thu, 21 Jan 2021 04:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611202321;
        bh=TSPPsdg02ahP/Wtn4EqkELMNHDhwHsYCq1iue1RYofc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Gs/TbRtRKAizKIOeMepg8NUszzXxjKsShpDdXtbfCjFemJzVddAqynV/Bn6JkVUv9
         Zsf2L1p24EumUnmeLdo1OfvrKng6ujElFAc4pEnaDq54Zd/dKBIjxWXDYQFWwWN3e4
         IXbNciBFULSNcl5VhziDrfNK1oVJvYHK9GSDCW7inaMxrP8aZYeW9rXaRi31W1MhIj
         OE3GWw3E8yMYMmtk/wG6KeRoq2Vc9JaB1PzAbkUfz7liW2kR3WSPgzPqS0EkGZB0Ui
         ld/DFFyogkDNvRK7N/7soxMZtuMtWF6hn2uPUu2Osk95VCCHkujoWEh42pYeYDuRKo
         +LXwIZFYdC9CA==
Subject: Re: [PATCH 08/20] clk: socfpga: clk-pll-a10: Remove set but unused
 variable 'rc'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
References: <20210120093040.1719407-1-lee.jones@linaro.org>
 <20210120093040.1719407-9-lee.jones@linaro.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <77dcbc1a-d0c6-aa35-57f4-a3bc66d81a87@kernel.org>
Date:   Wed, 20 Jan 2021 22:11:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210120093040.1719407-9-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/21 3:30 AM, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>   drivers/clk/socfpga/clk-pll-a10.c: In function ‘__socfpga_pll_init’:
>   drivers/clk/socfpga/clk-pll-a10.c:76:6: warning: variable ‘rc’ set but not used [-Wunused-but-set-variable]
> 
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/clk/socfpga/clk-pll-a10.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/socfpga/clk-pll-a10.c b/drivers/clk/socfpga/clk-pll-a10.c
> index db54f7d806a09..3338f054fe98c 100644
> --- a/drivers/clk/socfpga/clk-pll-a10.c
> +++ b/drivers/clk/socfpga/clk-pll-a10.c
> @@ -73,7 +73,6 @@ static struct clk * __init __socfpga_pll_init(struct device_node *node,
>   	const char *parent_name[SOCFGPA_MAX_PARENTS];
>   	struct clk_init_data init;
>   	struct device_node *clkmgr_np;
> -	int rc;
>   	int i = 0;
>   
>   	of_property_read_u32(node, "reg", &reg);
> @@ -108,7 +107,7 @@ static struct clk * __init __socfpga_pll_init(struct device_node *node,
>   		kfree(pll_clk);
>   		return NULL;
>   	}
> -	rc = of_clk_add_provider(node, of_clk_src_simple_get, clk);
> +	of_clk_add_provider(node, of_clk_src_simple_get, clk);
>   	return clk;
>   }
>   
> 

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
