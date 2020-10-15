Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C64228EDE9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 09:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgJOHwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 03:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbgJOHwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 03:52:06 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E94C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 00:52:06 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x7so2208963wrl.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 00:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pIIqF3rG0mMLMMV2BGG4gKCsXK1ncAM12/M5rg9O9DI=;
        b=HkHdg2eC0VICkGOjetUr1dVqtt6y2SKX8SJjno7O/41mlGnCGVFYUM/JVjN6/L628e
         eC03syETsQY7SjyUR6Ob3Mu3k10p72XO1H/Y0MYAd8S8YA3483jpeXSkbiU36H/yjvtM
         MnAL37OIF83Y9dxjZ+zz4w43kVbclC0kRwz1RWo8TKb2D3sZ/BiQdAm7xi5EB7zN50JB
         b88cTQSFpuAyntbnnFhZ/Uziir/aban1FEGcDah/qzafJUmZ8G0sb2upocWY9VljvPL8
         A6yrycVVX3M5spSQ2c0P5T1eofpEckJhxtlESfmtNDU5f8d88ZUZh+pPYOkTSE4wIY5G
         3BiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pIIqF3rG0mMLMMV2BGG4gKCsXK1ncAM12/M5rg9O9DI=;
        b=RTeyzaNZDBCnCBI2mrhfxAIu7dmf7Eq7G3eiVNpo9i9SilQx1BxZubi0k2MeFfVJpf
         iodHD4HuQcdFVKt4X8vg2vv1cGKz5rbcWtxxoiQs2uRInusidm3Ysp1lrieOTBk/Zzvl
         JmYnsP/a/VIPDNt9wsW8wNqt04OwXDd5IdsTi83i3s5D8luDba8zKQOFX6YfOWulpnYE
         t3guiyO2Q6eqcdIQYDsVWH70NeRF7ERjrgLMw5ZfzUp4If3lcOJOXIPYXd7OgD1Ej+GA
         nlsy4e7CtT30p8hyoDmsL1MKbj+EVQZHyNIwa0nDZ5pRRRtRtr8qVRStMOrNlaD90oRB
         Ao5g==
X-Gm-Message-State: AOAM532GdyIvmY7O6Zy6setpdNkgO4twmgtYSZGLdivtUdMZlHh+Wpgn
        FUcaZ9WDg9AriTctIS0me2KVptgvJVXf2snp
X-Google-Smtp-Source: ABdhPJy0NGcNmtsDCM1MdZMsWmFlDNGbQ647+dWKNaIpvo1IloyBDmihGB0I3Wvlhn65pv98UH7aJw==
X-Received: by 2002:adf:912e:: with SMTP id j43mr2708221wrj.325.1602748325233;
        Thu, 15 Oct 2020 00:52:05 -0700 (PDT)
Received: from alley (176-114-240-43.rychlydrat.cz. [176.114.240.43])
        by smtp.gmail.com with ESMTPSA id f6sm2992558wru.50.2020.10.15.00.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 00:52:04 -0700 (PDT)
From:   Petr Mladek <mladek.petr@gmail.com>
X-Google-Original-From: Petr Mladek <pmladek@suse.com>
Date:   Thu, 15 Oct 2020 09:52:02 +0200
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [GIT PULL] printk for 5.10 (includes lockless ringbuffer)
Message-ID: <20201015075202.GD13775@alley>
References: <20201012144916.GB10602@alley>
 <CAMuHMdXHFFUrjRMEHnXXU8QQkgD9x_S6R3N0Q7Q4H2RSfy2GGw@mail.gmail.com>
 <87lfg85xz1.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfg85xz1.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-10-14 23:01:30, John Ogness wrote:
> On 2020-10-14, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >> - Fully lockless ringbuffer implementation, including the support for
> >>   continuous lines. It will allow to store and read messages in any
> >>   situation wihtout the risk of deadlocks and without the need
> >>   of temporary per-CPU buffers.
> >
> >     linux-m68k-atari_defconfig$ bloat-o-meter vmlinux.old vmlinux.lockless_ringbuffer
> >     add/remove: 39/16 grow/shrink: 9/15 up/down: 214075/-4362 (209713)
> >     Function                                     old     new   delta
> >     _printk_rb_static_infos                        -  180224 +180224
> >     _printk_rb_static_descs                        -   24576  +24576
> 
> 131072 of _printk_rb_static_infos is reserved for dictionary usage. The
> rest (49152) is for the record meta data. Previously any dictionary
> usage and record meta data was embedded in the message buffer (log_buf,
> 65536).
> 
> Since the meta data is now separate, setting CONFIG_LOG_BUF_SHIFT=15
> would provide roughly the same amount of record storage as
> CONFIG_LOG_BUF_SHIFT=16 did with vmlinux.old. Then there would be:
> 
> 32768: message buffer
> 24576: meta data
> 65536: dictionary data
> 12288: descriptor data
> 
> Excluding the dictionary data, the total is 65536.
> 
> (With vmlinux.old there is 65536 total with CONFIG_LOG_BUF_SHIFT=16.)
>
> It is the reserved dictionary data that is hurting us here.
> 
> Should we provide a config option to kill the dictionary data?

This might be the best solution. AFAIK, they are currently
used only by journalctl. IMHO, most people are not aware of it
and it is not a widely used feature.


> Should CONFIG_LOG_BUF_SHIFT do an implicit -1 so that the sizes (without
> dictionary data) are about the same as before?

Beware that this might result in slightly reduced amount of stored
messages. The storage of the dictionary meta data is less effective
because they are not longer stored together with the messages and
we need to guarantee a space for them.

I would prefer to keep the current global default. In average,
the size of the systems is growing. They produce more messages
and have more memory available.

Yeah, the space hurts on small systems. We might modify the default
for them. Or we could allow to disable the dictionary.

Note that this is not the full picture of the printk memory usage.
I believe that we will be able to get rid of printk_safe and printk_nmi.
It would safe 16kB per-CPU at runtime.

If we make the dictionary optional and remove the per-CPU buffers
then we might end-up with less memory needs than before.

Best Regards,
Petr
