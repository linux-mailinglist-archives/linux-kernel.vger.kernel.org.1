Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78D12CF19E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbgLDQKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:10:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:35462 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbgLDQKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:10:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607098207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D33SdhwZNJi2uBaYJpFAFfeHS3fk9aEn8alrEz4biwo=;
        b=R4nG2RhjBXbm0SfRECtr8SQfRq+9lcVM56MVjR5KL1t3L6IlXzTgIxsu3BwXuEFoZC4bvm
        edF09KND73+4y/drqmjOe6NkMKrRUVAhHPDTlfEVK7JJ8tXebIAjiKrUDGqxMJKL+NFT8p
        ZDHlLQfGNfa9u1rsEknSMnZGXFfQRiQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 81BDCAC9A;
        Fri,  4 Dec 2020 16:10:07 +0000 (UTC)
Date:   Fri, 4 Dec 2020 17:10:07 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: recursion handling: Re: [PATCH next v2 3/3] printk: remove
 logbuf_lock, add syslog_lock
Message-ID: <X8pfX/qPBuY360k/@alley>
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
> @@ -1847,6 +1811,65 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
>  	}
>  }

The recursion-related code needs some explanation or we should do it
another way. I spent quite some time on it and I am still not sure
that I understand it. Let me describe how I understand it.


> +#ifdef CONFIG_PRINTK_NMI
> +#define NUM_RECURSION_CTX 2
> +#else
> +#define NUM_RECURSION_CTX 1
> +#endif

OK, the number of context is limited because interrupts are disabled inside
print_enter()/printk_exit(). It is basically the same reason why
we have only two printk_safe buffers (NNI + other contexts).

What is the exact reason to disable interrupts around the entire
vprintk_store(), please? It should get documented.

One reason is the use of per-cpu variables. Alternative solution would
be to store printk_context into task_struct. Well, I am not sure if
"current" task is available during early boot. But it might solve
problems with per-cpu variables that are not working during early boot.

That said, I am not sure if it is worth it.


> +
> +struct printk_recursion {
> +	char	count[NUM_RECURSION_CTX];
> +};
>
> +static DEFINE_PER_CPU(struct printk_recursion, percpu_printk_recursion);
> +static char printk_recursion_count[NUM_RECURSION_CTX];

This is pretty confusing. The array is hidden in a struct when per-cpu
variables are used. And a naked array is used for early boot.

Is the structure really needed? What about?

static DEFINE_PER_CPU(char [PRINTK_CTX_NUM], printk_count);
static char printk_count_early[NUM_RECURSION_CTX];

> +
> +static char *get_printk_count(void)
> +{
> +	struct printk_recursion *rec;
> +	char *count;
> +
> +	if (!printk_percpu_data_ready()) {
> +		count = &printk_recursion_count[0];

I see why you avoided per-cpu variables for early boot. I am just
curious how printk_context variable works these days. It is used by
any printk(), including early code, see vprintk_func().


> +	} else {
> +		rec = this_cpu_ptr(&percpu_printk_recursion);
> +
> +		count = &rec->count[0];
> +	}
> +
> +#ifdef CONFIG_PRINTK_NMI
> +	if (in_nmi())
> +		count++;
> +#endif

This is extremely confusing. It is far from obvious that
the pointer and not the value is incremented.

If we really need this to avoid per-cpu variables during early boot
then a more clear implementation would be:

char *get_printk_counter_by_ctx()
{
	int ctx = 0;

	if (in_nmi)
		ctx = 1;

	if (!printk_percpu_data_ready())
		return &printk_count_early[ctx];

	return this_cpu_ptr(printk_count[ctx]);
}

> +
> +	return count;
> +}
> +
> +static bool printk_enter(unsigned long *flags)
> +{
> +	char *count;
> +
> +	local_irq_save(*flags);
> +	count = get_printk_count();
> +	/* Only 1 level of recursion allowed. */

We should allow at least some level of recursion. Otherwise, we would
not see warnings printed from vsprintf code.

> +	if (*count > 1) {
> +		local_irq_restore(*flags);
> +		return false;
> +	}
> +	(*count)++;
> +
> +	return true;
> +}

This should be unified with printk_context, printk_nmi_enter(),
printk_nmi_exit(). It does not make sense to have two separate
printk context counters.

Or is there any plan to remove printk_safe and printk_context?

BTW: I prefer to use the bitmask approach. It allows to check
the normal context by a single operation (no bit is set).
There is no need to go through all counters.

Note that we need at least one more context for gdb.

Best Regards,
Petr
