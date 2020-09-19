Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD49270A27
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 04:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgISCsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 22:48:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40346 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbgISCsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 22:48:46 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A6AA161F0C41473CEDEE;
        Sat, 19 Sep 2020 10:48:44 +0800 (CST)
Received: from [10.174.176.211] (10.174.176.211) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 10:48:42 +0800
Subject: Re: [PATCH -next] tty: hvc: fix link error with
 CONFIG_SERIAL_CORE_CONSOLE=n
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20200918092030.3855438-1-yangyingliang@huawei.com>
 <20200918111708.GC2242974@kroah.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <6100a6e7-641f-7e9b-b4a3-3834320d1bb1@huawei.com>
Date:   Sat, 19 Sep 2020 10:48:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200918111708.GC2242974@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.211]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/9/18 19:17, Greg KH wrote:
> On Fri, Sep 18, 2020 at 05:20:30PM +0800, Yang Yingliang wrote:
>> Fix the link error by selecting SERIAL_CORE_CONSOLE.
>>
>> aarch64-linux-gnu-ld: drivers/tty/hvc/hvc_dcc.o: in function `dcc_early_write':
>> hvc_dcc.c:(.text+0x164): undefined reference to `uart_console_write'
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/tty/hvc/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
>> index d1b27b0522a3..8d60e0ff67b4 100644
>> --- a/drivers/tty/hvc/Kconfig
>> +++ b/drivers/tty/hvc/Kconfig
>> @@ -81,6 +81,7 @@ config HVC_DCC
>>   	bool "ARM JTAG DCC console"
>>   	depends on ARM || ARM64
>>   	select HVC_DRIVER
>> +	select SERIAL_CORE_CONSOLE
>>   	help
>>   	  This console uses the JTAG DCC on ARM to create a console under the HVC
>>   	  driver. This console is used through a JTAG only on ARM. If you don't have
>> -- 
>> 2.25.1
>>
> Same question here, what caused this problem to happen?
Fixes: d1a1af2cdf19 ("hvc: dcc: Add earlycon support")
>
> thanks,
>
> greg k-h
> .
