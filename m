Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D25F2AB401
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgKIJv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:51:27 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2365 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbgKIJvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:51:25 -0500
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4CV5q50hkzz52T4;
        Mon,  9 Nov 2020 17:51:13 +0800 (CST)
Received: from [10.140.157.68] (10.140.157.68) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 9 Nov 2020 17:51:22 +0800
Subject: Re: [PATCH] clk: hisilicon: Fix the memory leak issues
To:     Markus Elfring <Markus.Elfring@web.de>, <linux-clk@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
References: <20201106203525.9991-1-gengdongjiu@huawei.com>
 <30b24944-1315-b6de-5290-28b9d7842610@web.de>
From:   Dongjiu Geng <gengdongjiu@huawei.com>
Message-ID: <b6aedf2a-ed8a-938d-7962-34fd5c314f55@huawei.com>
Date:   Mon, 9 Nov 2020 17:51:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <30b24944-1315-b6de-5290-28b9d7842610@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.140.157.68]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/8 21:55, Markus Elfring wrote:
>> When return errors, …
> 
> I would find an other wording more appropriate for this change description.
> 
> 
>> …, so fix this issue.
> 
> I suggest to replace this information by an other imperative wording
> and the tag “Fixes”.

OK, done， I have submitted the version 2 patch

> 
> 
> …
>> +++ b/drivers/clk/hisilicon/clk-hi3620.c
>> @@ -463,12 +463,16 @@ static void __init hi3620_mmc_clk_init(struct device_node *node)
>>  	}
>>
>>  	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
>> -	if (WARN_ON(!clk_data))
>> +	if (WARN_ON(!clk_data)) {
>> +		iounmap(base);
> 
> Can a statement like “goto unmap_io;” make sense here?
OK， I have changed it.

> 
> 
>>  		return;
>> +	}
>>
>>  	clk_data->clks = kcalloc(num, sizeof(*clk_data->clks), GFP_KERNEL);
>> -	if (!clk_data->clks)
>> +	if (!clk_data->clks) {
> 
> How do you think about to add the function call “kfree(clk_data)” in this if branch?
OK, I have changed it.

> 
> 
> …
>> +++ b/drivers/clk/hisilicon/clk.c
> …
>  	if (!base) {
>  		pr_err("%s: failed to map clock registers\n", __func__);
> -		goto err;
> +		return NULL;
> 
> 
>> @@ -69,8 +69,10 @@ struct hisi_clock_data *hisi_clk_init(struct device_node *np,
>>  	}
>>
>>  	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
>> -	if (!clk_data)
>> +	if (!clk_data) {
>> +		iounmap(base);
>>  		goto err;
> 
> Please use another jump target.
OK, thanks, I have changed it.

> 
> 
>> @@ -82,6 +84,7 @@ struct hisi_clock_data *hisi_clk_init(struct device_node *np,
>>  	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data->clk_data);
>>  	return clk_data;
>>  err_data:
>> +	iounmap(base);
>>  	kfree(clk_data);
>>  err:
>>  	return NULL;
> 
> I propose to apply the following code variant.
OK, have modified.

> 
> 	return clk_data;
> 
> free_clk_data:
> 	kfree(clk_data);
> unmap_io:
> 	iounmap(base);
> 	return NULL;
> 
> 
> Regards,
> Markus
> .
> 
