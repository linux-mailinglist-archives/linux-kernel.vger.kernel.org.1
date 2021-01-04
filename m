Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCEB2E9548
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 13:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbhADMvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 07:51:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:47744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbhADMvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 07:51:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC9AF207AE;
        Mon,  4 Jan 2021 12:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609764624;
        bh=CLXBImd0VfVxFmHS5bb9iN9LH0cMftAe+oEws1dH8sQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XiAt2Dgx1ooHX0XWnUikafpKrJGgHiIhktYNevg5qoXNMTMWu21C9LtN5nKZ/rYMi
         yIYuMd8ICuFKQ3UvWLU9F5AFMiXloqByuSLxWaY2tzMEWWhGG3tTnge77Zr/D8IgAc
         fTnhcP9cN18NJbR3SHNZQRhbxLem72epJhTY5DbY=
Date:   Mon, 4 Jan 2021 13:51:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhangqiumiao1@huawei.com
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tty: resolve loopback wait problem for serial port
Message-ID: <X/MPZt75/zmrKt83@kroah.com>
References: <1609764086-5892-1-git-send-email-zhangqiumiao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609764086-5892-1-git-send-email-zhangqiumiao1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 08:41:26PM +0800, zhangqiumiao1@huawei.com wrote:
> From: Qiumiao Zhang <zhangqiumiao1@huawei.com>
> 
> Serial port writing will be suspended when the buffer is continuously full. When
> the serial port's TX and RX are short circuited, there is a certain probability
> that this will happed. The concrete representation is n_tty_write blocking in
> wait_woken and the process is trapped in a loop waiting. After testing, when the
> the serial port runs well, wait_woken wait time will not exceed 60 seconds. So
> for serial port, set the timeout value of wait_woken function to 60s. Wake up and
> flush the buffer after timeout.
> 

Why would we ever want to wait longer than 60 seconds?  What problems
does this cause if we just always set the timeout to 60 seconds?

> Signed-off-by: Qiumiao Zhang <zhangqiumiao1@huawei.com>
> ---
> v4:
>  fix wrong expression in path description
>  remove unnecessary macro definition and debugging code
> v3:
>  add changes from v1 to v2
> 
> v2:
>  change to use "real name"
>  fix wrong expression in path description
>  remove config option
>  use driver type to judge tty device type
> 
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index 319d68c..0e6f202 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -2375,7 +2375,17 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
>  		}
>  		up_read(&tty->termios_rwsem);
> 
> -		wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
> +		/* Resolve the problem of loopback waiting for serial port*/

Extra space please before the "*/"

> +		if (tty->driver->type == TTY_DRIVER_TYPE_SERIAL) {

Why is serial unique here?

> +			if (wait_woken(&wait, TASK_INTERRUPTIBLE, 60 * HZ) == 0)
> +				if (tty && tty->ops->flush_buffer) {
> +					tty->ops->flush_buffer(tty);
> +				} else {
> +					tty_err(tty, "tty related structure not registered\n");

How is this an error now?  What can a user do about it?  Do you need to
fix up some drivers because of this change?

Did you run this through checkpatch?  Are you sure that it does not
complain about the { } use here?



> +				}
> +		} else {
> +			wait_woken(&wait, TASK_INTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);
> +		}

This whole thing still feels really wrong.  If things are stuck, why
will this fix them?  Shouldn't the serial driver properly recover no
matter what?

What hardware and workload are you seeing this problem on?

thanks,

greg k-h
