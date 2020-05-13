Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A971D13AF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 14:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgEMM7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 08:59:37 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:50474 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgEMM7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:59:37 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65ebbee2701d-d035b; Wed, 13 May 2020 20:55:09 +0800 (CST)
X-RM-TRANSID: 2ee65ebbee2701d-d035b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.0.101] (unknown[112.1.172.85])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95ebbee2b276-49c69;
        Wed, 13 May 2020 20:55:08 +0800 (CST)
X-RM-TRANSID: 2ee95ebbee2b276-49c69
Subject: Re: [PATCH] USB: host: ehci: Add error handling in
 ehci_mxc_drv_probe()
To:     gregkh@linuxfoundation.org
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
References: <Pine.LNX.4.44L0.2005080950180.19653-100000@netrider.rowland.org>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <9f88b0fd-28e9-2fa8-2deb-73652eb53fd4@cmss.chinamobile.com>
Date:   Wed, 13 May 2020 20:55:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.2005080950180.19653-100000@netrider.rowland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi gregkh:

On 2020/5/8 21:51, Alan Stern wrote:
> On Fri, 8 May 2020, Tang Bin wrote:
>
>> The function ehci_mxc_drv_probe() does not perform sufficient error
>> checking after executing platform_get_irq(), thus fix it.
> Aside from the "irq <= 0" issue, the Subject: line should say
> "ehci-mxc", not "ehci".
>
I know this patch need v2, whether just fix the subject?

Thanks,

Tang Bin

>
>> Fixes: 7e8d5cd93fa ("USB: Add EHCI support for MX27 and MX31 based boards")
>> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
>> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
>> ---
>>   drivers/usb/host/ehci-mxc.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
>> index a1eb5ee77..a0b42ba59 100644
>> --- a/drivers/usb/host/ehci-mxc.c
>> +++ b/drivers/usb/host/ehci-mxc.c
>> @@ -50,6 +50,8 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
>>   	}
>>   
>>   	irq = platform_get_irq(pdev, 0);
>> +	if (irq < 0)
>> +		return irq;
>>   
>>   	hcd = usb_create_hcd(&ehci_mxc_hc_driver, dev, dev_name(dev));
>>   	if (!hcd)
>>


