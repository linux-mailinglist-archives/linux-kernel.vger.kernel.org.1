Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB48299AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408056AbgJZXpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:45:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408014AbgJZXpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:45:32 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A20821D24
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 23:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603755931;
        bh=QDKdWJXjxImBlf0JuhM6nieqHfmY156p5uov8h1hIiM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AI7CMdTKeIQ3eHr1pGP4pHhsrO60FpZicrhvjqbKtclPHazND7G5pTWllAN1aVCj3
         q//pWoKClZ1kJkUkMXkaBRGh18C6/5Rz4wNs1soa7jdqHNPeaFI9VuX987hAyXUxXl
         TmvvbSisE0d81HMfa9BUIoAjtDcGfpDe6xQqSM5M=
Received: by mail-wr1-f54.google.com with SMTP id n15so15027661wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 16:45:31 -0700 (PDT)
X-Gm-Message-State: AOAM530G6EtwPgt//9XDoWUtV5KeCfDERVgAD7TIvMB+YoSyyF53jNHV
        yC7GXhpYofL2gBMrW53ezbuCgKcUODyugshYJJokZQ==
X-Google-Smtp-Source: ABdhPJxneVSNXkoZqCi5HbWPf7TjeZqNUuJQyx4aQnIdeQ3Lk5j+5BElIymgsW8VROpNXaDn8o4Ma4B2Nio7DwceIm4=
X-Received: by 2002:a5d:54d0:: with SMTP id x16mr19902154wrv.75.1603755929641;
 Mon, 26 Oct 2020 16:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAP045Ar5CtqknH66i5ti6xOvo9cC9ib5v-5+3fFKcp_DW91hYw@mail.gmail.com>
 <20201026155521.GQ2594@hirez.programming.kicks-ass.net> <20201026160513.GC2651@hirez.programming.kicks-ass.net>
 <CAP045ApB_9h5Pp=a0L+taA6qFURrR6Se+W77Vb7A_VOWJNKfng@mail.gmail.com>
 <20201026163100.GR2594@hirez.programming.kicks-ass.net> <20201026165519.GD2651@hirez.programming.kicks-ass.net>
 <CALCETrVwzcpk88jWeNb+iCGBFsyzgbZ0E9_x330A2P-CMzSr4g@mail.gmail.com>
In-Reply-To: <CALCETrVwzcpk88jWeNb+iCGBFsyzgbZ0E9_x330A2P-CMzSr4g@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 26 Oct 2020 16:45:18 -0700
X-Gmail-Original-Message-ID: <CALCETrXwS0CtPuX7AgUorrPDis7Czd_ngO1=FG0=VqGS8Ru+JA@mail.gmail.com>
Message-ID: <CALCETrXwS0CtPuX7AgUorrPDis7Czd_ngO1=FG0=VqGS8Ru+JA@mail.gmail.com>
Subject: Re: [REGRESSION] x86/debug: After PTRACE_SINGLESTEP DR_STEP is no
 longer reported in dr6
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, Kyle Huey <me@kylehuey.com>,
        open list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: multipart/mixed; boundary="0000000000007e6a8a05b29b86bb"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000007e6a8a05b29b86bb
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 26, 2020 at 4:30 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Mon, Oct 26, 2020 at 9:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Oct 26, 2020 at 05:31:00PM +0100, Peter Zijlstra wrote:
> > > In that respect, I think the current virtual_dr6 = 0 is placed wrong, it
> > > should only be in exc_debug_user(). The only 'problem' then is that we
> > > seem to be able to loose BTF, but perhaps that is already an extant bug.
> > >
> > > Consider:
> > >
> > >  - perf: setup in-kernel #DB
> > >  - tracer: ptrace(PTRACE_SINGLEBLOCK)
> > >  - tracee: #DB on perf breakpoint, looses BTF
> > >  - tracee .. never triggers actual blockstep
> > >
> > > Hmm ? Should we re-set BTF when TIF_BLOCKSTEP && !user_mode(regs) ?
> >
> > Something like so then.
> >
> > Or sould we also have the userspace #DB re-set BTF when it was !DR_STEP?
> > I need to go untangle that ptrace stuff :/
> >
> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index 3c70fb34028b..31de8b0980ca 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -793,19 +793,6 @@ static __always_inline unsigned long debug_read_clear_dr6(void)
> >         set_debugreg(DR6_RESERVED, 6);
> >         dr6 ^= DR6_RESERVED; /* Flip to positive polarity */
> >
> > -       /*
> > -        * Clear the virtual DR6 value, ptrace routines will set bits here for
> > -        * things we want signals for.
> > -        */
> > -       current->thread.virtual_dr6 = 0;
> > -
> > -       /*
> > -        * The SDM says "The processor clears the BTF flag when it
> > -        * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
> > -        * TIF_BLOCKSTEP in sync with the hardware BTF flag.
> > -        */
> > -       clear_thread_flag(TIF_BLOCKSTEP);
> > -
> >         return dr6;
> >  }
> >
> > @@ -873,6 +860,20 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
> >          */
> >         WARN_ON_ONCE(user_mode(regs));
> >
> > +       if (test_thread_flag(TIF_BLOCKSTEP)) {
> > +               /*
> > +                * The SDM says "The processor clears the BTF flag when it
> > +                * generates a debug exception." but PTRACE_BLOCKSTEP requested
> > +                * it for userspace, but we just took a kernel #DB, so re-set
> > +                * BTF.
> > +                */
> > +               unsigned long debugctl;
> > +
> > +               rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
> > +               debugctl |= DEBUGCTLMSR_BTF;
> > +               wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
> > +       }
> > +
> >         /*
> >          * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
> >          * watchpoint at the same time then that will still be handled.
> > @@ -935,6 +936,26 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
> >         irqentry_enter_from_user_mode(regs);
> >         instrumentation_begin();
> >
> > +       /*
> > +        * Clear the virtual DR6 value, ptrace routines will set bits here for
> > +        * things we want signals for.
> > +        */
> > +       current->thread.virtual_dr6 = 0;
> > +
> > +       /*
> > +        * If PTRACE requested SINGLE(BLOCK)STEP, make sure to reflect that in
> > +        * the ptrace visible DR6 copy.
> > +        */
> > +       if (test_thread_flag(TIF_BLOCKSTEP) || test_thread_flag(TIF_SINGLESTEP))
> > +               current->thread.virtual_dr6 |= (dr6 & DR_STEP);
>
> I'm guessing that this would fail a much simpler test, though: have a
> program use PUSHF to set TF and then read out DR6 from the SIGTRAP.  I
> can whip up such a test if you like.
>
> Is there any compelling reason not to just drop the condition and do:
>
> current->thread.virtual_dr6 |= (dr6 & DR_STEP);
>
> unconditionally?  This DR6 cause, along with ICEBP, have the
> regrettable distinctions of being the only causes that a user program
> can trigger all on its own without informing the kernel first.  This
> means that we can't fully separate the concept of "user mode is
> single-stepping itself" from "ptrace or something else is causing the
> kernel to single step a program."
>
> I bet that, without making this tweak, the virtual_dr6 change will
> regress some horrific Wine use case.

PeterZ, this new scheme of having handlers clear bits in dr6 to
consume them and set bits in virtual_dr6 to send signals is
incomprehensible -- there is no possible way to read traps.c and tell
what the code does :(

I attached a test case.  I'll make a real patch out of this in a bit.
This passes on 5.8, and I haven't tested it yet on 5.10-rc1.  The real
patch will also test ICEBP, and I'm sure we'll be quite unhappy with
the result of that.

--0000000000007e6a8a05b29b86bb
Content-Type: text/x-patch; charset="US-ASCII"; name="test.patch"
Content-Disposition: attachment; filename="test.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kgr6twdc0>
X-Attachment-Id: f_kgr6twdc0

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3g4Ni9zaW5nbGVfc3RlcF9zeXNj
YWxsLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy94ODYvc2luZ2xlX3N0ZXBfc3lzY2FsbC5j
CmluZGV4IDVhNGM2ZTA2ODcyZS4uZjZhYmVmZDQwNjZlIDEwMDY0NAotLS0gYS90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy94ODYvc2luZ2xlX3N0ZXBfc3lzY2FsbC5jCisrKyBiL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL3g4Ni9zaW5nbGVfc3RlcF9zeXNjYWxsLmMKQEAgLTcyLDcgKzcyLDYgQEAg
c3RhdGljIHVuc2lnbmVkIGNoYXIgYWx0c3RhY2tfZGF0YVtTSUdTVEtTWl07CiBzdGF0aWMgdm9p
ZCBzaWd0cmFwKGludCBzaWcsIHNpZ2luZm9fdCAqaW5mbywgdm9pZCAqY3R4X3ZvaWQpCiB7CiAJ
dWNvbnRleHRfdCAqY3R4ID0gKHVjb250ZXh0X3QqKWN0eF92b2lkOwotCXVuc2lnbmVkIGxvbmcg
ZHI2ID0gaW5mby0+c2lfY29kZTsKIAogCWlmIChnZXRfZWZsYWdzKCkgJiBYODZfRUZMQUdTX1RG
KSB7CiAJCXNldF9lZmxhZ3MoZ2V0X2VmbGFncygpICYgflg4Nl9FRkxBR1NfVEYpOwpAQCAtODks
NyArODgsMTAgQEAgc3RhdGljIHZvaWQgc2lndHJhcChpbnQgc2lnLCBzaWdpbmZvX3QgKmluZm8s
IHZvaWQgKmN0eF92b2lkKQogCQkgICAgICAgKHVuc2lnbmVkIGxvbmcpY3R4LT51Y19tY29udGV4
dC5ncmVnc1tSRUdfSVBdKTsKIAl9CiAKLQlwcmludGYoIkRSNiA9IDB4JWx4XG4iLCBkcjYpOwor
CWlmIChpbmZvLT5zaV9jb2RlICE9IFRSQVBfVFJBQ0UpIHsKKwkJcHJpbnRmKCJbRkFJTF1cdHNp
X2NvZGUgd2FzIDB4JWx4OyBzaG91bGQgaGF2ZSBiZWVuIFRSQVBfVFJBQ0UgKDB4JWx4KVxuIiwg
KHVuc2lnbmVkIGxvbmcpaW5mby0+c2lfY29kZSwgKHVuc2lnbmVkIGxvbmcpVFJBUF9UUkFDRSk7
CisJCV9leGl0KDEpOworCX0KIH0KIAogc3RhdGljIGNoYXIgY29uc3QgKiBjb25zdCBzaWduYW1l
c1tdID0gewo=
--0000000000007e6a8a05b29b86bb--
