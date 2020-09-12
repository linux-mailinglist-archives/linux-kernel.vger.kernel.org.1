Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74307267748
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 04:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbgILCjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 22:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgILCjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 22:39:42 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CDD0221F0;
        Sat, 12 Sep 2020 02:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599878381;
        bh=zjnMbxyDgv9DNdXWqu1foZndnKirmwQusVIC9nJ03o8=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=qX3GJ4p4w9WN/QnhxzvLukRcXEkm8O+yQbpVH7tLPOL4kVXDYJK2O/mEuTEajs72F
         TVJXtA0sssAi+O+AdmqFNeGfTVNgkFKQz3msNSMeYyKdgzBiNyN3lghqvSrstmLdym
         EB297rqxdOpNuwVCuDBQKlYAjt20w/E4Bv9munLY=
Received: by mail-lj1-f172.google.com with SMTP id w3so14030270ljo.5;
        Fri, 11 Sep 2020 19:39:41 -0700 (PDT)
X-Gm-Message-State: AOAM532mz+4/i1Vz7A7D/X2wmJ4qh+tN13Okk2ppl8s1p1Q5m2a9zydI
        cF+Uxmbxf1N2+V8VPWIzZup+SwnEvtOjSR/yMh0=
X-Google-Smtp-Source: ABdhPJytsey538IOnpbeCR8B4v5A2X9XnZH4cx0iSaezGYFiyXrMK3kHBmAwm/JsOOUsi6l7lmd4O1eckw8VgK1cVng=
X-Received: by 2002:a2e:6c08:: with SMTP id h8mr1672796ljc.66.1599878379668;
 Fri, 11 Sep 2020 19:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <1593266228-61125-1-git-send-email-guoren@kernel.org>
 <1593266228-61125-2-git-send-email-guoren@kernel.org> <20200911204512.GA2705@aurel32.net>
In-Reply-To: <20200911204512.GA2705@aurel32.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 12 Sep 2020 10:39:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQiLV8sDE5cnvP=aBog4zaiMvMeieg_JtXwRODky1u3Hg@mail.gmail.com>
Message-ID: <CAJF2gTQiLV8sDE5cnvP=aBog4zaiMvMeieg_JtXwRODky1u3Hg@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] riscv: Fixup static_obj() fail
To:     Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Nick Hu <nickhu@andestech.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's come from mm/usercopy.c
/* Is this address range in the kernel text area? */
static inline void check_kernel_text_object(const unsigned long ptr,
                                            unsigned long n, bool to_user)
{
        unsigned long textlow = (unsigned long)_stext;
        unsigned long texthigh = (unsigned long)_etext;
        unsigned long textlow_linear, texthigh_linear;

        if (overlaps(ptr, n, textlow, texthigh))
                usercopy_abort("kernel text", NULL, to_user, ptr - textlow, n);

The __init_text/data areas will be freed after bootup, so I think it should be:
-        unsigned long textlow = (unsigned long)_stext;
+        unsigned long textlow = (unsigned long)_text;

That means _stext should include init_text/data and _text is only for freeable.


On Sat, Sep 12, 2020 at 5:01 AM Aurelien Jarno <aurelien@aurel32.net> wrote:
>
> Hi,
>
> On 2020-06-27 13:57, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > When enable LOCKDEP, static_obj() will cause error. Because some
> > __initdata static variables is before _stext:
> >
> > static int static_obj(const void *obj)
> > {
> >         unsigned long start = (unsigned long) &_stext,
> >                       end   = (unsigned long) &_end,
> >                       addr  = (unsigned long) obj;
> >
> >         /*
> >          * static variable?
> >          */
> >         if ((addr >= start) && (addr < end))
> >                 return 1;
> >
> > [    0.067192] INFO: trying to register non-static key.
> > [    0.067325] the code is fine but needs lockdep annotation.
> > [    0.067449] turning off the locking correctness validator.
> > [    0.067718] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.7.0-rc7-dirty #44
> > [    0.067945] Call Trace:
> > [    0.068369] [<ffffffe00020323c>] walk_stackframe+0x0/0xa4
> > [    0.068506] [<ffffffe000203422>] show_stack+0x2a/0x34
> > [    0.068631] [<ffffffe000521e4e>] dump_stack+0x94/0xca
> > [    0.068757] [<ffffffe000255a4e>] register_lock_class+0x5b8/0x5bc
> > [    0.068969] [<ffffffe000255abe>] __lock_acquire+0x6c/0x1d5c
> > [    0.069101] [<ffffffe0002550fe>] lock_acquire+0xae/0x312
> > [    0.069228] [<ffffffe000989a8e>] _raw_spin_lock_irqsave+0x40/0x5a
> > [    0.069357] [<ffffffe000247c64>] complete+0x1e/0x50
> > [    0.069479] [<ffffffe000984c38>] rest_init+0x1b0/0x28a
> > [    0.069660] [<ffffffe0000016a2>] 0xffffffe0000016a2
> > [    0.069779] [<ffffffe000001b84>] 0xffffffe000001b84
> > [    0.069953] [<ffffffe000001092>] 0xffffffe000001092
> >
> > static __initdata DECLARE_COMPLETION(kthreadd_done);
> >
> > noinline void __ref rest_init(void)
> > {
> >       ...
> >       complete(&kthreadd_done);
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > ---
> >  arch/riscv/kernel/vmlinux.lds.S | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> > index e6f8016..f3586e3 100644
> > --- a/arch/riscv/kernel/vmlinux.lds.S
> > +++ b/arch/riscv/kernel/vmlinux.lds.S
> > @@ -22,6 +22,7 @@ SECTIONS
> >       /* Beginning of code and text segment */
> >       . = LOAD_OFFSET;
> >       _start = .;
> > +     _stext = .;
> >       HEAD_TEXT_SECTION
> >       . = ALIGN(PAGE_SIZE);
> >
> > @@ -54,7 +55,6 @@ SECTIONS
> >       . = ALIGN(SECTION_ALIGN);
> >       .text : {
> >               _text = .;
> > -             _stext = .;
> >               TEXT_TEXT
> >               SCHED_TEXT
> >               CPUIDLE_TEXT
>
>
> This patch has been backported to kernel 5.8.4. This causes the kernel
> to crash when trying to execute the init process:
>
> [    3.484586] AppArmor: AppArmor sha1 policy hashing enabled
> [    4.749835] Freeing unused kernel memory: 492K
> [    4.752017] Run /init as init process
> [    4.753571] usercopy: Kernel memory overwrite attempt detected to kernel text (offset 507879, size 11)!
> [    4.754838] ------------[ cut here ]------------
> [    4.755651] kernel BUG at mm/usercopy.c:99!
> [    4.756445] Kernel BUG [#1]
> [    4.756815] Modules linked in:
> [    4.757542] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.8.0-1-riscv64 #1 Debian 5.8.7-1
> [    4.758372] epc: ffffffe0003b5120 ra : ffffffe0003b5120 sp : ffffffe07f783ca0
> [    4.758960]  gp : ffffffe000cc7230 tp : ffffffe07f77cec0 t0 : ffffffe000cdafc0
> [    4.759772]  t1 : 0000000000000064 t2 : 0000000000000000 s0 : ffffffe07f783cf0
> [    4.760534]  s1 : ffffffe00095d780 a0 : 000000000000005b a1 : 0000000000000020
> [    4.761309]  a2 : 0000000000000005 a3 : 0000000000000000 a4 : ffffffe000c1f340
> [    4.761848]  a5 : ffffffe000c1f340 a6 : 0000000000000000 a7 : 0000000000000087
> [    4.762684]  s2 : ffffffe000941848 s3 : 000000000007bfe7 s4 : 000000000000000b
> [    4.763500]  s5 : 0000000000000000 s6 : ffffffe00091cc00 s7 : fffffffffffff000
> [    4.764376]  s8 : 0000003ffffff000 s9 : ffffffe0769f3200 s10: 000000000000000b
> [    4.765208]  s11: ffffffe07d548c40 t3 : 0000000000000000 t4 : 000000000001dcd0
> [    4.766059]  t5 : ffffffe000cc8510 t6 : ffffffe000cd64aa
> [    4.766712] status: 0000000000000120 badaddr: 0000000000000000 cause: 0000000000000003
> [    4.768308] ---[ end trace 1f8e733e834d4c3e ]---
> [    4.769129] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    4.770070] SMP: stopping secondary CPUs
> [    4.771110] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
>
> Note that this is with CONFIG_HARDENED_USERCOPY=y
>
> Aurelien
>
> --
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                 http://www.aurel32.net



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
