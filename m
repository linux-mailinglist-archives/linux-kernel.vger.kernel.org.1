Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D642DEDBF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 08:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgLSHvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 02:51:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:48670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgLSHvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 02:51:32 -0500
Date:   Sat, 19 Dec 2020 08:50:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1608364251;
        bh=kBs6bq8KLqchoxQFj9AafT6V6cnuzOv01bSICdUJWjo=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=zEya4XpRCfl3bLcOaRPDhq4MTc3WZNLHRoCbrovc7L+hNLncXTLXBrBQFz3fGg2iv
         c8ezKv7QpEdbgO5WiYI8ZtnGIwIAgilS/sFBsgM/amESw+kyLWBYgUMnF1PKHijgQZ
         F0nM7hWYHp5elcT8kZ3hUEwpv7sV1NUdT0754Tt0=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhangqiumiao1@huwei.com
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        zhangqiumiao <zhangqiumiao1@huawei.com>
Subject: Re: [PATCH] tty: fix timeout equals to 0 problem in tty_ioctl
Message-ID: <X92w15bOlII1X0Pw@kroah.com>
References: <1608348451-24082-1-git-send-email-zhangqiumiao1@huwei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608348451-24082-1-git-send-email-zhangqiumiao1@huwei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 19, 2020 at 11:27:31AM +0800, zhangqiumiao1@huwei.com wrote:
> From: zhangqiumiao <zhangqiumiao1@huawei.com>
> 
> Fix the problem that tty buffer data was not flushed when timeout=0.
> 
> Signed-off-by: zhangqiumiao <zhangqiumiao1@huawei.com>
> ---
>  drivers/tty/tty_ioctl.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
> index 4de1c6ddb8ff..f9d4b6e22308 100644
> --- a/drivers/tty/tty_ioctl.c
> +++ b/drivers/tty/tty_ioctl.c
> @@ -220,13 +220,21 @@ void tty_wait_until_sent(struct tty_struct *tty, long timeout)
>  	tty_debug_wait_until_sent(tty, "wait until sent, timeout=%ld\n", timeout);
>  
>  	if (!timeout)
> -		timeout = MAX_SCHEDULE_TIMEOUT;
> +		timeout = 60 * HZ;

Why change this?

>  
>  	timeout = wait_event_interruptible_timeout(tty->write_wait,
>  			!tty_chars_in_buffer(tty), timeout);
> -	if (timeout <= 0)
> +	if (timeout < 0)
>  		return;

How can timeout be 0 here?

> +	if (timeout == 0) {
> +		if (tty->ops->flush_buffer) {
> +			pr_info("%s: flush buffer\n", __func__);

Debugging code?

> +			tty->ops->flush_buffer(tty);
> +		}
> +		return;
> +	}
> +

thanks,

greg k-h
