Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0AB2F0BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 05:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbhAKEGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 23:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbhAKEGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 23:06:40 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F91C061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 20:06:00 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id b10so2035489ljp.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 20:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hzsKcFE55evqkbte9pblpk+brr3UPTtNXgfWl4bSkvQ=;
        b=hM/2qZ5oBMHmZ8bIq4Q64okW/khXDZZZYSrngmVEwDaI9HqzAwtw+WxmJ7eyyoQcyF
         251iKCymCS/rjZyfuGfgpCUPIT8RKsh8JIpuUVOrNdwteP36K27NpUZLqVflPsKXoDa5
         Oa0EKaxkigCLQRRTLoNt6/doPd/ipur6+XXsFC6gVY8X0Bjc5uqREYSn2p/Eq9ty8vtM
         FVk4cyCZXEK2labVL98wK0CIuHGzvT+SWV41ev7uv3Bw0KcvtfVyMcqJc92OR50Cuih7
         WqYPHpRiCtegX3uP5OJe/tYF2tQDL3ZU2awVce2MkTUqtO72oqlwL5WbBU/FW9RE0kfi
         5ezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hzsKcFE55evqkbte9pblpk+brr3UPTtNXgfWl4bSkvQ=;
        b=tJV8izb6z4udmPYPvxAJXTcoKAJsrQFiPCBp7GI2iP5/rZqywxm5dPTCcRY8WjJDbK
         +TUDZsfKf6LzWLS5wgrSkQLEvxQ86UlEZ9ir1dJnlKoMPb/ifGTrHDlNc38Mp2JC3Lny
         cRuLpG8ionvNyvMH9/m3ajXc4hIGSJY+4xaudxL46Yna9SzJA3/ULrMX0HDAQFc7ZahH
         JXsfdkws/IwP3V3tJdCuhVcY4qUhXI0Z4aXChox9dWIq5k6SjjoGA8R/eW8IpuRGcGPL
         5LSPMI45Cc1ZWqx5n/Hs+2E3CelrKabLZtsx84TRpE00YCN3EvwmeNQ8hVJOMHoNSXwV
         IToQ==
X-Gm-Message-State: AOAM5331Gr6lLqcaWaWG2p3YGBCn05ywriMt9zor5IgkQp10EjHOWyXK
        TxcPezX9OtxDUA6V7dmJKgeIRh+gw384Ps+49lGzow==
X-Google-Smtp-Source: ABdhPJwFrWbgeTNNnn3V/4rMxmo8AroirXBbsDtnq5zOogzgkAe41SvHr0K2TNhq1Vuj2W6HdVR0ckBKuNfHVXxQ6sw=
X-Received: by 2002:a05:651c:48b:: with SMTP id s11mr6414476ljc.28.1610337958991;
 Sun, 10 Jan 2021 20:05:58 -0800 (PST)
MIME-Version: 1.0
References: <20210107092652.3438696-1-atish.patra@wdc.com>
In-Reply-To: <20210107092652.3438696-1-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 11 Jan 2021 09:35:45 +0530
Message-ID: <CAAhSdy2w=uY-Bp_bKzmVxRwcF+-xwCtvKtZ0e-J5PTke-+m5Pg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Assorted fixes for RV32
To:     Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Thu, Jan 7, 2021 at 2:57 PM Atish Patra <atish.patra@wdc.com> wrote:
>
> This series fixes various issues observed in latest kernel on RV32.
> The first two patches fixes an resource tree introduced in 5.11-rc1
> while the last two fixes the case where 2GB physical memory is used
> on RV32.
>
> There are may be better way to fix the issue pointed out in PATCH 3
> as it seems a generic kernel issue where kernel pointers can not use
> last 4k of addressable memory. I am open to other better alternate
> suggestions.
>
> Atish Patra (4):
> RISC-V: Do not allocate memblock while iterating reserved memblocks
> RISC-V: Set current memblock limit
> RISC-V: Fix L1_CACHE_BYTES for RV32
> RISC-V: Fix maximum allowed phsyical memory for RV32

Please consider these fixes for Linux-5.11-rcX.

>
> arch/riscv/Kconfig             |  6 ++++--
> arch/riscv/include/asm/cache.h |  4 ++++
> arch/riscv/kernel/setup.c      | 24 +++++++++++++-----------
> arch/riscv/mm/init.c           | 16 ++++++++++++++--
> 4 files changed, 35 insertions(+), 15 deletions(-)
>
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Regards,
Anup
