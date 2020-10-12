Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F05E28AEDA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 09:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgJLHOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 03:14:01 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:35292 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgJLHOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 03:14:00 -0400
Received: by mail-ej1-f65.google.com with SMTP id u21so21747441eja.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 00:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mm5wXa3adl71WlW1D8EVvHpFHWmd5P4Egw5mMDQLMMA=;
        b=TvjTmEfYEnfrCYT6ON37cUkb3CvRcgTBHjd9YdEzJT1rABDoCROxhydwg+wlVnj4Er
         YJF4HdEcNUjAHDwlxhzNW+FiVQiBruoUp5eeYTZ2WzQSYsbvTih68z5aO1pzo/GpuqNu
         COXI4PxiWmcVLQ7ZCaTYwRGUXa1ISmGZt9/WYUf5g9FCj7bAsum+8G4BBsj/d4iNpp4h
         nW4HGRQ+00iV9tAOb5K6vzLpNMksMjnKKRW4NdqG2K/ge5JBy3d5BP4K49FPcQEjBqit
         MKNBTjknru6JBhdXCw9s2BK+mcC+NlfD8U7TNq7KN11xsyTEmzAcHqECjzfWaSpo/WBe
         hm2g==
X-Gm-Message-State: AOAM531IHl7FGtMlG4HNnd1xJRO5KgE1GGPfzZDJwaZUSX+0GG/lqK1L
        ojWTCnTSF8I3uc6ajPDGUuA=
X-Google-Smtp-Source: ABdhPJyNIBHsEmQ2mHZhkDmYp5oTkoJffB1jNOlWZpz3doxuZWd44e4ksJo9Vwu44sxNZnMl2G+8ZQ==
X-Received: by 2002:a17:906:3a1a:: with SMTP id z26mr25588257eje.519.1602486837534;
        Mon, 12 Oct 2020 00:13:57 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id c17sm10099221ejb.15.2020.10.12.00.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 00:13:56 -0700 (PDT)
Subject: Re: [PATCH v2] drivers:tty:pty: Fix a race causing data loss on close
To:     minyard@acm.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Corey Minyard <cminyard@mvista.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        brian.bloniarz@gmail.com
References: <20201002130304.16728-1-minyard@acm.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <9983db8d-1e5c-4437-fd15-d54a65eb41b9@kernel.org>
Date:   Mon, 12 Oct 2020 09:13:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201002130304.16728-1-minyard@acm.org>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 10. 20, 15:03, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> If you write to a pty master an immediately close the pty master, the
> receiver might get a chunk of data dropped, but then receive some later
> data.  That's obviously something rather unexpected for a user.  It
> certainly confused my test program.

Hmm, that's another instance of bugs which were fixed in the past. Like:
commit f8747d4a466ab2cafe56112c51b3379f9fdb7a12
Author: Peter Hurley <peter@hurleysoftware.com>
Date:   Fri Sep 27 13:27:05 2013 -0400

     tty: Fix pty master read() after slave closes

and
commit 0f40fbbcc34e093255a2b2d70b6b0fb48c3f39aa
Author: Brian Bloniarz <brian.bloniarz@gmail.com>
Date:   Sun Mar 6 13:16:30 2016 -0800

     Fix OpenSSH pty regression on close


Ccing Peter who is involved in tty buffers a lot and Brian.

> It turns out that tty_vhangup() gets called from pty_close(), and that
> causes the data on the slave side to be flushed, but due to races more
> data can be copied into the slave side's buffer after that.  Consider
> the following sequence:
> 
> thread1          thread2         thread3
> -------          -------         -------
>   |                |-write data into buffer,
>   |                | n_tty buffer is filled
>   |                | along with other buffers
>   |                |-pty_close()
>   |                |--tty_vhangup()

This hangup is on slave, not master. This confused me initially.

>   |                |---tty_ldisc_hangup()
>   |                |----n_tty_flush_buffer()
>   |                |-----reset_buffer_flags()

So this flushes the data (as on the toilette; see below) slave already 
had in its buffer. That's not nice. As I understand it, programs like 
ssh rely on all the data to be delivered, actually.

>   |-n_tty_read()   |
>   |--up_read(&tty->termios_rwsem);
>   |                |------down_read(&tty->termios_rwsem)
>   |                |------clear n_tty buffer contents
>   |                |------up_read(&tty->termios_rwsem)
>   |--tty_buffer_flush_work()       |
>   |--schedules work calling        |
>   |  flush_to_ldisc()              |

"Flush" doesn't mean "flush" as on the toilette. Here, it's "flush" 
meaning actually "push" (that confused you given what I read in the note 
about trying to remove the rwsem lock below). It simply waits for 
flush_to_ldisc to finish the job.

>   |                                |-flush_to_ldisc()
>   |                                |--receive_buf()
>   |                                |---tty_port_default_receive_buf()
>   |                                |----tty_ldisc_receive_buf()
>   |                                |-----n_tty_receive_buf2()
>   |                                |------n_tty_receive_buf_common()
>   |                                |-------down_read(&tty->termios_rwsem)
>   |                                |-------__receive_buf()
>   |                                |-------copies data into n_tty buffer
>   |                                |-------up_read(&tty->termios_rwsem)

Sure, so we reset the head/tail in reset_buffer_flags (the data you 
miss) and queued another chunk of data (the data you get).

I currently don't see how to fix this properly. Any hint appreciated.

>   |--down_read(&tty->termios_rwsem)
>   |--copy buffer data to user
> 
>  From this sequence, you can see that thread2 writes to the buffer then
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
>    http://sourceforge.net/projects/ser2net/files/tmp/testpty.c
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
>   drivers/tty/n_tty.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index 1794d84e7bf6..1c33c26dc229 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -1704,6 +1704,9 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
>   
>   	down_read(&tty->termios_rwsem);
>   
> +	if (test_bit(TTY_HUPPING, &tty->flags))
> +		goto out_upsem;
> +
>   	do {
>   		/*
>   		 * When PARMRK is set, each input char may take up to 3 chars
> @@ -1760,6 +1763,7 @@ n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
>   	} else
>   		n_tty_check_throttle(tty);
>   
> +out_upsem:
>   	up_read(&tty->termios_rwsem);
>   
>   	return rcvd;
> 

thanks,
-- 
js
suse labs
