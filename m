Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDD82D0DB9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 11:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgLGKEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 05:04:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35322 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgLGKEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 05:04:22 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607335420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t4Jhtz8veRXymryz0xKab9TlQ3baLQoL7wNE/fpuipU=;
        b=MW4i1KXMb7DEMR3VrxXrhEtSLAsORfekNssZsz9I9bzJTKtqWFkiNiUSkfx1YSjbT0+60o
        nKkyiMPLFvK3TkuKMrIv81Br8rUBO/BXDxCajwvvfIClmAfjKur4VUfalc9uFlsksX30JI
        hglHrmn2goj9UBT1Lajx7ti+9uc+2wDf8qXY3i00QKAFRNtPfKr1LvX1D1eR4mJL0hB9VC
        2egTD53Os2zb1zLb1NOByD578XNcsbrPVBPERorikxY1G2/IOaKVBaZjZW2uRdmDhM3ooO
        5RVgSyzXpEFLe8k0+rxFF13HSZVEDLQjbSGSa+XZR86gFhCiQ0wvO+UWEgY+ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607335420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t4Jhtz8veRXymryz0xKab9TlQ3baLQoL7wNE/fpuipU=;
        b=AzFFebzy8Ardd0tIVtCVgtMMQMG69P11Xn6Pc9Bq0FHdevwLe3Y34MjxAyBwJAjrlwHCeq
        MMhaE1dWr7UZr4Bw==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 2/3] printk: change @clear_seq to atomic64_t
In-Reply-To: <20201207093419.GH3040@hirez.programming.kicks-ass.net>
References: <20201201205341.3871-1-john.ogness@linutronix.de> <20201201205341.3871-3-john.ogness@linutronix.de> <X8n9a2DWUFE/giyB@alley> <875z5eof8g.fsf@jogness.linutronix.de> <20201207093419.GH3040@hirez.programming.kicks-ass.net>
Date:   Mon, 07 Dec 2020 11:09:39 +0106
Message-ID: <87mtyq9blw.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-07, Peter Zijlstra <peterz@infradead.org> wrote:
>> Yes, and it is read-only access. Perhaps atomic64_t is the wrong thing
>> to use here. We could use a seqcount_latch and a shadow variable so that
>> if a writer has been preempted, we can use the previous value. (Only
>> kmsg_dump would need to use the lockless variant to read the value.)
>> 
>> void clear_seq_set(u64 val)
>> {
>>         spin_lock_irq(&clear_lock);
>>         raw_write_seqcount_latch(&clear_latch);
>>         clear_seq[0] = val;
>>         raw_write_seqcount_latch(&clear_latch);
>>         clear_seq[1] = val;
>>         spin_unlock_irq(&clear_lock);
>> }
>> 
>> u64 clear_seq_get_nolock(void)
>> {
>>         unsigned int seq, idx;
>>         u64 val;
>> 
>>         do {
>>                 seq = raw_read_seqcount_latch(&clear_latch);
>>                 idx = seq & 0x1;
>>                 val = clear_seq[idx];
>>         } while (read_seqcount_latch_retry(&clear_latch, seq));
>> 
>>         return val;
>> }
>
> That's overly complicated.
>
> If you're going to double the storage you can simply do:
>
>
> 	seq = val
> 	smp_wmb();
> 	seq_copy = val;
>
> vs
>
> 	do {
> 		tmp = seq_copy;
> 		smp_rmb();
> 		val = seq;
> 	} while (val != tmp);

That will not work. We are talking about a situation where the writer is
preempted. So seq will never equal seq_copy in that situation. I expect
that the seqcount_latch is necessary.

John Ogness
