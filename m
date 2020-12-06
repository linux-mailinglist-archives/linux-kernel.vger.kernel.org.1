Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2262D0772
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 22:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgLFVpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 16:45:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60414 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgLFVpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 16:45:38 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607291095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uvMIZ8V7P82TIE5ynaeOhFU443FPPkQVZf1zwOM1y3A=;
        b=L/z43f9iDM03hpUNwETYPWzr/NPqkFYwEJf8JqJmRKeJCuMpmJz5Mo03rquuIhTgiTTbzq
        ygNu50ZVfmcAnkxnHnpXF9XUDlfq5QsuDszFoNgavLbrmLJBt6TZlQLxwUvgSxkiMguUxk
        rlzJxBO1CHnB/A7+eIJJCrUjoEoW2q+cpkWbAniiZkG3VCmOWFXcwBXlHFZeOEXd+f6svL
        Wa8hIdRyt8jho97JBjwClhIB3msgMo1MI3GedduvziOX2LmhaKzF0KkYK5+a+pz+Nydifw
        GGCBtQi6cZV4euxOfFlDR5817nvI8odyXeuMr59n4dQL3paF//b0M+Oqfx3SbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607291095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uvMIZ8V7P82TIE5ynaeOhFU443FPPkQVZf1zwOM1y3A=;
        b=8n2snkdbySjbb1zYN6zLZrwi86jTBLwFvZK2nIepaSWUJVkTpITkSQOKtv9UxUY2SqcqyM
        ICQJcgRpD/wBckCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: recursion handling: Re: [PATCH next v2 3/3] printk: remove logbuf_lock, add syslog_lock
In-Reply-To: <X8pfX/qPBuY360k/@alley>
References: <20201201205341.3871-1-john.ogness@linutronix.de> <20201201205341.3871-4-john.ogness@linutronix.de> <X8pfX/qPBuY360k/@alley>
Date:   Sun, 06 Dec 2020 22:50:54 +0106
Message-ID: <87sg8imwx5.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-04, Petr Mladek <pmladek@suse.com> wrote:
> On Tue 2020-12-01 21:59:41, John Ogness wrote:
>> Since the ringbuffer is lockless, there is no need for it to be
>> protected by @logbuf_lock. Remove @logbuf_lock.
>> 
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1847,6 +1811,65 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
>>  	}
>>  }
>
> The recursion-related code needs some explanation or we should do it
> another way. I spent quite some time on it and I am still not sure
> that I understand it.

Sorry. :-/

> Let me describe how I understand it.
>
>> +#ifdef CONFIG_PRINTK_NMI
>> +#define NUM_RECURSION_CTX 2
>> +#else
>> +#define NUM_RECURSION_CTX 1
>> +#endif
>
> OK, the number of context is limited because interrupts are disabled
> inside print_enter()/printk_exit(). It is basically the same reason
> why we have only two printk_safe buffers (NNI + other contexts).

Correct.

> What is the exact reason to disable interrupts around the entire
> vprintk_store(), please? It should get documented.

It simplifies the context tracking. Also, in mainline interrupts are
already disabled for all of vprintk_store(). AFAIK latencies due to
logbuf_lock contention were not an issue.

> One reason is the use of per-cpu variables. Alternative solution would
> be to store printk_context into task_struct. Well, I am not sure if
> "current" task is available during early boot. But it might solve
> problems with per-cpu variables that are not working during early
> boot.
>
> That said, I am not sure if it is worth it.

I really don't want to touch task_struct. IMHO the usefulness of that
struct is limited, considering that printk can be called from scheduling
and interrupting contexts.

>> +
>> +struct printk_recursion {
>> +	char	count[NUM_RECURSION_CTX];
>> +};
>>
>> +static DEFINE_PER_CPU(struct printk_recursion, percpu_printk_recursion);
>> +static char printk_recursion_count[NUM_RECURSION_CTX];
>
> This is pretty confusing. The array is hidden in a struct when per-cpu
> variables are used. And a naked array is used for early boot.
>
> Is the structure really needed? What about?
>
> static DEFINE_PER_CPU(char [PRINTK_CTX_NUM], printk_count);
> static char printk_count_early[NUM_RECURSION_CTX];

OK.

>> +
>> +static char *get_printk_count(void)
>> +{
>> +	struct printk_recursion *rec;
>> +	char *count;
>> +
>> +	if (!printk_percpu_data_ready()) {
>> +		count = &printk_recursion_count[0];
>
> I see why you avoided per-cpu variables for early boot. I am just
> curious how printk_context variable works these days. It is used by
> any printk(), including early code, see vprintk_func().

IMO printk_context is serving a different purpose. With the existance of
logbuf_lock, printk_context exists for the sole purpose of making sure
logbuf_lock is not taken recursively or that the CPU does not spin on it
in NMI context. printk_context is simply gating calls to the safe
buffers.

For the lockless ringbuffer, there is no issue of taking a lock
recursively or dangers from NMI. There is no need for the printk_context
"gate". However, IMHO there is a real danger if a bug in printk (or its
ringbuffer) lead to infinite recursion. This new recursion counter is
offering safety against this scenario. Until now this scenario has been
ignored. So I suppose if we are comfortable with continuing to ignore
the scenario, then we don't need to track the recursion level.

To test, I triggered artificial WARNs in vsnprintf() of printk code. I
found it nice to be able to see the stack trace going into printk and at
the same time I was relieved that such a nested warning was not blasting
the system into infinite recursion.

>> +	} else {
>> +		rec = this_cpu_ptr(&percpu_printk_recursion);
>> +
>> +		count = &rec->count[0];
>> +	}
>> +
>> +#ifdef CONFIG_PRINTK_NMI
>> +	if (in_nmi())
>> +		count++;
>> +#endif
>
> This is extremely confusing. It is far from obvious that
> the pointer and not the value is incremented.
>
> If we really need this to avoid per-cpu variables during early boot
> then a more clear implementation would be:
>
> char *get_printk_counter_by_ctx()
> {
> 	int ctx = 0;
>
> 	if (in_nmi)
> 		ctx = 1;
>
> 	if (!printk_percpu_data_ready())
> 		return &printk_count_early[ctx];
>
> 	return this_cpu_ptr(printk_count[ctx]);
> }

Yes, much cleaner. Thank you.

>> +
>> +	return count;
>> +}
>> +
>> +static bool printk_enter(unsigned long *flags)
>> +{
>> +	char *count;
>> +
>> +	local_irq_save(*flags);
>> +	count = get_printk_count();
>> +	/* Only 1 level of recursion allowed. */
>
> We should allow at least some level of recursion. Otherwise, we would
> not see warnings printed from vsprintf code.

With 1 level, you will see warnings from vsprintf code. I'm not sure it
makes sense to allow more than 1 level. It causes exponential logging.

>> +	if (*count > 1) {
>> +		local_irq_restore(*flags);
>> +		return false;
>> +	}
>> +	(*count)++;
>> +
>> +	return true;
>> +}
>
> This should be unified with printk_context, printk_nmi_enter(),
> printk_nmi_exit(). It does not make sense to have two separate
> printk context counters.
>
> Or is there any plan to remove printk_safe and printk_context?

Yes, I plan to remove the safe buffers, which also removes printk_safe.c
and the printk_context "gate".

> BTW: I prefer to use the bitmask approach. It allows to check
> the normal context by a single operation (no bit is set).
> There is no need to go through all counters.

OK.

> Note that we need at least one more context for gdb.

Ah yes, thank you.

John Ogness
