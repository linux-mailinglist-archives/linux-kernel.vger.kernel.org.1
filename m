Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24C226841D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 07:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgINFgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 01:36:03 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39712 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgINFgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 01:36:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id e22so5747159edq.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 22:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wxoqNVM1H3WKm36n114z2e2rqxZdPyaA6w9fRdtHnaY=;
        b=kZHOnR6AVe/vVFPGY8gs9JUFMRUgoUWjjldVzRzlWLoRJh/Dn/Ga0YzoIUqhYgZQCw
         f9a7o94vRHnVLgWto68MG7e1rmK/Ys513BgeGZLFCrzUQCRvlMsPVOVqgvAsbLZwp9BH
         yTn73Gb8BoHsqM0mlqIsivkFpvlZe82LRrZUeMn/8Doicm9RCFoTLfrNKtghUjb21H2F
         iDC/Yna1JKI4Fw0JdzFlHVoe/ap7d/iKgX0GjFvg1xqIcBGJIwIEThpRQLYpa5HWsoWY
         NDg5wkEtrMI4aCZjK1+ZnHaEQkDKPokUBt3AJyh6WTKlYxA5CpFlLz/RCtKoMNfAfa5j
         5ZJg==
X-Gm-Message-State: AOAM532gC2n/cBYmP/iMNe7E0YepbsRh3flpqYLsyzHJ35USRjOs9GHw
        ZRXoVMo7i5wpzJ9KZtzpO7ilejRm2R7BDw==
X-Google-Smtp-Source: ABdhPJxO+gzy3P9dKsKAj7haR8PwnXeJ/5KijEPEhdd1N2WjH/pSCW9CdV40QrRQdcD5R0/bYD5Omg==
X-Received: by 2002:a05:6402:1515:: with SMTP id f21mr16006592edw.175.1600061758925;
        Sun, 13 Sep 2020 22:35:58 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id f17sm8461864eds.45.2020.09.13.22.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2020 22:35:58 -0700 (PDT)
Subject: Re: [PATCH] tty: hvcs: Don't NULL tty->driver_data until
 hvcs_cleanup()
To:     Tyrel Datwyler <tyreld@linux.ibm.com>, gregkh@linuxfoundation.org
Cc:     Jason Yan <yanaijie@huawei.com>, Joe Perches <joe@perches.com>,
        "open list:HYPERVISOR VIRTUAL CONSOLE DRIVER" 
        <linuxppc-dev@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200820234643.70412-1-tyreld@linux.ibm.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <9f00bbcd-9b5b-9574-fcaa-7188046feb5f@kernel.org>
Date:   Mon, 14 Sep 2020 07:35:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820234643.70412-1-tyreld@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 08. 20, 1:46, Tyrel Datwyler wrote:
> The code currently NULLs tty->driver_data in hvcs_close() with the
> intent of informing the next call to hvcs_open() that device needs to be
> reconfigured. However, when hvcs_cleanup() is called we copy hvcsd from
> tty->driver_data which was previoulsy NULLed by hvcs_close() and our
> call to tty_port_put(&hvcsd->port) doesn't actually do anything since
> &hvcsd->port ends up translating to NULL by chance. This has the side
> effect that when hvcs_remove() is called we have one too many port
> references preventing hvcs_destuct_port() from ever being called. This
> also prevents us from reusing the /dev/hvcsX node in a future
> hvcs_probe() and we can eventually run out of /dev/hvcsX devices.
> 
> Fix this by waiting to NULL tty->driver_data in hvcs_cleanup().

Without actually looking into the code, it looks like we need a fix
similar to:
commit 24eb2377f977fe06d84fca558f891f95bc28a449
Author: Jiri Slaby <jirislaby@kernel.org>
Date:   Tue May 26 16:56:32 2020 +0200

    tty: hvc_console, fix crashes on parallel open/close

here too?

> Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
> ---
>  drivers/tty/hvc/hvcs.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
> index 55105ac38f89..509d1042825a 100644
> --- a/drivers/tty/hvc/hvcs.c
> +++ b/drivers/tty/hvc/hvcs.c
> @@ -1216,13 +1216,6 @@ static void hvcs_close(struct tty_struct *tty, struct file *filp)
>  
>  		tty_wait_until_sent(tty, HVCS_CLOSE_WAIT);
>  
> -		/*
> -		 * This line is important because it tells hvcs_open that this
> -		 * device needs to be re-configured the next time hvcs_open is
> -		 * called.
> -		 */
> -		tty->driver_data = NULL;
> -
>  		free_irq(irq, hvcsd);
>  		return;
>  	} else if (hvcsd->port.count < 0) {
> @@ -1237,6 +1230,13 @@ static void hvcs_cleanup(struct tty_struct * tty)
>  {
>  	struct hvcs_struct *hvcsd = tty->driver_data;
>  
> +	/*
> +	 * This line is important because it tells hvcs_open that this
> +	 * device needs to be re-configured the next time hvcs_open is
> +	 * called.
> +	 */
> +	tty->driver_data = NULL;
> +
>  	tty_port_put(&hvcsd->port);
>  }
>  
> 

thanks,
-- 
js
