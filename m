Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B6B2ED380
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 16:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbhAGP2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 10:28:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:60696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbhAGP2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 10:28:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58D5F23403;
        Thu,  7 Jan 2021 15:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610033258;
        bh=3zkBKuvh5O9njYVZ7/x32WLyY2ph3SVrA7wza+8uQkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fb2uyLagmTQ7sjUIU2DaMwUtWK9X5BkZNzRm2AUIg6sjgaI5cjXCOf4YhsuCm1lt8
         EGn6hZxiws7ZT2ZZaKNrePbxDe1D8xzEXtQ4Cb7ASqwdiGUEeSepK5yN7kiw8g0+Bs
         TksBmtJVxtv9TU8BXvxNkjrncC7sez3ROKzyzE/c=
Date:   Thu, 7 Jan 2021 16:28:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhangqiumiao1@huwei.com
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        zhangqiumiao <zhangqiumiao1@huawei.com>
Subject: Re: [PATCH] tty: fix timeout equals to 0 problem in tty_ioctl
Message-ID: <X/couq0YmTE8ypTn@kroah.com>
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

How can that happen?  We need a lot better changelog text here please.

> 
> Signed-off-by: zhangqiumiao <zhangqiumiao1@huawei.com>

I need a "full" name here, please.

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

Why pick this random number?

>  
>  	timeout = wait_event_interruptible_timeout(tty->write_wait,
>  			!tty_chars_in_buffer(tty), timeout);
> -	if (timeout <= 0)
> +	if (timeout < 0)
>  		return;
>  
> +	if (timeout == 0) {
> +		if (tty->ops->flush_buffer) {
> +			pr_info("%s: flush buffer\n", __func__);

Debugging code needs to be removed.

thanks,

greg k-h
