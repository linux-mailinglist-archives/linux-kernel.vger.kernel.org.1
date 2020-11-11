Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB242AFCC0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgKLBdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbgKKWwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 17:52:19 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB66C0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 14:52:18 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id f16so3731591otl.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 14:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xMIglEImOD5ykxi32tJWx7f/rRAdlWoECV0wvKIUYuA=;
        b=hhVUmxndRd+3M8PKAjhRDQBpaadBe8wuydM7anHVudLle1DNaK3oiaTR2KNgECE6o7
         smpFFxm2dEd1Dk0yPYBU3qhZAnp9OOEno+REkPUBhRf7zbjaJ+3OXj691hjgebk3PfKF
         65AtDUtNOF1SGtmhMEqHa5O8dcWPZdNnNnIQpeCXo9pVrwX4iqQgb5EX1rk3i4OvlRKM
         M6dU0itwFx9I4EB1IDDqzmZM+AEvsHpVQBCYGnfsLbNdKxJFP98F7hn9oxxb/8eUehwH
         1DVzhwUewrkbPsi0iAnmey7sy3nZAkxfrssqVSRjc55e29STE0Tq7tmXShy2Zk43EVBh
         gkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xMIglEImOD5ykxi32tJWx7f/rRAdlWoECV0wvKIUYuA=;
        b=sqiDsyNo9aJ6Z1fDaIT04ejJw7R37DOCCi8YP6FNFUmCUoa72zpEvDxP346I4D9DwM
         sBbzhyEyp/puABFjdW3g+iqlmzmAsld4vQDrnUgUENuuW1Nucl8Xu+Ln1/a5KGqJapPw
         p1RFwIO74LC7jRCreyQC+F86ggiYhLReKtGqs+5OarP89hLEeGgZ+O7/qQK5qrDiRC63
         0qGZzxV0IrebT3esHz2qk/e4P2UTHVDA5zfdmyUi3r91bLPqOcdCL2hlxZTO0hoNL/n1
         Kd0R936AspHrcGXzA7T85osNOmSqCASTw+UynETH9WyFMe9X7swm8yeES3cQNfRCE7Sq
         mEYQ==
X-Gm-Message-State: AOAM532rB3DnRT2YhjnWnkSlPBNdnDyGjTwkbiEC7188xGxsYS3OvJCv
        F2pfFkjP7HHxST+nvEK7d891LEdPbOs=
X-Google-Smtp-Source: ABdhPJxlBS5a0+HgQ9nUvGqniaMfy0wj5jgzfhDuT5ogtEPhuyIsX5O8CIV/WlgvBWeYEnJSAVMS0A==
X-Received: by 2002:a9d:2c68:: with SMTP id f95mr20042226otb.300.1605135137777;
        Wed, 11 Nov 2020 14:52:17 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n129sm856845ooa.17.2020.11.11.14.52.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Nov 2020 14:52:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 11 Nov 2020 14:52:15 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] init/console: Use ttynull as a fallback when there
 is no console
Message-ID: <20201111225215.GA211321@roeck-us.net>
References: <20201111135450.11214-1-pmladek@suse.com>
 <20201111135450.11214-2-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111135450.11214-2-pmladek@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 02:54:49PM +0100, Petr Mladek wrote:
> stdin, stdout, and stderr standard I/O stream are created for the init
> process. They are not available when there is no console registered
> for /dev/console. It might lead to a crash when the init process
> tries to use them, see the commit 48021f98130880dd742 ("printk: handle
> blank console arguments passed in.").
> 
> Normally, ttySX and ttyX consoles are used as a fallback when no consoles
> are defined via the command line, device tree, or SPCR. But there
> will be no console registered when an invalid console name is configured
> or when the configured consoles do not exist on the system.
> 
> Users even try to avoid the console intentionally, for example,
> by using console="" or console=null. It is used on production
> systems where the serial port or terminal are not visible to
> users. Pushing messages to these consoles would just unnecessary
> slowdown the system.
> 
> Make sure that stdin, stdout, stderr, and /dev/console are always
> available by a fallback to the existing ttynull driver. It has
> been implemented for exactly this purpose but it was used only
> when explicitly configured.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

Reviewed-and-tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/tty/Kconfig     | 14 --------------
>  drivers/tty/Makefile    |  3 +--
>  drivers/tty/ttynull.c   | 18 ++++++++++++++++++
>  include/linux/console.h |  3 +++
>  init/main.c             | 10 ++++++++--
>  5 files changed, 30 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
> index 93fd984eb2f5..ca359bbd62f5 100644
> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -428,20 +428,6 @@ config MIPS_EJTAG_FDC_KGDB_CHAN
>  	help
>  	  FDC channel number to use for KGDB.
>  
> -config NULL_TTY
> -	tristate "NULL TTY driver"
> -	help
> -	  Say Y here if you want a NULL TTY which simply discards messages.
> -
> -	  This is useful to allow userspace applications which expect a console
> -	  device to work without modifications even when no console is
> -	  available or desired.
> -
> -	  In order to use this driver, you should redirect the console to this
> -	  TTY, or boot the kernel with console=ttynull.
> -
> -	  If unsure, say N.
> -
>  config TRACE_ROUTER
>  	tristate "Trace data router for MIPI P1149.7 cJTAG standard"
>  	depends on TRACE_SINK
> diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
> index 020b1cd9294f..f6b6bee0422d 100644
> --- a/drivers/tty/Makefile
> +++ b/drivers/tty/Makefile
> @@ -2,7 +2,7 @@
>  obj-$(CONFIG_TTY)		+= tty_io.o n_tty.o tty_ioctl.o tty_ldisc.o \
>  				   tty_buffer.o tty_port.o tty_mutex.o \
>  				   tty_ldsem.o tty_baudrate.o tty_jobctrl.o \
> -				   n_null.o
> +				   n_null.o ttynull.o
>  obj-$(CONFIG_LEGACY_PTYS)	+= pty.o
>  obj-$(CONFIG_UNIX98_PTYS)	+= pty.o
>  obj-$(CONFIG_AUDIT)		+= tty_audit.o
> @@ -25,7 +25,6 @@ obj-$(CONFIG_ISI)		+= isicom.o
>  obj-$(CONFIG_MOXA_INTELLIO)	+= moxa.o
>  obj-$(CONFIG_MOXA_SMARTIO)	+= mxser.o
>  obj-$(CONFIG_NOZOMI)		+= nozomi.o
> -obj-$(CONFIG_NULL_TTY)	        += ttynull.o
>  obj-$(CONFIG_ROCKETPORT)	+= rocket.o
>  obj-$(CONFIG_SYNCLINK_GT)	+= synclink_gt.o
>  obj-$(CONFIG_SYNCLINKMP)	+= synclinkmp.o
> diff --git a/drivers/tty/ttynull.c b/drivers/tty/ttynull.c
> index 17f05b7eb6d3..eced70ec54e1 100644
> --- a/drivers/tty/ttynull.c
> +++ b/drivers/tty/ttynull.c
> @@ -2,6 +2,13 @@
>  /*
>   * Copyright (C) 2019 Axis Communications AB
>   *
> + * The console is useful for userspace applications which expect a console
> + * device to work without modifications even when no console is available
> + * or desired.
> + *
> + * In order to use this driver, you should redirect the console to this
> + * TTY, or boot the kernel with console=ttynull.
> + *
>   * Based on ttyprintk.c:
>   *  Copyright (C) 2010 Samo Pogacnik
>   */
> @@ -59,6 +66,17 @@ static struct console ttynull_console = {
>  	.device = ttynull_device,
>  };
>  
> +void __init register_ttynull_console(void)
> +{
> +	if (!ttynull_driver)
> +		return;
> +
> +	if (add_preferred_console(ttynull_console.name, 0, NULL))
> +		return;
> +
> +	register_console(&ttynull_console);
> +}
> +
>  static int __init ttynull_init(void)
>  {
>  	struct tty_driver *driver;
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 4b1e26c4cb42..9c662e41cde5 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -187,9 +187,12 @@ extern int braille_register_console(struct console *, int index,
>  extern int braille_unregister_console(struct console *);
>  #ifdef CONFIG_TTY
>  extern void console_sysfs_notify(void);
> +extern void register_ttynull_console(void);
>  #else
>  static inline void console_sysfs_notify(void)
>  { }
> +static inline void register_ttynull_console(void)
> +{ }
>  #endif
>  extern bool console_suspend_enabled;
>  
> diff --git a/init/main.c b/init/main.c
> index 130376ec10ba..24413c055a85 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1470,8 +1470,14 @@ void __init console_on_rootfs(void)
>  	struct file *file = filp_open("/dev/console", O_RDWR, 0);
>  
>  	if (IS_ERR(file)) {
> -		pr_err("Warning: unable to open an initial console.\n");
> -		return;
> +		pr_err("Warning: unable to open an initial console. Fallback to ttynull.\n");
> +		register_ttynull_console();
> +
> +		file = filp_open("/dev/console", O_RDWR, 0);
> +		if (IS_ERR(file)) {
> +			pr_err("Warning: Failed to add ttynull console. No stdin, stdout, and stderr for the init process!\n");
> +			return;
> +		}
>  	}
>  	init_dup(file);
>  	init_dup(file);
> -- 
> 2.26.2
> 
