Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE732EB8FE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 05:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbhAFEf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 23:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbhAFEfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 23:35:55 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F96C06134C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 20:35:15 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id i5so1405474pgo.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 20:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0jZbWD+sHK2GdWV/CUfefgawgJK/eGwztAnh5wrZIDg=;
        b=e49I3amGEEQbWoPzQpGgiyM82/JwRi3TmzYiIu71mWZMeD9cLdyDHHneOsCo4bGoyb
         JEwGp13KKX+dOOIz4oBCZ0QzmtAsOdWIvHgKAoqw/zJ4P4/akalOoY1NOrStWAuN+b0H
         HDIDBmc0N08ZGAezGW3I9KUaGlbulHaBtdevif1RV/2MhRiZpAb/g8AzIXlux+GI7ow9
         VTDGNj/E+D7mpmM114VgA2sO3Z3I+cdr6Iov3m17EeXHhzjMZUuT9TPHMFUPhG2gooMd
         6KNuba+O28y6Qu7gbyf4NefmL9NrLAz+VRiL8I5xm+NNT/C5nXVXwBAtYSCGc5KlIVPy
         3nwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0jZbWD+sHK2GdWV/CUfefgawgJK/eGwztAnh5wrZIDg=;
        b=fT5cnjIfO6Z6cEcsx8LZPYAPTIsoASD8bvIin++R5GmiU1HgzgKcc4it1OBF69BAoy
         wLJq1a+zIRzhcmlAYThznjePXtDn8IQodkli934eCbw82vfn556gFlcvPMqZoXSupNXB
         i8M0MU6YpaHjA0SDmpwcFRkOCO/++PV8KRa0mYvAtDP4fUQc8znNNVasnzgo1XbyDMzv
         bHgWLstoY9BQgjkLELyc6UziXThIddrYer4oKGKzObYPZi8AWdv8ohGtpO8NfpjgzIZI
         Sy+AundSHtS8PdNYwjxyHxrdTCBRwixucniQeiWgulGba6hF4+YhcyZBEORhHcL0nvy9
         SdrA==
X-Gm-Message-State: AOAM531ictEif5f4wnQdq+/8f0LNufe5LUFO/TVtGgYs0UiL5XpIhfd6
        hpITnhDUJW7qoEC3rGk3+bs=
X-Google-Smtp-Source: ABdhPJzAzO/AR5pYurC3nPtm4+x7dCWobfUGcfWgeDQjQ+mad39HlBjM0nJkEPZ33deCU+4ljhI2MQ==
X-Received: by 2002:a63:5d10:: with SMTP id r16mr2476110pgb.406.1609907714470;
        Tue, 05 Jan 2021 20:35:14 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id 193sm832263pfz.36.2021.01.05.20.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 20:35:13 -0800 (PST)
Date:   Wed, 6 Jan 2021 13:35:11 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     =?utf-8?Q?=E2=80=9CWilliam?= Roche <william.roche@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v1] panic: push panic() messages to the console even from
 the MCE nmi handler
Message-ID: <X/U9/yawcAoXQ7qG@jagdpanzerIV.localdomain>
References: <1609794955-3661-1-git-send-email-william.roche@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1609794955-3661-1-git-send-email-william.roche@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/01/04 16:15), “William Roche wrote:
[..]
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 332736a..eb90cc0 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -166,6 +166,15 @@ static void panic_print_sys_info(void)
>  		ftrace_dump(DUMP_ALL);
>  }
>  
> +/*
> + * Force flush messages to the console.
> + */
> +static void panic_flush_to_console(void)
> +{
> +	printk_safe_flush_on_panic();
> +	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> +}

You must debug_locks_off() as the very first step here. But see below.

>  /**
>   *	panic - halt the system
>   *	@fmt: The text string to print
> @@ -247,7 +256,7 @@ void panic(const char *fmt, ...)
>  	 * Bypass the panic_cpu check and call __crash_kexec directly.
>  	 */
>  	if (!_crash_kexec_post_notifiers) {
> -		printk_safe_flush_on_panic();
> +		panic_flush_to_console();
>  		__crash_kexec(NULL);

It's dangerous to call console_flush_on_panic() before we stop secondary
CPUs. console_flush_on_panic() ignores the state console_sem, so if any
of the secondary is currently printing something on the consoles you'll
get corrupted messages - we use `static char buffer` for messages we
push to consoles.

Another issue is that with this panic_flush_to_console() call console_sem
can end up being locked once (by secondary CPU) and unlocked twice (by
second and panic CPUs) [*]

>  		/*
> @@ -271,9 +280,8 @@ void panic(const char *fmt, ...)
>  	 */
>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>  
> -	/* Call flush even twice. It tries harder with a single online CPU */
> -	printk_safe_flush_on_panic();
>  	kmsg_dump(KMSG_DUMP_PANIC);
> +	panic_flush_to_console();

Why?

>  	/*
>  	 * If you doubt kdump always works fine in any situation,
> @@ -298,7 +306,7 @@ void panic(const char *fmt, ...)
>  	 * buffer.  Try to acquire the lock then release it regardless of the
>  	 * result.  The release will also print the buffers out.  Locks debug
>  	 * should be disabled to avoid reporting bad unlock balance when
> -	 * panic() is not being callled from OOPS.
> +	 * panic() is not being called from OOPS.
>  	 */
>  	debug_locks_off();
>  	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
> @@ -314,6 +322,7 @@ void panic(const char *fmt, ...)
>  		 * We can't use the "normal" timers since we just panicked.
>  		 */
>  		pr_emerg("Rebooting in %d seconds..\n", panic_timeout);
> +		panic_flush_to_console();

[*] So this

>  		for (i = 0; i < panic_timeout * 1000; i += PANIC_TIMER_STEP) {
>  			touch_nmi_watchdog();
> @@ -347,6 +356,7 @@ void panic(const char *fmt, ...)
>  	disabled_wait();
>  #endif
>  	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
> +	panic_flush_to_console();

[*] and this are both very interesting points.

Those extra console_flush_on_panic() calls indicate that normal printk()
cannot succeed in locking the console_sem so it doesn't try to
console_unlock(): either because we killed the secondary CPU while it
was holding the lock, or because we locked it once and unlocked it twice.

I think it would make sense to just re-init console_sem, so that normal
printk()-s will have chance to grab the console_sem lock and then we don't
need any extra panic_flush_to_console() calls. Maybe we can do something
like this

---

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ffdd0dc7ec6d..4bd2e29c8cc0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2638,6 +2638,7 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	 * context and we don't want to get preempted while flushing,
 	 * ensure may_schedule is cleared.
 	 */
+	sema_init(&console_sem, 1);
 	console_trylock();
 	console_may_schedule = 0;
 
