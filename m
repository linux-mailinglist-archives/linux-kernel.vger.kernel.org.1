Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E5127A9BB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgI1IkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:40:22 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:49904 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1IkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:40:22 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb5f71a167e92-f0d3d; Mon, 28 Sep 2020 16:40:07 +0800 (CST)
X-RM-TRANSID: 2eeb5f71a167e92-f0d3d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.21.77] (unknown[10.42.68.12])
        by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25f71a166719-a64bf;
        Mon, 28 Sep 2020 16:40:07 +0800 (CST)
X-RM-TRANSID: 2ee25f71a166719-a64bf
Subject: Re: [PATCH] usb: bdc: Remove duplicate error message in bdc_probe()
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200927134218.20028-1-tangbin@cmss.chinamobile.com>
 <1601275744.29336.12.camel@mhfsdcap03>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <20c1b250-bc9a-98fd-8029-99a4c92a1c94@cmss.chinamobile.com>
Date:   Mon, 28 Sep 2020 16:40:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1601275744.29336.12.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/9/28 14:49, Chunfeng Yun 写道:
> On Sun, 2020-09-27 at 21:42 +0800, Tang Bin wrote:
>> In this function, we don't need dev_err() message because
>> when something goes wrong, devm_platform_ioremap_resource()
>> can print an error message itself, so remove the redundant
>> one.
>>
>> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
>> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
>> ---
>>   drivers/usb/gadget/udc/bdc/bdc_core.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
>> index 02a3a7746..9454f179e 100644
>> --- a/drivers/usb/gadget/udc/bdc/bdc_core.c
>> +++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
>> @@ -508,10 +508,8 @@ static int bdc_probe(struct platform_device *pdev)
>>   	bdc->clk = clk;
>>   
>>   	bdc->regs = devm_platform_ioremap_resource(pdev, 0);
>> -	if (IS_ERR(bdc->regs)) {
>> -		dev_err(dev, "ioremap error\n");
>> +	if (IS_ERR(bdc->regs))
>>   		return -ENOMEM;
>> -	}
>>   	irq = platform_get_irq(pdev, 0);
>>   	if (irq < 0)
>>   		return irq;
> Cc bdc's maintainer:  Florian Fainelli <f.fainelli@gmail.com>

Got it, thanks.

Tang Bin

>
>


