Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7102782C0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 10:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbgIYI2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 04:28:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:40082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727497AbgIYI2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 04:28:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601022503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=euJLBbehiioflObKiAz7T9pxWxEh9LTTpiJibpxwmag=;
        b=WlQFROgd/jSn3njMXDvAyAlVYby/YIYPTN778ZF7ddqI0q6tz/dzhGbOYVH6MgymbNb/RI
        tHup65zOLxBSMO8fpKYgcHoUy/aOjq7ajSKhmC+dTu6dbl99+0mdstIkxNT2D0o8A/irVB
        Fq3ad7FMDuyuYX3fLxswL97VUoG8jZk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 44379B14C;
        Fri, 25 Sep 2020 08:28:23 +0000 (UTC)
Date:   Fri, 25 Sep 2020 10:28:22 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 3/5] printk: use buffer pool for sprint buffers
Message-ID: <20200925082822.GL29288@alley>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
 <20200922153816.5883-4-john.ogness@linutronix.de>
 <20200923151129.GC6442@alley>
 <aef3626f-56a0-9040-fc0e-224ada032d02@prevas.dk>
 <2c95c16b-03e7-eadd-d3af-bedc6b0b471e@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c95c16b-03e7-eadd-d3af-bedc6b0b471e@prevas.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-09-24 14:32:49, Rasmus Villemoes wrote:
> On 24/09/2020 11.54, Rasmus Villemoes wrote:
> > On 23/09/2020 17.11, Petr Mladek wrote:
> >> On Tue 2020-09-22 17:44:14, John Ogness wrote:
> >>> vprintk_store() is using a single static buffer as a temporary
> >>> sprint buffer for the message text. This will not work once
> >>> @logbuf_lock is removed. Replace the single static buffer with a
> >>> pool of buffers.
> >>
> >> The buffer is used because we do not know the length of the
> >> formatted message to reserve the right space in the ring buffer
> >> in advance.
> >>
> >> There was the idea to call vsprintf(NULL, fmt, args) to count
> >> the length in advance.
> > 
> > sprintf is dog slow.

Well, printk() is a slow path. It has never been too optimized for
speed. The main purpose is to report problems and eventually some
interesting information.

Yes, it is used also for debugging. But there is always trace_printk()
that is designed to be fast. I guess that people have to use it
already today when debugging performance crytical code.


> If you do this, perhaps say "we can afford to use
> > 128 bytes of stack" and do vsprintf(stackbuf, 128, fmt, args) to do the
> > counting, and in the vast majority of cases where the text fits we don't
> > need to do vsprintf() again.

It is an interesting idea. I am a bit concerned about the stack usage. It
might limit a possible nesting too much.

> Or, since 128 bytes of stack may be too much, combine the "pre-allocate
> a few buffers" with "but fall back to vsprintf(NULL) if we can't get
> one". That should allow choosing the X in X*1024 smaller than what
> worst-case requires (which will never actually be used, assuming the
> machine is doing something useful rather than just printk'ing all day
> long) and still works even when a tmp buffer can't be obtained.

I would like to keep it simple at the beginning. We could always add
some fancy tricks when it is not good enough.

Best Regards,
Petr
