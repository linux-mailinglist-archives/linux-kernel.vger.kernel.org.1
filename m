Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB03F2F25D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbhALBul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 20:50:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10704 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbhALBuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 20:50:40 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DFD4p2B94zl3rc;
        Tue, 12 Jan 2021 09:48:42 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Tue, 12 Jan 2021 09:49:49 +0800
Subject: Re: [PATCH v2] USB:ehci:fix an interrupt calltrace error
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     <gregkh@linuxfoundation.org>, <yisen.zhuang@huawei.com>,
        <kong.kongxinwei@hisilicon.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1610364577-11617-1-git-send-email-liulongfang@huawei.com>
 <20210111170703.GD1196682@rowland.harvard.edu>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <e8de5c15-af3c-c850-03f2-643a580134f1@huawei.com>
Date:   Tue, 12 Jan 2021 09:49:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210111170703.GD1196682@rowland.harvard.edu>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/12 1:07, Alan Stern Wrote:
> On Mon, Jan 11, 2021 at 07:29:37PM +0800, Longfang Liu wrote:
>> The system that use Synopsys USB host controllers goes to suspend
>> when using USB audio player. This causes the USB host controller
>> continuous send interrupt signal to system, When the number of
>> interrupts exceeds 100000, the system will forcibly close the
>> interrupts and output a calltrace error.
>>
>> When the system goes to suspend, the last interrupt is reported to
>> the driver. At this time, the system has set the state to suspend.
>> This causes the last interrupt to not be processed by the system and
>> not clear the interrupt flag. This uncleared interrupt flag constantly
>> triggers new interrupt event. This causing the driver to receive more
>> than 100,000 interrupts, which causes the system to forcibly close the
>> interrupt report and report the calltrace error.
>>
>> so, when the driver goes to sleep and changes the system state to
>> suspend, the interrupt flag needs to be cleared.
>>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> OK, I will add it on the next patch
Thanks,
Longfang
>> ---
>>
>> Changes in v2:
>> - updated cleared registers
>>
>>  drivers/usb/host/ehci-hub.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
>> index ce0eaf7..a99c1ac 100644
>> --- a/drivers/usb/host/ehci-hub.c
>> +++ b/drivers/usb/host/ehci-hub.c
>> @@ -346,8 +346,12 @@ static int ehci_bus_suspend (struct usb_hcd *hcd)
>>  
>>  	unlink_empty_async_suspended(ehci);
>>  
>> +	/* Some Synopsys controllers mistakenly leave IAA turned on */
>> +	ehci_writel(ehci, STS_IAA, &ehci->regs->status);
>> +
>>  	/* Any IAA cycle that started before the suspend is now invalid */
>>  	end_iaa_cycle(ehci);
>> +
>>  	ehci_handle_start_intr_unlinks(ehci);
>>  	ehci_handle_intr_unlinks(ehci);
>>  	end_free_itds(ehci);
>> -- 
>> 2.8.1
>>
> .
> 
