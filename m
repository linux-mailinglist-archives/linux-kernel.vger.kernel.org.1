Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F7B2AD5BD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 12:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgKJL6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 06:58:21 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2429 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKJL6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:58:21 -0500
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CVmb50XQBz53g0;
        Tue, 10 Nov 2020 19:58:09 +0800 (CST)
Received: from [10.140.157.68] (10.140.157.68) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 10 Nov 2020 19:58:16 +0800
Subject: Re: [PATCH v2] clk: hisilicon: Free clk_data and unmap region
 obtained by of_iomap
To:     Markus Elfring <Markus.Elfring@web.de>, <linux-clk@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
References: <20201109180920.43193-1-gengdongjiu@huawei.com>
 <c6d2fe3b-3261-2c0f-f245-49bb5e63c1ed@web.de>
From:   Dongjiu Geng <gengdongjiu@huawei.com>
Message-ID: <3252231f-dfb9-789f-e164-11d0e579defe@huawei.com>
Date:   Tue, 10 Nov 2020 19:58:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c6d2fe3b-3261-2c0f-f245-49bb5e63c1ed@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.140.157.68]
X-ClientProxiedBy: dggeme714-chm.china.huawei.com (10.1.199.110) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/11/10 1:54, Markus Elfring wrote:
> …
>> +++ b/drivers/clk/hisilicon/clk-hi3620.c
> …
>> @@ -478,6 +478,10 @@ static void __init hi3620_mmc_clk_init(struct device_node *node)
>>
>>  	clk_data->clk_num = num;
>>  	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
>> +free_clk_data:
>> +	kfree(clk_data);
> …
> 
> * Should any system resources be kept allocated if the execution
>   of this function implementation succeeded?
> 
> * How do you think about to add the statement “return;”
>   after the call of the function “of_clk_add_provider”?
> 
> * Should another return value be also checked here?

sure.

> 
>   See also:
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clk/clk.c?id=f8394f232b1eab649ce2df5c5f15b0e528c92091#n4414
>   https://elixir.bootlin.com/linux/v5.10-rc2/source/drivers/clk/clk.c#L4414
> 
> * Would you like to use the function “of_clk_add_hw_provider” instead?

    How about we still use of_clk_add_provider()? It doesn't seem to make difference using of_clk_add_hw_provider().

> 
> Regards,
> Markus
