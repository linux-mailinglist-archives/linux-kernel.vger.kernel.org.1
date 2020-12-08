Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351D22D27F9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgLHJmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:42:49 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:43512 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727982AbgLHJms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:42:48 -0500
Received: from [IPv6:2a01:e0a:255:1000:c8c5:d1bc:5841:24db] (unknown [IPv6:2a01:e0a:255:1000:c8c5:d1bc:5841:24db])
        (Authenticated sender: duncan.sands@free.fr)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id B0972B0051B;
        Tue,  8 Dec 2020 10:41:52 +0100 (CET)
Subject: Re: [PATCH 3/3] drivers: usb: atm: use pr_err() and pr_warn() instead
 of raw printk()
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     accessrunner-general@lists.sourceforge.net,
        linux-usb@vger.kernel.org
References: <20201208093206.24780-1-info@metux.net>
 <20201208093206.24780-3-info@metux.net>
From:   Duncan Sands <duncan.sands@free.fr>
Message-ID: <f5c8d260-f617-4efe-c45e-b5846c24e3c0@free.fr>
Date:   Tue, 8 Dec 2020 10:41:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201208093206.24780-3-info@metux.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/20 10:32 AM, Enrico Weigelt, metux IT consult wrote:
> Since we have the nice helpers pr_err() and pr_warn(), use them instead
> of raw printk().
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Acked-by: Duncan Sands <duncan.sands@free.fr>

> ---
>   drivers/usb/atm/usbatm.c  | 2 +-
>   drivers/usb/atm/xusbatm.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/atm/usbatm.c b/drivers/usb/atm/usbatm.c
> index 56fe30d247da..1c90aa273a41 100644
> --- a/drivers/usb/atm/usbatm.c
> +++ b/drivers/usb/atm/usbatm.c
> @@ -1278,7 +1278,7 @@ EXPORT_SYMBOL_GPL(usbatm_usb_disconnect);
>   static int __init usbatm_usb_init(void)
>   {
>   	if (sizeof(struct usbatm_control) > sizeof_field(struct sk_buff, cb)) {
> -		printk(KERN_ERR "%s unusable with this kernel!\n", usbatm_driver_name);
> +		pr_err("%s unusable with this kernel!\n", usbatm_driver_name);
>   		return -EIO;
>   	}
>   
> diff --git a/drivers/usb/atm/xusbatm.c b/drivers/usb/atm/xusbatm.c
> index ffc9810070a3..0befbf63d1cc 100644
> --- a/drivers/usb/atm/xusbatm.c
> +++ b/drivers/usb/atm/xusbatm.c
> @@ -179,7 +179,7 @@ static int __init xusbatm_init(void)
>   	    num_vendor != num_product ||
>   	    num_vendor != num_rx_endpoint ||
>   	    num_vendor != num_tx_endpoint) {
> -		printk(KERN_WARNING "xusbatm: malformed module parameters\n");
> +		pr_warn("xusbatm: malformed module parameters\n");
>   		return -EINVAL;
>   	}
>   
> 

