Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE062B065A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgKLNXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:23:19 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7523 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbgKLNXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:23:18 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CX2N91FKvzhk1l;
        Thu, 12 Nov 2020 21:23:05 +0800 (CST)
Received: from [10.174.176.61] (10.174.176.61) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 12 Nov 2020 21:23:05 +0800
Subject: Re: [PATCH] usb: gadget: mass_storage: fix error return code in
 msg_bind()
To:     <balbi@kernel.org>
References: <20201112085324.181903-1-chenzhou10@huawei.com>
CC:     <gregkh@linuxfoundation.org>, <weiyongjun1@huawei.com>,
        <jun.li@freescale.com>, <rogerq@ti.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <53ee397a-ef2e-4248-8d32-52c8d1e138e9@huawei.com>
Date:   Thu, 12 Nov 2020 21:23:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20201112085324.181903-1-chenzhou10@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.61]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/11/12 16:53, Chen Zhou wrote:
> Fix to return a negative error code from the error handling case
> instead of 0 in function msg_bind(), as done elsewhere in this
> function.
>
> Fixes: d86788979761 ("usb: gadget: mass_storage: allocate and init otg descriptor by otg capabilities")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  drivers/usb/gadget/legacy/mass_storage.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/legacy/mass_storage.c b/drivers/usb/gadget/legacy/mass_storage.c
> index 9ed22c5fb7fe..7a88c5282d61 100644
> --- a/drivers/usb/gadget/legacy/mass_storage.c
> +++ b/drivers/usb/gadget/legacy/mass_storage.c
> @@ -175,8 +175,10 @@ static int msg_bind(struct usb_composite_dev *cdev)
>  		struct usb_descriptor_header *usb_desc;
>  
>  		usb_desc = usb_otg_descriptor_alloc(cdev->gadget);
> -		if (!usb_desc)
> +		if (IS_ERR(usb_desc)) {
> +			status = PTR_ERR(usb_desc);
>  			goto fail_string_ids;
> +		}
>  		usb_otg_descriptor_init(cdev->gadget, usb_desc);
>  		otg_desc[0] = usb_desc;
>  		otg_desc[1] = NULL;
Ignore this.
