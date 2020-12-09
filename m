Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4712D3D17
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgLIIIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbgLIIIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:08:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05173C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 00:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PqMS5S7XjAIlxl6JeUYeGzLqUJQmKwtWVexDfjcXEGA=; b=dFhM7Xct/GxeNM4/8NPOtMs+fA
        bCxaioDPFF6rpiMcL6a4J+cYUuYby6Ua9t8CaPtRfGg8SlEsMDGd9lmUYzGLF1kcZt50xISyDDDv0
        Vxxn+NXopMPWRVYbh7ql/FKrdxhJRD68+YkqXgpyQz68EKcqGDRPcj2HaFOwozUOSoZAfOnuMt9OB
        nK8e6CNDM/bF6iTQEzOPOUAx53TkHW3uKH2Il9gyyJ0fNZOzUPzvQ8gdLIfFbqsa+ihMan4rqmBa0
        8UwBJYOyveXUsfCDopyPbPFc+1Sb0yHXr+3OQbygoRK2DeE9b8VMvjOTfwHPYhavH7m96l0hKe+fs
        yFEBIzJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmuVf-00043D-1I; Wed, 09 Dec 2020 08:07:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 09AB830477A;
        Wed,  9 Dec 2020 09:07:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E405820812951; Wed,  9 Dec 2020 09:07:35 +0100 (CET)
Date:   Wed, 9 Dec 2020 09:07:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 2/3] printk: change @clear_seq to atomic64_t
Message-ID: <20201209080735.GH2414@hirez.programming.kicks-ass.net>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-3-john.ogness@linutronix.de>
 <X8n9a2DWUFE/giyB@alley>
 <X8/jS9k/eMIL+Acw@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8/jS9k/eMIL+Acw@jagdpanzerIV.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 05:34:19AM +0900, Sergey Senozhatsky wrote:
> On (20/12/04 10:12), Petr Mladek wrote:
> > On Tue 2020-12-01 21:59:40, John Ogness wrote:
> > > Currently @clear_seq access is protected by @logbuf_lock. Once
> > > @logbuf_lock is removed some other form of synchronization will be
> > > required. Change the type of @clear_seq to atomic64_t to provide the
> > > synchronization.
> > > 
> > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > > index fc5e3a7d6d89..e9018c4e1b66 100644
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -3412,7 +3418,7 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
> > >   */
> > >  void kmsg_dump_rewind_nolock(struct kmsg_dumper *dumper)
> > >  {
> > > -	dumper->cur_seq = clear_seq;
> > > +	dumper->cur_seq = atomic64_read(&clear_seq);
> > 
> > Sigh, atomic64_read() uses a spin lock in the generic implementation
> > that is used on some architectures.
> 
> Oh... So on those archs prb is not lockless in fact, it actually
> takes the spin_lock each time we read the descriptor state?

Yeah, many 32bit archs cannot natively do 64bit atomics and get to use
the horrible hashed spinlock crap.

But it gets even worse, we have a few architectures that cannot do
atomics _at_all_ and _always_ use the horrible hashed spinlock crap for
all atomics, even native word length ones.

I consider these architectures broken crap, and they work mostly by
accident than anything else, but we have them :/ The good new is that
they don't have NMIs either, so that helps.
