Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3009D2CF1C3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgLDQT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:19:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:40604 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgLDQT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:19:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607098752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pvBA2QTEG8+DUV0iSoBYtADWus09fWKoB/UzFWsmqN8=;
        b=pP1NiLhoYJieaoHPa0IAePw45pEfzZ+93mPAex6q3D0lLMeMjuQzPNJDODYXzl+bQ3Kk7C
        iW9ESl0DUBthsOGRHwtGEAfsvar+vELiZUl8mIrcyhoMUve0ym/LBvpOYvHSJopeUKVaeR
        4lzO7nCNKm1k4NsGmLuKy63keTpjVRw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0C0DBAC9A;
        Fri,  4 Dec 2020 16:19:12 +0000 (UTC)
Date:   Fri, 4 Dec 2020 17:19:11 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: consoles: was: [PATCH next v2 3/3] printk: remove logbuf_lock, add
 syslog_lock
Message-ID: <X8phf/jITFd7nV38@alley>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201205341.3871-4-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-12-01 21:59:41, John Ogness wrote:
> Since the ringbuffer is lockless, there is no need for it to be
> protected by @logbuf_lock. Remove @logbuf_lock.
> 
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -59,7 +57,7 @@ void defer_console_output(void);
>  __printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
>  
>  /*
> - * In !PRINTK builds we still export logbuf_lock spin_lock, console_sem
> + * In !PRINTK builds we still export console_sem
>   * semaphore and some of console functions (console_unlock()/etc.), so
>   * printk-safe must preserve the existing local IRQ guarantees.

We should revisit whether it is still needed just for console_sem.
Well, I wonder why we need printk_safe at all.


> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2432,7 +2490,6 @@ void console_unlock(void)
>  		size_t len;
>  
>  		printk_safe_enter_irqsave(flags);

Why do we actually need to use the printk_safe context here?
There is not longer a risk of deadlock caused by logbuf_lock.
All other recursions should be prevented by console_trylock()
in printk(). Do I miss anything?

Note that we still need to disable interrupts around

     console_lock_spinning_enable();
     console_lock_spinning_disable_and_check();

to make sure that printk() could busy wait for passing
the console lock.


> -		raw_spin_lock(&logbuf_lock);
>  skip:
>  		if (!prb_read_valid(prb, console_seq, &r))
>  			break;

Best Regards,
Petr
