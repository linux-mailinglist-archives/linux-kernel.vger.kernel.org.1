Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9EB296E3A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 14:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463461AbgJWMLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 08:11:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:48570 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S369866AbgJWMLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 08:11:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603455095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PnUm70V+5EWN9rUJE/JshXA3shOzxaXojS/AI5HvYuU=;
        b=fGHmfrh7RaefzeIoXnsKI090BfDNZzk44DVnLWWzvzAtfIIb357WQ7LUAoQFle0jgFsan4
        fElCkPSwre6Zg0Fs64NFLrU1DHWvoxoIRbUzu/bQtFZuuXxIva/Xauuvix/Jy2yKxHATBJ
        CtpSA5buHeil9AMYN+7DqAXtNekYMvQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7F78B80F;
        Fri, 23 Oct 2020 12:11:35 +0000 (UTC)
Date:   Fri, 23 Oct 2020 14:11:34 +0200
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
Subject: Re: [RFC 1/2] printk: Add kernel parameter: mute_console
Message-ID: <20201023121134.GF32486@alley>
References: <20201022114228.9098-1-pmladek@suse.com>
 <20201022114228.9098-2-pmladek@suse.com>
 <20201023003334.GA588@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023003334.GA588@jagdpanzerIV.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-10-23 09:33:34, Sergey Senozhatsky wrote:
> On (20/10/22 13:42), Petr Mladek wrote:
> > +static bool mute_console;
> > +
> > +static int __init mute_console_setup(char *str)
> > +{
> > +	mute_console = true;
> > +	pr_info("All consoles muted.\n");
> > +
> > +	return 0;
> > +}
> 
> First of all, thanks a lot for picking this up and for the patch set!
> 
> I've several thoughts and comments below.
> 
> >  static bool suppress_message_printing(int level)
> >  {
> > -	return (level >= console_loglevel && !ignore_loglevel);
> > +	if (unlikely(mute_console))
> > +		return true;
> > +
> > +	if (unlikely(ignore_loglevel))
> > +		return false;
> > +
> > +	return (level >= console_loglevel);
> >  }
> 
> This is one way of doing it. Another one is to clear CON_ENABLED bit
> from all consoles (upon registration), one upside of this is that we
> will signal user-space that consoles are disabled/muted (by removing
> the E flag from /proc/consoles).

Hmm, CON_ENABLED is used by suspend/resume code unconditionaly. We
would need another flag to define the state after resume.

Well, it is true that CON_ENABLED has the same effect. Messages are
not printed to the console. So, introducing another variable is
likely overkill.

> Thinking more about it. We are still relying on the fact that there is
> anything registered as console driver, which is not necessarily the case,
> we can have NULL console drivers list. So how about having a dummy struct
> console in printk, with NOP read/write and NOP tty_driver and NOP
> tty_operations. So that when init calls filp_open("/dev/console") and
> we can't give tty anything but NULL, we'd just give tty back the dummy
> NOP device.

Yup, this seems to be the best solution.

Best Regards,
Petr
