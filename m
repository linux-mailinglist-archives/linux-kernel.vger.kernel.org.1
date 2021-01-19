Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73222FB812
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391954AbhASLzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 06:55:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34034 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390178AbhASLpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:45:34 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611056687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=utL8UxlPCpk/07YjUgieC46PewvCgHyuan1ont6LOtI=;
        b=Ac8bzvk56W92wah8bLK27PuYbqb90tbIlmgn17KPvfmQNCmpZ8S3xXPThJps2I7mdNbJmz
        BBvbcyBIzQgg45T02/reRsdLa3whZOWtkhBpQhkRjWf4l2S9r82THP+hJoeuNEHSaFDx33
        Hx7pFReT2JUZ/vg+QamjFXwrfnvfehzUyNT/N015Rzy52yTS004UdqkQYrf9gYPHutnsNE
        8X+hvu45hL9opjsLw8HPq58pzAksM8BH00KyHn/MATTTBRj/eueQgq4zBsQga30zAQAE1a
        V3Fot4hOqQ+3e861WCqhXlui3cqsv60mmx4pJbPAxwrBjwqQ2Szy65s0aKHWSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611056687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=utL8UxlPCpk/07YjUgieC46PewvCgHyuan1ont6LOtI=;
        b=iNY7OASrO377LOVNOz5HI32Oivlm8NoMGM8vJHsNHNYV3MUYX17x2m2YjvGInFOS6zUA0t
        k0Zpc/4sSwGeCMDw==
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: fix buffer overflow potential for print_text()
In-Reply-To: <YAa0j9CG/6yrGcs+@jagdpanzerIV.localdomain>
References: <20210114170412.4819-1-john.ogness@linutronix.de> <YAGE1O/nG57hyRs4@alley> <YAGFebfPNLwjyhcl@alley> <YAYriDiAl7lajty9@jagdpanzerIV.localdomain> <87r1mh5mso.fsf@jogness.linutronix.de> <YAa0j9CG/6yrGcs+@jagdpanzerIV.localdomain>
Date:   Tue, 19 Jan 2021 12:50:47 +0106
Message-ID: <87bldl5exc.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-19, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
>>> John, how did you spot these problems?
>> 
>> I am preparing my series to remove the logbuf_lock, which also
>> refactors and consolidates code from syslog_print_all() and
>> kmsg_dump_get_buffer(). While testing/verifying my series, I noticed
>> the these oddities in the semantics and decided I should research
>> where they came from and if they were actually necessary.
>
> Any chance you can put those tests somewhere public so that we can
> run them regularly?

I have a collection of hacked-together tools that I use to test most of
the various interfaces of printk. I would need to clean them up if they
should be used for any kind of automated regression testing.

And where should I make such things available? I could put them in a
repo in the Linutronix github account (like I did for the ringbuffer
stress testing tool). (??)

John
