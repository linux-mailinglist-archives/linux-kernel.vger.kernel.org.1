Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BF928712A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 11:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgJHJB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 05:01:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:33286 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgJHJB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:01:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602147715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AzJEdvC+G7NnMzyULtk00YOH5Sxb+JafFdEJYX2lY7Y=;
        b=kOkwM9wA1Bsn8lGGr7eqceZu2K9P0znL4DhCXJ4k5Wxy5ff+HKIAc3zjQWFCpeXTh4TG4h
        qVRVDig54AxLJbFjSorbxWUo+YEmOEKAQ2Vcmutjo+JhI9I/Hv57U2sa9ysvoW0wSlPS8l
        I7iSrZbIswmBwteHdX9kOm6mqSQ1DQ8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AAF32AF4E;
        Thu,  8 Oct 2020 09:01:55 +0000 (UTC)
Date:   Thu, 8 Oct 2020 11:01:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20201008090155.GB16837@alley>
References: <20201006095226.GB32369@alley>
 <24f7a6bc-c917-2bb7-0e86-9d729c18e812@roeck-us.net>
 <20201006134328.GD32369@alley>
 <20201006163514.GE32369@alley>
 <20201006171504.GA64770@jagdpanzerIV.localdomain>
 <20201007072853.GF32369@alley>
 <20201007123044.GA509@jagdpanzerIV.localdomain>
 <be66237b-e7b2-0321-c00c-cd6fba6e3b58@roeck-us.net>
 <20201007162942.GA440@jagdpanzerIV.localdomain>
 <20201008055238.GA554@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008055238.GA554@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-10-08 14:52:38, Sergey Senozhatsky wrote:
> On (20/10/08 01:29), Sergey Senozhatsky wrote:
> > On (20/10/07 08:57), Guenter Roeck wrote:
> > > On 10/7/20 5:30 AM, Sergey Senozhatsky wrote:
> > 
> > [..]
> > 
> > > I can see to options: Link /dev/console to /dev/null if there is no console,
> > > or do something like
> > > 
> > > 	if (IS_ERR(file)) {
> > >                 pr_warn("Warning: unable to open an initial console.\n");
> > >                 file = filp_open("/dev/null", O_RDWR, 0);
> > > 		if (IS_ERR(file))
> > >                 	return;
> > >         }
> > 
> > As far as I can tell, /dev/null does not exist yet on this stage
> > (at least not in my system). But generally the idea looks interesting.
> 
> Hmm. How about this. console= is undocumented and unspecified - it
> may work sometimes or it may kill the system (and theoretically even
> corrupt some files, depending on what fd 1 and fd 2 point to). So
> maybe we can document console= and handle it in printk, rather than
> somewhere deep in init/main.c
> 
> IOW add one more flag (yeah, I know) and set it when console_setup()
> sees console= boot param. The idea is allow console registration,
> but all consoles should be disabled (cleared CON_ENABLED bit). This
> would be easier to document, at least.
> 
> Schematically:
> 
> ---
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 929e86a01148..b71ff9d87693 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -281,6 +281,7 @@ static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
>  
>  static int preferred_console = -1;
>  static bool has_preferred_console;
> +static bool mute_consoles = false;
>  int console_set_on_cmdline;
>  EXPORT_SYMBOL(console_set_on_cmdline);
>  
> @@ -2141,6 +2142,9 @@ static int __add_preferred_console(char *name, int idx, char *options,
>  	struct console_cmdline *c;
>  	int i;
>  
> +	if (mute_consoles)
> +		return;
> +
>  	/*
>  	 *	See if this tty is not yet registered, and
>  	 *	if we have a slot free.

Interesting idea. Well, it looks like yet another mess:

  + it would show the consoles in /proc/consoles
    even thought they will be basically unusable

  + it is yet another way to affect the amount of messages
    on console. We already have console_loglevel, ignore_loglevel.

  + this effect is far from obvious when using console=""


IMHO, we should try to understand why it actually crashes first.
It might help to solve the problem some cleaner way.

Thanks a lot for digging into it.

Best Regards,
Petr
