Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA42284FF4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 18:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgJFQfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 12:35:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:46622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgJFQfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 12:35:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602002115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=otPJ9dbCjuwwNchIDB5rytsiy123wjN6QIlkbo3Pfqw=;
        b=Pe6WPbvO8ij8x+wxHXCsvtjCuCFVuYPU0KjCN8QudcYOpQBTUShifOyAggE5NeuaSib4MH
        iWoPUM/XagOmqR5GYnPt3Y4umhS3QH2ZIIXDcyyZfRrt0/av7pjhdXI71QqizFUP31/3rc
        fb8elwSiCvp4mbCrkXtlVdwM6XE3Gyo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 410E7AE79;
        Tue,  6 Oct 2020 16:35:15 +0000 (UTC)
Date:   Tue, 6 Oct 2020 18:35:14 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Shreyas Joshi <shreyas.joshi@biamp.com>, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20201006163514.GE32369@alley>
References: <MN2PR17MB31979437E605257461AC003DFCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
 <20200522065306.83-1-shreyas.joshi@biamp.com>
 <20200522100046.GH3464@linux-b0ei>
 <20201006025935.GA597@jagdpanzerIV.localdomain>
 <f19c18fd-20b3-b694-5448-7d899966a868@roeck-us.net>
 <20201006095226.GB32369@alley>
 <24f7a6bc-c917-2bb7-0e86-9d729c18e812@roeck-us.net>
 <20201006134328.GD32369@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006134328.GD32369@alley>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-10-06 15:43:28, Petr Mladek wrote:
> On Tue 2020-10-06 03:45:00, Guenter Roeck wrote:
> > On 10/6/20 2:52 AM, Petr Mladek wrote:
> > > And it makes perfect sense to disable all consoles or drop all defined
> > > by dts. But I would prefer to make it more obvious way, for
> > > example by parameters like:
> > > 
> > >    + console=none
> > >    + no-console
> > >    + no-dtd-console
> > >    + no-default-console
> > > 
> > Again, the problem isn't limited to dts provided consoles, or at least
> > that was my understanding. I am still trying to understand how default
> > consoles are defined, so I may get something wrong. Anyway, personally I
> > liked "console=", but that is just me. Anything else should work for us
> > as long as it is backward compatible (which excludes the no-xxx options).
> 
> Here is my understanding:
> 
> The consoles can be defined by scpr, dts, and on the command line. It
> is anyone calling add_preferred_console().
> 
> Then the various devices call register_console(). They are registered
> only when they match any console in console_cmdline[] array, see
> try_enable_new_console().
> 
> > Whatever is decided, I'd like to have it made official and documented to
> > avoid a similar problem in the future.

Sigh, it is even bigger mess than I expected. There is a magic
variable "console_set_on_cmdline". It used, for example, in
of_console_check() to prevent using the default console from dts.

It is used on few more locations to prevent the default console.
But there are other locations when add_preferred_console() is
called without checking this variable.

As a result, "console=" has different effect on different systems.

I tend to revert the problematic patch now.

And I would try to clean up this mess for-5.11. There is a big chance
that people used the empty console= only on systems where it disabled
all default consoles. I would try to make it the official global
behavior. But this would need some longer testing in linux-next, ...

Best Regards,
Petr
