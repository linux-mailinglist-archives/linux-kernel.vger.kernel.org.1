Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E8E28E209
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 16:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389010AbgJNOQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 10:16:46 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:36867 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731507AbgJNOQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 10:16:42 -0400
Received: by mail-oo1-f67.google.com with SMTP id f19so823130oot.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 07:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AC8HS2z8T98nEugT5efb+X+wCmYYZ6+WNEVgjuczYIg=;
        b=kjABU/YpboSTW8mXbk/SRBNX8vsrN4xh/GVsd0KhbiO0IEY3uYGlKb2c/T6Zy3aRip
         Z9LMRawccDQ8eo2wbSFsiWFmH4j89wQg+nB4Ej4r40Z3jsFvvmvsO5rb05p9yrjLB8Fe
         HKipvjkoFhVVmr1zyUmed8FC6Hdpk2XU4/OlX9ZOIOTJ6pT6KtiLgJ+P7q+eh7WRpdoC
         863FCqH2KJ0e/KC96gPvqBOIKnEohe1LCgVsMLw5qYNFglACYFllpXcaT8a3CsJP2c1g
         jONksyrnQH5FmZU+otOh0Po2ATDlL6xhHc/KSfzXKU3saVqhpIx2Kt/cXOgboj3mDj6q
         D49w==
X-Gm-Message-State: AOAM532uWlIMObzWVU6xxEUKxu48pLfHBjn1/3+pcnyIAawuv74Tpu0w
        z5HwcylS1yGR9Z7RRle1Q9HK284F1T28nqN8jnk=
X-Google-Smtp-Source: ABdhPJzR9vzQaAGQ+U5oIafEX82tCF9xHeYF2/XGwS+mhL2wLyjwukN1MdBepRIU33FiyJ+GPi7iQKhQvqj8O0AwADM=
X-Received: by 2002:a4a:dbd3:: with SMTP id t19mr3724339oou.40.1602685000238;
 Wed, 14 Oct 2020 07:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201012144916.GB10602@alley>
In-Reply-To: <20201012144916.GB10602@alley>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 14 Oct 2020 16:16:29 +0200
Message-ID: <CAMuHMdXHFFUrjRMEHnXXU8QQkgD9x_S6R3N0Q7Q4H2RSfy2GGw@mail.gmail.com>
Subject: Re: [GIT PULL] printk for 5.10 (includes lockless ringbuffer)
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Mon, Oct 12, 2020 at 4:50 PM Petr Mladek <pmladek@suse.com> wrote:
> - Fully lockless ringbuffer implementation, including the support for
>   continuous lines. It will allow to store and read messages in any
>   situation wihtout the risk of deadlocks and without the need
>   of temporary per-CPU buffers.

    linux-m68k-atari_defconfig$ bloat-o-meter vmlinux.old
vmlinux.lockless_ringbuffer
    add/remove: 39/16 grow/shrink: 9/15 up/down: 214075/-4362 (209713)
    Function                                     old     new   delta
    _printk_rb_static_infos                        -  180224 +180224
    _printk_rb_static_descs                        -   24576  +24576
    [...]

Seriously?!? Or am I being misled by the tools?

    linux-m68k-atari_defconfig$ size vmlinux.old vmlinux.lockless_ringbuffer
       text    data     bss     dec     hex filename
    3559108 941716 177772 4678596 4763c4 vmlinux.old
    3563922 1152496 175276 4891694 4aa42e vmlinux.lockless_ringbuffer

Apparently not...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
