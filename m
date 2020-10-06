Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA99F28451B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 06:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgJFEvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 00:51:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgJFEvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 00:51:20 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE15120782
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 04:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601959879;
        bh=zQEbWwurLJknoGsA2za54fJCxE87S2cBcDrKm/th3pg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cNcW09FSvLW4Xlk9USEEhnQBHArF4FzM4F5CwRhwB9d5lSef7NaAzf7/BPIRNJhhM
         ZfHU1Gem3xhB6DVDkPDzt3/mmuX65aAzVyRi3Ozks7tapKbg3QTfnAXVzFP6PQB8FO
         /eQm4qSrL2AWN6s54pb6565IH6/IcgCW/D+99Wmg=
Received: by mail-wr1-f46.google.com with SMTP id k10so11862632wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 21:51:18 -0700 (PDT)
X-Gm-Message-State: AOAM5323/m0bqSc33L1XuHeMpeJ4rfMtl5dMQo+a8oWKhU+sKwXOwgtr
        lC7QW4/i+i/0/uyW9WbzfOCdKCWq1kKC+kIb2lrAMg==
X-Google-Smtp-Source: ABdhPJwg7KhXHxiek3PhwKY6wXmAm/bn0/mAgWQF0B2h8zWe/dajHmoVjlMEDSHxY89Ir4UO/pibHu7QXd/WCAkkJHY=
X-Received: by 2002:a5d:5281:: with SMTP id c1mr2643682wrv.184.1601959877469;
 Mon, 05 Oct 2020 21:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601925251.git.luto@kernel.org> <4b3b4fbf8e9806840135e95cef142a0adefc3455.1601925251.git.luto@kernel.org>
 <20201006022910.GF15803@linux.intel.com>
In-Reply-To: <20201006022910.GF15803@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 5 Oct 2020 21:51:06 -0700
X-Gmail-Original-Message-ID: <CALCETrUPtvF7WyvCZmMZHo5cDA-Ltn-FVVCCTMabexO5hyEQEQ@mail.gmail.com>
Message-ID: <CALCETrUPtvF7WyvCZmMZHo5cDA-Ltn-FVVCCTMabexO5hyEQEQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/stackprotector/32: Make the canary into a regular
 percpu variable
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 7:29 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Mon, Oct 05, 2020 at 12:30:03PM -0700, Andy Lutomirski wrote:
> > On 32-bit kernels, the stackprotector canary is quite nasty -- it is
> > stored at %gs:(20), which is nasty because 32-bit kernels use %fs for
> > percpu storage.  It's even nastier because it means that whether %gs
> > contains userspace state or kernel state while running kernel code
> > sepends on whether stackprotector is enabled (this is
>
>   depends
>
> > CONFIG_X86_32_LAZY_GS), and this setting radically changes the way
> > that segment selectors work.  Supporting both variants is a
> > maintenance and testing mess.
> >
> > Merely rearranging so that percpu and the stack canary
> > share the same segment would be messy as the 32-bit percpu address
> > layout isn't currently compatible with putting a variable at a fixed
> > offset.
> >
> > Fortunately, GCC 8.1 added options that allow the stack canary to be
> > accessed as %fs:stack_canary, effectively turning it into an ordinary
> > percpu variable.  This lets us get rid of all of the code to manage
> > the stack canary GDT descriptor and the CONFIG_X86_32_LAZY_GS mess.
> >
> > This patch forcibly disables stackprotector on older compilers that
> > don't support the new options and makes the stack canary into a
> > percpu variable.
>
> It'd be helpful to explicitly state that the so called "lazy GS" approach is
> now always used for i386.
>
> > Signed-off-by: Andy Lutomirski <luto@kernel.org>
> > ---
>
> ...
>
> > diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend_32.h
> > index fdbd9d7b7bca..eb872363ca82 100644
> > --- a/arch/x86/include/asm/suspend_32.h
> > +++ b/arch/x86/include/asm/suspend_32.h
> > @@ -16,9 +16,7 @@ struct saved_context {
> >        * On x86_32, all segment registers, with the possible exception of
>
> Is this still a "possible" exception, or is it now always an exception?

Good catch.

>
> >        * gs, are saved at kernel entry in pt_regs.
> >        */
> > -#ifdef CONFIG_X86_32_LAZY_GS
> >       u16 gs;
> > -#endif
> >       unsigned long cr0, cr2, cr3, cr4;
> >       u64 misc_enable;
> >       bool misc_enable_saved;
>
> ...
>
> > diff --git a/arch/x86/kernel/tls.c b/arch/x86/kernel/tls.c
> > index 64a496a0687f..3c883e064242 100644
> > --- a/arch/x86/kernel/tls.c
> > +++ b/arch/x86/kernel/tls.c
> > @@ -164,17 +164,11 @@ int do_set_thread_area(struct task_struct *p, int idx,
> >               savesegment(fs, sel);
> >               if (sel == modified_sel)
> >                       loadsegment(fs, sel);
> > -
> > -             savesegment(gs, sel);
> > -             if (sel == modified_sel)
> > -                     load_gs_index(sel);
> >  #endif
> >
> > -#ifdef CONFIG_X86_32_LAZY_GS
> >               savesegment(gs, sel);
> >               if (sel == modified_sel)
> > -                     loadsegment(gs, sel);
> > -#endif
> > +                     load_gs_index(sel);
>
> Side topic, the "index" part of this is super confusing.  I had to reread
> this entire patch after discovering load_gs_index is loadsegment on i386.
>
> Maybe also worth a shout out in the changelog?

Sure.

load_gs_index() makes perfect sense to me because I've been drinking
the kool-aid for too long.  Maybe some day we should rename it, but
I"m not sure what the best name would be.  set_gs_update_user_base()?
The semantics are that it loads GS except that it changes the user
GSBASE instead of the kernel GSBASE.  Thanks, AMD.

--Andy
