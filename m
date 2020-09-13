Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885D3267F84
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 14:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgIMMjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 08:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgIMMji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 08:39:38 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CC2C061573
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 05:39:37 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id n2so14766122oij.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 05:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l3WXaGdP8SgXL6VCI8rD1lbY8X7+MJhgv01RyK8uTDE=;
        b=p5+1D6mg1ApenrzHMzvr04hfK1qUgWGB3Tg9DLvHl9k67RwzlnZZifJqsKlJNxmSZ9
         cc3T6cFH42iv2brYTpeR/bsLzTTe3qE8w97vwWbeqjBnYY7l0gowQor6ml30Nc25Q6pS
         eSMiAHsl1Q9aT+zCyOqECTKCU7lhv+Xb1+IMk1YMo0LeBuAIcjxme3uM668XXU47Er9j
         dZBrnZ0xsqZgLZqHH7T4HfgYtms8aVNatnUEMPiGxBPrYMl4Z1Mbh9IW9f3mTefse9dW
         mj+6aKEK8/nSAM2EzJFCuVwfUXfPlT1+PagXN5LCi6Cqm02xs8fnb+uXKDGGHCA3Vz/i
         52Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=l3WXaGdP8SgXL6VCI8rD1lbY8X7+MJhgv01RyK8uTDE=;
        b=KDivUOYpj8XvXWPK0PWNhVnCKGCK5C9i/7zCG8Cjl0JcBSxcaNQNufN6CWA+MI7utl
         gi/pl3Wh/l0PCCtQcYNH8lO6Qlq6tjz/PyYNV8MK07AIm5FNCH9nOq5dbSgyYiVOh2QF
         tC3QcpO5jfgpCzird3JP7d/spEL/8AhJToIy/78Qrfpmg3rjUoCH6h8+BNQYEU4vDeg3
         yAa3zpJpjDteQDwMKZcejBjRwJk0vAuAoGadDCgX13z3jU+yNw4Afz9FwU4Z0bzh2Ght
         cA06KXnnsHp9mji4P+CmcGQ3qJf7tfWAvzajhCfrWGXIHbCy5HSfA0fMmeievEzphtTt
         wgvQ==
X-Gm-Message-State: AOAM532y5Tf8YpS/MI+bGdC+DmydVth63x9wW7N1g/fwfdLCWxJZ1W0Y
        XMX8F03fznqr5+z9o41IoInvt2AFmg==
X-Google-Smtp-Source: ABdhPJwoWPBCa2RxpIiOjqfQYMaTBJQTMz0eDcy/1DqzYWqRVHxuHqGPDdUD8kmuqvDxQavtMNO62g==
X-Received: by 2002:a05:6808:287:: with SMTP id z7mr6377916oic.99.1600000773754;
        Sun, 13 Sep 2020 05:39:33 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.156])
        by smtp.gmail.com with ESMTPSA id e7sm1570012otk.59.2020.09.13.05.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 05:39:32 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:ecd3:d2ae:8b57:1a08])
        by serve.minyard.net (Postfix) with ESMTPSA id D397F180056;
        Sun, 13 Sep 2020 12:39:31 +0000 (UTC)
Date:   Sun, 13 Sep 2020 07:39:30 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi: retry to get device id when error
Message-ID: <20200913123930.GH15602@minyard.net>
Reply-To: minyard@acm.org
References: <20200913120203.3368-1-tian.xianting@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200913120203.3368-1-tian.xianting@h3c.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 08:02:03PM +0800, Xianting Tian wrote:
> We can't get bmc's device id with low probability when loading ipmi driver,
> it caused bmc device register failed. This issue may caused by bad lpc
> signal quality. When this issue happened, we got below kernel printks:
> 	[Wed Sep  9 19:52:03 2020] ipmi_si IPI0001:00: IPMI message handler: device id demangle failed: -22
> 	[Wed Sep  9 19:52:03 2020] IPMI BT: using default values
> 	[Wed Sep  9 19:52:03 2020] IPMI BT: req2rsp=5 secs retries=2
> 	[Wed Sep  9 19:52:03 2020] ipmi_si IPI0001:00: Unable to get the device id: -5
> 	[Wed Sep  9 19:52:04 2020] ipmi_si IPI0001:00: Unable to register device: error -5
> 
> When this issue happened, we want to manually unload the driver and try to
> load it again, but it can't be unloaded by 'rmmod' as it is already 'in use'.

I'm not sure this patch is a good idea; it would cause a long boot delay
in situations where there really isn't a BMC out there.  Yes, it
happens.

You don't have to reload the driver to add a device, though.  You can
hot-add devices using /sys/modules/ipmi_si/parameters/hotmod.  Look in
Documentation/driver-api/ipmi.rst for details.

Does that work for you?

-corey

> 
> We add below 'printk' in handle_one_recv_msg(), when this issue happened,
> the msg we received is "Recv: 1c 01 d5", which means the data_len is 1,
> data[0] is 0xd5.
> 	Debug code:
> 	static int handle_one_recv_msg(struct ipmi_smi *intf,
>                                struct ipmi_smi_msg *msg) {
>         	printk("Recv: %*ph\n", msg->rsp_size, msg->rsp);
> 		... ...
> 	}
> Then in ipmi_demangle_device_id(), it returned '-EINVAL' as 'data_len < 7'
> and 'data[0] != 0'.
> 
> We used this patch to retry to get device id when error happen, we
> reproduced this issue again and the retry succeed on the first retry, we
> finally got the correct msg and then all is ok:
> Recv: 1c 01 00 01 81 05 84 02 af db 07 00 01 00 b9 00 10 00
> 
> So use retry machanism in this patch to give bmc more opportunity to
> correctly response kernel.
> 
> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 737c0b6b2..bfb2de77a 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -34,6 +34,7 @@
>  #include <linux/uuid.h>
>  #include <linux/nospec.h>
>  #include <linux/vmalloc.h>
> +#include <linux/delay.h>
>  
>  #define IPMI_DRIVER_VERSION "39.2"
>  
> @@ -60,6 +61,9 @@ enum ipmi_panic_event_op {
>  #else
>  #define IPMI_PANIC_DEFAULT IPMI_SEND_PANIC_EVENT_NONE
>  #endif
> +
> +#define GET_DEVICE_ID_MAX_RETRY	5
> +
>  static enum ipmi_panic_event_op ipmi_send_panic_event = IPMI_PANIC_DEFAULT;
>  
>  static int panic_op_write_handler(const char *val,
> @@ -2426,19 +2430,26 @@ send_get_device_id_cmd(struct ipmi_smi *intf)
>  static int __get_device_id(struct ipmi_smi *intf, struct bmc_device *bmc)
>  {
>  	int rv;
> -
> -	bmc->dyn_id_set = 2;
> +	unsigned int retry_count = 0;
>  
>  	intf->null_user_handler = bmc_device_id_handler;
>  
> +retry:
> +	bmc->dyn_id_set = 2;
> +
>  	rv = send_get_device_id_cmd(intf);
>  	if (rv)
>  		return rv;
>  
>  	wait_event(intf->waitq, bmc->dyn_id_set != 2);
>  
> -	if (!bmc->dyn_id_set)
> +	if (!bmc->dyn_id_set) {
> +		msleep(1000);
> +		if (++retry_count <= GET_DEVICE_ID_MAX_RETRY)
> +			goto retry;
> +
>  		rv = -EIO; /* Something went wrong in the fetch. */
> +	}
>  
>  	/* dyn_id_set makes the id data available. */
>  	smp_rmb();
> -- 
> 2.17.1
> 
