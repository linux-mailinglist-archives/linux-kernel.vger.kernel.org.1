Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CF52E05EE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 07:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgLVGJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 01:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgLVGJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 01:09:55 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D92C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 22:09:14 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id s26so29254449lfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 22:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+qVOZPWJ62ItCavpYTc2cD7FQ+yxPCY4tR6s3WH6ht4=;
        b=oyaCdNqmtnm9DmdIzM4Jrse7AVPqoYm0yyJ3JLC8E5xyoHDE/mO1WxsGx1PrLn4gY9
         SLkzNPoUMqk2Fv61EMABF8PvBegh58LC5LxVs75ZtvbkPABxFWgOLPvqRrPOWMMW+eTk
         qWzKoVSCkMfvkV8SXqs405FYqhC0UfDmYtzRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+qVOZPWJ62ItCavpYTc2cD7FQ+yxPCY4tR6s3WH6ht4=;
        b=Ys5A7/1IrEonBN4Rh3GKpDFRXeRspgcd9Z5wMPS2uVVqucSeDhM1LSlFW3a3gg3D/q
         ZYce6WnTbu5NERtA2agfWBB7dKul8K+AkKhqE/hy7HPZXeU8nHtGvO2teLqo3iHGmWy2
         mixj0LVdhdqaoRD/tVlKnJhhjA1RidajK/F2ampzcXymDJyBfpGW0Sm8//KGtRhfty3S
         GNZ723IWK4zSof3DurpFqveo9b5LPxi9fZD2EsgjE+L3VRz58HNEEZcyDSgXpyOHL0H5
         FFz+H/Ya/4trx1XKD059XoL3JwG22SkWK5Jx6cev64uaG0OzQZrfyc5y4J/0fkrocw/4
         t04Q==
X-Gm-Message-State: AOAM530wBfTlhhuLxgOC351IHBfl+kZjsqwQdtRuBJDI9dU0gFAk5uEd
        SQ2XrGbu8GRNPEInbpQSLYVhk5KHvG81kmCwQ43WNw==
X-Google-Smtp-Source: ABdhPJxuM+PNBCQukR4WRAomas5niPqhweEV5nrr5YitwfD5fm66ydVnnEjs0jU6z/NDJQcOSnSJ2/8BYs+PR4/WY8s=
X-Received: by 2002:a2e:6112:: with SMTP id v18mr8952215ljb.198.1608617353038;
 Mon, 21 Dec 2020 22:09:13 -0800 (PST)
MIME-Version: 1.0
References: <20201221203719.15988-1-vitaly.wool@konsulko.com> <CAEUhbmVrMEWCds2QRgnUGE4KGakxrYi6Z_EY-meyX33Fy_teoA@mail.gmail.com>
In-Reply-To: <CAEUhbmVrMEWCds2QRgnUGE4KGakxrYi6Z_EY-meyX33Fy_teoA@mail.gmail.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Tue, 22 Dec 2020 07:09:01 +0100
Message-ID: <CAM4kBBJ8MssFvS5Lcm8wGEgF9E88NqyWD8y2SNHq6amT-0R3NQ@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: enable XIP
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bin Meng <bin.meng@windriver.com>,
        Anup Patel <anup@brainfault.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 2:44 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Vitaly,
>
> On Tue, Dec 22, 2020 at 4:39 AM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
> >
> > Introduce XIP (eXecute In Place) support for RISC-V platforms.
> > It allows code to be executed directly from non-volatile storage
> > directly addressable by the CPU, such as QSPI NOR flash which can
> > be found on many RISC-V platforms. This makes way for significant
> > optimization of RAM footprint. The XIP kernel is not compressed
> > since it has to run directly from flash, so it will occupy more
> > space on the non-volatile storage to The physical flash address
> > used to link the kernel object files and for storing it has to
> > be known at compile time and is represented by a Kconfig option.
> >
> > XIP on RISC-V will currently only work on MMU-enabled kernels.
> >
> > Changed in v2:
> > - dedicated macro for XIP address fixup when MMU is not enabled yet
> >   o both for 32-bit and 64-bit RISC-V
> > - SP is explicitly set to a safe place in RAM before __copy_data call
> > - removed redundant alignment requirements in vmlinux-xip.lds.S
> > - changed long -> uintptr_t typecast in __XIP_FIXUP macro.
> >
> > Changed in v3:
> > - rebased against latest for-next
> > - XIP address fixup macro now takes an argument
> > - SMP related fixes
>
> The above changelogs should go below ---

That is very fair, thanks. Will do that for v4.

~Vitaly

> > Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
> > ---
> >  arch/riscv/Kconfig                  |  46 ++++++++-
> >  arch/riscv/Makefile                 |   8 +-
> >  arch/riscv/boot/Makefile            |  13 +++
> >  arch/riscv/include/asm/pgtable.h    |  56 +++++++++--
> >  arch/riscv/kernel/cpu_ops_sbi.c     |   3 +
> >  arch/riscv/kernel/head.S            |  69 +++++++++++++-
> >  arch/riscv/kernel/head.h            |   3 +
> >  arch/riscv/kernel/setup.c           |   8 +-
> >  arch/riscv/kernel/vmlinux-xip.lds.S | 132 ++++++++++++++++++++++++++
> >  arch/riscv/kernel/vmlinux.lds.S     |   6 ++
> >  arch/riscv/mm/init.c                | 142 +++++++++++++++++++++++++---
> >  11 files changed, 460 insertions(+), 26 deletions(-)
> >  create mode 100644 arch/riscv/kernel/vmlinux-xip.lds.S
> >
>
> Regards,
> Bin
