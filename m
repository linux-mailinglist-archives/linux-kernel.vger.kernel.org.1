Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173B82B3204
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 04:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgKODGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 22:06:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbgKODGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 22:06:06 -0500
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEC412417B;
        Sun, 15 Nov 2020 03:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605409566;
        bh=PcClpXu3KiOwaaUagTIiQI2iPEfsvKH5yU8G9nBQ3EA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vB7zggMFq2DHn8xvFqn4EjCMyTHILpnMqGUS//DNHMbF0AEupaISKIQBFDwoCrUlZ
         GO3SLR1mKnRE+K+XpRdGlOoU2E0nQ8UEnHN7+cNqo0MHEI58lgRTinIiWOiJxTy2+5
         1uFy4RebSMEbJVRUcVGycxPuQWqAmllWEQGHzy3c=
Received: by mail-lf1-f53.google.com with SMTP id r9so19817651lfn.11;
        Sat, 14 Nov 2020 19:06:05 -0800 (PST)
X-Gm-Message-State: AOAM530ojJEqvCwyITaAHyJkHSfVPZSIGx96ZiFHmUBp0pt9LkxFsWqJ
        DC6LjMWgsX9LMqab4eOPQNB1jRzDqy6l8yzX3oA=
X-Google-Smtp-Source: ABdhPJy7AM5rppSQoupCrOrC1VAmGG/BLptOkWdz7cLxMYo/htpzH163GWy1eTrOW3pvsQD8GpjaBPiPEPgy5+sCWvA=
X-Received: by 2002:a19:fc0f:: with SMTP id a15mr3152753lfi.248.1605409563974;
 Sat, 14 Nov 2020 19:06:03 -0800 (PST)
MIME-Version: 1.0
References: <1603024697-30080-1-git-send-email-guoren@kernel.org> <202011131457.63270B286@keescook>
In-Reply-To: <202011131457.63270B286@keescook>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 15 Nov 2020 11:05:52 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT6j3YQJBy6C4Rz-wfYd7r7FkWLV+q1G7NHzBzUQ6iVqw@mail.gmail.com>
Message-ID: <CAJF2gTT6j3YQJBy6C4Rz-wfYd7r7FkWLV+q1G7NHzBzUQ6iVqw@mail.gmail.com>
Subject: Re: [PATCH v4] riscv: Enable per-task stack canaries
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Atish Patra <atish.patra@wdc.com>, cooper.qu@linux.alibaba.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

Could you help move the patch into your next-tree with Kees' review added?

On Sat, Nov 14, 2020 at 6:57 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Sun, Oct 18, 2020 at 12:38:17PM +0000, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > This enables the use of per-task stack canary values if GCC has
> > support for emitting the stack canary reference relative to the
> > value of tp, which holds the task struct pointer in the riscv
> > kernel.
> >
> > After compare arm64 and x86 implementations, seems arm64's is more
> > flexible and readable. The key point is how gcc get the offset of
> > stack_canary from gs/el0_sp.
> >
> > x86: Use a fix offset from gs, not flexible.
> >
> > struct fixed_percpu_data {
> >       /*
> >        * GCC hardcodes the stack canary as %gs:40.  Since the
> >        * irq_stack is the object at %gs:0, we reserve the bottom
> >        * 48 bytes of the irq stack for the canary.
> >        */
> >       char            gs_base[40]; // :(
> >       unsigned long   stack_canary;
> > };
> >
> > arm64: Use -mstack-protector-guard-offset & guard-reg
> >       gcc options:
> >       -mstack-protector-guard=sysreg
> >       -mstack-protector-guard-reg=sp_el0
> >       -mstack-protector-guard-offset=xxx
> >
> > riscv: Use -mstack-protector-guard-offset & guard-reg
> >       gcc options:
> >       -mstack-protector-guard=tls
> >       -mstack-protector-guard-reg=tp
> >       -mstack-protector-guard-offset=xxx
> >
> >  GCC's implementation has been merged:
> >  commit c931e8d5a96463427040b0d11f9c4352ac22b2b0
> >  Author: Cooper Qu <cooper.qu@linux.alibaba.com>
> >  Date:   Mon Jul 13 16:15:08 2020 +0800
> >
> >      RISC-V: Add support for TLS stack protector canary access
> >
> > In the end, these codes are inserted by gcc before return:
> >
> > *  0xffffffe00020b396 <+120>:   ld      a5,1008(tp) # 0x3f0
> > *  0xffffffe00020b39a <+124>:   xor     a5,a5,a4
> > *  0xffffffe00020b39c <+126>:   mv      a0,s5
> > *  0xffffffe00020b39e <+128>:   bnez    a5,0xffffffe00020b61c <_do_fork+766>
> >    0xffffffe00020b3a2 <+132>:   ld      ra,136(sp)
> >    0xffffffe00020b3a4 <+134>:   ld      s0,128(sp)
> >    0xffffffe00020b3a6 <+136>:   ld      s1,120(sp)
> >    0xffffffe00020b3a8 <+138>:   ld      s2,112(sp)
> >    0xffffffe00020b3aa <+140>:   ld      s3,104(sp)
> >    0xffffffe00020b3ac <+142>:   ld      s4,96(sp)
> >    0xffffffe00020b3ae <+144>:   ld      s5,88(sp)
> >    0xffffffe00020b3b0 <+146>:   ld      s6,80(sp)
> >    0xffffffe00020b3b2 <+148>:   ld      s7,72(sp)
> >    0xffffffe00020b3b4 <+150>:   addi    sp,sp,144
> >    0xffffffe00020b3b6 <+152>:   ret
> >    ...
> > *  0xffffffe00020b61c <+766>:   auipc   ra,0x7f8
> > *  0xffffffe00020b620 <+770>:   jalr    -1764(ra) # 0xffffffe000a02f38 <__stack_chk_fail>
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>
> Thanks for getting this working! It looks good to me. :)
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
