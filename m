Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFF02AE4C7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 01:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbgKKAN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 19:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgKKAN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 19:13:58 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E62C0613D1;
        Tue, 10 Nov 2020 16:13:56 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id i19so278888ejx.9;
        Tue, 10 Nov 2020 16:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6s5bGiJKxEvlGWLA71eC6l1dT+udPEghIXy67ZZhh/c=;
        b=YXa0Afs77MC7d2NWsflirOlTNuIWFUC8u2wXeSMsQ0wjbhYzTB/ppLOJD6EnHK+dPB
         zcQ2fvMATWhCXiZ1yhq62iskCuVOUJnWjKF8YS1cUay2eAIcMikr+xy3kWIhvq1oM+YE
         fNqemZIfBUpwlj6hYAMr8mYw6/17BRjpmB17AGiQnmO93BOjGk22oxtJrFcdbutoCYUk
         6Ql4OPLYy6A99+6UgZiEfRz/e/UbzxcHPSX3zhbjCcR85DyY3xKQ/Gsh49BguVCX3JxP
         ODtCHM5TNXsV4yTTZ7Cvujlu1oUaqSnMh6+Tj1CceULQvtjodePbVYTUenhBTm+EOTbQ
         FAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6s5bGiJKxEvlGWLA71eC6l1dT+udPEghIXy67ZZhh/c=;
        b=WWYlRK8Hgr4ps1b4X8hCQgDMpQExwU4APjAqEJTh4FYvHKpsiXRTPi9zLGfI8H8vVE
         uuuGXxMpK9OJ03f07h1wm7GTJ+mRMp536TsK5hV0BNzChErb2pEzjQpbt6gkhk7bbKKB
         b3VbXPq1b347009y+TqBcFQmwFkJ4OHrnlUEYgSrNzXQ5Rta5oLqqqQdc0qxZqLcTmLx
         WF1k092mwiT8cbra5KMEx2zgcHERArtfw2D2GRhtHil2Xn0d+hG3zEOxvuxY8G4MvQEc
         F8cH5DxN/24LIKvg6I9mqIX1h4wZNnmlNgOlh4bjnvW/1ZmxTGGwVGqf9xPn3vCdXivj
         mR4g==
X-Gm-Message-State: AOAM531TsLCJZJsu7UQ05+TD5hqDnAfjl2CmETPDO7o5MMpw4m6xkaWL
        MEgU1T3NBATlZrdzzC8PWXsdy/AIcIrOi5Lzvus=
X-Google-Smtp-Source: ABdhPJwOh+MQk/Kcwo4yAp+KlyKtnXcp3jsyh/V8EjpxP6pKJJ9ZsgcdIoNuDfVsrlC4PsmpwlPwat/3/zeRzEZol44=
X-Received: by 2002:a17:906:34c3:: with SMTP id h3mr22785967ejb.132.1605053633951;
 Tue, 10 Nov 2020 16:13:53 -0800 (PST)
MIME-Version: 1.0
References: <1605018060-11571-1-git-send-email-cainiao666999@gmail.com> <7766d351074242a8bc929b12857eed46@AcuMS.aculab.com>
In-Reply-To: <7766d351074242a8bc929b12857eed46@AcuMS.aculab.com>
From:   Yang Mingzhe <cainiao666999@gmail.com>
Date:   Wed, 11 Nov 2020 08:13:42 +0800
Message-ID: <CAAY4BKMa5OuPx8TyNmS5+KqSNE00uuiHCdnG83mFvKZimeMOSw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: x86: fix thread_info's position
To:     David Laight <David.Laight@aculab.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Laight
> Sent: 10 November 2020 23:03

Thank you for your review!

> Nope, most stacks 'grow down'.
> So the first item pushed is at address 8k (for 8k stacks).

Yep, most stacks 'grow down'. But the zero offset of a stack is also
at address 8k(for 8k stack).

> The bit about the kernel 4.9 changes doesn't read well at all.
> I think the commas are just wrong.

I=E2=80=99m sorry for that, because my English is not very well.

> You could say something like:
> Prior to kernel 4.9 the thread_info structure was at the bottom of the ke=
rnel stack. kernel 4.9 moved it into the task_struct.

Gotcha!


On Tue, Nov 10, 2020 at 11:03 PM David Laight <David.Laight@aculab.com> wro=
te:
>
> From: Yang Mingzhe
> > Sent: 10 November 2020 14:21
> >
> > The bottom of the stack is where the first item was added to the stack,
> > usually at the zero offset. Actually, the thread_info structure at the
> > end of the stack.
>
> Nope, most stacks 'grow down'.
> So the first item pushed is at address 8k (for 8k stacks).
>
> > Please see attached picture:
> > https://github.com/Mutated1994/kernel-beginner/blob/master/kernel-stack=
.md
> >
> > See commits c65eacb ("sched/core: Allow putting thread_info into
> > task_struct"), 15f4eae ("x86: Move thread_info into task_struct")
> > and 883d50f ("scripts/gdb: fix get_thread_info").
> >
> > Signed-off-by: Yang Mingzhe <cainiao666999@gmail.com>
> > ---
> >  Documentation/x86/kernel-stacks.rst | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/x86/kernel-stacks.rst b/Documentation/x86/ke=
rnel-stacks.rst
> > index 6b0bcf0..b88b9e12 100644
> > --- a/Documentation/x86/kernel-stacks.rst
> > +++ b/Documentation/x86/kernel-stacks.rst
> > @@ -15,7 +15,9 @@ Like all other architectures, x86_64 has a kernel sta=
ck for every
> >  active thread.  These thread stacks are THREAD_SIZE (2*PAGE_SIZE) big.
> >  These stacks contain useful data as long as a thread is alive or a
> >  zombie. While the thread is in user space the kernel stack is empty
> > -except for the thread_info structure at the bottom.
> > +except for the thread_info structure at the end (since kernel 4.9, the
> > +thread_info has been moved into task_struct, no longer locates at the
> > +end of kernel stack).
>
> So 'bottom' - meaning address 0 is probably right.
> Not sure what happens on the few architectures where pushing values
> onto the stack does increase the stack pointer.
>
> The bit about the kernel 4.9 changes doesn't read well at all.
> I think the commas are just wrong.
> You could say something like:
>
> Prior to kernel 4.9 the thread_info structure was at the bottom
> of the kernel stack. kernel 4.9 moved it into the task_struct.
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)
>
