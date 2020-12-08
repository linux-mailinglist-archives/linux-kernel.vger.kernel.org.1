Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1162D33D7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731174AbgLHUQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:16:06 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39572 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730495AbgLHUMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:12:50 -0500
Received: by mail-qk1-f196.google.com with SMTP id q22so17224799qkq.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 12:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ry0RMMRI6lcJmXGqls40K/Cni7b/pY976045DAMxl2Y=;
        b=DIBzqTuyEQ8pabG0pQeroxSjIG+k7y6lgeY6qSxlmmBQL3kfPEu4qCIL3QvRTTwXID
         yZT2SiEwlb1l8WhoBaVRTWJWVYaTMIl2RPLig0/a5ry0v/r4HqJvy1rRW//pLmKekM9T
         2qonCOQqP/f2YIei8QdsdlRIVNIKgSU/4kiobj/HBwDR5KqDgq5iJDXQLVQu+aRq2nFV
         Zp5sTNEZ1Rx3YR26hQ+CoRkAkEfueDBQ3guNXb8kTvs6IxsuyuKvUxRqTsq2vx+vLOlM
         9sRio+v15Z+a9gMVpX22nHZi/x8BI9gZTJBkHH9ZLEccMwjjBL7faYWRLn6cGuJUMQQF
         9Sgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ry0RMMRI6lcJmXGqls40K/Cni7b/pY976045DAMxl2Y=;
        b=rY+JHrOYNvVr72S6PdlAXErzeOzdxxXK10U617Gx45CgfJr0Iyy0VKDN0viC7oR8B5
         UXiurfPaixMMMlOJvq4vII1u3hvJTdKhEoPwHRSv1eIfXGilxuX07VfGHSH0NdZJ3+p1
         Y++OQ71Fs62TKOR4JAciPD2+Hu7eoyBg2JokB7orc5OspcaB4sQ0cMfAPpVptxBchWdB
         Wlpc27NwLMiDDcrSTH5Vx0ZI/AAJqTdSkeoO+YAHrcSP4TnN1iOlnHPqMH7UVDuGHJXs
         M1Z8izvFxbTO3DyBmjRUEx2zJ4tNnlDsDL5efu6nXnYTOt/Wk7gHhEL2OfIunSA/PyyT
         zhJQ==
X-Gm-Message-State: AOAM531AzKY1rgnmcTc+LcaEwi9wvKIsJDdxJIDJwu4KxesN1Nhqa9bC
        nZOzqbCp+n/ExzkpDV+i0P2JeaxKbPJmjVBKDNLDrG/PKlhJUeu7
X-Google-Smtp-Source: ABdhPJxze+863Tc5BBQQ6G3CBEuPNUuV3WUaoG6kzikJPfonJz4d11Xc68kD2Tz/LW5+/ynUdmpDZH1trcT2XmfbgS4=
X-Received: by 2002:ac8:1119:: with SMTP id c25mr31773889qtj.315.1607456244239;
 Tue, 08 Dec 2020 11:37:24 -0800 (PST)
MIME-Version: 1.0
References: <20201124223917.795844-1-elavila@google.com> <X79CrSX1rnpnbqPd@kroah.com>
 <20201126132613.7f737afe@oasis.local.home> <20201130094846.6b8bc60b@gandalf.local.home>
 <20201130181350.GA1116146@google.com>
In-Reply-To: <20201130181350.GA1116146@google.com>
From:   "J. Avila" <elavila@google.com>
Date:   Tue, 8 Dec 2020 11:37:13 -0800
Message-ID: <CAGFReeOOBoWqq-Ksdg6c7phS6KgpnK5em_PNKgnUX844fYsoEg@mail.gmail.com>
Subject: Re: Potential Issue in Tracing Ring Buffer
To:     William Mcvicker <willmcvicker@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Greg KH <gregkh@linuxfoundation.org>, mingo@redhat.com,
        John Stultz <john.stultz@linaro.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Daniel Mentz <danielmentz@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steven,

Thank you once again for all of your support. We saw that you also recently
merged a change[1] which adds some validation for the timestamps in
ring_buffer.c. Would you have any recommendations on how to add a more
lightweight check for time going "backwards" in the timestamps? The idea
is that we could use this quick test to detect the problem, then run a build
with your config to dig deeper.

Thanks,

Avila

[1] https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git/commit/?h=for-next

On Mon, Nov 30, 2020 at 10:13 AM William Mcvicker
<willmcvicker@google.com> wrote:
>
> On Mon, Nov 30, 2020 at 09:48:46AM -0500, Steven Rostedt wrote:
> > On Thu, 26 Nov 2020 13:26:13 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > > On Thu, 26 Nov 2020 06:52:45 +0100
> > > Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > > On Tue, Nov 24, 2020 at 10:39:17PM +0000, J. Avila wrote:
> > > > > Hello,
> > > > >
> > > > > In the ftrace logs we've collected internally, we have found that there are
> > > > > situations where time seems to go backwards; this breaks userspace tools which
> > > > > expect time to always go forward in these logs. For example, in this snippet
> > > > > from a db845c running a 5.10-rc4 kernel[1] (thanks for getting us the trace,
> > > > > John!), we see:
> > > >
> > > > Does the patch at:
> > > >   https://lore.kernel.org/r/20201125225654.1618966-1-minchan@kernel.org
> > > >
> > > > resolve this issue for you?
> > > >
> > >
> > > I think I found the bug. Can you apply this patch and let me know if it
> > > fixes the issue for you?
> > >
> > > -- Steve
> > >
> > > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > > index dc83b3fa9fe7..bccaf88d3706 100644
> > > --- a/kernel/trace/ring_buffer.c
> > > +++ b/kernel/trace/ring_buffer.c
> > > @@ -3291,7 +3291,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
> > >                     /* Nothing came after this event between C and E */
> > >                     info->delta = ts - info->after;
> > >                     (void)rb_time_cmpxchg(&cpu_buffer->write_stamp,
> > > -                                         info->after, info->ts);
> > > +                                         info->after, ts);
> > >                     info->ts = ts;
> > >             } else {
> > >                     /*
> > >
> >
> > Can I get a Tested-by from someone on the Google team, so that I can send
> > this upstream? It already passed all my internal testing, but I want to
> > make sure this is the fix for the issue I reference in the change log.
> >
> > -- Steve
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> >
> Hi Steve,
>
> Thanks for the quick turnaround! Daniel and I have both tested your patch and
> verified it's working on our end. Feel free to include:
>
> Tested-by: Daniel Mentz <danielmentz@google.com>
> Tested-by: Will McVicker <willmcvicker@google.com>
>
> --Will
