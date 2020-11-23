Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA9F2C0295
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 10:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgKWJx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 04:53:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:39848 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgKWJx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 04:53:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606125205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CWE9aaL7FjNx6siMu72tnDhc+74qhGXlXrHv8loEhJ4=;
        b=CVCNLFZ6aKFK5I6KC9QU4Me1iCyHVXhYXQWzq8xKVvC5EHQwiZLTnDQZ9JH8k+Kh0JRIwR
        mLW9RyomXe4ZzQ12LNHmEshYiXQiP0ssnLzl3wrA63p9PHeRVwaru2K5DPhy73fikSAH0y
        0/UEfsLuw3qcjfh5fRnDrBhDDLqHNbk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 97614AC24;
        Mon, 23 Nov 2020 09:53:25 +0000 (UTC)
Date:   Mon, 23 Nov 2020 10:53:24 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Printk specifiers for __user pointers
Message-ID: <X7uGlDg88bI6zebS@alley>
References: <20201120164412.GD619708@rowland.harvard.edu>
 <20201120134242.6cae9e72@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120134242.6cae9e72@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-11-20 13:42:42, Steven Rostedt wrote:
> On Fri, 20 Nov 2020 11:44:12 -0500
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > To the VSPRINTF maintainers:
> > 
> > Documentation/core-api/printk-formats.rst lists a large number of format 
> > specifiers for pointers of various sorts.  Yet as far as I can see, 
> > there is no specifier meant for use with __user pointers.
> > 
> > The security implications of printing the true, unmangled value of a 
> > __user pointer are minimal, since doing so does not leak any kernel 
> > information.  So %px would work, but tools like checkpatch.pl don't like 
> > it.

Just to be sure as I am not a security expert. Is there really that
big difference in the risk? The following scenarios come to my mind:

1. The address would show a well defined location in the userspace
   application? Could it be used to attack the application?

2. The address shows a location that is being accessed by kernel.
   Could not it be used to pass a value that might be used to attack
   kernel?


> > Should a new specifier be added?  If not, should we simply use %px?
> 
> There's currently no user of '%pu' (although there is a '%pus'. Perhaps we
> should have a '%pux'?
> 
> I would even state that if it is used, that if makes sure that the value is
> indeed a user space pointer (goes through the same checks as accessing user
> space), before its printed, otherwise it shows "(fault)" or something.

I have mixed feelings about this.

One one hand, it might make sense to mark locations where userspace
address is printed. We could easily decide how to print them (hash or
value) and we could check that it is really from a userspace one.

But I have few concerns:

1. The existing "%pus" has a kind of opposite meaning. It says what
   address space should be used when the kernel and userspace address
   space is overlapping.

2. There is the history with "%pk". It did not work because people did
   not use it.

3. I am not sure about the output when the address is not from
   userspace. Printing ("fault") is not much helpful. Printing
   hashed value might be confusing. Well, I am still not sure
   that it is really safe to print real userspace addresses
   by default.

Best Regards,
Petr
