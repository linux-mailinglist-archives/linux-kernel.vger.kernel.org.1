Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6918C2E0404
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 02:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgLVBpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 20:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgLVBpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 20:45:00 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B308C061793
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 17:44:20 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id v67so10455825ybi.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 17:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YH3kWY/9FTGGbdzmNW9iq4F93NRlfV9MWRvEtUM4SS0=;
        b=rjmLASfuwY28xHGdpeV19G1UBOLlHHOdWjZgjVW/XmS9DcoS+OXS0kiWoh4378uujl
         jy4nUBTNtXJeExUNXmxcA5VTBzKFrJlOJ2sOZyQv11+B4iXErsaCHCzUoxMX725JJSVF
         zhQkcLI14tlflcdajcQWTyYJbAeqtkDPCmbJc9Ln8iqPqk8msY9HfFKhXbY99zj3UD/I
         VvsXaWkO+OWCkmvrE/ekjrAjVWSkBOBNBorhdxd2kdrigyouJPKHQXxvgwBRDuvfNvDZ
         p/HhrGC5McY2W+sJ3ZvDlJc3TYVljC4KerJW6Fvm3XpnZxaPUs39Ms8QfdI1c8QUVIDL
         ueJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YH3kWY/9FTGGbdzmNW9iq4F93NRlfV9MWRvEtUM4SS0=;
        b=CPtKdgDH42C8snxE6Zh0XmfROsf1PSgZktu9xZdUo2uWwr0LCO8lI1YUHlFCnUN6Lo
         p7u3HlgP/uj8xr4aM5S+D93W4F8Iw8jXFIXmZjC4Yg4VzJp3/KhrNr/iW2TZIFOQq9pI
         +5FXlV1Bw49svevDdPCxKWtmKWpv3AnAevMY77QDV1VEIU0kh1QnIsyNDErOx+rOpGEX
         4DSnrLu16bxarSbIG68BMPPS7G0ZLtHzZqq3DDx/yKjNsIg3u4YdU9W6ohJNTuyCndVE
         ZrKx5nD9/vGj+dndMeLfVFxXRJAovargH8JoXJtvGcgJOq0/rTNarVK9gWswWRcevxRj
         u9Pg==
X-Gm-Message-State: AOAM5316Dms65AJQZcPKp85+9ReDMrGke6ZO83Vgeg1ZH4mJpj441zr2
        rhKbSwKze4ioqIadAfEGjKLACDKs26dERe/c3NQ=
X-Google-Smtp-Source: ABdhPJysp9vMmw/VrIF8je/96pRXtsRwVglS1oOcwhaM9qgwQUdK1kNb9gWC9DWMJURPZkbZN/TYBVB5HPX0fjC4np8=
X-Received: by 2002:a05:6902:210:: with SMTP id j16mr26754851ybs.122.1608601459692;
 Mon, 21 Dec 2020 17:44:19 -0800 (PST)
MIME-Version: 1.0
References: <20201221203719.15988-1-vitaly.wool@konsulko.com>
In-Reply-To: <20201221203719.15988-1-vitaly.wool@konsulko.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Tue, 22 Dec 2020 09:44:08 +0800
Message-ID: <CAEUhbmVrMEWCds2QRgnUGE4KGakxrYi6Z_EY-meyX33Fy_teoA@mail.gmail.com>
Subject: Re: [PATCH v3] RISC-V: enable XIP
To:     Vitaly Wool <vitaly.wool@konsulko.com>
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

Hi Vitaly,

On Tue, Dec 22, 2020 at 4:39 AM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
>
> Introduce XIP (eXecute In Place) support for RISC-V platforms.
> It allows code to be executed directly from non-volatile storage
> directly addressable by the CPU, such as QSPI NOR flash which can
> be found on many RISC-V platforms. This makes way for significant
> optimization of RAM footprint. The XIP kernel is not compressed
> since it has to run directly from flash, so it will occupy more
> space on the non-volatile storage to The physical flash address
> used to link the kernel object files and for storing it has to
> be known at compile time and is represented by a Kconfig option.
>
> XIP on RISC-V will currently only work on MMU-enabled kernels.
>
> Changed in v2:
> - dedicated macro for XIP address fixup when MMU is not enabled yet
>   o both for 32-bit and 64-bit RISC-V
> - SP is explicitly set to a safe place in RAM before __copy_data call
> - removed redundant alignment requirements in vmlinux-xip.lds.S
> - changed long -> uintptr_t typecast in __XIP_FIXUP macro.
>
> Changed in v3:
> - rebased against latest for-next
> - XIP address fixup macro now takes an argument
> - SMP related fixes

The above changelogs should go below ---

> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
> ---
>  arch/riscv/Kconfig                  |  46 ++++++++-
>  arch/riscv/Makefile                 |   8 +-
>  arch/riscv/boot/Makefile            |  13 +++
>  arch/riscv/include/asm/pgtable.h    |  56 +++++++++--
>  arch/riscv/kernel/cpu_ops_sbi.c     |   3 +
>  arch/riscv/kernel/head.S            |  69 +++++++++++++-
>  arch/riscv/kernel/head.h            |   3 +
>  arch/riscv/kernel/setup.c           |   8 +-
>  arch/riscv/kernel/vmlinux-xip.lds.S | 132 ++++++++++++++++++++++++++
>  arch/riscv/kernel/vmlinux.lds.S     |   6 ++
>  arch/riscv/mm/init.c                | 142 +++++++++++++++++++++++++---
>  11 files changed, 460 insertions(+), 26 deletions(-)
>  create mode 100644 arch/riscv/kernel/vmlinux-xip.lds.S
>

Regards,
Bin
