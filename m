Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D6F27E42A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 10:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgI3Ive (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 04:51:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:52384 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgI3Ive (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 04:51:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601455892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4okL5nlwl2P2e7PNqlzA8NhEnXvJgDq23Zf2CdgTcGs=;
        b=ufphnqAeN3wjMojrEk8qDC+WCor9lcbP6zCWGm2xHVKPNVqOGHroGs3I9zYSPpSj5f+wvN
        wWaUhVowq5JmxD6jOsAqrUthWCS7dAMe1Urk2ujA4mx1DUymGP0RS1fnTLdrLH8tB+4ZUn
        9NjcN2I7WJDKfqQT3fYtmmhWh487ah8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7981BB22A;
        Wed, 30 Sep 2020 08:51:32 +0000 (UTC)
Date:   Wed, 30 Sep 2020 10:51:32 +0200
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
Message-ID: <20200930085131.GY29288@alley>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
 <20200922153816.5883-4-john.ogness@linutronix.de>
 <20200923151129.GC6442@alley>
 <aef3626f-56a0-9040-fc0e-224ada032d02@prevas.dk>
 <2c95c16b-03e7-eadd-d3af-bedc6b0b471e@prevas.dk>
 <20200925082822.GL29288@alley>
 <4e36f308-a435-f9c1-2d4f-362e797c764e@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e36f308-a435-f9c1-2d4f-362e797c764e@prevas.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-09-30 10:06:24, Rasmus Villemoes wrote:
> On 25/09/2020 10.28, Petr Mladek wrote:
> > On Thu 2020-09-24 14:32:49, Rasmus Villemoes wrote:
> >> On 24/09/2020 11.54, Rasmus Villemoes wrote:
> >>> On 23/09/2020 17.11, Petr Mladek wrote:
> >>>> On Tue 2020-09-22 17:44:14, John Ogness wrote:
> >>>>> vprintk_store() is using a single static buffer as a temporary
> >>>>> sprint buffer for the message text. This will not work once
> >>>>> @logbuf_lock is removed. Replace the single static buffer with a
> >>>>> pool of buffers.
> >>>>
> >>>> The buffer is used because we do not know the length of the
> >>>> formatted message to reserve the right space in the ring buffer
> >>>> in advance.
> >>>>
> >>>> There was the idea to call vsprintf(NULL, fmt, args) to count
> >>>> the length in advance.
> >>>
> >>> sprintf is dog slow.
> > 
> > Well, printk() is a slow path. It has never been too optimized for
> > speed. The main purpose is to report problems and eventually some
> > interesting information.
> 
> True. But remember that printk is called from _everywhere_, with all
> sorts of locks held and/or preemption disabled or whatnot, and every
> cycle spent in printk makes those windows wider. Doubling the cost of
> every single printk by unconditionally doing vsnprintf() twice is a bad
> idea.

I would prefer to solve this when there are real life problems.
printk() should not get called in performance sensitive paths in
the first place.

We could always make the code more complicated when it can be
justified. Extra buffers is yet another layer (code and memory)
in the processing. And the current arguments sounds theoretical.

Anyway, the performance is not that obvious. The 1st run should
be faster because the result will not be stored. 2nd run should
be faster because the input values will likely by cached. Using
temporary buffers would require extra copying.

Best Regards,
Petr
