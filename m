Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4912F7432
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 09:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbhAOIUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 03:20:40 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:42032 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbhAOIUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 03:20:39 -0500
Received: by mail-ed1-f42.google.com with SMTP id g24so8558862edw.9;
        Fri, 15 Jan 2021 00:20:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q3u1c2cmK2DITir507fdDBtH+U4eOB5jtHbxWlFMVtQ=;
        b=Gt/X1UBjEnHrwfM3FEGFdLiI73n0tEwFQ5JjbI6GUWsSaUeGJ1S6EwmDWVTKjNyWLN
         J1/vK8UwpD1CLrPHJ1WZ25Nk6dHwxajYBq8Na2shP6uFdNrv9DSKHWt2uCiDZLws1FTj
         5P+z9ZDBcWZsYFOeSU/zJZS9W3HTmLNHTNgRsL9Ow76tPs3iQII8bvt0yFpPDFPwAAQs
         PGX9+vvK93EoQuTwXtxsyPXr6ECXGT4SniRlabctI7hCpqB6ZnLQ4nf+vo1HBH35qRgz
         kQEFg0boJ3h7IZIrN7V/a4EH1WaAb2dQFUej6fMfFfAkRCbcJ8GBOKMBonPJx9Jdp5Ro
         Ehjg==
X-Gm-Message-State: AOAM530/nSnu8PyrMNtKnDyGoWgk+rsHV6Sxyqy/V6nUUNRxMqLYg1sQ
        gkLPt3HzRD6/gk1wVR3DXLdtmMpluOI=
X-Google-Smtp-Source: ABdhPJwWBbtrNN8Dt/03jdN8TWPQGNvz2cTqSx6WvSbbavMAhwqQ7OozTqX2J4z2mqMcfAOpbO1pBg==
X-Received: by 2002:aa7:d2d4:: with SMTP id k20mr6782073edr.361.1610698796929;
        Fri, 15 Jan 2021 00:19:56 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id o20sm2929393ejb.123.2021.01.15.00.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 00:19:56 -0800 (PST)
Subject: Re: [PATCH 1/3] tty: hvcs: Drop unnecessary if block
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210114175718.137483-1-u.kleine-koenig@pengutronix.de>
 <20210114175718.137483-2-u.kleine-koenig@pengutronix.de>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <1afca17b-f148-4412-c80f-6168e79fd2ac@kernel.org>
Date:   Fri, 15 Jan 2021 09:19:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210114175718.137483-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14. 01. 21, 18:57, Uwe Kleine-König wrote:
> If hvcs_probe() succeeded dev_set_drvdata() is called with a non-NULL
> value, and if hvcs_probe() failed hvcs_remove() isn't called.
> 
> So there is no way dev_get_drvdata() can return NULL in hvcs_remove() and
> the check can just go away.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/hvc/hvcs.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
> index 509d1042825a..3e0461285c34 100644
> --- a/drivers/tty/hvc/hvcs.c
> +++ b/drivers/tty/hvc/hvcs.c
> @@ -825,9 +825,6 @@ static int hvcs_remove(struct vio_dev *dev)
>   	unsigned long flags;
>   	struct tty_struct *tty;
>   
> -	if (!hvcsd)
> -		return -ENODEV;
> -
>   	/* By this time the vty-server won't be getting any more interrupts */
>   
>   	spin_lock_irqsave(&hvcsd->lock, flags);
> 


-- 
js
