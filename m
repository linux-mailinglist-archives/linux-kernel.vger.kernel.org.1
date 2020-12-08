Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B792D2C84
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 15:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgLHOET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 09:04:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:36634 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgLHOET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 09:04:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607436212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Icp08ODjiwfuirJHs1nv3KopbAd++A1hFZ697nTl6KM=;
        b=tZDX2wZAfRbsLWvjwuDymCoklusMlAyKP/vchgEGxf+2ziVzTrcdwekS1JyAEUxPK+xJcD
        FhFZtxxdaLWHrxqHgDZYpxgPGNB9Ia1+L171Bhb0F+PbnneyH/Gci6Z9tDCn9uYmZCAWfV
        pCTeHaIwFYN54wdQooVNxxTKkowsSBE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DB91FAD7C;
        Tue,  8 Dec 2020 14:03:31 +0000 (UTC)
Date:   Tue, 8 Dec 2020 15:03:31 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v3 3/3] printk: remove logbuf_lock protection for
 ringbuffer
Message-ID: <X8+Hs36YBOb9nyuH@alley>
References: <20201207222020.2923-1-john.ogness@linutronix.de>
 <20201207222020.2923-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207222020.2923-4-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-12-07 23:26:20, John Ogness wrote:
> Since the ringbuffer is lockless, there is no need for it to be
> protected by @logbuf_lock. Remove @logbuf_lock protection of the
> ringbuffer.

This patch removes the protection only on the write part. Please,
make it clear here and also in the subject.

> This means that printk_nmi_direct and printk_safe_flush_on_panic()
> no longer need to acquire any lock to run.
> 
> Without @logbuf_lock it is no longer possible to use the single
> static buffer for temporarily sprint'ing the message. Instead,
> use vsnprintf() to determine the length and perform the real
> vscnprintf() using the area reserved from the ringbuffer. This
> leads to suboptimal packing of the message data, but will
> result in less wasted storage than multiple per-cpu buffers to
> support lockless temporary sprint'ing.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c      | 131 +++++++++++++++++++++++++-----------
>  kernel/printk/printk_safe.c |  18 +----
>  2 files changed, 95 insertions(+), 54 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index e1f068677a74..f3c0fcc3163f 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1861,19 +1856,91 @@ static inline u32 printk_caller_id(void)
>  		0x80000000 + raw_smp_processor_id();
>  }
>  
> -/* Must be called under logbuf_lock. */
> +/**
> + * parse_prefix - Parse level and control flags.
> + *
> + * @text:     The text message.
> + * @text_len: A pointer to a value of strlen(@text), will be updated.
> + * @level:    A pointer to the current level value, will be updated.
> + * @lflags:   A pointer to the current log flags, will be updated.
> + *
> + * The variable pointed to by @text_len is updated to the message length
> + * when subtracting the parsed level and control flag length.
> + *
> + * @level may be NULL if the caller is not interested in the parsed value.
> + * Otherwise the variable pointed to by @level must be set to
> + * LOGLEVEL_DEFAULT in order to be updated with the parsed value.
> + *
> + * @lflags may be NULL if the caller is not interested in the parsed value.
> + * Otherwise the variable pointed to by @lflags will be OR'd with the parsed
> + * value.
> + *
> + * Return: The text message with the parsed level and control flags skipped.
> + */
> +static char *parse_prefix(char *text, u16 *text_len, int *level, enum log_flags *lflags)
> +{
> +	int kern_level;
> +
> +	while (*text_len >= 2) {
> +		kern_level = printk_get_level(text);
> +		if (!kern_level)
> +			break;
> +
> +		switch (kern_level) {
> +		case '0' ... '7':
> +			if (level && *level == LOGLEVEL_DEFAULT)
> +				*level = kern_level - '0';
> +			break;
> +		case 'c':	/* KERN_CONT */
> +			if (lflags)
> +				*lflags |= LOG_CONT;
> +		}
> +
> +		*text_len -= 2;
> +		text += 2;
> +	}
> +
> +	return text;
> +}
> +
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
> +
> +	/* Strip log level and control flags. */
> +	if (facility == 0) {
> +		text = parse_prefix(text, &text_len, NULL, NULL);
> +		if (text != orig_text)
> +			memmove(orig_text, text, text_len);
> +	}
> +
> +	return text_len;
> +}
> +
> +__printf(4, 0)
>  int vprintk_store(int facility, int level,
>  		  const struct dev_printk_info *dev_info,
>  		  const char *fmt, va_list args)
>  {
>  	const u32 caller_id = printk_caller_id();
> -	static char textbuf[LOG_LINE_MAX];
>  	struct prb_reserved_entry e;
>  	enum log_flags lflags = 0;
>  	struct printk_record r;
>  	u16 trunc_msg_len = 0;
> -	char *text = textbuf;
> +	char prefix_buf[8];
> +	va_list args2;
>  	u16 text_len;
> +	int ret = 0;
>  	u64 ts_nsec;
>  
>  	/*
> @@ -1884,35 +1951,21 @@ int vprintk_store(int facility, int level,
>  	 */
>  	ts_nsec = local_clock();
>  
> +	va_copy(args2, args);
> +
>  	/*
>  	 * The printf needs to come first; we need the syslog
>  	 * prefix which might be passed-in as a parameter.
>  	 */
> -	text_len = vscnprintf(text, sizeof(textbuf), fmt, args);
> +	text_len = vsnprintf(&prefix_buf[0], sizeof(prefix_buf), fmt, args) + 1;

The "+ 1" confused me a lot.

I guess that you added "+ 1" because we need to reserve the space also
for the trailing "\0". Otherwise, the later vscnprintf() would shrink
the string.

But the same variable is later used for the lenghth wihtout the trailing
newline after the second vscnprintf().

It is very confusing and error prone.

Please, use two variables:

    + reserve_size: as a return from the first vsnprintf() + 1. And use
	it to reserve the size.

    + text_len: as a return from printk_sprint().

I though about using "buf_size" but it might be confused with the size
of prefix_buf. IMHO, reserve_size is more informative.

+	if (text_len > CONSOLE_LOG_MAX)
+		text_len = CONSOLE_LOG_MAX;

As you wrote, this should check/set LOG_LINE_MAX.


> -	/* mark and strip a trailing newline */
> -	if (text_len && text[text_len-1] == '\n') {
> -		text_len--;
> -		lflags |= LOG_NEWLINE;
> -	}
> -
> -	/* strip kernel syslog prefix and extract log level or control flags */
> +	/* Extract log level or control flags. */
>  	if (facility == 0) {
> -		int kern_level;
> -
> -		while ((kern_level = printk_get_level(text)) != 0) {
> -			switch (kern_level) {
> -			case '0' ... '7':
> -				if (level == LOGLEVEL_DEFAULT)
> -					level = kern_level - '0';
> -				break;
> -			case 'c':	/* KERN_CONT */
> -				lflags |= LOG_CONT;
> -			}

> +		u16 tmplen = sizeof(prefix_buf);

We are not really interested into tmplen here.
BTW: The name is confusing ;-)

What about updating parse_prefix() to return the length of the prefix
string. Then we could do here:


	if (facility == 0)
		parse_prefix(&prefix_buf[0], &level, &lflags);

In printk_sprint(), we could do:

	if (facility == 0) {
		u16 prefix_len;

		prefix_len = parse_prefix(text, NULL, NULL);
		if (prefix_len) {
			text_len -= prefix_len;
			text = memmove(text, text + prefix_len,	text_len);
		}
	}

> -			text_len -= 2;
> -			text += 2;
> -		}
> +		parse_prefix(&prefix_buf[0], &tmplen, &level, &lflags);
>  	}
>  
>  	if (level == LOGLEVEL_DEFAULT)
> @@ -1972,7 +2027,10 @@ int vprintk_store(int facility, int level,
>  	else
>  		prb_final_commit(&e);
>  
> -	return (text_len + trunc_msg_len);
> +	ret = text_len + trunc_msg_len;
> +out:
> +	va_end(args2);

I suggest to use args2 for the first vsnprintf(). I mean:

	va_copy(args2, args);
	reserve_size = vsnprintf(&prefix_buf[0], sizeof(prefix_buf),fmt, args) + 1;
	va_end(args2)

Then we could avoid the churn with "out" label.


> +	return ret;
>  }
>  
>  asmlinkage int vprintk_emit(int facility, int level,
> @@ -1995,10 +2053,7 @@ asmlinkage int vprintk_emit(int facility, int level,
>  	boot_delay_msec(level);
>  	printk_delay();
>  
> -	/* This stops the holder of console_sem just where we want him */
> -	logbuf_lock_irqsave(flags);
>  	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
> -	logbuf_unlock_irqrestore(flags);

It will not longer prevent an infinite recursion via the printk_safe() code.
We either need to prevent the recursion another way or use:

	printk_safe_enter_irqsave(flags);
	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
	printk_safe_exit_irqrestore(flags);

>  
>  	/* If called from the scheduler, we can not call up(). */
>  	if (!in_sched) {
> diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
> index a0e6f746de6c..7248b6e3df6c 100644
> --- a/kernel/printk/printk_safe.c
> +++ b/kernel/printk/printk_safe.c
> @@ -266,18 +266,6 @@ void printk_safe_flush(void)
>   */
>  void printk_safe_flush_on_panic(void)
>  {
> -	/*
> -	 * Make sure that we could access the main ring buffer.
> -	 * Do not risk a double release when more CPUs are up.
> -	 */
> -	if (raw_spin_is_locked(&logbuf_lock)) {
> -		if (num_online_cpus() > 1)
> -			return;

This has to stay until we remove logbuf_lock from any code that
might be called in panic(). Otherwise, the lock might stay locked
and cause deadlock in these other code paths.


> -
> -		debug_locks_off();
> -		raw_spin_lock_init(&logbuf_lock);
> -	}
> -
>  	printk_safe_flush();
>  }
>  
> @@ -371,17 +359,15 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
>  	 * Try to use the main logbuf even in NMI. But avoid calling console
>  	 * drivers that might have their own locks.
>  	 */
> -	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK) &&
> -	    raw_spin_trylock(&logbuf_lock)) {
> +	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK)) {
>  		int len;
>  
>  		len = vprintk_store(0, LOGLEVEL_DEFAULT, NULL, fmt, args);
> -		raw_spin_unlock(&logbuf_lock);

Just for record. This was not safe against an infinite recursion.
Also it was not safe against double unlock. It is great that
it will be gone soon.

Well, I would prefer to keep it as is until we remove logbuf_lock from
other code paths. It probably is not strictly necessary because
we are just storing the messages here. But there might theoretically
be a panic_notifier that tries to call a dumper() or so.
Better be on the safe side to avoid regression.


>  		defer_console_output();
>  		return len;
>  	}
>  
> -	/* Use extra buffer in NMI when logbuf_lock is taken or in safe mode. */
> +	/* Use extra buffer in NMI or in safe mode. */
>  	if (this_cpu_read(printk_context) & PRINTK_NMI_CONTEXT_MASK)
>  		return vprintk_nmi(fmt, args);
>  
> -- 
> 2.20.1
