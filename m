Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C7D2834FE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 13:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgJELbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 07:31:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgJELbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 07:31:04 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17F502064C;
        Mon,  5 Oct 2020 11:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601897463;
        bh=FH9WYU8EUwbqVyg7R8YladPLPaMYFL3mG2J76fWdYdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SGzQ+pEBTHBOuMJqLi9vsd+UwkGtAtftY+efugpZWwNboJiUGo8hJA/8IMDsFcWP2
         +gQBR3Og6KJXtoWxw7lWgdQMAnzv+hWaF3f3rEW8v2H6j6HT1xB//THno3Jv76XWpn
         mrwJJMkuN5Vwhj+Cfd/sQB0IUzOzHV99SC78jHhg=
Date:   Mon, 5 Oct 2020 13:31:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     minyard@acm.org, Jiri Slaby <jirislaby@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH v2] drivers:tty:pty: Fix a race causing data loss on close
Message-ID: <20201005113149.GA444220@kroah.com>
References: <20201002130304.16728-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002130304.16728-1-minyard@acm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 08:03:04AM -0500, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> If you write to a pty master an immediately close the pty master, the
> receiver might get a chunk of data dropped, but then receive some later
> data.  That's obviously something rather unexpected for a user.  It
> certainly confused my test program.
> 
> It turns out that tty_vhangup() gets called from pty_close(), and that
> causes the data on the slave side to be flushed, but due to races more
> data can be copied into the slave side's buffer after that.  Consider
> the following sequence:
> 
> thread1          thread2         thread3
> -------          -------         -------
>  |                |-write data into buffer,
>  |                | n_tty buffer is filled
>  |                | along with other buffers
>  |                |-pty_close()
>  |                |--tty_vhangup()
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
>  |                                |-------copies data into n_tty buffer
>  |                                |-------up_read(&tty->termios_rwsem)
>  |--down_read(&tty->termios_rwsem)
>  |--copy buffer data to user
> 
> >From this sequence, you can see that thread2 writes to the buffer then
> only clears the part of the buffer in n_tty.  The n_tty receive buffer
> code then copies more data into the n_tty buffer.
> 
> This change checks to see if the tty is being hung up before copying
> anything in n_tty_receive_buf_common().  It has to be done after the
> tty->termios_rwsem semaphore is claimed, for reasons that should be
> apparent from the sequence above.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
> 
> Changes since v1: Added lines to make the sequence diagram clearer.
> 
> I sent a program to reproduce this, I extended it to prove it wasn't the
> test program that caused the issue, and I've uploaded it to:
>   http://sourceforge.net/projects/ser2net/files/tmp/testpty.c
> if you want to run it.  It has a lot of comments that explain what is
> going on.
> 
> This is not a very satisfying fix, though.  It works reliably, but it
> doesn't seem right to me.  My inclination was to remove the up and down
> semaphore around tty_buffer_flush_work() in n_tty_read(), as it just
> schedules some work, no need to unlock for that.  But that resulted
> in a deadlock elsewhere, so that up/down on the semaphore is there for
> another reason.
> 
> The locking in the tty code is really hard to follow.  I believe this is
> actually a locking problem, but fixing it looks daunting to me.
> 
> Another way to fix this that occurred just occurred to me would be to
> clear all the buffers in pty_close().
> 
> -corey
> 
> 
>  drivers/tty/n_tty.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index 1794d84e7bf6..1c33c26dc229 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -1704,6 +1704,9 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
>  
>  	down_read(&tty->termios_rwsem);
>  
> +	if (test_bit(TTY_HUPPING, &tty->flags))
> +		goto out_upsem;
> +
>  	do {
>  		/*
>  		 * When PARMRK is set, each input char may take up to 3 chars
> @@ -1760,6 +1763,7 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
>  	} else
>  		n_tty_check_throttle(tty);
>  
> +out_upsem:
>  	up_read(&tty->termios_rwsem);
>  
>  	return rcvd;
> -- 
> 2.17.1
> 

Jiri, any thoughts about this?  At first glance, it looks sane to me,
but a second review would be great.

thanks,

greg k-h
