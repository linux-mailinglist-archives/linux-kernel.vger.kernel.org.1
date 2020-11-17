Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0062B57E4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 04:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgKQD32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 22:29:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:59158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgKQD31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 22:29:27 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB74F2469D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 03:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605583767;
        bh=WMRhCW6DOK8RnOuLzcdydvPfp06u9UtoDSKwaFODpgY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=btN8fO4oH59fwlcG1NlVB4yzWn5RNtXq6pmYb2loUqeLdn2YjXYpk6lQAav6vrQ4t
         rwple4e4fcjb0LCj47dr8za6O1qNlxXzOjS8t5a7A28P4NbJCNeH3xSZBIaUlcayO5
         EBfmgv8CtTziraWpki+n94sDYN3+7lWfchtdoJcs=
Received: by mail-wm1-f44.google.com with SMTP id 19so1884756wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 19:29:26 -0800 (PST)
X-Gm-Message-State: AOAM533M3CkY16gh46N2QtmFVV/C/SrWAgPfz8AQpsmRVlT7NyqHthn9
        nWgn2eQvvhlMEVBcLxz73LNUjg7UrdbrBWuF5QR6aA==
X-Google-Smtp-Source: ABdhPJzFWgJUzKTEsaSvrSr5rrOi4fhhYM2FMrNXfJy5CkO1AmG6K+e912rcJptHY+4p1YoKCncqmFpCn68qjhsiqLw=
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr1948152wmg.21.1605583765456;
 Mon, 16 Nov 2020 19:29:25 -0800 (PST)
MIME-Version: 1.0
References: <20201002042915.403558-1-mark.mossberg@gmail.com>
 <20201103125034.GA30391@redhat.com> <20201103171537.GC4111@zn.tnic>
 <20201103174744.GB23992@redhat.com> <20201103175237.GD4111@zn.tnic>
 <20201103181114.GC23992@redhat.com> <20201103182018.GE4111@zn.tnic>
 <87blfxx8ps.fsf@nanos.tec.linutronix.de> <CALCETrW+Jek_t51RyqxO=HUA_PJ4APwS9hJQWsXyc426cgf0wA@mail.gmail.com>
 <878sb0yisp.fsf@nanos.tec.linutronix.de>
In-Reply-To: <878sb0yisp.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 16 Nov 2020 19:29:11 -0800
X-Gmail-Original-Message-ID: <CALCETrVoOA3u6Hej4r3n3d6C+ZE+wB0+mbOZzPUtLF6DzYZdCQ@mail.gmail.com>
Message-ID: <CALCETrVoOA3u6Hej4r3n3d6C+ZE+wB0+mbOZzPUtLF6DzYZdCQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/dumpstack: Fix misleading instruction pointer
 error message
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>, Oleg Nesterov <oleg@redhat.com>,
        Mark Mossberg <mark.mossberg@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jann Horn <jannh@google.com>,
        kyin@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 3:37 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, Nov 16 2020 at 15:04, Andy Lutomirski wrote:
>
> > On Mon, Nov 16, 2020 at 2:01 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >>  arch/x86/kernel/dumpstack.c |   23 +++++++++++++++++++----
> >>  1 file changed, 19 insertions(+), 4 deletions(-)
> >>
> >> --- a/arch/x86/kernel/dumpstack.c
> >> +++ b/arch/x86/kernel/dumpstack.c
> >> @@ -78,6 +78,9 @@ static int copy_code(struct pt_regs *reg
> >>         if (!user_mode(regs))
> >>                 return copy_from_kernel_nofault(buf, (u8 *)src, nbytes);
> >>
> >> +       /* The user space code from other tasks cannot be accessed. */
> >> +       if (regs != task_pt_regs(current))
> >> +               return -EPERM;
> >
> > Depending on exactly where this gets called, this may not be
> > sufficient.  You should also check nmi_uaccess_okay().
>
> which is what copy_from_user_nmi() already does.

Whoops.  I thought I checked that...
