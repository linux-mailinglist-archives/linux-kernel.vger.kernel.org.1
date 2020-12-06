Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26292D071E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 21:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgLFUYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 15:24:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59934 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgLFUYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 15:24:42 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607286240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JTrbLxSVsa+AJjMwFCvM3YrglsqeqmRd6O81SfPFnrY=;
        b=D762acncMNFT4eJbtzjA0Nb0CFGslfEYsX7pbMjZ87qVVBpH1SgenykDfkBbkhEFO3eY7C
        SnGggmLVnd2Z24lgJv/bsjYFX2CCHZruFYHnrfc4wk+WksBh4WPc/3xWJ3VfF+E1wDJUfT
        1siFxsqaV7zuyftTCOxLHwyxX5qMyTVkcyZbOD724ecSwtT1pJUgjO98uB+khyPvuWz+JV
        iNQ/cCDTFDnSV3tJPvxEWlzd1xbWel4/IFZjwExVxom2MInIdKx0tR3pyaIY2isoXZV2lF
        hXi9vUvUMSfNMgFYtIXZdNiZmbP0VtYp0SJWdl1GfIbbeVT4XU92XMox64hyUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607286240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JTrbLxSVsa+AJjMwFCvM3YrglsqeqmRd6O81SfPFnrY=;
        b=SqDCGd2gx88hR2ztINUYQhOdlUxxSr+Z1zTtv5YFOmH0xbqz7l0EyNueCpiPBjl9a0p17z
        lYTnkcTsAk+AXDCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 2/3] printk: change @clear_seq to atomic64_t
In-Reply-To: <X8n9a2DWUFE/giyB@alley>
References: <20201201205341.3871-1-john.ogness@linutronix.de> <20201201205341.3871-3-john.ogness@linutronix.de> <X8n9a2DWUFE/giyB@alley>
Date:   Sun, 06 Dec 2020 21:29:59 +0106
Message-ID: <875z5eof8g.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-04, Petr Mladek <pmladek@suse.com> wrote:
> On Tue 2020-12-01 21:59:40, John Ogness wrote:
>> Currently @clear_seq access is protected by @logbuf_lock. Once
>> @logbuf_lock is removed some other form of synchronization will be
>> required. Change the type of @clear_seq to atomic64_t to provide the
>> synchronization.
>> 
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index fc5e3a7d6d89..e9018c4e1b66 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -3412,7 +3418,7 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
>>   */
>>  void kmsg_dump_rewind_nolock(struct kmsg_dumper *dumper)
>>  {
>> -	dumper->cur_seq = clear_seq;
>> +	dumper->cur_seq = atomic64_read(&clear_seq);
>
> Sigh, atomic64_read() uses a spin lock in the generic implementation
> that is used on some architectures.
>
> Hmm, this seems to be the only location where the lock must not be
> used.

Yes, and it is read-only access. Perhaps atomic64_t is the wrong thing
to use here. We could use a seqcount_latch and a shadow variable so that
if a writer has been preempted, we can use the previous value. (Only
kmsg_dump would need to use the lockless variant to read the value.)

void clear_seq_set(u64 val)
{
        spin_lock_irq(&clear_lock);
        raw_write_seqcount_latch(&clear_latch);
        clear_seq[0] = val;
        raw_write_seqcount_latch(&clear_latch);
        clear_seq[1] = val;
        spin_unlock_irq(&clear_lock);
}

u64 clear_seq_get_nolock(void)
{
        unsigned int seq, idx;
        u64 val;

        do {
                seq = raw_read_seqcount_latch(&clear_latch);
                idx = seq & 0x1;
                val = clear_seq[idx];
        } while (read_seqcount_latch_retry(&clear_latch, seq));

        return val;
}

u64 clear_seq_get(void)
{
        u64 val;
        
        spin_lock_irq(&clear_lock);
        val = clear_seq[0];
        spin_unlock_irq(&clear_lock);
        return val;
}

> Alternative solution would to always fallback to the first_seq on
> these architectures. Few people would complain when they see more
> messages. We could always improve it when it causes problems.

I am also OK with this solution.

John Ogness
