Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D675329819D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 13:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415669AbgJYMVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 08:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393967AbgJYMVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 08:21:31 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EBCC0613CE;
        Sun, 25 Oct 2020 05:21:30 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id p15so7092121ioh.0;
        Sun, 25 Oct 2020 05:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g8KrN20/xQjVk7r3KMHGneSGRzTdCMB0+bYafbj2+Nw=;
        b=LHVC3ji/HQ/64M2gA4rJz3OfH4a7SQjaJVtuTac1Ab2Zcx7nFxVZlPaedjqXhvfEaA
         ooEjn7HUu8z7H5ZgYBtt/cVjehQD8ljUDbizr9Y8CQeZmkvZ2Uwa6U1c++kO4Do0ve7p
         XKeqC0QdWMaT8MqlxHErI92hJ+YAe2+E/+eUuidVqRDpXlTOkilYRyzkbhcHCLRiawlt
         dyl6VlQb9k3DanzjBNgEA4spIpXXbm3u+Gdo2EYMakaAtMxgOlrbGVHovWmoRDcvfRcF
         Ak78UOfX22Jxyt0Zqxg8qf3d+DYE5DQ5wljNAoAdtf8Ini7QvsA6cR+CuIDv2/S4aCBl
         HPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g8KrN20/xQjVk7r3KMHGneSGRzTdCMB0+bYafbj2+Nw=;
        b=NM3bzOn/6UudDFuZCvjUBovW6+9W1jrxW7Z5Xn4xjib55Rc/7BFIH8ZyqHF14dG7YQ
         6W2W7w9BJe/STwqvGiutyiOa+f50hBiLzHumL7yLXis7UVu7tKT5xnq2F5Ws77CgSSER
         REIEZ8kc898CAH7evM077WrZwzMFhphkFP6JVTAFgHS7pe3ziV2H2TPhUzUBzUFaGCaI
         NUJWz2BPBBOUlPFAFyyIoPT9ZX/cf9yuuIiWA5Mu7mGWp6bQ0frnew4iDklLUFOsWpUi
         fCLEPt0+MFlZG1Fa+xbZ8MbhW4n38Mn4KSm2F7oWn/KGlZnQ1ZBAlpcVS0VDHGC7SuJG
         5Ybg==
X-Gm-Message-State: AOAM530+C8XiUZkWOSA2EKbldtzwCLz0GIDwnbBZpafvKrgOSuYhYkTJ
        QjnaZ6yXo4h2uSlnLJ72EGpBlffIJdwRA38y1rU=
X-Google-Smtp-Source: ABdhPJy6c2KkPXC/FK5wQMUEVMVjPMh+JzTdlizPpffGzlz1YIKDPQek4r5GLpB4qHZWIWLzXEOzc9KiY4G+Lh0my3M=
X-Received: by 2002:a05:6602:2f04:: with SMTP id q4mr7315858iow.75.1603628490048;
 Sun, 25 Oct 2020 05:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
 <871rhq7j1h.fsf@nanos.tec.linutronix.de> <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com>
In-Reply-To: <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Sun, 25 Oct 2020 23:21:18 +1100
Message-ID: <CAOSf1CG=Pvr8Yw_+6J3c4VOD0QJwv58iRtSAqBFpeZM6S=7Viw@mail.gmail.com>
Subject: Re: [Skiboot] [PATCH 0/3] warn and suppress irqflood
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <mkshah@codeaurora.org>,
        Petr Mladek <pmladek@suse.com>,
        Oliver Neukum <oneukum@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 25, 2020 at 10:22 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> On Thu, Oct 22, 2020 at 4:37 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Thu, Oct 22 2020 at 13:56, Pingfan Liu wrote:
> > > I hit a irqflood bug on powerpc platform, and two years ago, on a x86 platform.
> > > When the bug happens, the kernel is totally occupies by irq.  Currently, there
> > > may be nothing or just soft lockup warning showed in console. It is better
> > > to warn users with irq flood info.
> > >
> > > In the kdump case, the kernel can move on by suppressing the irq flood.
> >
> > You're curing the symptom not the cause and the cure is just magic and
> > can't work reliably.
> Yeah, it is magic. But at least, it is better to printk something and
> alarm users about what happens. With current code, it may show nothing
> when system hangs.
> >
> > Where is that irq flood originated from and why is none of the
> > mechanisms we have in place to shut it up working?
> The bug originates from a driver tpm_i2c_nuvoton, which calls i2c-bus
> driver (i2c-opal.c). After i2c_opal_send_request(), the bug is
> triggered.
>
> But things are complicated by introducing a firmware layer: Skiboot.
> This software layer hides the detail of manipulating the hardware from
> Linux.
>
> I guess the software logic can not enter a sane state when kernel crashes.
>
> Cc Skiboot and ppc64 community to see whether anyone has idea about it.

What system are you using?

There's an external interrupt pin which is supposed to be wired to the
TPM. I think we bounce that interrupt to FW by default since the
external interrupt is sometimes used for other system-specific
purposes. Odds are FW doesn't know what to do with it so you
effectively have an always-on LSI. I fixed a similar bug a while ago
by having skiboot mask any interrupts it doesn't have a handler for,
but I have no idea when that fix will land in a released FW build. Oh
well.
