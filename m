Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88A52870F6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 10:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgJHIuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 04:50:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:53436 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728930AbgJHIuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 04:50:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602147009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hgIWe/sB7dxwLIfkrwYpnqUN+ttnxhG6egD7osPFZCM=;
        b=SxARGWI/7NEbHbX/FAOoErzB5KYcsSVZkrd0QJCDrkjQFXEPGXHcaiC5y0Pny2TmkdIvJb
        DSXkfTlBPRMCrqdX6vwOhF4dMFfn7M7nWlUQk11I/oB/UHN1/0L4pHTcRxusYyuyfQDgyr
        r6qRoC3cdEcFQpDDChZ793j+lbYguSQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6C29CAF31;
        Thu,  8 Oct 2020 08:50:09 +0000 (UTC)
Date:   Thu, 8 Oct 2020 10:50:08 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Shreyas Joshi <shreyas.joshi@biamp.com>, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20201008085008.GA16837@alley>
References: <20200522100046.GH3464@linux-b0ei>
 <20201006025935.GA597@jagdpanzerIV.localdomain>
 <f19c18fd-20b3-b694-5448-7d899966a868@roeck-us.net>
 <20201006095226.GB32369@alley>
 <24f7a6bc-c917-2bb7-0e86-9d729c18e812@roeck-us.net>
 <20201006134328.GD32369@alley>
 <20201006163514.GE32369@alley>
 <20201006171504.GA64770@jagdpanzerIV.localdomain>
 <20201007072853.GF32369@alley>
 <20201007123044.GA509@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007123044.GA509@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-10-07 21:30:44, Sergey Senozhatsky wrote:
> On (20/10/07 09:28), Petr Mladek wrote:
> > 
> > 		/*
> > 		 * Dirty hack to prevent using any console with tty
> > 		 * binding as a fallback and adding the empty
> > 		 * name into console_cmdline array.
> > 		 */
> > 		preferred_console = MAX_CMDLINECONSOLES;
> 
> Let me dump my findings so far. I still don't understand what exactly
> crashes the laptop (blank screen is not very helpful).
> 
> So, things start with the "preferred_console = -1". In console_setup()
> we call __add_preferred_console(). Since we have no consoles, the
> name matching loop is not executed, and console selection counter remains
> at 0. After the loop, despite the fact that we don't have the console
> (`name' is empty), we still set `preferred_console', to 0.

Heh, we actually add the console. But it is ignored in all the later
cycles because the name is "". All the cycles takes this as
the end of the cycle.

> This affects
> register_console(). Since we have `preferred_console >= 0' we don't
> execute the newcon->setup(), but, more importantly, we don't set the
> newcon->flags |= CON_ENABLED. Now, we call try_enable_new_console():
> since there are no consoles, the ->match() loop is not executed.
> newcone does not have CON_ENABLED set, so try_enable_new_console()
> returns -ENOENT. Both for user_specified=true and for fallback
> user_specified=false cases. At this point we hit error-return path
> from register_console() - we don't add newcon to the list of console
> drivers. The console drivers list, thus, remains empty. So far so good.
> 
> Now. Things get strange in init/main.c
> 
> We have that kernel_init_freeable()->console_on_rootfs() control path.
> 
> console_on_rootfs() attempts to filp_open()->tty_open() /dev/console.
> This ends up in printk's console_device(), which iterates the list of
> console drivers and returns associated console->device back to tty. The
> problem is that console drivers list is empty, so the function returns
> NULL, and filp_open("/dev/console") fails. But the console_on_rootfs()
> comment says that this function should never fail (!). This sort of
> makes me wonder if "console=" is actually legal.
> 
> What this filp_open() failure means in particular, is that we never
> create stdin/out/err fds, because we error-out and don't invoke
> init_dup(file).
> 
> Things look different in older kernels. For instance, even in 5.4
> the corresponding code looks as follows:
> 
> 	/* Open the /dev/console on the rootfs, this should never fail */
> 	if (ksys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
> 		pr_err("Warning: unable to open an initial console.\n");
> 
> 	(void) ksys_dup(0);
> 	(void) ksys_dup(0);
> 
> Somehow, the fact that we don't init_dup(file) causes problems on my
> laptop, but, at the moment, I can't tell exactly where. Perhaps more
> experienced people will be like "darn, this is trivial, the problem is
> here, here and there".
> 
> Hint: I can crash my laptop when I remove the "console=" boot param and
> comment out init_dup(file) calls in console_on_rootfs().
> 
> I guess the problem is somewhat related to missing stdin/out/err fds.

I wonder if you see the problem solved by the commit 2d3145f8d2809592ef8
("early init: fix error handling when opening /dev/console").

I am also curious about the commit 74f1a299107b9e1a56 "Revert "fs:
remove ksys_dup()"". I wonder why it was safe to call ksys_dup(0);
even though the previous ksys_open() failed.

Best Regards,
Petr

PS: I am quite busy with something else this week. I wish, had more
time to dig into it. It should be better the following week.
Anyway, you seem to be on the right way. And we really should
understand the need of stdout and stderr before allowing
to disable all consoles.
