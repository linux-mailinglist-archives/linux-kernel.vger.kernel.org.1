Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E650278262
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 10:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbgIYIPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 04:15:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:57798 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbgIYIPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 04:15:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601021712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fc8eN87fP8DSToCEtWnmQvSMtw+BUUdgti9YeDiVi0o=;
        b=IRQsSJ1v9wnKImxTH2bbKUGinMva9jN8JTB8F8qXgf/fecRq+xrOVyA6BJw++v1eaVxt/R
        b4BQOz6cArjhUhQgJVPjign/mM9VSFv3aIawwPxqXnR8xnAq+Y9b9tT/EIQul+sF5nGSuA
        VFfL+l7XG/ssA3mtO7OQvzZPtRtkhaU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 138DDADDF;
        Fri, 25 Sep 2020 08:15:12 +0000 (UTC)
Date:   Fri, 25 Sep 2020 10:15:11 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 3/5] printk: use buffer pool for sprint buffers
Message-ID: <20200925081511.GK29288@alley>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
 <20200922153816.5883-4-john.ogness@linutronix.de>
 <20200923151129.GC6442@alley>
 <20200924054058.GE577@jagdpanzerIV.localdomain>
 <20200924084555.GJ6442@alley>
 <20200924085343.GB541@jagdpanzerIV.localdomain>
 <a3a29f06-9ecc-ae21-c0fe-2f86fe31f780@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3a29f06-9ecc-ae21-c0fe-2f86fe31f780@prevas.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-09-24 11:49:06, Rasmus Villemoes wrote:
> On 24/09/2020 10.53, Sergey Senozhatsky wrote:
> > On (20/09/24 10:45), Petr Mladek wrote:
> >> On Thu 2020-09-24 14:40:58, Sergey Senozhatsky wrote:
> >>> On (20/09/23 17:11), Petr Mladek wrote:
> >>>>
> >>>> AFAIK, there is one catch. We need to use va_copy() around
> >>>> the 1st call because va_format can be proceed only once.
> >>>>
> >>>
> >>> Current printk() should be good enough for reporting, say, "Kernel
> >>> stack overflow" errors. Is extra pressure that va_copy() adds something
> >>> that we need to consider?
> >>
> >> The thing is that vsprintf() traverses the arguments using va_arg().
> >> It modifies internal values so that the next va_arg() will read
> >> the next value.
> > 
> > Yes, I understand the purpose of va_copy(). I'm asking if we are
> > always on the safe side doing va_copy for every printk (+ potential
> > recursive va_copy-s).
> 
> va_copy doesn't really add any extra stack use worth talking about. When
> ABI says all arguments are passed on stack, va_list is just a pointer
> into the arguments, and va_copy merely copies that pointer. When some
> arguments are passed in register, the function prologue sets up a
> "register save area" where those registers are stashed, and va_list then
> contains two pointers: one to the reg save area, one to the place in the
> stack where the rest of the arguments are, plus a bit of control
> information on how many of the register arguments have been consumed so
> far (and that control info is the only reason one must "reset" a
> va_list, or rather use a copy that was made before consumption started).
> In either case, an extra va_list doesn't cost more than 24 bytes or so
> of stack - even if printk() was called with 100 arguments, those
> 90-100ish arguments are only stored once on the stack.

Thanks a lot for the detailed information. It is good to know that
va_copy() does not cost that much.

Best Regards,
Petr
