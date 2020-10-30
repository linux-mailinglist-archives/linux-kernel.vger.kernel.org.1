Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126F82A09D9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgJ3P2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:28:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:45166 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgJ3P2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:28:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604071690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zjFVfadmbfOYJYU6bWK4dj3vP5s6atsYIfJPOXVexSk=;
        b=VNCF2HlnvxvXu6YGxVKdLYaiCA9EP8/jC5gY2SphIZJDNpfuexlyTlU6SVkeZ2MZZ3ke/J
        3fVOhAdnOfAXFvSbCgKKlKZshsokCu6POHF2Bg2eVXgP7E7H/Wk5T/nE3hMWWRcacfL84L
        WT3zXOgohdssKttb1tnz9rFwJfpklQI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B6FF3AE2C;
        Fri, 30 Oct 2020 15:28:10 +0000 (UTC)
Date:   Fri, 30 Oct 2020 16:28:10 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-embedded@vger.kernel.org
Subject: Re: [PATCH v2 2/2] init/Kconfig: Increase default log buffer size
 from 128 KB to 512 KB
Message-ID: <20201030152810.GA20201@alley>
References: <20200811092924.6256-1-pmenzel@molgen.mpg.de>
 <20200811092924.6256-2-pmenzel@molgen.mpg.de>
 <20200811105352.GG6215@alley>
 <92a13465-d133-0b39-f64b-7074dbbb3fcc@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92a13465-d133-0b39-f64b-7074dbbb3fcc@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-10-29 23:16:01, Paul Menzel wrote:
> Dear Petr,
> 
> 
> Am 11.08.20 um 12:53 schrieb Petr Mladek:
> > On Tue 2020-08-11 11:29:24, Paul Menzel wrote:
> > > Commit f17a32e97e (let LOG_BUF_SHIFT default to 17) from 2008 was the
> > > last time, the the default log buffer size bump was increased.
> > > 
> > > Machines have evolved, and on current hardware, enough memory is
> > > present, and some devices have over 200 PCI devices, like a two socket
> > > Skylake-E server, resulting a lot of lines.
> > > 
> > > Therefore, increase the default from 128 KB to 512 KB. Anyone, with
> > > limited memory, can still lower it.
> > > 
> > > --- a/init/Kconfig
> > > +++ b/init/Kconfig
> > > @@ -681,9 +681,9 @@ config IKHEADERS
> > >   	  kheaders.ko is built which can be loaded on-demand to get access to headers.
> > >   config LOG_BUF_SHIFT
> > > -	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)"
> > > +	int "Kernel log buffer size (17 => 128KB, 19 => 512KB)"
> > >   	range 12 25
> > > -	default 17
> > > +	default 19
> > >   	depends on PRINTK
> > >   	help
> > >   	  Select the minimal kernel log buffer size as a power of 2.
> > 
> > Honestly, I do not have experience with changing the defaults. People
> > hacking small devices might complain. Well, this can be solved
> > by increasing the default only when BASE_FULL is set.
> > 
> > I am personally fine with increasing the default when BASE_FULL
> > is set. The amount of messages is growing over time because of
> > increasing complexity of both the hardware and software.
> > Fortunately also the amount of available memory is growing.
> > 
> > Well, this should get discussed in wider audience. Adding some
> > people into CC.
> > 
> > JFYI, it started with report of lost messages, see
> > https://lore.kernel.org/lkml/264bfbae-122d-9c41-59ea-6413f91bd866@molgen.mpg.de/
> 
> As there was no objection, is it possible to apply the two patches, and
> maybe even get them into Linux 5.10?

Thanks for reminding me. I am sorry but it is too late for
5.10. Such a change should be added during the merge window.

Well, the size of the ring buffer has effectively increased in 5.10.
The lockless implementation stores strings and metadata separately.
It basically doubled the memory needs and people around embedded
devices were not happy, see
https://lore.kernel.org/r/CAMuHMdXHFFUrjRMEHnXXU8QQkgD9x_S6R3N0Q7Q4H2RSfy2GGw@mail.gmail.com

Please update the patch so that the default stays the same for
BASE_SMALL. Please, add Rasmus Villemoes
<linux@rasmusvillemoes.dk> and Geert Uytterhoeven
<geert@linux-m68k.org> into CC when you send it.

Best Regards,
Petr
