Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2EF827A9E3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgI1IqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:46:22 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:22001 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgI1IqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:46:22 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee45f71a2ae565-f1855; Mon, 28 Sep 2020 16:45:34 +0800 (CST)
X-RM-TRANSID: 2ee45f71a2ae565-f1855
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.21.77] (unknown[10.42.68.12])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95f71a2ace47-a72e9;
        Mon, 28 Sep 2020 16:45:33 +0800 (CST)
X-RM-TRANSID: 2ee95f71a2ace47-a72e9
Subject: Re: [PATCH] usb: bdc: Remove duplicate error message in bdc_probe()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
References: <20200927134218.20028-1-tangbin@cmss.chinamobile.com>
 <20200927134550.GA302849@kroah.com>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <e895f44b-2c53-a883-322b-e3768fdb6733@cmss.chinamobile.com>
Date:   Mon, 28 Sep 2020 16:45:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200927134550.GA302849@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg KH:

在 2020/9/27 21:45, Greg KH 写道:
> On Sun, Sep 27, 2020 at 09:42:18PM +0800, Tang Bin wrote:
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
> Why not return the error given to us?

Because when get ioremap failed, devm_platform_ioremap_resource() can 
print error message

"dev_err(dev, "ioremap failed for resource %pR\n", res)" in it's called 
function. So I think this's place's

dev_err(dev, "ioremap error\n") is redundant.


Thanks

Tang Bin


>


