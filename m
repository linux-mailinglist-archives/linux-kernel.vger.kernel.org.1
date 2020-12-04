Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE7C2CE839
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 07:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgLDGmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 01:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLDGme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 01:42:34 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBA8C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 22:41:48 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id o9so3020619pfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 22:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vsi6NiahvyRDxgNsHen914koOHBTiwKcV13MUlInbBw=;
        b=E2ozQqInpzxG5Yl3R3HJbztG0Y9RUH6zb/72rHDi/dI2dMtn5uJkjKCaR0iu5hhBbu
         tuZi2IqTLNJRXUAJN5L0bdn5mm9gx87lpVxbQ4RCF9fOtSGFlYnyKe+I95TjCwbg7yZs
         WnbfFY6FlXqB0cATfZlKK44DziOli4afmjjtGCFhQlWIJQSUhqJhuNyioeTkejxoTDMB
         JGdq5CHsuDvO6JLtJuJDejd5GMxQ440ocEB8RHZ1C+NMUlQOF86QjxNV7cqmaRBCwVpU
         XZAuZ2mhSkmx1MXW+S6xPq252E3/+KMGWopVSetkVwzeotdxWzq7ryAs4+cdEMzz8u19
         oOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vsi6NiahvyRDxgNsHen914koOHBTiwKcV13MUlInbBw=;
        b=HrjsSL3nnu404fBDJDinmCc1Dfkl1h66JilCFtRwQ9ejhS/hRFlXrGPrAyh1qWmSKn
         ndoT/4THrShWCdkvxgF4V8LKc1+q32gtx24C+ZfT0Q2V0MHcNADYfe110g0xdPCO3e7w
         c0rIdMTfyexdWoYgCEIK0XZASp9xqHd02LG+B19VqxQ0YePE6BY0vb0lUs0lEdupReKz
         B+e+AowB4BUpEHTGIxLZFToL9kSGjTNkgJRYprV6mXoNKVB3J+deR1Bzj/qKAc9LgVf5
         IpYnlf7ewDO7It0W/rG+twL7Wyo0CBifbF67UJbrapwNEnVlZYX5lOgVmG3vZwY7Ty39
         xXpA==
X-Gm-Message-State: AOAM533BTe2T9Pzpqh11NsMOmQ2c/5Niq9YIeogAf7Avkx7xkpajoyD8
        Q5e9VJOxXxwt4Gt9F7UFpos=
X-Google-Smtp-Source: ABdhPJxLr9RQds044zStiEdVbLLohLuFgfPv/6DtWX1i/H+j9l7k7xnyJo4tnVdwp2+bGZbYAN0E/A==
X-Received: by 2002:a63:715:: with SMTP id 21mr6405299pgh.150.1607064108118;
        Thu, 03 Dec 2020 22:41:48 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id h7sm3718913pfq.76.2020.12.03.22.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 22:41:47 -0800 (PST)
Date:   Fri, 4 Dec 2020 15:41:43 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 3/3] printk: remove logbuf_lock, add syslog_lock
Message-ID: <X8naJzXN9HtiG3c8@jagdpanzerIV.localdomain>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201205341.3871-4-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/12/01 21:59), John Ogness wrote:
>  
> +#ifdef CONFIG_PRINTK_NMI
> +#define NUM_RECURSION_CTX 2
> +#else
> +#define NUM_RECURSION_CTX 1
> +#endif
> +
> +struct printk_recursion {
> +	char	count[NUM_RECURSION_CTX];
> +};
> +
> +static DEFINE_PER_CPU(struct printk_recursion, percpu_printk_recursion);
> +static char printk_recursion_count[NUM_RECURSION_CTX];
> +
> +static char *get_printk_count(void)

A nit: I think get_foo() has some sort of special meaning and one would
expect that there should be put_foo() as well, and that those have
something to do with the ref counting.

> +{
> +	struct printk_recursion *rec;
> +	char *count;
> +
> +	if (!printk_percpu_data_ready()) {
> +		count = &printk_recursion_count[0];
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
> +
> +	return count;
> +}
> +
> +static bool printk_enter(unsigned long *flags)

This better explicitly state that it disables local IRQs

	printk_enter_irqsave()

I'm not very certain that printk_enter/printk_exit are best names:

	if (!printk_enter())
		return;

Maybe it can spell out why we couldn't enter printk so the function
name can contain recursion_limit or something.

> +{
> +	char *count;
> +
> +	local_irq_save(*flags);
> +	count = get_printk_count();
> +	/* Only 1 level of recursion allowed. */
> +	if (*count > 1) {
> +		local_irq_restore(*flags);
> +		return false;
> +	}
> +	(*count)++;
> +
> +	return true;
> +}
> +
> +static void printk_exit(unsigned long flags)

This enables local IRQs, so

	printk_exit_irqrestore()

> +{
> +	char *count;
> +
> +	count = get_printk_count();
> +	(*count)--;
> +	local_irq_restore(flags);
> +}

	-ss
