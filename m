Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E48D27825A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 10:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgIYINX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 04:13:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:53610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbgIYINW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 04:13:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601021601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rvWeth9lHbMoeY9JrU9czVyWKCzeGrLEom9cRPUs51o=;
        b=HmmszuJj1Et2IQW52xDmOV0qcC8egFljGtNgQlpbLrpOu06WpUmO+suu5k9bviig1Ba57Q
        5M+G7Yhku6vjcyoHj67e4RMKSMwKzT4e0p1Oj/5n/iAZ0e0CItSZGPqItH5RxQd6Rn0Xig
        LxPM+VMLE0KnjY2cBSfM1ly3VVv6v+s=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F18D9AFEF;
        Fri, 25 Sep 2020 08:13:20 +0000 (UTC)
Date:   Fri, 25 Sep 2020 10:13:20 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 3/5] printk: use buffer pool for sprint buffers
Message-ID: <20200925081319.GJ29288@alley>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
 <20200922153816.5883-4-john.ogness@linutronix.de>
 <20200924061746.GF577@jagdpanzerIV.localdomain>
 <20200924085445.GK6442@alley>
 <20200924090653.GC541@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924090653.GC541@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-09-24 18:06:53, Sergey Senozhatsky wrote:
> On (20/09/24 10:54), Petr Mladek wrote:
> > > Just a question:
> > > 
> > > Can dynamic_textbuf be a PER_CPU array of five textbuf[1024] buffers
> > > (for normal printk, nmi, hard irq, soft irq and one extra buffer for
> > > recursive printk calls)?
> > 
> > That would be my preferred fallback when the approach with
> > vsprintf(NULL, ) is not acceptable for some reasons.
> 
> OK.
> 
> > But I still think that calling vsprintf(NULL, ) is the most trivial
> > and good enough solution.
> 
> It's probably good enough.
> 
> > IMHO, the solution with per-CPU buffers is not that trivial, for
> > example:
> > 
> >   What if recursive printk() is interrupted by NMI and it causes
> >   yet another recursion?
> > 
> >   Is one level of recursion enough?
> 
> We might try the current approach - when we, for example, have
> recursion in printk_safe() we just end up writing data to the
> same per-CPU buffer. We need to limit the depth of recursion
> one way or another. With per-CPU counter we will just bail out
> of "deeply recursive printk" without attempting to store its
> messages; with the buffers approach we will write the data to
> a static buffer and see how badly it will be overlapped at the
> end. Just a thought.

It makes some sense but it has just another bunch of problems:

   + require some tricky code [*]
   + temporary buffers need extra care in panic()
   + does not guarantee that there is enough stack for the recursion

I think that limiting recursion to some level (3 or 5?) is much
easier and provide similar protection.


[*] We could reuse printk_safe but we would need to maintain it.
    In fact, the code might be easier because it will not be needed
    to read the buffer from other CPU. But it would need to be
    tricky anyway.

Best Regards,
Petr
