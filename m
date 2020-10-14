Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BEE28E2D2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbgJNPHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:07:53 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33969 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgJNPHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:07:53 -0400
Received: by mail-oi1-f193.google.com with SMTP id w204so3577273oiw.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 08:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+++v1uYKIqqkhsTVwIx8O5YBXIudVcProF+d+S7NWQ=;
        b=al9e1i/Wg8H/SQS8KdnabmlC7YviAXoFUfKpTn/cepogiNOEbRrQpmI7hgfX7jR75G
         /95r7nvY7+9WFrfZ6ZsvOtMU56ozHWR6dDg/6nd59Kqn52WAAhHj7gtNyX1RcAFOu26+
         4w13sSsOCa5t5M5Rx2o0nIGotzqUGzE/v1PqUwFQJu9FnOKeOPWB76UTp+M23h4OcQpI
         gGWQDHPXb5XtqBlc7VRHdd+t4nRit/FXhv5rclgByPpSq2/oib8ieQ51QfO/H1M+6xoK
         hwWfmw2K/76dT3BrCYhnx2MnqFGldf3sx9rYob5C6uy3WtN3GkWdPyJVf52ntr2dUOG5
         lmRQ==
X-Gm-Message-State: AOAM532XvthqDQHhnbJBVRPbjPiBHKN+wemKMQAdsf++Y93zYoMBrl0p
        /qBlxa7SV7NUMmFU13X/3FBgvcAi+wlk1hHROR8=
X-Google-Smtp-Source: ABdhPJzTxoM9/m3uQBBibTTDTuJTWszhApH+4WyQ5Srv0GWnVLW7vNDV7X/fDtDG0X5xhdaKfhJenIpMO7Kj3C6OuVU=
X-Received: by 2002:aca:4441:: with SMTP id r62mr2367404oia.153.1602688072436;
 Wed, 14 Oct 2020 08:07:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201012144916.GB10602@alley> <CAMuHMdXHFFUrjRMEHnXXU8QQkgD9x_S6R3N0Q7Q4H2RSfy2GGw@mail.gmail.com>
 <49292e1a-7e46-b078-d15d-fb2f406317db@rasmusvillemoes.dk>
In-Reply-To: <49292e1a-7e46-b078-d15d-fb2f406317db@rasmusvillemoes.dk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 14 Oct 2020 17:07:41 +0200
Message-ID: <CAMuHMdWtnWNBoCETxO_egcQ7qzbn6Ckd-RD6=-fmZAmwUTHnHA@mail.gmail.com>
Subject: Re: [GIT PULL] printk for 5.10 (includes lockless ringbuffer)
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

On Wed, Oct 14, 2020 at 4:58 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> On 14/10/2020 16.16, Geert Uytterhoeven wrote:
> > On Mon, Oct 12, 2020 at 4:50 PM Petr Mladek <pmladek@suse.com> wrote:
> >> - Fully lockless ringbuffer implementation, including the support for
> >>   continuous lines. It will allow to store and read messages in any
> >>   situation wihtout the risk of deadlocks and without the need
> >>   of temporary per-CPU buffers.
> >
> >     linux-m68k-atari_defconfig$ bloat-o-meter vmlinux.old
> > vmlinux.lockless_ringbuffer
> >     add/remove: 39/16 grow/shrink: 9/15 up/down: 214075/-4362 (209713)
> >     Function                                     old     new   delta
> >     _printk_rb_static_infos                        -  180224 +180224
> >     _printk_rb_static_descs                        -   24576  +24576
> >     [...]
> >
> > Seriously?!? Or am I being misled by the tools?
> >
> >     linux-m68k-atari_defconfig$ size vmlinux.old vmlinux.lockless_ringbuffer
> >        text    data     bss     dec     hex filename
> >     3559108 941716 177772 4678596 4763c4 vmlinux.old
> >     3563922 1152496 175276 4891694 4aa42e vmlinux.lockless_ringbuffer
> >
> > Apparently not...
>
> Hm, that's quite a lot. And the only reason the buffers don't live
> entirely in .bss is because a few of their entries have non-zero
> initializers.

Even if this would live in BSS, it would still consume 200 KiB of RAM.
Or am I missing something?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
