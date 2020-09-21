Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E3F2723D7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgIUMZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:25:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:40902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgIUMZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:25:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600691108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xi88G/T/Ke4IpBIm5Oy0pNETwvmeWGhrwcyE3mpgIIE=;
        b=TTPAujd9IzUCDyyq2m9ZiMJADYiSSGuQMObA5pjcAdHMUJno4eoD6UihbxnZ5ju75rjP08
        BgBjVxfWyrXL++9xTbMLEkwTu6hnJR9PT8ltkRSuXUo4s/jO/YGe04Uu0WbPFQzJYMla8Z
        eEhK4mm0PRDb8DEjIMr9nO2T0UR1RWw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F724ACAF;
        Mon, 21 Sep 2020 12:25:44 +0000 (UTC)
Message-ID: <1600691092.2424.85.camel@suse.com>
Subject: Re: [PATCH] usb: yurex: Rearrange code not to need GFP_ATOMIC
From:   Oliver Neukum <oneukum@suse.com>
To:     Pavel Machek <pavel@denx.de>, gregkh@linuxfoundation.org,
        stern@rowland.harvard.edu, johan@kernel.org, gustavoars@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:24:52 +0200
In-Reply-To: <20200920084452.GA2257@amd>
References: <20200920084452.GA2257@amd>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, den 20.09.2020, 10:44 +0200 schrieb Pavel Machek:
> Move prepare to wait around, so that normal GFP_KERNEL allocation can
> be used.
> 
> Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

Ehm. Please recheck.

> diff --git a/drivers/usb/misc/yurex.c b/drivers/usb/misc/yurex.c
> index b2e09883c7e2..071f1debebba 100644
> --- a/drivers/usb/misc/yurex.c
> +++ b/drivers/usb/misc/yurex.c
> @@ -489,10 +489,10 @@ static ssize_t yurex_write(struct file *file, const char __user *user_buffer,
>  	}
>  
>  	/* send the data as the control msg */
> -	prepare_to_wait(&dev->waitq, &wait, TASK_INTERRUPTIBLE);
>  	dev_dbg(&dev->interface->dev, "%s - submit %c\n", __func__,
>  		dev->cntl_buffer[0]);
> -	retval = usb_submit_urb(dev->cntl_urb, GFP_ATOMIC);
> +	retval = usb_submit_urb(dev->cntl_urb, GFP_KERNEL);

URB completes here. wake_up() returns the task to RUNNING.

> +	prepare_to_wait(&dev->waitq, &wait, TASK_INTERRUPTIBLE);

Task goes to TASK_INTERRUPTIBLE

>  	if (retval >= 0)
>  		timeout = schedule_timeout(YUREX_WRITE_TIMEOUT);

Task turns into Sleeping Beauty until timeout

>  	finish_wait(&dev->waitq, &wait);

And here task goes into error reporting as it checks timeout.

	Regards
		Oliver

