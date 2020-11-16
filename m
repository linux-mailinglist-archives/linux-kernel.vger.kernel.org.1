Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F7A2B4ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbgKPQUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:20:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:37536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728072AbgKPQUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:20:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605543605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=40yfWRXLa2zy92JsDyv1W7tlg+pQ9YiYvZ8oyXD5WJQ=;
        b=IF8aUeqzC/spfwShNBfSbgfpA2ME9vUYagO4xCADHc6oyRnCEqlI//sueZTTJLEbIDXICs
        jPXN+iWoyYElVKjRoLRT1VW27AT9/NaoHZeAHbYug8/ybYkHLzioMzW3BJGgzxaq+qFuxr
        xI+zHtWn6jZ4AygO3Uh/ElbboM54wxw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7C244ABD6;
        Mon, 16 Nov 2020 16:20:05 +0000 (UTC)
Date:   Mon, 16 Nov 2020 17:20:04 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] init/console: Use ttynull as a fallback when there
 is no console
Message-ID: <20201116162004.GP1602@alley>
References: <20201111135450.11214-1-pmladek@suse.com>
 <20201111135450.11214-2-pmladek@suse.com>
 <X6x/AxD1qanC6evJ@jagdpanzerIV.localdomain>
 <X6yTyvIfRUH7TOOx@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X6yTyvIfRUH7TOOx@jagdpanzerIV.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-11-12 10:45:46, Sergey Senozhatsky wrote:
> On (20/11/12 09:17), Sergey Senozhatsky wrote:
> > On (20/11/11 14:54), Petr Mladek wrote:
> > [..]
> > > diff --git a/init/main.c b/init/main.c
> > > index 130376ec10ba..24413c055a85 100644
> > > --- a/init/main.c
> > > +++ b/init/main.c
> > > @@ -1470,8 +1470,14 @@ void __init console_on_rootfs(void)
> > >  	struct file *file = filp_open("/dev/console", O_RDWR, 0);
> > >  
> > >  	if (IS_ERR(file)) {
> > > -		pr_err("Warning: unable to open an initial console.\n");
> > > -		return;
> > > +		pr_err("Warning: unable to open an initial console. Fallback to ttynull.\n");
> > > +		register_ttynull_console();
> > > +
> > 
> > A nit, this probably can be done in console_device() function.
> > 
> > For several reasons:
> > 
> > - we will get covered all the future cases when something other than
> >   console_on_rootfs() will filp_open("/dev/console")

Good point!

My concern is that console_device might be called in "unclear"
context. For example, it is called under tty_mutex in:

	+ tty_open_by_driver()
	  + tty_lookup_driver()
	    + console_device()

Also console_on_rootf() is likely the first code that would actually
use the device.

Well, there is spk_ttyio_initialise_ldisc() that calls tty_kopen().
I am a bit lazy to investigate whether it is called sooner or later.
Anyway, it is accessibility code, so that there should be configured
an accessibility console anyway.

> And the existing ones (including user-space). For instance,
> kernel/bpf/preload/iterators/iterators.c probably fails (?)
> on systems with console=
> 
> 	debug_fd = open("/dev/console", O_WRONLY | O_NOCTTY | O_CLOEXEC);
> 	if (debug_fd < 0)
> 		return 1;
> 
> 	-ss

This looks like an userspace tool, so it should get called after
console_on_rootfs().

It might be my laziness. But I would prefer to go with this patchset.
We could always improve it when anyone meet the problem.

Best Regards,
Petr
