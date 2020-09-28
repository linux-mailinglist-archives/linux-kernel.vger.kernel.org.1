Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E2527ACB9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 13:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgI1Lbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 07:31:45 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:59587 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgI1Lbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 07:31:45 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35f71c9871e4-f33dc; Mon, 28 Sep 2020 19:31:19 +0800 (CST)
X-RM-TRANSID: 2ee35f71c9871e4-f33dc
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.21.77] (unknown[10.42.68.12])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35f71c9858a0-40163;
        Mon, 28 Sep 2020 19:31:19 +0800 (CST)
X-RM-TRANSID: 2ee35f71c9858a0-40163
Subject: Re: [PATCH] usb: bdc: Remove duplicate error message in bdc_probe()
To:     Greg KH <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
References: <20200927134218.20028-1-tangbin@cmss.chinamobile.com>
 <20200927134550.GA302849@kroah.com>
 <e895f44b-2c53-a883-322b-e3768fdb6733@cmss.chinamobile.com>
 <87sgb29r3g.fsf@kernel.org>
 <02162cfc-cbe3-4747-e518-7f3b3d7a0e7f@cmss.chinamobile.com>
 <20200928112301.GA415117@kroah.com>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <f1e0051e-30a2-beea-0459-c392d0c4104e@cmss.chinamobile.com>
Date:   Mon, 28 Sep 2020 19:31:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200928112301.GA415117@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

在 2020/9/28 19:23, Greg KH 写道:
> On Mon, Sep 28, 2020 at 06:55:26PM +0800, Tang Bin wrote:
>> Hi Balbi：
>>
>> 在 2020/9/28 17:40, Felipe Balbi 写道:
>>> Hi,
>>>
>>> Tang Bin <tangbin@cmss.chinamobile.com> writes:
>>>> Hi Greg KH:
>>>>
>>>> 在 2020/9/27 21:45, Greg KH 写道:
>>>>> On Sun, Sep 27, 2020 at 09:42:18PM +0800, Tang Bin wrote:
>>>>>> In this function, we don't need dev_err() message because
>>>>>> when something goes wrong, devm_platform_ioremap_resource()
>>>>>> can print an error message itself, so remove the redundant
>>>>>> one.
>>>>>>
>>>>>> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
>>>>>> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
>>>>>> ---
>>>>>>     drivers/usb/gadget/udc/bdc/bdc_core.c | 4 +---
>>>>>>     1 file changed, 1 insertion(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
>>>>>> index 02a3a7746..9454f179e 100644
>>>>>> --- a/drivers/usb/gadget/udc/bdc/bdc_core.c
>>>>>> +++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
>>>>>> @@ -508,10 +508,8 @@ static int bdc_probe(struct platform_device *pdev)
>>>>>>     	bdc->clk = clk;
>>>>>>     	bdc->regs = devm_platform_ioremap_resource(pdev, 0);
>>>>>> -	if (IS_ERR(bdc->regs)) {
>>>>>> -		dev_err(dev, "ioremap error\n");
>>>>>> +	if (IS_ERR(bdc->regs))
>>>>>>     		return -ENOMEM;
>>>>> Why not return the error given to us?
>>>> Because when get ioremap failed, devm_platform_ioremap_resource() can
>>>> print error message
>>>>
>>>> "dev_err(dev, "ioremap failed for resource %pR\n", res)" in it's called
>>>> function. So I think this's place's
>>>>
>>>> dev_err(dev, "ioremap error\n") is redundant.
>>> that's not what Greg point you at, though. Greg's concern is valid in
>>> that instead of passing along the error within bdc->regs, you always
>>> return -ENOMEM. OTW, your code should read like so:
>>>
>>> 	if (IS_ERR(bdc->regs))
>>>           	return PTR_ERR(bdc->regs);
>> Thanks for your explain，when I send the patch yesterday, my point is at
>> dev_err(), and not aimed at IS_ERR() & PTR_ERR(),
>>
>> if it's Greg's point, I will change this patch after his reply.
> Felipe is correct, and also, you should listen to him over me as he is
> the maintainer of this part of the kernel :)
>
Thanks for your reply, I will send v2 for all of you.


For me, all of you are the teachers, I am glad to learn from you. I 
respect every teacher,

I think Felipe should be able to feel.  Because the premise of the patch,

Felipe is also teaching me the question. So I feel I am lucky.


Thanks for all of you. Thanks

Tang Bin



