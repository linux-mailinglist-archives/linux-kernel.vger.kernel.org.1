Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA4A2D0D18
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgLGJfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgLGJfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:35:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A9BC0613D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 01:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b1j1H8XecQrBVNudhF5CzRVkTselpA16gsYa3scFeZw=; b=uWCrzYW5xhcvC1/HYehJsuLddK
        WYw/tPoSFVZ+GRu3XVNWbfnJaUNFnkq5EcKSntpifvfRuQPJc5ei/zQmErrZNFs3+vRdICRvk+OT8
        FxHPnqWxs5Re8ypT4DRc5ZNtPFq8pSWAZuxgaRupBMPlfkmUs6aMOVGWFERhiDLhBe4/UHlSOE0Vi
        Eppyz9e/PdzJmEvKUd0o985bckVOQYluMF3k8YGf3h2Xmlu1wGRIZgzEri7cIcJduGsea2SegmUK4
        AnLRFQy0F+yK63q644D5ReQ11tzeMvf4A6duCII1Lyo11ZshnC5c1La3muhGWQB92cUcv8u51mqsn
        /gndXO7w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmCuS-0007I0-ST; Mon, 07 Dec 2020 09:34:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B59D6304D28;
        Mon,  7 Dec 2020 10:34:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A49CB20E02217; Mon,  7 Dec 2020 10:34:19 +0100 (CET)
Date:   Mon, 7 Dec 2020 10:34:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 2/3] printk: change @clear_seq to atomic64_t
Message-ID: <20201207093419.GH3040@hirez.programming.kicks-ass.net>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-3-john.ogness@linutronix.de>
 <X8n9a2DWUFE/giyB@alley>
 <875z5eof8g.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z5eof8g.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 06, 2020 at 09:29:59PM +0106, John Ogness wrote:
> Yes, and it is read-only access. Perhaps atomic64_t is the wrong thing
> to use here. We could use a seqcount_latch and a shadow variable so that
> if a writer has been preempted, we can use the previous value. (Only
> kmsg_dump would need to use the lockless variant to read the value.)
> 
> void clear_seq_set(u64 val)
> {
>         spin_lock_irq(&clear_lock);
>         raw_write_seqcount_latch(&clear_latch);
>         clear_seq[0] = val;
>         raw_write_seqcount_latch(&clear_latch);
>         clear_seq[1] = val;
>         spin_unlock_irq(&clear_lock);
> }
> 
> u64 clear_seq_get_nolock(void)
> {
>         unsigned int seq, idx;
>         u64 val;
> 
>         do {
>                 seq = raw_read_seqcount_latch(&clear_latch);
>                 idx = seq & 0x1;
>                 val = clear_seq[idx];
>         } while (read_seqcount_latch_retry(&clear_latch, seq));
> 
>         return val;
> }

That's overly complicated.

If you're going to double the storage you can simply do:


	seq = val
	smp_wmb();
	seq_copy = val;

vs

	do {
		tmp = seq_copy;
		smp_rmb();
		val = seq;
	} while (val != tmp);


Also look for CONFIG_64_BIT in kernel/sched/fair.c.
