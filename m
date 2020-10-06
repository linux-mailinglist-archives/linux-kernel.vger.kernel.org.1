Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F50F284CA4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 15:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgJFNnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 09:43:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:42088 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgJFNnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 09:43:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601991809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KP8O4xZdv3wbMSFd4+l8TuNNeWoTpWM0nMozZEDZPHI=;
        b=MJQ27gOWUEag5azqL4C9xoGK0oDAUUbTZMFc4uQK3+gcBcas6ik7Ud49pvSMocq7r6PfRt
        vvMgwhXUraimFN63/GSqytqICRqXcd5a6vrGqdfR0FqA7dktUVY+oLUmNv9EKzeZ6D00Vh
        KlUhYRL+UTKujNsJp8fDVKYr4Wdqwjo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 05B9DAD2E;
        Tue,  6 Oct 2020 13:43:29 +0000 (UTC)
Date:   Tue, 6 Oct 2020 15:43:28 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Shreyas Joshi <shreyas.joshi@biamp.com>, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20201006134328.GD32369@alley>
References: <MN2PR17MB31979437E605257461AC003DFCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
 <20200522065306.83-1-shreyas.joshi@biamp.com>
 <20200522100046.GH3464@linux-b0ei>
 <20201006025935.GA597@jagdpanzerIV.localdomain>
 <f19c18fd-20b3-b694-5448-7d899966a868@roeck-us.net>
 <20201006095226.GB32369@alley>
 <24f7a6bc-c917-2bb7-0e86-9d729c18e812@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24f7a6bc-c917-2bb7-0e86-9d729c18e812@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-10-06 03:45:00, Guenter Roeck wrote:
> On 10/6/20 2:52 AM, Petr Mladek wrote:
> > And it makes perfect sense to disable all consoles or drop all defined
> > by dts. But I would prefer to make it more obvious way, for
> > example by parameters like:
> > 
> >    + console=none
> >    + no-console
> >    + no-dtd-console
> >    + no-default-console
> > 
> Again, the problem isn't limited to dts provided consoles, or at least
> that was my understanding. I am still trying to understand how default
> consoles are defined, so I may get something wrong. Anyway, personally I
> liked "console=", but that is just me. Anything else should work for us
> as long as it is backward compatible (which excludes the no-xxx options).

Here is my understanding:

The consoles can be defined by scpr, dts, and on the command line. It
is anyone calling add_preferred_console().

Then the various devices call register_console(). They are registered
only when they match any console in console_cmdline[] array, see
try_enable_new_console().

The only exception is when the array is empty (or only braile console
was added). Then the first console with tty binding is registered.
This special case is done by the following code in register_console():

	/*
	 *	See if we want to use this console driver. If we
	 *	didn't select a console we take the first one
	 *	that registers here.
	 */
	if (!has_preferred_console) {
		if (newcon->index < 0)
			newcon->index = 0;
		if (newcon->setup == NULL ||
		    newcon->setup(newcon, NULL) == 0) {
			newcon->flags |= CON_ENABLED;
			if (newcon->device) {
				newcon->flags |= CON_CONSDEV;
				has_preferred_console = true;
			}
		}
	}

> Whatever is decided, I'd like to have it made official and documented to
> avoid a similar problem in the future.

Sure. I am going to play with the code. I would prefer to avoid
introducing back the crash that was solved by the patch.
If the change is simple, we could use it. If not, we should just
revert the problematic patch and come up with something better
for-5.10
or later.

We need to be careful because the behavior is not defined. It seems
that many people actually use also console=null for this purpose, see
https://www.programmersought.com/article/19374022450/
https://developer.toradex.com/knowledge-base/how-to-disable-enable-debug-messages-in-linux
https://unix.stackexchange.com/questions/117926/try-to-disable-console-output-console-null-doesnt-work

Best Regards,
Petr
