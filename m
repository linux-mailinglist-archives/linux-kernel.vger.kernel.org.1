Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879262E79D7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 14:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgL3N43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 08:56:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbgL3N43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 08:56:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBB9020791;
        Wed, 30 Dec 2020 13:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609336548;
        bh=lll0qazF8/eBr9JW0JL5Dgjtv1rUJUbslF+AEahjrUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JFwzncjAnHU6NiqmM+56H22z6WZfh07lkRlxsBn9VztTCBCRMMymZjJl6Z5Nr6l6c
         DjZANA9J9WNOlWnO+MVT4/bo1BXMAGPXk2G52BunyDFinFqugwqCCY9zSm9mdt5/vZ
         AG3lUDfkpbQ3VK+r01JbK4i6EQUIdfbGX7m6qVmo=
Date:   Wed, 30 Dec 2020 14:57:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhangqiumiao1@huawei.com
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tty: resolve loopback wait problem for aging serial
 port
Message-ID: <X+yHOr6Q5fsuQhSy@kroah.com>
References: <1609335929-13463-1-git-send-email-zhangqiumiao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609335929-13463-1-git-send-email-zhangqiumiao1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 09:45:29PM +0800, zhangqiumiao1@huawei.com wrote:
> From: Qiumiao Zhang <zhangqiumiao1@huawei.com>
> 
> Because serial port is low-speed device, serial port writing will be suspended
> when the buffer of driver layer is full due to serial port aging.

What do you mean here exactly?  What is "serial port aging"?

And since when is a serial port a low-speed device?  Compared to what?

> The concrete
> representation is n_tty_write blocking in the process of wait_woken, the process
> of writing serial port exists without feedback, and becomes a zombie process.

I do not understand this sentance, sorry.  Can you rephrase it?

> So for serial port, set the timeout value of wait_woken function to 60s. Wake up
> and flush the buffer after timeout.

Where did the 60 second number come from?  Why that value and not any
other specific value?


> 
> Signed-off-by: Qiumiao Zhang <zhangqiumiao1@huawei.com>
> ---
> v3:
>  add changes from v1 to v2
> 
> v2:
>  change to use "real name"
>  fix wrong expression in path description
>  remove config option
>  use driver type to judge tty device type
> 
>  drivers/tty/n_tty.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index 319d68c..8e7591a 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -87,6 +87,8 @@
>  # define n_tty_trace(f, args...)	no_printk(f, ##args)
>  #endif
> 
> +#define SIXTY_SEC_TIMEOUT (60 * HZ)

Is that define really needed?

> +
>  struct n_tty_data {
>  	/* producer-published */
>  	size_t read_head;
> @@ -2375,7 +2377,18 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
>  		}
>  		up_read(&tty->termios_rwsem);
> 
> -		wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
> +		/* Resolve the problem of loopback waiting when the serial port is aging seriously */
> +		if (tty->driver->type == TTY_DRIVER_TYPE_SERIAL) {
> +			if (wait_woken(&wait, TASK_INTERRUPTIBLE, SIXTY_SEC_TIMEOUT) == 0)
> +				if (tty && tty->ops->flush_buffer) {
> +					printk(KERN_INFO "n_tty_write flush buffer\n");

Why have you left debugging code in here?

> +					tty->ops->flush_buffer(tty);
> +				} else {
> +					printk(KERN_ERR "tty related structure not registered\n");

What can a user do with this?  How can it be hit?

And never use printk() in a driver, please use dev_err() and friends
instead.

thanks,

greg k-h
