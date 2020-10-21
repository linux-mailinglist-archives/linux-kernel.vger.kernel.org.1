Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92E7294957
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 10:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395244AbgJUI1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 04:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394683AbgJUI1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 04:27:16 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 390A0222C8;
        Wed, 21 Oct 2020 08:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603268835;
        bh=nMmI8qRuAv1yyZjH2PDs0VpZ8HlNElzwHwOCPCUV/wM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vbVMF2Ffjd0/ArQ/MNVOMx4NHX8jFUMBuyywm7cYqrUxbH/kJA8pM+ielLTVu5zAh
         5Bhtxb1OHGBZwGIrgZYJkVw8sLvV8qSBTC5ubJBa/AmC9Dpay0EZBMCNd5bGiPSvI0
         5CA520/c2cUrg41SNdPYnbDJlWmBJ9CuIkoIwVI0=
Received: by mail-lf1-f50.google.com with SMTP id r127so1945575lff.12;
        Wed, 21 Oct 2020 01:27:15 -0700 (PDT)
X-Gm-Message-State: AOAM533O0nE/ui9/hEBfPFJR0wXyQq6KxpLITTKaBbtozzOogw+Xn4lj
        CWHy3y+4uJ75duWz6Q65x+u6FY9wQRz17FEYKiE=
X-Google-Smtp-Source: ABdhPJyVwP5SKU7CNKU3RSFKHT0y1pGyDfX2/XwsNk97u9k6um7/ZanN9MPhONY1QqNPV9ltPXGduJx8MkjDIi5j6zQ=
X-Received: by 2002:ac2:5a4e:: with SMTP id r14mr737881lfn.451.1603268833344;
 Wed, 21 Oct 2020 01:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <1602918377-23573-1-git-send-email-guoren@kernel.org>
 <1602918377-23573-10-git-send-email-guoren@kernel.org> <CAOnJCU+oTRcJ2p8WQDX5P-EsOHmkn3kP9s54VQa+iw2wXDvzkg@mail.gmail.com>
 <CAJF2gTSU+M+b+bn5zH_EyE7Ksh=5+ZkO8LkAn=Tm-p45CgYW1w@mail.gmail.com> <20201020164121.32626e45@gandalf.local.home>
In-Reply-To: <20201020164121.32626e45@gandalf.local.home>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 21 Oct 2020 16:27:02 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSpcNAzhic9KTSygtjSbyTerA3VLFb2ziFu6uSGxgAhfg@mail.gmail.com>
Message-ID: <CAJF2gTSpcNAzhic9KTSygtjSbyTerA3VLFb2ziFu6uSGxgAhfg@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] riscv: Fixup lockdep_assert_held(&text_mutex) in patch_insn_write
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Atish Patra <atishp@atishpatra.org>, Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alan Kao <alankao@andestech.com>,
        =?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>,
        Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why?

funca:
nop                   addi  sp,sp, -8
nop                   sd ra, 0(sp)
nop, nop           auipc ra, 0x?
nop, nop  ->      jalr -?(ra)
nop                   ld ra,0(sp)
nop                   addi sp,sp, 8

When CPU0 has only changed half of them, CPU1 call funca then CPU1 broken.

On Wed, Oct 21, 2020 at 4:41 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 20 Oct 2020 19:18:01 +0800
> Guo Ren <guoren@kernel.org> wrote:
>
> > > What platform are you testing ? We are seeing a crash while enabling
> > > any of the tracers multiple times
> > > on Qemu/HiFive Unleashed.
> > I use qemu for testing. I've changed dynamic ftrace mechanism from
> > mcount to -fpatchable-entry.
> >
> > The problem is made by the lockdep checking of text_mutex.
>
> If you are switching to "patchable-entry" you shouldn't need to use
> stop_machine for the updates. No?
>
> -- Steve



--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
