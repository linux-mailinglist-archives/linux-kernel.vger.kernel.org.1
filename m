Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9FA2FA0CA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404224AbhARNJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390640AbhARNJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:09:12 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63432C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:08:32 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id w79so18523405qkb.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y0jOa20hYwCAA9+mLbUWHauihKEmdoZpSDEChlOtOxo=;
        b=EkH4aq1xxjyfmsU0Qi0IUIAjOfLWThaxN2gouwrYjLk8GNQuzI4/LbtYtx+61cn0lj
         Ex6UC9cKvGUA+ypXcM9yyg5sSfGp/hhRRi045Cy/VHvIdXXbdXCFfk5Tbp3r5FSL5+so
         SKopSQmX4XvDYlvYKZ1bMAWPcnNTq2nJ3JcBvgDLKYIurEmKLmTjRiUh0aElyhLcVPT8
         QqmhdpaNwsyhgoKQ/rA1GAPrZG1a5BobVudLseS8qtlyWhftmHapYcjytWQEw1IltTIW
         0quj20ptSkZAsku7RUvbfJJV/fXcEw4U7mAqvjkwE6kw9apbjRLRtin92FcT97qht7l8
         o3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y0jOa20hYwCAA9+mLbUWHauihKEmdoZpSDEChlOtOxo=;
        b=bjyIlsIOTNth1Xu4RMmrwXH/fKkviSLaF9ILF2FWZ1L+k5QsO7plS443lUlS/KFac+
         /FzhKVh3RcA2ImwM/fVYEuoJdqzvzklGPPnGhFU98B9CAXYs42Fqs1x+Pvu2Yb/MP0hE
         fVtWcZSkFPHonJd6p610VkcviUT2heIBA7R9n4nnwollLK2u2pM4zFV3R8S8A3Dq79EX
         gTWgwNJYlY56i/7tEbMqwX4ut4mGAOd7WlV8A//RFr2sj56Ve56lSu3iWgTz2OQPiOEG
         Pr6vqxIg8C4EAuOybRRFcwuvLO8HsKChRes839ApZjUTczSoIyBDqQAY55qNo9bBgMk2
         Z8Ew==
X-Gm-Message-State: AOAM531oG8e300ziPh7XRfzuDxqZZsTB9uvwLjULjjMFgTRi4xIoKAS9
        w/7B7djGOgMAEEpa97OSljjrom+AOulzUUYdE5HtnQ==
X-Google-Smtp-Source: ABdhPJy1dn0illdPKpjCZ3i6pG59dMkga3rShB9ObsNFNWP3NsbiWGSv1YvjkUlr4JgMEveOtVtBKAsV9YLqo45WZpE=
X-Received: by 2002:a37:70d:: with SMTP id 13mr23735344qkh.326.1610975311245;
 Mon, 18 Jan 2021 05:08:31 -0800 (PST)
MIME-Version: 1.0
References: <20210115130336.2520663-1-glider@google.com> <20210115130336.2520663-3-glider@google.com>
 <YAVzNrBIlp0UJKfs@alley>
In-Reply-To: <YAVzNrBIlp0UJKfs@alley>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 18 Jan 2021 14:08:19 +0100
Message-ID: <CAG_fn=UmjC2LOCXRpp+vTZ6nr0M7=dCKjFYgVFVvmqftTkjGYw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] lib: add error_report_notify to collect debugging
 tools' reports
To:     Petr Mladek <pmladek@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Marco Elver <elver@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 12:38 PM Petr Mladek <pmladek@suse.com> wrote:
Thanks for your input! Some responses below.

>
> On Fri 2021-01-15 14:03:33, Alexander Potapenko wrote:
> > With the introduction of various production error-detection tools, such=
 as
> > MTE-based KASAN and KFENCE, the need arises to efficiently notify the
> > userspace OS components about kernel errors. Currently, no facility exi=
sts
> > to notify userspace about a kernel error from such bug-detection tools.
> > The problem is obviously not restricted to the above bug detection tool=
s,
> > and applies to any error reporting mechanism that does not panic the
> > kernel; this series, however, will only add support for KASAN and KFENC=
E
> > reporting.
> >
> > +++ b/lib/error_report_notify.c
> > +/*
> > + * Trace hook for the error_report_start event. In an unlikely case of=
 another
> > + * task already printing a report bail out, otherwise save the current=
 pid
> > + * together with in_task() return value.
>
> This is not reliable. Some events might get lost.


> > +
> > +     /* Pairs with acquire in last_report_show(). */
> > +     atomic_inc_return_release(&num_reports);
> > +     schedule_delayed_work(&reporting_done, 0);
>
> Why delayed work when it gets queued immediately?

Because error reports may be sent from a place where waiting is
forbidden (in the case of KFENCE that is the page fault handler).
A delayed work ensures the notification occurs in a wait-safe context.


> > +static void skip_extra_info(const char **buf, size_t *len)
> > +{
> > +     int num_brackets =3D IS_ENABLED(CONFIG_PRINTK_TIME) +
> > +                        IS_ENABLED(CONFIG_PRINTK_CALLER);
>
> The timestamp can be disabled also at runtime by
> /sys/module/printk/parameters/time

Guess that would result in disabling it for the whole kernel, which is
too aggressive.


> IMHO, removing the timestamp is a bad idea. It will complicate
> matching the message with other events.

Given that we are moving away from sysfs, the report size limit can be
increased, therefore we don't have to remove the timestamp to save
space anymore.

> I am afraid that some reports would get shrunken anyway.
Do you have any particular subsystem in mind? We could probably
increase the report buffer to, say, 16K, to avoid this.

> I suggest to use some lockless ringbuffer to store these
> messages. Either ftrace or printk one.
>
> But the biggest problem would be that console might be called
> asynchronously from another process. The messages might get
> lost in the meantime.

Do you mean that one process may call printk(), but the console probe
for that message will be executed in the context of another process?
If so, that would be a problem. Could it be possible to extend the
console trace event to pass an extra caller id?

>
> There are many other more reliable solutions:
>
> Either add hook into vprintk_store() and make another copy of the
> message into your buffer. But there will still be the problem
> that you could not store more reports in parallel. So, it won't
> be reliable anyway.

At least for now, we do not expect many reports to come in parallel:
this feature is meant for collecting the long tail of memory
corruptions from production devices.

>
> Or add a hook into /dev/kmsg interface. It allows to read any
> stored message immediately and quickly. Well, you would need
> to have your own reader of this interface.

This probably could be done, but isn't the console tracepoint designed
exactly for this?

> Or add your own reader of the main printk log.
>
> Or give up on having your own buffers. Instead just inform userspace
> about a new report via the pooled interface. And get the messages
> from the main log, e.g. via /dev/kmsg.

Yes, that could be an option, although the need to search for
tool-specific strings in kmsg and figure out where the report starts
and ends still persists.
At the end of the day, this sounds like the best approach for now,
that we could later extend to store the logs.


> I agree with Andrew that this might be _very_ dangerous feature.
> It is another way how to get messages from kernel. It looks like
> a hack how to get certain messages from the main kernel log
> into a separate log. This might end up with implementing
> yet another printk() or trace_printk().

Initially our intent was to refactor KFENCE error reporting so that
the whole report is stored in a buffer and can be exposed to userspace
via a VFS entry.
Then it turned out we'd need something similar for KASAN, which
would've also resulted in a major rewrite.
So we thought a much more generic solution would be to let the tools
"tee" their output to a specific file on demand.
Yes, sounds like duplicating the kernel log :)
On the other hand, we never really planned to extend printk or
duplicate parts of it, so unless trace_console() is a good fit we'd
probably refrain from storing the logs for now.

> I suggest to integrate this better with printk():
>
>    + We already have printk_context() that allows to handle
>      messages a special way.
>
>    + Just store extra flag into the main log buffer for these
>      messages.
>
>    + Allow to read the messages via some interface, either
>      /dev/kmsg or a new one. We already store PID and context
>      info into the main log buffer. It will allow to put
>      relevant lines together.
>
>    + Anyway, I strongly suggest to avoid your own buffer. It looks
>      like an overhead. It it would get more complicated when
>      there are more users, ...

Having the special flag for the error reports is handy, but given the
existence of CONFIG_PRINTK_CALLER may not be worth the effort, at
least for now.

>
>
> I still have to think about it. This feature heavily depends on
> printk(). It makes sense to integrate it there. But we also
> need to keep it simple because printk() is already pretty
> complicated.
>
> Best Regards,
> Petr



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
