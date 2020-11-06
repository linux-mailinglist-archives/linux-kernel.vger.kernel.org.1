Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC0F2A8D41
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgKFC5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:57:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgKFC5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:57:09 -0500
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB80B20885;
        Fri,  6 Nov 2020 02:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604631428;
        bh=9rQRIBsHfZeDxfMqnHjDf3pUoaqjw7mhb/AQ10vMDoY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TF7x00ZgQVa4HaGnSQPmDiTyB8y+VIQoCzJV3YdhsaaRLyFkTM9ISom0fByffhcI1
         pBZBzMw9pSGGggy6eUaKobaD6IWzYqTcZEfnah5VBBFPN+U/8aODKos2zvTkGnE6/X
         iTrY+Q7WCTabdB4kIhBAdrrlNJU9vVaKgMtfmRRU=
Received: by mail-lj1-f177.google.com with SMTP id l10so3780288lji.4;
        Thu, 05 Nov 2020 18:57:07 -0800 (PST)
X-Gm-Message-State: AOAM533iAYBPjJ1o+S8PD8TvKFR0STdCkW6sNlLLWWLr3SkramzaC2P8
        Hh/ACuWjlhLVirscn7d9U1CsIadixfR7rkGUyHA=
X-Google-Smtp-Source: ABdhPJyS549mSsbY71592hwkiYhz+BcFJErkk2ka5vmMUXvgndKh9GeAWhQ5JZMC4w2XtW9dc3WPYMqmypHc7huC/0s=
X-Received: by 2002:a2e:8816:: with SMTP id x22mr1814521ljh.377.1604631425962;
 Thu, 05 Nov 2020 18:57:05 -0800 (PST)
MIME-Version: 1.0
References: <1602918377-23573-6-git-send-email-guoren@kernel.org> <mhng-7d7afc22-b857-4f64-868e-0c7aad7f8f6a@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-7d7afc22-b857-4f64-868e-0c7aad7f8f6a@palmerdabbelt-glaptop1>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 6 Nov 2020 10:56:54 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSWubMT3hk4pMg5my9=6G+U+8+Wx_Hzud+rxLgn6Ah6kw@mail.gmail.com>
Message-ID: <CAJF2gTSWubMT3hk4pMg5my9=6G+U+8+Wx_Hzud+rxLgn6Ah6kw@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] riscv: Add kprobes supported
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
        Guo Ren <guoren@linux.alibaba.com>,
        Bjorn Topel <bjorn.topel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 9:02 AM Palmer Dabbelt <palmerdabbelt@google.com> wr=
ote:
>
> On Sat, 17 Oct 2020 00:06:13 PDT (-0700), guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > This patch enables "kprobe & kretprobe" to work with ftrace
> > interface. It utilized software breakpoint as single-step
> > mechanism.
> >
> > Some instructions which can't be single-step executed must be
> > simulated in kernel execution slot, such as: branch, jal, auipc,
> > la ...
> >
> > Some instructions should be rejected for probing and we use a
> > blacklist to filter, such as: ecall, ebreak, ...
> >
> > We use ebreak & c.ebreak to replace origin instruction and the
> > kprobe handler prepares an executable memory slot for out-of-line
> > execution with a copy of the original instruction being probed.
> > In execution slot we add ebreak behind original instruction to
> > simulate a single-setp mechanism.
> >
> > The patch is based on packi's work [1] and csky's work [2].
> >  - The kprobes_trampoline.S is all from packi's patch
> >  - The single-step mechanism is new designed for riscv without hw
> >    single-step trap
> >  - The simulation codes are from csky
> >  - Frankly, all codes refer to other archs' implementation
> >
> >  [1] https://lore.kernel.org/linux-riscv/20181113195804.22825-1-me@pack=
i.ch/
> >  [2] https://lore.kernel.org/linux-csky/20200403044150.20562-9-guoren@k=
ernel.org/
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Co-Developed-by: Patrick St=C3=A4hlin <me@packi.ch>
>
> Checkpatch says
>
>     WARNING: 'Co-developed-by:' is the preferred signature form
>     #108:
>     Co-Developed-by: Patrick St=C3=A4hlin <me@packi.ch>
>
>     WARNING: Co-developed-by: must be immediately followed by Signed-off-=
by:
>     #108:
>     Co-Developed-by: Patrick St=C3=A4hlin <me@packi.ch>
>     Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
>
> There's some other checkpatch warnings throughout the patch set, but this=
 is
> one I'm not supposed to fix up.  Can one of you re-post the patches with =
the
> correct DCO?
Ok, I'll fix it up in V5 and rebase 5.10-rc2

--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
