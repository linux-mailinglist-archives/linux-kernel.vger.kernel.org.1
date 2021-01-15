Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0102F7436
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 09:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732540AbhAOIV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 03:21:29 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:44439 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbhAOIV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 03:21:28 -0500
Received: by mail-ed1-f42.google.com with SMTP id p22so8560207edu.11;
        Fri, 15 Jan 2021 00:21:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bBlGeqvogN/tfxpT7qIQYHjcZ7UeRjnnIYs3P87C0W0=;
        b=V+EILBiccd1Z90+EC7rLU4AyaDQCjgBEiSnLSvSzkEcYxzphMrGgZ53kHVtvH3qKyk
         6CqachtFUl4oikzFDObmM3vzaAXkS5pr2n2J9rp6BUa0P6wx0T4NYJW1E3iBZSQCfNob
         0NHphVmY9wUGqAOZMhdRU3KJVAWMe4WKHyvdywqkYgt0M+ilDQ/3XbvmZpPWQt/HjBsw
         gl/qXWu0qx5FwuOiEfO87Tkx9Tjvo4WOQSQJecYRKuApTaJq6n+n3rmCwGzAOZxbtiDH
         HL19qugru5q75sOuyBFky8AbtpFpjaSms+gs+Pw22n0OARTZSJlbz9cuczFWgEGVv9gA
         SV/Q==
X-Gm-Message-State: AOAM533aC6ptx4ayBCdeKBfnUGoiUpRPdIAKDgjs3tk9MI7VvmkNkmuM
        ER3CarzAur1Yerqtb3ULOXRzEuje0s8=
X-Google-Smtp-Source: ABdhPJwPRo+BZcR8EuEdLUaLQa2/MEEQ7N5QfiNCyKXjmI9rNiQ7nzOrspllBA1Qb61UYd4mriJXZw==
X-Received: by 2002:aa7:c603:: with SMTP id h3mr8806921edq.254.1610698846251;
        Fri, 15 Jan 2021 00:20:46 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id ay24sm1005068edb.79.2021.01.15.00.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 00:20:45 -0800 (PST)
Subject: Re: [PATCH 3/3] tty: vcc: Drop impossible to hit WARN_ON
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210114175718.137483-1-u.kleine-koenig@pengutronix.de>
 <20210114175718.137483-4-u.kleine-koenig@pengutronix.de>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <046bdfe5-5741-0ebb-6cfd-2548f9a5543e@kernel.org>
Date:   Fri, 15 Jan 2021 09:20:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210114175718.137483-4-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14. 01. 21, 18:57, Uwe Kleine-König wrote:
> vcc_get() returns the port that has provided port->index. As the port that
> is about to be removed isn't removed yet this trivially will find this
> port. So simplify the call to not assign an identical value to the port
> pointer and drop the warning that is never hit.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/vcc.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
> index d9b0dc6deae9..e2d6205f83ce 100644
> --- a/drivers/tty/vcc.c
> +++ b/drivers/tty/vcc.c
> @@ -692,12 +692,9 @@ static int vcc_remove(struct vio_dev *vdev)
>   		tty_vhangup(port->tty);
>   
>   	/* Get exclusive reference to VCC, ensures that there are no other
> -	 * clients to this port
> +	 * clients to this port. This cannot fail.
>   	 */
> -	port = vcc_get(port->index, true);
> -
> -	if (WARN_ON(!port))
> -		return -ENODEV;
> +	vcc_get(port->index, true);
>   
>   	tty_unregister_device(vcc_tty_driver, port->index);
>   
> 


-- 
js
