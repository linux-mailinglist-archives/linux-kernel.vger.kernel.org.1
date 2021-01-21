Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A1A2FE07A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 05:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbhAUEQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 23:16:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728833AbhAUENE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:13:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E073238E4;
        Thu, 21 Jan 2021 04:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611202311;
        bh=i0o5BOTuobkVm+Oy4OCU51ghTjJgBql7EKiATSN3E0M=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OYXMbM0RVabxirrEwy/tHCTU4KlXXGViQbMh+li0zjDuWUoEh1mr23enbikIAIpxW
         DIPOHVnHtkwVwyeLDcl8g8RP2YgX6wUXsjH68bBTwmKvAWBHBFLgtCGeYGvb8WxPTv
         rHGB4qOEGDmwh0jCTe4haw46lFy90ijoA4M6ow4zlOfIIHcTJA14wH1zEnAqazL7n1
         X1Nn1az4G3DLtJwB8zK70EoUmra0D7anMbiw8Q6RvZ9zuqkacIhM2uWYt0ywYJ/hVo
         J0ESg+jdZus5BcG5wbCqKlQ3ECm7egmYRrwbEN97QihniwCVD7KhSnmvuAHUiW+Sid
         TrI+6b5ozKbSw==
Subject: Re: [PATCH 07/20] clk: socfpga: clk-pll: Remove unused variable 'rc'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
References: <20210120093040.1719407-1-lee.jones@linaro.org>
 <20210120093040.1719407-8-lee.jones@linaro.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <3d6c8a56-0fdb-f116-95ff-29526400fc14@kernel.org>
Date:   Wed, 20 Jan 2021 22:11:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210120093040.1719407-8-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/21 3:30 AM, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>   drivers/clk/socfpga/clk-pll.c: In function ‘__socfpga_pll_init’:
>   drivers/clk/socfpga/clk-pll.c:83:6: warning: variable ‘rc’ set but not used [-Wunused-but-set-variable]
> 
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/clk/socfpga/clk-pll.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/socfpga/clk-pll.c b/drivers/clk/socfpga/clk-pll.c
> index e5fb786843f39..3cf99df7d0056 100644
> --- a/drivers/clk/socfpga/clk-pll.c
> +++ b/drivers/clk/socfpga/clk-pll.c
> @@ -80,7 +80,6 @@ static __init struct clk *__socfpga_pll_init(struct device_node *node,
>   	const char *parent_name[SOCFPGA_MAX_PARENTS];
>   	struct clk_init_data init;
>   	struct device_node *clkmgr_np;
> -	int rc;
>   
>   	of_property_read_u32(node, "reg", &reg);
>   
> @@ -111,7 +110,7 @@ static __init struct clk *__socfpga_pll_init(struct device_node *node,
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


