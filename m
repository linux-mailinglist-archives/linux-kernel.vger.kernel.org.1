Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B4829FF6C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 09:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgJ3IJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 04:09:09 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37531 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3IJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 04:09:08 -0400
Received: by mail-yb1-f194.google.com with SMTP id h196so4423988ybg.4;
        Fri, 30 Oct 2020 01:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/jzjKrd2GSFI2jORP6qlsLl+sejwVXANXoHe0KfMn0=;
        b=UQH25hvagVGSdccd5gmk8rBs2vwkNop09Lhs6mwDbriqGPAvUiB96KXrdeqqsTDj6A
         PWxytEMToIkQF7DIoziQx9xBuVGhXw5F3okEXWWSqiUNIL7lunsEItAoyHmFQ626+eqo
         6Dqv0q8iPCD/jyeABEx9N59GlTZ+p67qImNQYTGT+5BLvGBUX/XVLVxB5VZQakBsdQyP
         zoLH+iqz/D0klsn2dLX34mbySUCIcCbcTKnqHP5uvfUgEGrhQwo1Dze21QUXkUu9Zm8c
         wiBocvNnjd6FW7ss4F0XIwROpweOxZp8G7zoNE7E3e+Nb4/bp39y5cYuqOnOdCCyFU9C
         IMUw==
X-Gm-Message-State: AOAM531+bVnm2zKWbRy5+kJRLaYjFH8C8+h7wfBXpwA8QZqvLFQeR2JX
        awKPk8hgd0DRt7Y9oApm0xy54X2FFX+xMnmeBqTKp0zHtaZF/w==
X-Google-Smtp-Source: ABdhPJyroTn2hs8jXpOD6BmbCWkQFZDlqvELgCsyP8SvMUf3WczXlOpvoh9Rk8Bijl+J/NHtvz7DYPpJepHo+4MUsm0=
X-Received: by 2002:a9d:3b76:: with SMTP id z109mr754329otb.250.1604044886252;
 Fri, 30 Oct 2020 01:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200811092924.6256-1-pmenzel@molgen.mpg.de> <20200811092924.6256-2-pmenzel@molgen.mpg.de>
 <20200811105352.GG6215@alley>
In-Reply-To: <20200811105352.GG6215@alley>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 30 Oct 2020 09:01:15 +0100
Message-ID: <CAMuHMdVfxiJ8evasLQ6Hc59jMJdU7R6Eyn7X3rM20O3T4Z6nKg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] init/Kconfig: Increase default log buffer size
 from 128 KB to 512 KB
To:     Petr Mladek <pmladek@suse.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Embedded <linux-embedded@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 12:55 PM Petr Mladek <pmladek@suse.com> wrote:
> On Tue 2020-08-11 11:29:24, Paul Menzel wrote:
> > Commit f17a32e97e (let LOG_BUF_SHIFT default to 17) from 2008 was the
> > last time, the the default log buffer size bump was increased.
> >
> > Machines have evolved, and on current hardware, enough memory is
> > present, and some devices have over 200 PCI devices, like a two socket
> > Skylake-E server, resulting a lot of lines.
> >
> > Therefore, increase the default from 128 KB to 512 KB. Anyone, with
> > limited memory, can still lower it.
> >
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -681,9 +681,9 @@ config IKHEADERS
> >         kheaders.ko is built which can be loaded on-demand to get access to headers.
> >
> >  config LOG_BUF_SHIFT
> > -     int "Kernel log buffer size (16 => 64KB, 17 => 128KB)"
> > +     int "Kernel log buffer size (17 => 128KB, 19 => 512KB)"
> >       range 12 25
> > -     default 17
> > +     default 19
> >       depends on PRINTK
> >       help
> >         Select the minimal kernel log buffer size as a power of 2.
>
> Honestly, I do not have experience with changing the defaults. People
> hacking small devices might complain. Well, this can be solved
> by increasing the default only when BASE_FULL is set.
>
> I am personally fine with increasing the default when BASE_FULL
> is set. The amount of messages is growing over time because of
> increasing complexity of both the hardware and software.
> Fortunately also the amount of available memory is growing.

Note that making this change means that some of the embedded
defconfigs may need to gain a CONFIG_LOG_BUF_SHIFT=17
line...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
