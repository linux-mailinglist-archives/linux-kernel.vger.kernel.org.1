Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358322C0CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbgKWOLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:11:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:42734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729794AbgKWOLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:11:30 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7378F20732;
        Mon, 23 Nov 2020 14:11:28 +0000 (UTC)
Date:   Mon, 23 Nov 2020 09:11:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Printk specifiers for __user pointers
Message-ID: <20201123091126.5d6313d2@gandalf.local.home>
In-Reply-To: <X7uGlDg88bI6zebS@alley>
References: <20201120164412.GD619708@rowland.harvard.edu>
        <20201120134242.6cae9e72@gandalf.local.home>
        <X7uGlDg88bI6zebS@alley>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Nov 2020 10:53:24 +0100
Petr Mladek <pmladek@suse.com> wrote:

> On Fri 2020-11-20 13:42:42, Steven Rostedt wrote:
> > On Fri, 20 Nov 2020 11:44:12 -0500
> > Alan Stern <stern@rowland.harvard.edu> wrote:
> >   
> > > To the VSPRINTF maintainers:
> > > 
> > > Documentation/core-api/printk-formats.rst lists a large number of format 
> > > specifiers for pointers of various sorts.  Yet as far as I can see, 
> > > there is no specifier meant for use with __user pointers.
> > > 
> > > The security implications of printing the true, unmangled value of a 
> > > __user pointer are minimal, since doing so does not leak any kernel 
> > > information.  So %px would work, but tools like checkpatch.pl don't like 
> > > it.  
> 
> Just to be sure as I am not a security expert. Is there really that
> big difference in the risk? The following scenarios come to my mind:

One of the biggest differences, is that with exposing the kernel, every
process has the same kernel address space. By leaking memory addresses of
the kernel, and knowing of some overflow bug in a system call, you can
exploit it right away.

Also, a user space application could trigger some kind of print to show
that kernel address space.

With having the kernel show the address space of another process, it is not
as easy to exploit. You would need to make that other process do something
to have the kernel show its address space.

> 
> 1. The address would show a well defined location in the userspace
>    application? Could it be used to attack the application?

It's possible, but the ramifications usually wont be as bad as the kernel.
Unless of course you do it for systemd or some other daemon. But then
again, you still need to have that application cause the print, as any
user space address being printed from the kernel would need to be caused by
that application.

> 
> 2. The address shows a location that is being accessed by kernel.
>    Could not it be used to pass a value that might be used to attack
>    kernel?

I don't know what you mean here.

> 
> 
> > > Should a new specifier be added?  If not, should we simply use %px?  
> > 
> > There's currently no user of '%pu' (although there is a '%pus'. Perhaps we
> > should have a '%pux'?
> > 
> > I would even state that if it is used, that if makes sure that the value is
> > indeed a user space pointer (goes through the same checks as accessing user
> > space), before its printed, otherwise it shows "(fault)" or something.  
> 
> I have mixed feelings about this.
> 
> One one hand, it might make sense to mark locations where userspace
> address is printed. We could easily decide how to print them (hash or
> value) and we could check that it is really from a userspace one.

It would definitely need to be checked that it is from user space.


> 
> But I have few concerns:
> 
> 1. The existing "%pus" has a kind of opposite meaning. It says what
>    address space should be used when the kernel and userspace address
>    space is overlapping.
> 
> 2. There is the history with "%pk". It did not work because people did
>    not use it.
> 
> 3. I am not sure about the output when the address is not from
>    userspace. Printing ("fault") is not much helpful. Printing
>    hashed value might be confusing. Well, I am still not sure
>    that it is really safe to print real userspace addresses
>    by default.

We could have it print: "(kernel:<hash>)" if it is a kernel address space,
and the hash value wont be as confusing if it states "kernel", and by
showing the hash value, it may be possible to know what was printed there
instead (by possibly seeing another hash with the same value).

-- Steve
