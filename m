Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E502F2BC99D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 22:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgKVVpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 16:45:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:57714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgKVVpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 16:45:10 -0500
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEBF020789
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 21:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606081510;
        bh=j8kQr1sqydOsvjEY9shLB0wmUrzUic9iCe1dNmPahV0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1ywLGw0S6Iag6+okOvBgPfWDSIRAX+z1ZSr78Si08frRCT6wlTaFGPbwKtciUr39i
         O4G4Y6EDiAcTMD7bLatQqayiaSxXNnDjjohYDNfE1OGhJGilgriL+1Ok0nRavMxdql
         /HYOzGZTzKTS4GqAkezXaMALXqruwPPbUTcCQfII=
Received: by mail-wm1-f48.google.com with SMTP id a3so15568446wmb.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 13:45:09 -0800 (PST)
X-Gm-Message-State: AOAM530pnjjhyKCqmkJP24uuC9JSuzQNdxa/JDM5ne2Ab52JFmKwXsDZ
        rRGjZn8FecKUS+S1amCTSwGscVfh6j+Ia6RcE9fytA==
X-Google-Smtp-Source: ABdhPJwifakpgwUVTLbeDBYdoVmnAfRpiEVwGa2XrrCKUuyY/SYxT6I31Kv43oa6WFJkbjZ+4GFZn5n4pemXbXWt+C8=
X-Received: by 2002:a1c:2781:: with SMTP id n123mr3937832wmn.49.1606081506352;
 Sun, 22 Nov 2020 13:45:06 -0800 (PST)
MIME-Version: 1.0
References: <20201120114630.13552-1-jgross@suse.com> <20201120114630.13552-6-jgross@suse.com>
 <20201120115943.GD3021@hirez.programming.kicks-ass.net> <eb05e878-6334-8d19-496b-6572df67fc56@suse.com>
In-Reply-To: <eb05e878-6334-8d19-496b-6572df67fc56@suse.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 22 Nov 2020 13:44:53 -0800
X-Gmail-Original-Message-ID: <CALCETrXOGhXoOJpzhAMqD7iibi09WzbGk9SWVH7JzA=d5uarWA@mail.gmail.com>
Message-ID: <CALCETrXOGhXoOJpzhAMqD7iibi09WzbGk9SWVH7JzA=d5uarWA@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] x86: rework arch_local_irq_restore() to not use popf
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "VMware, Inc." <pv-drivers@vmware.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 21, 2020 at 10:55 PM J=C3=BCrgen Gro=C3=9F <jgross@suse.com> wr=
ote:
>
> On 20.11.20 12:59, Peter Zijlstra wrote:
> > On Fri, Nov 20, 2020 at 12:46:23PM +0100, Juergen Gross wrote:
> >> +static __always_inline void arch_local_irq_restore(unsigned long flag=
s)
> >> +{
> >> +    if (!arch_irqs_disabled_flags(flags))
> >> +            arch_local_irq_enable();
> >> +}
> >
> > If someone were to write horrible code like:
> >
> >       local_irq_disable();
> >       local_irq_save(flags);
> >       local_irq_enable();
> >       local_irq_restore(flags);
> >
> > we'd be up some creek without a paddle... now I don't _think_ we have
> > genius code like that, but I'd feel saver if we can haz an assertion in
> > there somewhere...
> >
> > Maybe something like:
> >
> > #ifdef CONFIG_DEBUG_ENTRY // for lack of something saner
> >       WARN_ON_ONCE((arch_local_save_flags() ^ flags) & X86_EFLAGS_IF);
> > #endif
> >
> > At the end?
>
> I'd like to, but using WARN_ON_ONCE() in include/asm/irqflags.h sounds
> like a perfect receipt for include dependency hell.
>
> We could use a plain asm("ud2") instead.

How about out-of-lining it:

#ifdef CONFIG_DEBUG_ENTRY
extern void warn_bogus_irqrestore();
#endif

static __always_inline void arch_local_irq_restore(unsigned long flags)
{
       if (!arch_irqs_disabled_flags(flags)) {
               arch_local_irq_enable();
       } else {
#ifdef CONFIG_DEBUG_ENTRY
               if (unlikely(arch_local_irq_save() & X86_EFLAGS_IF))
                    warn_bogus_irqrestore();
#endif
}
