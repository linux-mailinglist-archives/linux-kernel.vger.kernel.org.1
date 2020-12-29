Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECECB2E6F65
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 10:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgL2Jek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 04:34:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgL2Jej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 04:34:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 850F0208BA;
        Tue, 29 Dec 2020 09:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609234439;
        bh=NlXxpt2vfq5xLcc+2SH8PKSKui2Nmv2rrzEXX/o3hLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hr+jkgGJ1hCbJgeVmGduTSkAKsY+rc4vMNnDyvzsWC0Zxr0a+u7NR8dfZTz250mcr
         sCLZIj1bfXZXzHZWNMjrN1Hba2kPxq/oz8zoDbs5Xd+KlF+UjxroQtS6VPtqVZGe3A
         YeSyRBbPO7jjICmkGPB5giHBVE4ge/4QSi5RGQF4=
Date:   Tue, 29 Dec 2020 10:35:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhangqiumiao1@huawei.com
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: resolve loopback wait problem when serial port is
 damaged
Message-ID: <X+r4V5KFiLWtK64W@kroah.com>
References: <1609232006-26090-1-git-send-email-zhangqiumiao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609232006-26090-1-git-send-email-zhangqiumiao1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 04:53:26PM +0800, zhangqiumiao1@huawei.com wrote:
> From: zhangqiumiao <zhangqiumiao1@huawei.com>
> 
> Since ttySx and ttyAMAx are low-speed devices, serial port writing will be
> suspended when the buffer of driver layer is full due to serial port damage. The
> concrete representation is n_tty_write blocking in the process of wait_woken,
> the process of writing serial port exists without feedback, and becomes a zombie
> process. So for ttySx and ttyAMAx, set the timeout value of wait_woken function
> to 60s. Wake up and flush the buffer after timeout.
> 
> Signed-off-by: zhangqiumiao <zhangqiumiao1@huawei.com>

Please use your "real name" here and the From line.

And since when is ttySx always a "low speed" device?

And what do you mean by "damage"?

> ---
>  drivers/tty/Kconfig |  8 ++++++++
>  drivers/tty/n_tty.c | 19 +++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> index 47a6e42..cc33c8b 100644
> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -173,6 +173,14 @@ config LDISC_AUTOLOAD
>  	  dev.tty.ldisc_autoload sysctl, this configuration option will
>  	  only set the default value of this functionality.
> 
> +config TTY_CONSOLE_STABLE
> +	bool "Enhance serial console stability"
> +	help
> +	  Set the timeout value of wait_woken function to 60s, wake up and
> +	  flush the buffer after timeout. It can prevent the serial port
> +	  from falling into loopback waiting when the serial port is damaged
> +	  and enhance the stability of serial console.

No config option should be needed for "make the kernel more stable" type
of options, right?

> +
>  source "drivers/tty/serial/Kconfig"
> 
>  config SERIAL_NONSTANDARD
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index 319d68c..4222feb 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -87,6 +87,10 @@
>  # define n_tty_trace(f, args...)	no_printk(f, ##args)
>  #endif
> 
> +#ifdef CONFIG_TTY_CONSOLE_STABLE
> +# define SIXTY_SEC_TIMEOUT (60 * HZ)
> +#endif
> +
>  struct n_tty_data {
>  	/* producer-published */
>  	size_t read_head;
> @@ -2375,7 +2379,22 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
>  		}
>  		up_read(&tty->termios_rwsem);
> 
> +#ifdef CONFIG_TTY_CONSOLE_STABLE

No #ifdefs in .c code.

> +		/* Resolve the problem of loopback waiting when the serial port is damaged */
> +		if (strncmp(tty->name, "ttyS", 4) == 0 || strncmp(tty->name, "ttyAMA", 6) == 0) {

Doing things based on a string is ripe for major problems.

greg k-h
