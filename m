Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089252D1136
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgLGM5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:57:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:52974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgLGM5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:57:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607345806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=keFHSMBmtWxbt66sXOQVyjqH1hMokV/Tn2yC85tP24s=;
        b=F6nQy+bXVQ4BE3VYT5h+tLvTdFgS6QCNsROXoXqhNA7KXpFtjrYTtQ/WW9mcqDSXeff4KP
        sDxuQByxbCH00S/F8ZpFMGKlv9sS7r/HkJlAbSJT7vk/qTXRwBoxnUxQ96xpIRLCVhWKxz
        DHU/BeJrBK5wDzWKVtotC/3v6jhdNhA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 299A6AB63;
        Mon,  7 Dec 2020 12:56:46 +0000 (UTC)
Date:   Mon, 7 Dec 2020 13:56:45 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 2/3] printk: change @clear_seq to atomic64_t
Message-ID: <X84mjRsbxcsAfi1x@alley>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-3-john.ogness@linutronix.de>
 <X8n9a2DWUFE/giyB@alley>
 <875z5eof8g.fsf@jogness.linutronix.de>
 <20201207093419.GH3040@hirez.programming.kicks-ass.net>
 <87mtyq9blw.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtyq9blw.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-12-07 11:09:39, John Ogness wrote:
> On 2020-12-07, Peter Zijlstra <peterz@infradead.org> wrote:
> >> Yes, and it is read-only access. Perhaps atomic64_t is the wrong thing
> >> to use here. We could use a seqcount_latch and a shadow variable so that
> >> if a writer has been preempted, we can use the previous value. (Only
> >> kmsg_dump would need to use the lockless variant to read the value.)
> >> 
> >> void clear_seq_set(u64 val)
> >> {
> >>         spin_lock_irq(&clear_lock);
> >>         raw_write_seqcount_latch(&clear_latch);
> >>         clear_seq[0] = val;
> >>         raw_write_seqcount_latch(&clear_latch);
> >>         clear_seq[1] = val;
> >>         spin_unlock_irq(&clear_lock);
> >> }
> >> 
> >> u64 clear_seq_get_nolock(void)
> >> {
> >>         unsigned int seq, idx;
> >>         u64 val;
> >> 
> >>         do {
> >>                 seq = raw_read_seqcount_latch(&clear_latch);
> >>                 idx = seq & 0x1;
> >>                 val = clear_seq[idx];
> >>         } while (read_seqcount_latch_retry(&clear_latch, seq));
> >> 
> >>         return val;
> >> }
> >
> > That's overly complicated.
> >
> > If you're going to double the storage you can simply do:
> >
> >
> > 	seq = val
> > 	smp_wmb();
> > 	seq_copy = val;
> >
> > vs
> >
> > 	do {
> > 		tmp = seq_copy;
> > 		smp_rmb();
> > 		val = seq;
> > 	} while (val != tmp);
> 
> That will not work. We are talking about a situation where the writer is
> preempted. So seq will never equal seq_copy in that situation. I expect
> that the seqcount_latch is necessary.

Or we could disable interrupts around the writer.

But seqcount_latch will actually be need so that it works in panic().
The writer might be on a CPU that has been stopped using NMI. And this
code is used by dumpers() that are called during panic().

Sigh, I have to take a coffee and try to really understand the latch code ;-)

Best Regards,
Petr
