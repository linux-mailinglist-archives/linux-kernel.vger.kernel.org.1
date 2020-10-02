Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521D02811E9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 14:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387821AbgJBMBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 08:01:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgJBMBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 08:01:34 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB624206A2;
        Fri,  2 Oct 2020 12:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601640094;
        bh=zbiiuyF5kjvD4Hk79n0s5rZqUD3LAi6erjiDnLetCJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aJPgagblHWUFpqbxqUSneM6YdWH/dllJTLnhIWqtaZHi2cVY3vJfn/mBFe3245uIg
         zjr9vP9lZbkdo27whBOhPtnRwyAX8hteZwNtTqqvcZ06RIWx/JyuMLKT7n8Pc+ml8v
         +fHZtIIhTTAHAnYwE04mAFoMcR7edrtUvmq0UWiM=
Date:   Fri, 2 Oct 2020 14:01:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     minyard@acm.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH] drivers:tty:pty: Fix a race causing data loss on close
Message-ID: <20201002120133.GB3339665@kroah.com>
References: <20201002021630.4892-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002021630.4892-1-minyard@acm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 09:16:30PM -0500, minyard@acm.org wrote:
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
> thread1            thread2            thread3
>                    write data into buffer,
>                       n_tty buffer is filled
>                    pty_close()
>                     tty_vhangup()
>                      tty_ldisc_hangup()
>                       n_tty_flush_buffer()
>                        reset_buffer_flags()
> n_tty_read()
>  up_read(&tty->termios_rwsem);
>                         down_read(&tty->termios_rwsem);
>                         clear n_tty buffer contents
>                         up_read(&tty->termios_rwsem);
>  tty_buffer_flush_work()
>   schedules work calling
>         flush_to_ldisc()
>                                       flush_to_ldisc()
>                                        receive_buf()
>                                         tty_port_default_receive_buf()
>                                          tty_ldisc_receive_buf()
>                                           tty_ldisc_receive_buf()
>                                            n_tty_receive_buf2()
>                                             n_tty_receive_buf_common()
>                                              down_read(&tty->termios_rwsem);
>                                              __receive_buf()
>                                               copies data into n_tty buffer
>                                              up_read(&tty->termios_rwsem);
>  down_read(&tty->termios_rwsem);
>  copy buffer data to user

Your text got line-wrapped here for this explaination and it doesn't
make much sense :(

Can you resend this?

> This change checks to see if the tty is being hung up before copying
> anything in n_tty_receive_buf_common().  It has to be done after the
> tty->termios_rwsem semaphore is claimed, for reasons that should be
> apparent from the sequence above.

That kind of makes sense, but it's tricky, if you resend with the above
fixed it might be more obvious...

thanks,

greg k-h
