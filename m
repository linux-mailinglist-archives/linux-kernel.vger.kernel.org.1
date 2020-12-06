Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6A92D0722
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 21:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgLFUpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 15:45:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60010 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgLFUpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 15:45:42 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607287500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9VZi8ujgSXh7HIp+A/M1SLGnPCwni73lR3eHRtUwCWY=;
        b=ofok/O4wUx96kxGzktfjjsXjM0RwhH5BYoBhxBzcZxXhL5QTp+3pQhH/ZKf5DH4AXZVSxm
        DVTO5lAFQEseZRlV4vrp9mIbySJpf0zj9kUSrTehE1dH2boD7rRMUraJpcGzXo9usxFDCv
        J2rZBWYHGi+ucY3pxRAxuxqmnUVAWrk9KYLVaOOjFo33Ugtv+5Hib04YRnTDm7g9hTciE1
        lJ33iOh8MyJBaA/bReBRhnNhLP7hqVVoi410xeQr8lMQflGsEgVp/tGL7lGtejS26krb9B
        At85Yd7IAS4lvQAd0exv0pjLSluiZYS4aHkuHB+HBC3i2s5ne77Kh+UblhvGYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607287500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9VZi8ujgSXh7HIp+A/M1SLGnPCwni73lR3eHRtUwCWY=;
        b=Q4+e3lr8qNXgBt+cSsykW8rCoe4wJCM2jSDQK3fKxULchtdTVGVIMKAuqyVUCzPOXsvTUM
        sDSbIKgkm714oNDQ==
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 3/3] printk: remove logbuf_lock, add syslog_lock
In-Reply-To: <X8naJzXN9HtiG3c8@jagdpanzerIV.localdomain>
References: <20201201205341.3871-1-john.ogness@linutronix.de> <20201201205341.3871-4-john.ogness@linutronix.de> <X8naJzXN9HtiG3c8@jagdpanzerIV.localdomain>
Date:   Sun, 06 Dec 2020 21:50:59 +0106
Message-ID: <871rg2oe9g.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-04, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
>> +static char *get_printk_count(void)
>
> A nit: I think get_foo() has some sort of special meaning and one
> would expect that there should be put_foo() as well, and that those
> have something to do with the ref counting.

OK. How about:

static char *printk_recursion_counter(void)

?

>> +static bool printk_enter(unsigned long *flags)
>
> This better explicitly state that it disables local IRQs
>
> 	printk_enter_irqsave()
>
> I'm not very certain that printk_enter/printk_exit are best names:
>
> 	if (!printk_enter())
> 		return;
>
> Maybe it can spell out why we couldn't enter printk so the function
> name can contain recursion_limit or something.

printk_recurse_irqsave() ?

I would prefer printk_enter_irqsave() and just add comments that say it
is checking the recursion level. It is only used in one place.

>> +static void printk_exit(unsigned long flags)
>
> This enables local IRQs, so
>
> 	printk_exit_irqrestore()

Yes, I like that.

John Ogness
