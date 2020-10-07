Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447F1285919
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbgJGHMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 03:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbgJGHMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:12:24 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E66C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 00:12:24 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id y13so1302872iow.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 00:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xi1LOdmOzzyOAIKt3+WaGpmoC5ZmXljmCt0LFHCFgaM=;
        b=iir5vgHBnKXs28pVgyqldJhxhdomtTqo+WB8iDs8gjJs65pBHUdQR6CGFP0a2xfojv
         j7O2CRbJhEZQ1I3PPMfeioiqpzYidrNmvusEDw15sfZ/qAy7qXUitFyYuvJLhwFbyPgo
         EeXqHyAJwOLntMCCVIELliL/YYEOHiwGYbCsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xi1LOdmOzzyOAIKt3+WaGpmoC5ZmXljmCt0LFHCFgaM=;
        b=hBMIQeYGTFC2G53/GpvExeH5S61khYkzo2mW9AaKLwi0mUtadhh/2fhuY6JxKmWROb
         TnwMz4lKvCiCnBAS6lIp5j6leH0kogY9O9gS36zvbGADzpAp0gqXJSR+PGZyRW9mM9lf
         wp1Pzxy8mhqKvALkZSbhYFpx4KWByGyqlWRBXxPe7Zyb7EW5IwYl8XacQ0607rFSfSbR
         qV4qsWuQBisvNEyVftKF2nVLhtCaXFWbBH50dS7eLlh5fTrXs4LfHdYsJUrOwOYxs+YY
         by8t4U+7/x9rJfZuchBS10BfFInsJs6tjMBGXnUfWr4YbdcSLse3muyMAbm7nTDmlB5h
         lAcw==
X-Gm-Message-State: AOAM530hPax6VVOoW2Jvh4jwkqXQRN2dsQslk9DFcSRecBFhE2TVCVq3
        tyyOG+fo/4pp9R/Rt4cK6ll951ldz+2EEiY2bl0w
X-Google-Smtp-Source: ABdhPJz2TmwP3z4c7sr6ej/YTwPX+d9QyUpD3prBxDMpPWTVe9zH7d8FxWe+L5MdzSFijnn/zVngkOlGs0Ids0u4dKs=
X-Received: by 2002:a5d:84c6:: with SMTP id z6mr1345226ior.0.1602054743520;
 Wed, 07 Oct 2020 00:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <1602002973-92934-1-git-send-email-guoren@kernel.org> <mhng-405fa3f3-74ce-4a03-958e-d0a6c42de3f6@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-405fa3f3-74ce-4a03-958e-d0a6c42de3f6@palmerdabbelt-glaptop1>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 7 Oct 2020 00:12:10 -0700
Message-ID: <CAOnJCU+H3NX8mTVcsy46JSi8GcihyY1uQ0KKfsMYwzQ+NcEkUA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fixup bootup failure with HARDENED_USERCOPY
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 6, 2020 at 9:12 PM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> On Tue, 06 Oct 2020 09:49:33 PDT (-0700), guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > As Aurelien has reported:
> >
> > [    3.484586] AppArmor: AppArmor sha1 policy hashing enabled
> > [    4.749835] Freeing unused kernel memory: 492K
> > [    4.752017] Run /init as init process
> > [    4.753571] usercopy: Kernel memory overwrite attempt detected to kernel text (offset 507879, size 11)!
> > [    4.754838] ------------[ cut here ]------------
> > [    4.755651] kernel BUG at mm/usercopy.c:99!
> > [    4.756445] Kernel BUG [#1]
> > [    4.756815] Modules linked in:
> > [    4.757542] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.8.0-1-riscv64 #1 Debian 5.8.7-1
> > [    4.758372] epc: ffffffe0003b5120 ra : ffffffe0003b5120 sp : ffffffe07f783ca0
> > [    4.758960]  gp : ffffffe000cc7230 tp : ffffffe07f77cec0 t0 : ffffffe000cdafc0
> > [    4.759772]  t1 : 0000000000000064 t2 : 0000000000000000 s0 : ffffffe07f783cf0
> > [    4.760534]  s1 : ffffffe00095d780 a0 : 000000000000005b a1 : 0000000000000020
> > [    4.761309]  a2 : 0000000000000005 a3 : 0000000000000000 a4 : ffffffe000c1f340
> > [    4.761848]  a5 : ffffffe000c1f340 a6 : 0000000000000000 a7 : 0000000000000087
> > [    4.762684]  s2 : ffffffe000941848 s3 : 000000000007bfe7 s4 : 000000000000000b
> > [    4.763500]  s5 : 0000000000000000 s6 : ffffffe00091cc00 s7 : fffffffffffff000
> > [    4.764376]  s8 : 0000003ffffff000 s9 : ffffffe0769f3200 s10: 000000000000000b
> > [    4.765208]  s11: ffffffe07d548c40 t3 : 0000000000000000 t4 : 000000000001dcd0
> > [    4.766059]  t5 : ffffffe000cc8510 t6 : ffffffe000cd64aa
> > [    4.766712] status: 0000000000000120 badaddr: 0000000000000000 cause: 0000000000000003
> > [    4.768308] ---[ end trace 1f8e733e834d4c3e ]---
> > [    4.769129] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> > [    4.770070] SMP: stopping secondary CPUs
> > [    4.771110] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
> >
> > Above failure is relate to commit: a0fa4027dc911 (riscv: Fixup
>
> That commit isn't in Linus' tree (at least, as far as I see it).  I have
> 6184358da000 ("riscv: Fixup static_obj() fail"), so I'm going to fix that -- in
> fact, I'm going to essentially just replace most of this rationale with what I
> wrote up in my revert as this is all a bit too long for a commit message.
>
> I was kind of worried the initdata move was a bit too risky, but after reading
> the users of __init_{begin,end} I think it's safe.  Here's what I ended up with
> on fixes.
>
> Thanks!
>
> commit 84814460eef9af0fb56a4698341c9cb7996a6312 (HEAD -> fixes, riscv/fixes)
> gpg: Signature made Tue 06 Oct 2020 09:11:35 PM PDT
> gpg:                using RSA key 2B3C3747446843B24A943A7A2E1319F35FBB1889
> gpg:                issuer "palmer@dabbelt.com"
> gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
> gpg:                 aka "Palmer Dabbelt <palmerdabbelt@google.com>" [ultimate]
> Author: Guo Ren <guoren@linux.alibaba.com>
> Date:   Tue Oct 6 16:49:33 2020 +0000
>
>     riscv: Fixup bootup failure with HARDENED_USERCOPY
>
>     6184358da000 ("riscv: Fixup static_obj() fail") attempted to elide a lockdep
>     failure by rearranging our kernel image to place all initdata within [_stext,
>     _end], thus triggering lockdep to treat these as static objects.  These objects
>     are released and eventually reallocated, causing check_kernel_text_object() to
>     trigger a BUG().
>
>     This backs out the change to make [_stext, _end] all-encompassing, instead just
>     moving initdata.  This results in initdata being outside of [__init_begin,
>     __init_end], which means initdata can't be freed.
>

But we are not moving all initdata out of __init_begin/end. Should we
move all the _initdata section out of _init_begin ?
http://lists.infradead.org/pipermail/linux-riscv/2020-October/002400.html

>     Link: https://lore.kernel.org/linux-riscv/1593266228-61125-1-git-send-email-guoren@kernel.org/T/#t
>     Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>     Reported-by: Aurelien Jarno <aurelien@aurel32.net>
>     Tested-by: Aurelien Jarno <aurelien@aurel32.net>
>     [Palmer: Clean up commit text]
>     Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
>
> > static_obj() fail). When we expand static_obj include INIT_DATA,
> > we also include INIT_TEXT into usercopy check kernel text:
> >
> > /* Is this address range in the kernel text area? */
> > static inline void check_kernel_text_object(const unsigned long ptr,
> >                                             unsigned long n, bool to_user)
> > {
> >         unsigned long textlow = (unsigned long)_stext;
> >         unsigned long texthigh = (unsigned long)_etext;
> >         unsigned long textlow_linear, texthigh_linear;
> >
> >         if (overlaps(ptr, n, textlow, texthigh))
> >                 usercopy_abort("kernel text", NULL, to_user, ptr - textlow, n);
> >
> > When INIT_TEXT/DATA are freed, new allocation will reuse these
> > memory and overlaps check will be triggered.
> >
> > The patch met static_obj and check_kernel_text_object requirements.
> >
> > Link: https://lore.kernel.org/linux-riscv/1593266228-61125-1-git-send-email-guoren@kernel.org/T/#t
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Reported-by: Aurelien Jarno <aurelien@aurel32.net>
> > Tested-by: Aurelien Jarno <aurelien@aurel32.net>
> > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > Cc: Atish Patra <atishp@atishpatra.org>
> > Cc: Andreas Schwab <schwab@linux-m68k.org>
> > ---
> >  arch/riscv/kernel/vmlinux.lds.S | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> > index f3586e3..34d00d9 100644
> > --- a/arch/riscv/kernel/vmlinux.lds.S
> > +++ b/arch/riscv/kernel/vmlinux.lds.S
> > @@ -22,13 +22,11 @@ SECTIONS
> >       /* Beginning of code and text segment */
> >       . = LOAD_OFFSET;
> >       _start = .;
> > -     _stext = .;
> >       HEAD_TEXT_SECTION
> >       . = ALIGN(PAGE_SIZE);
> >
> >       __init_begin = .;
> >       INIT_TEXT_SECTION(PAGE_SIZE)
> > -     INIT_DATA_SECTION(16)
> >       . = ALIGN(8);
> >       __soc_early_init_table : {
> >               __soc_early_init_table_start = .;
> > @@ -55,6 +53,7 @@ SECTIONS
> >       . = ALIGN(SECTION_ALIGN);
> >       .text : {
> >               _text = .;
> > +             _stext = .;
> >               TEXT_TEXT
> >               SCHED_TEXT
> >               CPUIDLE_TEXT
> > @@ -67,6 +66,8 @@ SECTIONS
> >               _etext = .;
> >       }
> >
> > +     INIT_DATA_SECTION(16)
> > +
> >       /* Start of data section */
> >       _sdata = .;
> >       RO_DATA(SECTION_ALIGN)



-- 
Regards,
Atish
