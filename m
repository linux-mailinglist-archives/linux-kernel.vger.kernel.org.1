Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE182CF1C0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgLDQQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:16:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:39382 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgLDQQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:16:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607098557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UyfSIUJD3A1xmg2RWmSd8HkdBVuOod7ZPB6QL2MeQ/Q=;
        b=E791E8NQeGNAN7oLMkgqN6Ia12AifKYMZbvXkCeuz5A5fx4CuBAf5BxfYLV9W51XXdXOrV
        J5HUlADkWT63pjd7HXO6H5687bVvNtU1VYkeU3zWzDQC3WM896vjsFnlQ4jFNFlofgMBo8
        xxYosajjTPvtIbejYgIG3V+BUnsQ/Uw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 386D9ACC1;
        Fri,  4 Dec 2020 16:15:57 +0000 (UTC)
Date:   Fri, 4 Dec 2020 17:15:56 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: vprintk_store: was: [PATCH next v2 3/3] printk: remove logbuf_lock,
 add syslog_lock
Message-ID: <X8pgvA3wKRwAyyaS@alley>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201205341.3871-4-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-12-01 21:59:41, John Ogness wrote:
> Since the ringbuffer is lockless, there is no need for it to be
> protected by @logbuf_lock. Remove @logbuf_lock.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1867,40 +1890,75 @@ static inline u32 printk_caller_id(void)
>  		0x80000000 + raw_smp_processor_id();
>  }
>  
> -/* Must be called under logbuf_lock. */
> +static u16 printk_sprint(char *text, u16 size, int facility, enum log_flags *lflags,
> +			 const char *fmt, va_list args)
> +{
> +	char *orig_text = text;
> +	u16 text_len;
> +
> +	text_len = vscnprintf(text, size, fmt, args);
> +
> +	/* Mark and strip a trailing newline. */
> +	if (text_len && text[text_len - 1] == '\n') {
> +		text_len--;
> +		*lflags |= LOG_NEWLINE;
> +	}

We reserve the space for '\n' anyway. It would make sense to just
store it and remove all these LOG_NEWLINE-specific hacks.

Well, let's leave it as is now. It is still possible that people
will not love this approach and we will need to format the message
into some temporary buffer first.


> +	/* Strip kernel syslog prefix. */

Syslog actually uses: <level> format. We are skipping log level
and control flags here.


> +	if (facility == 0) {
> +		while (text_len >= 2 && printk_get_level(text)) {
> +			text_len -= 2;
> +			text += 2;
> +		}

We should avoid two completely different approaches
that handle printk_level prefix.

One solution is to implement something like:

     static char *parse_prefix(text, &level, &flags)

That would return pointer to the text after the prefix.
And fill level and flags only when non-NULL pointers are passed.

Another solution would be to pass this information from
vprintk_store(). The prefix has already been parsed
after all.

> +
> +		if (text != orig_text)
> +			memmove(orig_text, text, text_len);
> +	}

We should clear the freed space to make the ring buffer as
human readable as possible when someone just dumps the memory.

Sigh, I have to admit that I missed the problem with prefix and
trailing '\n' when I suggested to avoid the temporary buffers.
This memmove() and the space wasting is pity.

Well, it is typically 3 bytes per message. And the copying would
be necessary even with the temporary buffer. So, I am less convinced
but I would still try to avoid the temporary buffers for now.

> +
> +	return text_len;
> +}
> +
> +__printf(4, 0)

Best Regards,
Petr
