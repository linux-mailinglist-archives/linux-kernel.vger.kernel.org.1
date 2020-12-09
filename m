Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72612D40C4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbgLILOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:14:17 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:38621 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729887AbgLILOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:14:17 -0500
Received: from [192.168.1.155] ([77.2.91.93]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MLA6m-1kVyjB0KSg-00IGWK; Wed, 09 Dec 2020 12:11:39 +0100
Subject: Re: [PATCH] drivers: usb: gadget: prefer pr_*() functions over raw
 printk()
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, balbi@kernel.org, leoyang.li@nxp.com,
        linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20201208144403.22097-1-info@metux.net>
 <X8+howyVRiTR9gv/@pendragon.ideasonboard.com>
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
Message-ID: <9aaa06ad-0bd8-486d-b16b-66927d57cf96@metux.net>
Date:   Wed, 9 Dec 2020 12:11:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <X8+howyVRiTR9gv/@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TS1+oAY6AdC0UtwhrAetL+tFGsmfL2VfyybwOSaT75VKnrTnQRP
 +IsskL1kzQM9VxvORn/3q+2HI+37v7ZwZzAgdFcCtYyGKF2H12RAOoHm/AnxwZEfQfdTnAG
 riDnR9h5WKx005G0EBL3tnCOrA3A2kDwZoFjNwOeV9e+JMvdFNOPusk61sFmC0Blv/Vh2PP
 j1H0hZddMV8nXVQWrrzyw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:RM211oNVR54=:1XiRZHVIi19YQnFsm7XyvZ
 J8yJn8EPVUS+l4KRvyFYjOoysMsMTUUSmR5ly4TkYSj+HKFlWvFnACtU+qrg1mjdUGfg04CLB
 vXaZgfvNFwFK7lEroaK2e0YkqQEIrWOv6vHQXfQXtwo0VdInG3xO279w3eyt/T4UQZTUciKpK
 uCkQxlDMxYW8HrGoQqsNUip379n87iTHxVkuDsEnz0Q1x370MzRfUncMlfmDIbF/0jmFrEubV
 GMzOnzXenmF97iQKeIwVX9b4haZmsVLtVXWoytsoEtuACmBn0J+XbqWOlT4i8lLDszXGmH+h1
 75P9mNi7z7FRFtGp38Pb+hkNFskuQrtfJM3KOn4w0fFcvpFLS3x5Eo+D8TqRTR4hmLIeNPuz7
 t4lz6Lmk/RWJUE4JHACJUKzmb4ZibNft2dnWOOH3V6uhFP6KkIhPurHBQFa/q
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.12.20 16:54, Laurent Pinchart wrote:

Hi,

>> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
>> index 2b893bceea45..4834fafb3f70 100644
>> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
>> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
>> @@ -1573,7 +1573,7 @@ static void usba_control_irq(struct usba_udc *udc, struct usba_ep *ep)
>>  		 * generate or receive a reply right away. */
>>  		usba_ep_writel(ep, CLR_STA, USBA_RX_SETUP);
>>  
>> -		/* printk(KERN_DEBUG "setup: %d: %02x.%02x\n",
>> +		/* pr_debug("setup: %d: %02x.%02x\n",
>>  			ep->state, crq.crq.bRequestType,
>>  			crq.crq.bRequest); */
> 
> I wonder if this shouldn't be dropped instead, commented-out code isn't
> very useful.

Indeed. Shall I send a separate patch for that ?

> When a pointer to a struct device is available, dev_err() would be much
> better. That's however out of scope for this patch, but it would be nice
> to address it. This would become
> 
> 		dev_err(&pdev->dev, "Check IRQ setup!\n");
> 

You're right. I didn't check for that yet. I'll do it in a separate
patch.


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
