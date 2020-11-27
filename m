Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A764C2C5EBB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 03:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392231AbgK0C3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 21:29:11 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8043 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgK0C3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 21:29:11 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Chz8G0fB9zhhvK;
        Fri, 27 Nov 2020 10:28:46 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Fri, 27 Nov 2020 10:29:03 +0800
Subject: Re: [PATCH] USB:ehci:fix an interrupt calltrace error
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1606361673-573-1-git-send-email-liulongfang@huawei.com>
 <20201126160830.GA827745@rowland.harvard.edu>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <96b4d366-c94c-9708-da12-5693bf16b716@huawei.com>
Date:   Fri, 27 Nov 2020 10:29:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201126160830.GA827745@rowland.harvard.edu>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/27 0:08, Alan Stern Wrote:
> On Thu, Nov 26, 2020 at 11:34:33AM +0800, Longfang Liu wrote:
>> The system goes to suspend when using USB audio player. This causes
>> the USB device continuous send interrupt signal to system, When the
>> number of interrupts exceeds 100000, the system will forcibly close
>> the interrupts and output a calltrace error.
> 
> This description is very confusing.  USB devices do not send interrupt 
> signals to the host.  Do you mean that the device sends a wakeup 
> request?  Or do you mean something else?
The irq type is IRQ_NONE£¬It's counted in the note_interrupt function.
From the analysis of the driver code, that are indeed  interrupt signals.
> 
>> When the system goes to suspend, the last interrupt is reported to
>> the driver. At this time, the system has set the state to suspend.
>> This causes the last interrupt to not be processed by the system and
>> not clear the interrupt state flag. This uncleared interrupt flag
>> constantly triggers new interrupt event. This causing the driver to
>> receive more than 100,000 interrupts, which causes the system to
>> forcibly close the interrupt report and report the calltrace error.
> 
> If the driver receives an interrupt, it is supposed to process the event 
> even if the host controller is suspended.  And when ehci_irq() runs, it 
> clears the bits that are set in the USBSYS register.
When the host controller is suspended, the ehci_suspend() will clear
the HCD_FLAG_HW_ACCESSIBLE, and then usb_hcd_irq() will return IRQ_NONE
directly without calling ehci_irq().
> 
> Why is your system getting interrupts?  That is, which bits are set in 
> the USBSTS register?
BIT(5) and BIT(3) are setted, STS_IAA and STS_FLR.
> 
>> so, when the driver goes to sleep and changes the system state to
>> suspend, the interrupt flag needs to be cleared.
>>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  drivers/usb/host/ehci-hub.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
>> index ce0eaf7..5b13825 100644
>> --- a/drivers/usb/host/ehci-hub.c
>> +++ b/drivers/usb/host/ehci-hub.c
>> @@ -348,6 +348,11 @@ static int ehci_bus_suspend (struct usb_hcd *hcd)
>>  
>>  	/* Any IAA cycle that started before the suspend is now invalid */
>>  	end_iaa_cycle(ehci);
>> +
>> +	/* clear interrupt status */
>> +	if (ehci->has_synopsys_hc_bug)
>> +		ehci_writel(ehci, INTR_MASK | STS_FLR, &ehci->regs->status);
> 
> This is a very strange place to add your new code -- right in the middle 
> of the IAA and unlink handling.  Why not put it in a more reasonable 
> place?After the IAA is processed, clear the STS_IAA interrupt state flag.
> 
> Also, the patch description does not mention has_synopsys_hc_bug.  The 
> meaning of this flag has no connection with the interrupt status 
> register, so why do you use it here?
Because of our USB IP comes from Synopsys, and the uncleared flage is also caused by
special hardware design, in addition, we have not tested other manufacturers' USB
controllers.We don¡¯t know if other manufacturers¡¯ designs have this problem,
so this modification is only limited to this kind of design.
> 
>> +
>>  	ehci_handle_start_intr_unlinks(ehci);
>>  	ehci_handle_intr_unlinks(ehci);
>>  	end_free_itds(ehci);
> 
> Alan Stern
> .
> 
Thanks,
Longfang Liu
