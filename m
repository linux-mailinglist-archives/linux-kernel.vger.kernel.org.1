Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E62C28EA68
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbgJOBoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729403AbgJOBoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:44:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CAEC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 13:55:32 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602708931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pjGI6H9agriY8l5DUZ66fy7If4bjx92jpFy4Tji1P+Q=;
        b=lUIm7QuZ8vsupAyZT7jr3RthxXVf/R/A651aPEYTr4ijryfyHCNyb4+4+rIB957Tgny3bT
        waB6BPwqhvHkFP3rJuj8OqGsYrt4coa6Gkutq76fTPTJyQnlVpu1HkkUt5PdxB8pwelxar
        9mz7P7YY+dA7EBi/FmqA/NHnfgpyrIoOi4QrqJsSQpTZm6iyKAUGW65zqA1kuIUZ+jUmZu
        9frbOdAshP7nLAv1IXXs3jEPw4KmBMZCWzs9ezHZ9rURkqenmXxYnjL1FuqZYXq5ccAjgd
        7AN+34YKCOhGd6tOEBwU+neaygffAYF8YJt+jZ1u4bgYDapoOqEwqM7xlLzawg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602708931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pjGI6H9agriY8l5DUZ66fy7If4bjx92jpFy4Tji1P+Q=;
        b=IvH1opAJBTH7APHNqHnZVuXCHqZqLBQUcoUpxy+8vK5QJQUZ5R9Jb0nl+TA5psm9M/LQuO
        5q1BGHK0SOwiVDBg==
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [GIT PULL] printk for 5.10 (includes lockless ringbuffer)
In-Reply-To: <CAMuHMdXHFFUrjRMEHnXXU8QQkgD9x_S6R3N0Q7Q4H2RSfy2GGw@mail.gmail.com>
References: <20201012144916.GB10602@alley> <CAMuHMdXHFFUrjRMEHnXXU8QQkgD9x_S6R3N0Q7Q4H2RSfy2GGw@mail.gmail.com>
Date:   Wed, 14 Oct 2020 23:01:30 +0206
Message-ID: <87lfg85xz1.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-14, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> - Fully lockless ringbuffer implementation, including the support for
>>   continuous lines. It will allow to store and read messages in any
>>   situation wihtout the risk of deadlocks and without the need
>>   of temporary per-CPU buffers.
>
>     linux-m68k-atari_defconfig$ bloat-o-meter vmlinux.old vmlinux.lockless_ringbuffer
>     add/remove: 39/16 grow/shrink: 9/15 up/down: 214075/-4362 (209713)
>     Function                                     old     new   delta
>     _printk_rb_static_infos                        -  180224 +180224
>     _printk_rb_static_descs                        -   24576  +24576

131072 of _printk_rb_static_infos is reserved for dictionary usage. The
rest (49152) is for the record meta data. Previously any dictionary
usage and record meta data was embedded in the message buffer (log_buf,
65536).

Since the meta data is now separate, setting CONFIG_LOG_BUF_SHIFT=15
would provide roughly the same amount of record storage as
CONFIG_LOG_BUF_SHIFT=16 did with vmlinux.old. Then there would be:

32768: message buffer
24576: meta data
65536: dictionary data
12288: descriptor data

Excluding the dictionary data, the total is 65536.

(With vmlinux.old there is 65536 total with CONFIG_LOG_BUF_SHIFT=16.)

It is the reserved dictionary data that is hurting us here.

Should we provide a config option to kill the dictionary data?

Should CONFIG_LOG_BUF_SHIFT do an implicit -1 so that the sizes (without
dictionary data) are about the same as before?

Maybe dictionaries should only exist in the dynamically allocated
ringbuffer?

John Ogness
