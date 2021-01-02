Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAEA2E87A4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 15:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbhABOmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jan 2021 09:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbhABOl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 09:41:59 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB6DC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jan 2021 06:41:12 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id f132so26906741oib.12
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jan 2021 06:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rtg5cCarez9Rshf3Uq1IaD02vXT6DPqWvQZxIe08iDc=;
        b=0a4Akb2/5t4FtuHsI4vNVrQlcykE/gmbpShoPRd8kA0U06lfpni/8gWIsu1hj0JA45
         L4mH0F87NvZtVPpkXheqtMSJv9T51m9+XWduqeKPBuMstRs+VigykHHiJ+e4EvQQtQFD
         VMn1LJWsR09aaVDv2dNih8kJ8/R7zyMC8Ge6rx0HyFPEQSog2H+YLd5n4vYXx8coHJwM
         aqn3DG3Rz07/qeeAOctgH/eKm8F9ISIo8FexqM9X4LvFIZpFvwJl+qX3T5ChQlgdYAld
         ynZpKIHz1LF9ZrhveZ/ChE6XYdo1OeASRGi/3mtkXkCuVEFgwRyG8p3L7xsgBI9ZtGrZ
         3YbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=Rtg5cCarez9Rshf3Uq1IaD02vXT6DPqWvQZxIe08iDc=;
        b=H6C2ENDlGx5W+Hx1dfxnIYsajDwsC7YWZSTHNsqvDfR0TZb8EEf3fdgOl3dKHENgYp
         MW2s5L7mi0mnpqEuubEOAvP055frTj5slz6LZ3k9DSbxfK7MjzM5Kiq1h99mQPhRjx1Z
         mmfV3v8X/EtPSKNu6tTRS7p10vWDn1xg/AS8rWjetD0eUHxnk9E12ysYSK3x+7sHh9XB
         WyZJC2TJeiDCK0iHAJxyaE9FzH6deRuk2gcHcKI/Dx8vm0nYwPzLB83AYINODWZp8IM9
         GQhRLg2isVOSQU+iKu92R1jN4+gBUAIvp5b6crF5zg/nx+tc8fPKIJfkhhIkh/Xnx9nj
         clXA==
X-Gm-Message-State: AOAM531dhcVy3adiF0GqAdIWv7Dq8KqUa3Obx4IrWu+XmVi6meHiaD6w
        6kV2v5OUuOtGxOVtN/OByxaR4A==
X-Google-Smtp-Source: ABdhPJwWGgjXhUwdnSovvbomfoZSYyLbBCrPvMVhBm2gBtqCgzK05WQ7rehfWcBeHZNb/XLGF9duRA==
X-Received: by 2002:a54:4096:: with SMTP id i22mr13598204oii.126.1609598472128;
        Sat, 02 Jan 2021 06:41:12 -0800 (PST)
Received: from minyard.net ([2001:470:b8f6:1b:9886:db2a:7dce:1243])
        by smtp.gmail.com with ESMTPSA id b188sm8706008oif.49.2021.01.02.06.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jan 2021 06:41:11 -0800 (PST)
Date:   Sat, 2 Jan 2021 08:41:09 -0600
From:   Corey Minyard <cminyard@mvista.com>
To:     minyard@acm.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        brian.bloniarz@gmail.com
Subject: Re: [PATCH 2/2] drivers:tty:pty: Fix a race causing data loss on
 close
Message-ID: <20210102144109.GA4173@minyard.net>
Reply-To: cminyard@mvista.com
References: <20201124004902.1398477-1-minyard@acm.org>
 <20201124004902.1398477-3-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124004902.1398477-3-minyard@acm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 06:49:02PM -0600, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> Remove the tty_vhangup() from the pty code and just release the
> redirect.  The tty_vhangup() results in data loss and data out of order
> issues.

It's been a while, so ping on this.  I'm pretty sure this is the right
fix, the more I've thought about it.

Thankks,

-corey

> 
> If you write to a pty master an immediately close the pty master, the
> receiver might get a chunk of data dropped, but then receive some later
> data.  That's obviously something rather unexpected for a user.  It
> certainly confused my test program.
> 
> It turns out that tty_vhangup() on the slave pty gets called from
> pty_close(), and that causes the data on the slave side to be flushed,
> but due to races more data can be copied into the slave side's buffer
> after that.  Consider the following sequence:
> 
> thread1          thread2         thread3
> -------          -------         -------
>  |                |-write data into buffer,
>  |                | n_tty buffer is filled
>  |                | along with other buffers
>  |                |-pty_close(master)
>  |                |--tty_vhangup(slave)
>  |                |---tty_ldisc_hangup()
>  |                |----n_tty_flush_buffer()
>  |                |-----reset_buffer_flags()
>  |-n_tty_read()   |
>  |--up_read(&tty->termios_rwsem);
>  |                |------down_read(&tty->termios_rwsem)
>  |                |------clear n_tty buffer contents
>  |                |------up_read(&tty->termios_rwsem)
>  |--tty_buffer_flush_work()       |
>  |--schedules work calling        |
>  |  flush_to_ldisc()              |
>  |                                |-flush_to_ldisc()
>  |                                |--receive_buf()
>  |                                |---tty_port_default_receive_buf()
>  |                                |----tty_ldisc_receive_buf()
>  |                                |-----n_tty_receive_buf2()
>  |                                |------n_tty_receive_buf_common()
>  |                                |-------down_read(&tty->termios_rwsem)
>  |                                |-------__receive_buf()
>  |                                |       copies data into n_tty buffer
>  |                                |-------up_read(&tty->termios_rwsem)
>  |--down_read(&tty->termios_rwsem)
>  |--copy buffer data to user
> 
> From this sequence, you can see that thread2 writes to the buffer then
> only clears the part of the buffer in n_tty.  The n_tty receive buffer
> code then copies more data into the n_tty buffer.
> 
> But part of the vhangup, releasing the redirect, is still required to
> avoid issues with consoles running on pty slaves.  So do that.
> As far as I can tell, that is all that should be required.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>  drivers/tty/pty.c    | 15 +++++++++++++--
>  drivers/tty/tty_io.c |  5 +++--
>  2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
> index 23368cec7ee8..29be6b985e76 100644
> --- a/drivers/tty/pty.c
> +++ b/drivers/tty/pty.c
> @@ -67,7 +67,8 @@ static void pty_close(struct tty_struct *tty, struct file *filp)
>  	wake_up_interruptible(&tty->link->read_wait);
>  	wake_up_interruptible(&tty->link->write_wait);
>  	if (tty->driver->subtype == PTY_TYPE_MASTER) {
> -		set_bit(TTY_OTHER_CLOSED, &tty->flags);
> +		struct file *f;
> +
>  #ifdef CONFIG_UNIX98_PTYS
>  		if (tty->driver == ptm_driver) {
>  			mutex_lock(&devpts_mutex);
> @@ -76,7 +77,17 @@ static void pty_close(struct tty_struct *tty, struct file *filp)
>  			mutex_unlock(&devpts_mutex);
>  		}
>  #endif
> -		tty_vhangup(tty->link);
> +
> +		/*
> +		 * This hack is required because a program can open a
> +		 * pty and redirect a console to it, but if the pty is
> +		 * closed and the console is not released, then the
> +		 * slave side will never close.  So release the
> +		 * redirect when the master closes.
> +		 */
> +		f = tty_release_redirect(tty->link);
> +		if (f)
> +			fput(f);
>  	}
>  }
>  
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 571b1d7d4d5a..91c33a0df3c4 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -547,7 +547,9 @@ EXPORT_SYMBOL_GPL(tty_wakeup);
>   *	@tty: tty device
>   *
>   *	This is available to the pty code so if the master closes, if the
> - *	slave is a redirect it can release the redirect.
> + *	slave is a redirect it can release the redirect.  It returns the
> + *	filp for the redirect, which must be fput when the operations on
> + *	the tty are completed.
>   */
>  struct file *tty_release_redirect(struct tty_struct *tty)
>  {
> @@ -562,7 +564,6 @@ struct file *tty_release_redirect(struct tty_struct *tty)
>  
>  	return f;
>  }
> -EXPORT_SYMBOL_GPL(tty_release_redirect);
>  
>  /**
>   *	__tty_hangup		-	actual handler for hangup events
> -- 
> 2.25.1
> 
