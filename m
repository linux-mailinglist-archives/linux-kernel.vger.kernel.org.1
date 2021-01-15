Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B447B2F7434
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 09:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbhAOIVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 03:21:08 -0500
Received: from mail-ej1-f45.google.com ([209.85.218.45]:34361 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbhAOIVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 03:21:07 -0500
Received: by mail-ej1-f45.google.com with SMTP id hs11so9742806ejc.1;
        Fri, 15 Jan 2021 00:20:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jEyFAI8Tiov/SBHpNo3029tSX/H+CCtTPEByvcBUUrQ=;
        b=DkuvQEPMtxco7IdyKu5xMEPlBcK7j6OWDkSs48lhC4mwPDDoIghySMK45ZTJKQlNgX
         asf39P3RkBC5kwR2JPOYWAo9UPQkyg+xwv6Q5RbwKhbb2OYCtspUIX6CjwW7Ce+rPdHx
         jIgpxhb/7+r5HDSZglRFS6WQY1BB8VyRry3xqgeKOzaXpEUho0gfsZfDKrxV7XS+D7wJ
         ihmJdL26WVB/uL6PYJrNH1RvS6BjpEViC8iEkxEbJv9hHyK4HauY6hehMwWJQHsyt3Db
         Hk3TSPHpFXvNZo/OVzYJhmz5m43ffGrYMZzYjLWkRHQGQcyRqiE1VGM6n07AcbtyA7YF
         MebQ==
X-Gm-Message-State: AOAM531fquYMlZYZjns07eA1oTlQTUZDIV4X1iSBeUa8AkDcscU0IXWU
        o/zpSIZeZUhBC1qNPmHJLRjiZ2VGy0U=
X-Google-Smtp-Source: ABdhPJza8YUJJ+T+zmo3FTE2Q4CTVcyXE8IE5bnUQXWXBR8ur4YO/4xQ/EJM/R7aABO9UuVSd7Ptxw==
X-Received: by 2002:a17:906:4893:: with SMTP id v19mr77844ejq.454.1610698825555;
        Fri, 15 Jan 2021 00:20:25 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id h23sm2923600ejg.37.2021.01.15.00.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 00:20:24 -0800 (PST)
Subject: Re: [PATCH 2/3] tty: vcc: Drop unnecessary if block
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210114175718.137483-1-u.kleine-koenig@pengutronix.de>
 <20210114175718.137483-3-u.kleine-koenig@pengutronix.de>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <9a1c68fc-f3bf-79e7-e2ae-238059241e2f@kernel.org>
Date:   Fri, 15 Jan 2021 09:20:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210114175718.137483-3-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14. 01. 21, 18:57, Uwe Kleine-König wrote:
> If vcc_probe() succeeded dev_set_drvdata() is called with a non-NULL
> value, and if vcc_probe() failed vcc_remove() isn't called.
> 
> So there is no way dev_get_drvdata() can return NULL in vcc_remove() and
> the check can just go away.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/vcc.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
> index 9ffd42e333b8..d9b0dc6deae9 100644
> --- a/drivers/tty/vcc.c
> +++ b/drivers/tty/vcc.c
> @@ -681,9 +681,6 @@ static int vcc_remove(struct vio_dev *vdev)
>   {
>   	struct vcc_port *port = dev_get_drvdata(&vdev->dev);
>   
> -	if (!port)
> -		return -ENODEV;
> -
>   	del_timer_sync(&port->rx_timer);
>   	del_timer_sync(&port->tx_timer);
>   
> 


-- 
js
