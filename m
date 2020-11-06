Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA992A8D36
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgKFCzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:55:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgKFCzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:55:11 -0500
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45F382078E;
        Fri,  6 Nov 2020 02:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604631310;
        bh=GCRu5Nj6jlFu7EoC6UyDydSyAjZGCvEP1u13Yu2YJkU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ngBOoevtyMiaZoS5dLNMl5K6SHrIs+qW8jE+nVSG26e8PE1P2kMQhNldJVD/Nog8u
         RislWWMtlbuzn0I/jE9+/1QMnhK1mYjuv1BBuCWURKFjJJFkw7v5qaUVYs5u0nS3ZL
         ftVlSp2BZVAQlKp12wu4US0Z9DJWG89A4riVByoI=
Received: by mail-lj1-f173.google.com with SMTP id 2so3748520ljj.13;
        Thu, 05 Nov 2020 18:55:10 -0800 (PST)
X-Gm-Message-State: AOAM531VXy7UXKn11apAA3or1FHTewnLNN2UTaWt52256PqtUJCptw8B
        0ifW8G8RiMBvuwYX6L9tJ4l2XIZbCLMfLOAVaO8=
X-Google-Smtp-Source: ABdhPJzfbFpuBLZhmEP5T24pYyEQWLJ9bVNG3rcuQ7VBcP+PYmdLj4SV5oT0cm306fdrgA6+20tTRV7rJ7SrePKYJRk=
X-Received: by 2002:a2e:8816:: with SMTP id x22mr1812466ljh.377.1604631308478;
 Thu, 05 Nov 2020 18:55:08 -0800 (PST)
MIME-Version: 1.0
References: <1602918377-23573-2-git-send-email-guoren@kernel.org> <mhng-c3f5e2b4-0467-42f6-9f5b-e66ade70eef2@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-c3f5e2b4-0467-42f6-9f5b-e66ade70eef2@palmerdabbelt-glaptop1>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 6 Nov 2020 10:54:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRw57smCihUB7fWf32WgRwJBV86-xT6pxHstLSrCG119w@mail.gmail.com>
Message-ID: <CAJF2gTRw57smCihUB7fWf32WgRwJBV86-xT6pxHstLSrCG119w@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] RISC-V: Implement ptrace regs and stack API
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alan Kao <alankao@andestech.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>, linux-csky@vger.kernel.org,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        =?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 9:03 AM Palmer Dabbelt <palmerdabbelt@google.com> wr=
ote:
>
> On Sat, 17 Oct 2020 00:06:09 PDT (-0700), guoren@kernel.org wrote:
> > From: Patrick St=C3=A4hlin <me@packi.ch>
> >
> > Needed for kprobes support. Copied and adapted from arm64 code.
> >
> > Guo Ren fixup pt_regs type for linux-5.8-rc1.
> >
> > Signed-off-by: Patrick St=C3=A4hlin <me@packi.ch>
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Reviewed-by: Pekka Enberg <penberg@kernel.org>
> > Reviewed-by: Zong Li <zong.li@sifive.com>
> > Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  arch/riscv/Kconfig              |  1 +
> >  arch/riscv/include/asm/ptrace.h | 29 ++++++++++++
> >  arch/riscv/kernel/ptrace.c      | 99 +++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 129 insertions(+)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index b7821ac..e6424d8b 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -87,6 +87,7 @@ config RISCV
> >       select SPARSE_IRQ
> >       select SYSCTL_EXCEPTION_TRACE
> >       select THREAD_INFO_IN_TASK
> > +     select HAVE_REGS_AND_STACK_ACCESS_API
>
> We alphabetize these now -- I'd usually just fix it, but there's a
> Signed-off-by issue later in the patch set.
ok, I'll fix it and rebase 5.10-rc2.


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
