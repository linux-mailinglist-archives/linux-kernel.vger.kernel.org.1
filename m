Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2172D07B2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 23:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgLFWbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 17:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgLFWbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 17:31:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719DFC0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 14:30:56 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607293853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Qi26rLo3lNty3TaRit8SNgWVdwKIo0fZR3vvxZKsRs=;
        b=WKx2q7fYacvwb8PbU2x8r7uTzhT86uqiMiLZ3eOydR1kODUCNvEOcOVuqjpmqOZ+/HWIc6
        K9T5okEgcWLECxuPVt1NK2wUQwRbHdppzv7bgrooc3I+pEF++YyxDb+kFH+T5l2zuaAq7K
        +0qgQ4cj2jMCX8iDa+yvQqOI4HMBWbfNPnxTKR1ysMdwvhUlzknYIj1ApjEdhBgj7VArDo
        WdkVj2cmgz6FP+HTQ9Glln3G8uUML3GshuFyRtNgDK2TRJ8kYxqgQpLMlILWjz7LSrGJ+B
        2YFSVhTl+TUrwd0mNwOdjqgTRXBOFW6YAqwA8zM2+4vjmiwbu8Jje6wOp4aN3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607293853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Qi26rLo3lNty3TaRit8SNgWVdwKIo0fZR3vvxZKsRs=;
        b=Hr6S2mX1ArDCuKRdsCx5XIO8RvktN9JItRe2BqP/5GhCjhbARzwaQKX4aL92HfoXFy+rBB
        7Kd1iDwJaO7+/9CA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: vprintk_store: was: [PATCH next v2 3/3] printk: remove logbuf_lock, add syslog_lock
In-Reply-To: <X8pgvA3wKRwAyyaS@alley>
References: <20201201205341.3871-1-john.ogness@linutronix.de> <20201201205341.3871-4-john.ogness@linutronix.de> <X8pgvA3wKRwAyyaS@alley>
Date:   Sun, 06 Dec 2020 23:36:53 +0106
Message-ID: <87k0tumusi.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-04, Petr Mladek <pmladek@suse.com> wrote:
>> +	/* Strip kernel syslog prefix. */
>
> Syslog actually uses: <level> format. We are skipping log level
> and control flags here.

OK.

>> +	if (facility == 0) {
>> +		while (text_len >= 2 && printk_get_level(text)) {
>> +			text_len -= 2;
>> +			text += 2;
>> +		}
>
> We should avoid two completely different approaches
> that handle printk_level prefix.
>
> One solution is to implement something like:
>
>      static char *parse_prefix(text, &level, &flags)
>
> That would return pointer to the text after the prefix.
> And fill level and flags only when non-NULL pointers are passed.

OK.

> Another solution would be to pass this information from
> vprintk_store(). The prefix has already been parsed
> after all.

Well, there is a vscnprintf() that happens in between and I don't think
we should trust the parsed offset from the first vsnprintf().

>> +
>> +		if (text != orig_text)
>> +			memmove(orig_text, text, text_len);
>> +	}
>
> We should clear the freed space to make the ring buffer as
> human readable as possible when someone just dumps the memory.

Data blocks are currently padded and that padding is not cleared. So it
is already not perfectly human readable on a raw dump.

> Sigh, I have to admit that I missed the problem with prefix and
> trailing '\n' when I suggested to avoid the temporary buffers.
> This memmove() and the space wasting is pity.
>
> Well, it is typically 3 bytes per message. And the copying would
> be necessary even with the temporary buffer. So, I am less convinced
> but I would still try to avoid the temporary buffers for now.

Agreed. I think this approach is better than the temporary buffers I
previously used. Also, if we add a trimming feature to the ringbuffer,
it will keep the ringbuffer mostly clean anyway. Something like this:

prb_rec_init_wr(&r, text_len);
prb_reserve(&e, prb, &r);
text_len = printk_sprint(&r.text_buf[0], text_len, ...);
r.info->text_len = text_len;
prb_trim_rec(&e, &r); <--- try to reduce datablock size to @text_len
prb_commit(&e);

I see no urgency to add such a feature. But I think we should keep it on
our radar.

John Ogness
