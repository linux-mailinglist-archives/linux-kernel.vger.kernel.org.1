Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324BE2D0D60
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgLGJuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:50:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:36182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgLGJut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:50:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607334602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5oB5c9ZsUdrU98e8x3Xd8C+cSkMMOcaStdQxfT8FnL0=;
        b=f/t4KZsgZqgxxnGy6WIxWfe+ftoS+YA/Y6QHcmjaGWFn8FDf7lhXTOxrXNM+EwIM3SbC7o
        rpSQY7W59X1sTv0cRZKNZNyYfUpPXjGPbRpFKTigv6ccamsukt3IySGh1w+QqAfjq91077
        0guvtOTYo3cp9ZAX1yFkqBsRjY/5ib0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C2D93AD7C;
        Mon,  7 Dec 2020 09:50:02 +0000 (UTC)
Date:   Mon, 7 Dec 2020 10:50:02 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: consoles: was: [PATCH next v2 3/3] printk: remove logbuf_lock,
 add syslog_lock
Message-ID: <X836yrIxyIp5y+Qq@alley>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-4-john.ogness@linutronix.de>
 <X8phf/jITFd7nV38@alley>
 <X8sPGfe2kWkAqsl1@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8sPGfe2kWkAqsl1@jagdpanzerIV.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2020-12-05 13:39:53, Sergey Senozhatsky wrote:
> On (20/12/04 17:19), Petr Mladek wrote:
> [..]
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -2432,7 +2490,6 @@ void console_unlock(void)
> > >  		size_t len;
> > >  
> > >  		printk_safe_enter_irqsave(flags);
> > 
> > Why do we actually need to use the printk_safe context here?
> > There is not longer a risk of deadlock caused by logbuf_lock.
> > All other recursions should be prevented by console_trylock()
> > in printk().
> 
> All semaphore functions, including down_trylock(), acquire
> semaphore spin_lock;

This has a very easy solution. The patch adds a code that counts
recursion level. We just must not call console_trylock() when
being inside a recursive printk.

printk_safe() has two functions:

  1. It allows to store messages a lockless way. This is obsoleted
     by the lockless ringbuffer.

  2. It prevents calling consoles. We could move this check
     into vprintk_store(). We already have there similar check
     for printk_deferred().


> and then some call into the scheduler
> (or other kernel core functions) under semaphore's spin_lock.
> For instance
> 
> 	up()
> 	 raw_spin_lock_irqsave(&sem->lock)
> 	   __up()
> 	     wake_up_process()
> 	       try_to_wake_up()

This problem is partly solved by printk_deferred(). In each
case, printk_safe() does not help here.

I still do _not_ see a reason to keep printk_safe()!

Best Regards,
Petr
