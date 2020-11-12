Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEBC2AFFCB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 07:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgKLGlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 01:41:10 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2430 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKLGlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 01:41:09 -0500
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CWsS82f9sz54B9;
        Thu, 12 Nov 2020 14:40:56 +0800 (CST)
Received: from [10.140.157.68] (10.140.157.68) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 12 Nov 2020 14:41:05 +0800
Subject: Re: [PATCH] clk: hisilicon: Add clock driver for hi3559A SoC
To:     Rob Herring <robh@kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20201109202838.43105-1-gengdongjiu@huawei.com>
 <20201111222340.GA2143735@bogus>
From:   Dongjiu Geng <gengdongjiu@huawei.com>
Message-ID: <69f78676-6e5e-867a-5b14-cb9af84a32ba@huawei.com>
Date:   Thu, 12 Nov 2020 14:41:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20201111222340.GA2143735@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.140.157.68]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/12 6:23, Rob Herring wrote:
> On Mon, Nov 09, 2020 at 08:28:38PM +0000, Dongjiu Geng wrote:
>> Add clock drivers for hi3559A SoC, this driver controls the SoC
>> registers to supply different clocks to different IPs in the SoC.
>>
>> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
>> ---
>>  drivers/clk/hisilicon/Kconfig                 |   7 +
>>  drivers/clk/hisilicon/Makefile                |   1 +
>>  drivers/clk/hisilicon/clk-hi3559a.c           | 873 ++++++++++++++++++
>>  include/dt-bindings/clock/hi3559av100-clock.h | 173 ++++
> 
> Is there a binding for this? The header should be part of it.
yes, I will add it.
Thanks for the pointing out.

> 
>>  4 files changed, 1054 insertions(+)
>>  create mode 100644 drivers/clk/hisilicon/clk-hi3559a.c
>>  create mode 100644 include/dt-bindings/clock/hi3559av100-clock.h
>>
>> diff --git a/drivers/clk/hisilicon/Kconfig b/drivers/clk/hisilicon/Kconfig
>> index 6a9e93a0bb95..5ecc37aaa118 100644
>> --- a/drivers/clk/hisilicon/Kconfig
>> +++ b/drivers/clk/hisilicon/Kconfig
>> @@ -15,6 +15,13 @@ config COMMON_CLK_HI3519
>>  	help
>>  	  Build the clock driver for hi3519.
>>  
>> +config COMMON_CLK_HI3559A
>> +	bool "Hi3559A Clock Driver"
>> +	depends on ARCH_HISI || COMPILE_TEST
>> +	default ARCH_HISI
>> +	help
>> +	  Build the clock driver for hi3559a.
>> +
>>  config COMMON_CLK_HI3660
>>  	bool "Hi3660 Clock Driver"
>>  	depends on ARCH_HISI || COMPILE_TEST
>> diff --git a/drivers/clk/hisilicon/Makefile b/drivers/clk/hisilicon/Makefile
>> index b2441b99f3d5..bc101833b35e 100644
>> --- a/drivers/clk/hisilicon/Makefile
>> +++ b/drivers/clk/hisilicon/Makefile
>> @@ -17,3 +17,4 @@ obj-$(CONFIG_COMMON_CLK_HI6220)	+= clk-hi6220.o
>>  obj-$(CONFIG_RESET_HISI)	+= reset.o
>>  obj-$(CONFIG_STUB_CLK_HI6220)	+= clk-hi6220-stub.o
>>  obj-$(CONFIG_STUB_CLK_HI3660)	+= clk-hi3660-stub.o
>> +obj-$(CONFIG_COMMON_CLK_HI3559A)	+= clk-hi3559a.o
>> diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/clk-hi3559a.c
>> new file mode 100644
>> index 000000000000..bd3921fc8c8e
>> --- /dev/null
>> +++ b/drivers/clk/hisilicon/clk-hi3559a.c
>> @@ -0,0 +1,873 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Hisilicon Hi3559A clock driver
>> + *
>> + * Copyright (c) 2019-2020 HiSilicon Technologies Co., Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
> 
> Don't need both this and SPDX tag. Kernel code should be GPL-2.0 (-only) 
> generally.

Ok, I will remove one. thanks.

> 
>> + *
>> + * Author: Dongjiu Geng <gengdongjiu@huawei.com>
> 
> git will tell us this.
> 
> Same comments apply to the header. Though DT headers should be dual 
> licensed.
> 
> Rob
> .
> 
