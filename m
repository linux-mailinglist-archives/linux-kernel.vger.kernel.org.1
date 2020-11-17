Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE32D2B691A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgKQPwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:52:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:60768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbgKQPwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:52:51 -0500
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5B7C246A4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605628370;
        bh=n5hKtnSFbRkV9Ne7F3tzTOQSjkjOGG9/Snmw1ldMllw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wng07msAE8++JfieGqzZYgVw6nSQ52Zny/os6+FInAAdBYxt737ime6etV+2z58Yk
         jZDkSmOz9r0h4poU7EmRmoS/9HB+AjshlaMerJZMpWBTUTZq9EEGY83tFGTyH1KtBf
         76ekIZR7dJDSBr5gAbBWlYjcbsQ2EU8hryh4m3jg=
Received: by mail-wr1-f54.google.com with SMTP id r17so23695013wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 07:52:49 -0800 (PST)
X-Gm-Message-State: AOAM5304KIDee2ICLdmn3F0je6oUNEKLCydB99WF7fgqrZ+8fN5BHKEf
        jWpNa5IHVS1Yoi5oiUwIrsx9XpmVlb2VMx+Mq82WAQ==
X-Google-Smtp-Source: ABdhPJx7Js1z7R2ybZj/Qw2xAJYSDUwnncWIhJhMB0U7OUakF/SEBWlcTmMuoU9g5eD15k4CqaHtRGsPOcVPbpJ2Puk=
X-Received: by 2002:a5d:5482:: with SMTP id h2mr204314wrv.18.1605628368294;
 Tue, 17 Nov 2020 07:52:48 -0800 (PST)
MIME-Version: 1.0
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
 <20201116144757.1920077-13-alexandre.chartre@oracle.com> <CALCETrUSCwtR41CCo_cAQf_BwG7istH6fM=bxWh_VfOjSNFmSw@mail.gmail.com>
 <bc8a254e-deaa-388e-99ea-0291f5625b5b@oracle.com> <CALCETrUJQJRi6fE=bs3iAySgM8wjmGU1f464FqOuU+PiBwwnQQ@mail.gmail.com>
 <bf919e4b-d56f-711d-f7ae-b463b8fdadfd@oracle.com>
In-Reply-To: <bf919e4b-d56f-711d-f7ae-b463b8fdadfd@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 17 Nov 2020 07:52:33 -0800
X-Gmail-Original-Message-ID: <CALCETrWS8_yugbLGFpGUbj2Z5bV04jnCNcnc40QUXWCdmJQU-g@mail.gmail.com>
Message-ID: <CALCETrWS8_yugbLGFpGUbj2Z5bV04jnCNcnc40QUXWCdmJQU-g@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 12/21] x86/pti: Use PTI stack instead of
 trampoline stack
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        jan.setjeeilers@oracle.com, Junaid Shahid <junaids@google.com>,
        oweisse@google.com, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alexander Graf <graf@amazon.de>, mgross@linux.intel.com,
        kuzuno@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 7:07 AM Alexandre Chartre
<alexandre.chartre@oracle.com> wrote:
>
>
>
> On 11/16/20 7:34 PM, Andy Lutomirski wrote:
> > On Mon, Nov 16, 2020 at 10:10 AM Alexandre Chartre
> > <alexandre.chartre@oracle.com> wrote:
> >>
> >>
> >> On 11/16/20 5:57 PM, Andy Lutomirski wrote:
> >>> On Mon, Nov 16, 2020 at 6:47 AM Alexandre Chartre
> >>> <alexandre.chartre@oracle.com> wrote:
> >>>>
> >>>> When entering the kernel from userland, use the per-task PTI stack
> >>>> instead of the per-cpu trampoline stack. Like the trampoline stack,
> >>>> the PTI stack is mapped both in the kernel and in the user page-table.
> >>>> Using a per-task stack which is mapped into the kernel and the user
> >>>> page-table instead of a per-cpu stack will allow executing more code
> >>>> before switching to the kernel stack and to the kernel page-table.
> >>>
> >>> Why?
> >>
> >> When executing more code in the kernel, we are likely to reach a point
> >> where we need to sleep while we are using the user page-table, so we need
> >> to be using a per-thread stack.
> >>
> >>> I can't immediately evaluate how nasty the page table setup is because
> >>> it's not in this patch.
> >>
> >> The page-table is the regular page-table as introduced by PTI. It is just
> >> augmented with a few additional mapping which are in patch 11 (x86/pti:
> >> Extend PTI user mappings).
> >>
> >>>   But AFAICS the only thing that this enables is sleeping with user pagetables.
> >>
> >> That's precisely the point, it allows to sleep with the user page-table.
> >>
> >>> Do we really need to do that?
> >>
> >> Actually, probably not with this particular patchset, because I do the page-table
> >> switch at the very beginning and end of the C handler. I had some code where I
> >> moved the page-table switch deeper in the kernel handler where you definitively
> >> can sleep (for example, if you switch back to the user page-table before
> >> exit_to_user_mode_prepare()).
> >>
> >> So a first step should probably be to not introduce the per-task PTI trampoline stack,
> >> and stick with the existing trampoline stack. The per-task PTI trampoline stack can
> >> be introduced later when the page-table switch is moved deeper in the C handler and
> >> we can effectively sleep while using the user page-table.
> >
> > Seems reasonable.
> >
>
> I finally remember why I have introduced a per-task PTI trampoline stack right now:
> that's to be able to move the CR3 switch anywhere in the C handler. To do so, we need
> a per-task stack to enter (and return) from the C handler as the handler can potentially
> go to sleep.
>
> Without a per-task trampoline stack, we would be limited to call the switch CR3 functions
> from the assembly entry code before and after calling the C function handler (also called
> from assembly).

The noinstr part of the C entry code won't sleep.

--Andy
