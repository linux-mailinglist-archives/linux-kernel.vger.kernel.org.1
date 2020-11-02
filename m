Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEDD2A2647
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 09:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgKBIkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 03:40:04 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6728 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbgKBIkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 03:40:01 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CPmZ45LSBzkdcy;
        Mon,  2 Nov 2020 16:39:56 +0800 (CST)
Received: from [10.174.176.180] (10.174.176.180) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Mon, 2 Nov 2020 16:39:56 +0800
Subject: Re: [PATCH] usb: dwc2: Fix unused label warning
To:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
References: <20201031060342.43384-1-yuehaibing@huawei.com>
 <d3249c9c-e937-7ba1-e21b-3c89a79cb184@synopsys.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <2aa957ab-d31d-f22f-e470-19169220e6a9@huawei.com>
Date:   Mon, 2 Nov 2020 16:39:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <d3249c9c-e937-7ba1-e21b-3c89a79cb184@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.180]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/2 15:04, Minas Harutyunyan wrote:
> On 10/31/2020 10:03 AM, YueHaibing wrote:
>> drivers/usb/dwc2/platform.c: In function ‘dwc2_driver_probe’:
>> drivers/usb/dwc2/platform.c:611:1: warning: label ‘error_debugfs’ defined but not used [-Wunused-label]
>>   error_debugfs:
>>   ^~~~~~~~~~~~~
>>
>> Move label 'error_debugfs' to ifdef block.
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>   drivers/usb/dwc2/platform.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
>> index e2820676beb1..5f18acac7406 100644
>> --- a/drivers/usb/dwc2/platform.c
>> +++ b/drivers/usb/dwc2/platform.c
>> @@ -608,10 +608,13 @@ static int dwc2_driver_probe(struct platform_device *dev)
>>   #endif /* CONFIG_USB_DWC2_PERIPHERAL || CONFIG_USB_DWC2_DUAL_ROLE */
>>   	return 0;
>>   
>> +#if IS_ENABLED(CONFIG_USB_DWC2_PERIPHERAL) || \
>> +	IS_ENABLED(CONFIG_USB_DWC2_DUAL_ROLE)
>>   error_debugfs:
>>   	dwc2_debugfs_exit(hsotg);
>>   	if (hsotg->hcd_enabled)
>>   		dwc2_hcd_remove(hsotg);
>> +#endif
>>   error_drd:
>>   	dwc2_drd_exit(hsotg);
>>   
>>
> Thank you for patch. Identical patch submitted by on 10/17/2020 by 
> Martin Blumenstingl: [PATCH] usb: dwc2: Avoid leaving the error_debugfs 
> label unused. I'm already ACKed it.

Thanks for this info.
> Thanks,
> Minas
> 
