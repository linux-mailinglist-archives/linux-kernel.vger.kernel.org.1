Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65892DCDE5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 09:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgLQIyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 03:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgLQIyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 03:54:07 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D808C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 00:53:27 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id k78so25147669ybf.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 00:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jl8kFReN3xlQEVNrxs/A2c7FLmN/hmcFGpm4h9sxYP8=;
        b=hJ3bHMmCImusNFvOIXd8Uyu8m1+AbWrG9BQv+vn0WA0G/hmKyxwht8OYy205ytn+WU
         pxsifaLDB57CtA/PRsmaVfdygYmeJCV6Ma4N9zb+0PhBPlx3bA2Jff86OjvNIGMlNRTf
         1sDhwZe9sWe7zGnY3YSEdzrIq07n1H26i35kNrbqowqrASVLSQ7V1AYzseLQFAGSi3Qz
         mZRU/g87QQBy1FE4yxWOwaFxhhlMPfi5m1vWw4veX8IniNvrwhXVfRHGZuTOsXRsY1IJ
         PHT2lo/t2/s8I59KVNbL/YxqYFYalpn7kBDUf30ayDEXnOOgt4JUyJRxLPMH1BtWZQxz
         RU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jl8kFReN3xlQEVNrxs/A2c7FLmN/hmcFGpm4h9sxYP8=;
        b=dy8O7B2Cw7a7HKHrmd2ZJzmscMoE+3ofklNWCwSgxCKb6U6ureh2xJ2+qOUEImDVnm
         CRm9X8KJQlOseTWJ9YrdVWfhFyy8ltCaXxea1EGszohIARw0OXBMghB2uUjUilaHMAMu
         +dbIZlHro9FY44jxh6cQkJ8XBGziwfFy6HSz2lvmw30lowoX0oA3K3Mqdvv2ne9+oFVw
         +/5viFmAVd9V2IdRzkHNTaXPmfkmFUK3/GlAirov/pQIUpRBcaGYogWdcjvpczg/RUCm
         jGFbE4YsDp37qlqoHrU0cYd7VngNIzicaFuRDWDzThQq5pViAkO/aezb5kTp/L5T+XLj
         E9Qg==
X-Gm-Message-State: AOAM531ieIMycWaBN83seLKDLjC2bn2uasezSV5WQbhxh9lVgOEFj/2y
        qe8FvNxrnliyjgKO1hiI66qig6jsZLWHyTpYLEo=
X-Google-Smtp-Source: ABdhPJy7OcJJb/8ON4fVb9DXuTUtW638/7SfECwc3GsnZrqj2EMDfvOF68paNQHgObns0xj3oJ7yt6aT34z7PadgF4U=
X-Received: by 2002:a25:4d7:: with SMTP id 206mr34066987ybe.306.1608195206859;
 Thu, 17 Dec 2020 00:53:26 -0800 (PST)
MIME-Version: 1.0
References: <20201217074855.1948743-1-atish.patra@wdc.com> <CAEUhbmV-AirwmVDN9xWi8eLwH53PFdoc+eU3sKzosA19Xd36Ag@mail.gmail.com>
 <CAOnJCUJSKn-QNwKCcHXc+kYtuwFQE2qatnOtGfqTOG0_Jzt4og@mail.gmail.com>
In-Reply-To: <CAOnJCUJSKn-QNwKCcHXc+kYtuwFQE2qatnOtGfqTOG0_Jzt4og@mail.gmail.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 17 Dec 2020 16:53:15 +0800
Message-ID: <CAEUhbmUXXH2P=jagTx88J86ec=C9eur9fkfGM=OdN7oqmD7W0g@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Fix usage of memblock_enforce_memory_limit
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atish,

On Thu, Dec 17, 2020 at 4:43 PM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Thu, Dec 17, 2020 at 12:12 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Hi Atish,
> >
> > On Thu, Dec 17, 2020 at 3:49 PM Atish Patra <atish.patra@wdc.com> wrote:
> > >
> > > memblock_enforce_memory_limit accepts the maximum memory size not the last
> > > address. Fix the function invocation correctly.
> > >
> > > Fixes: 1bd14a66ee52 ("RISC-V: Remove any memblock representing unusable memory area")
> > >
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > ---
> > >  arch/riscv/mm/init.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> >
> > Thank you for working on this.
> >
> > Tested with QEMU 5.2.0 on 32-bit 'virt' and 'sifive_u', with
> > fw_jump.bin used as the -bios.
>
> fw_dynamic should also work unless you are using more than 1G of memory.
> Linux kernel can only support 1G of memory for RV32. The current

I have always been using -m 2G for testing both 32-bit and 64-bit.
32-bit 'virt' with 2G memory boots the 32-bit kernel fine.

$ qemu-system-riscv32 -nographic -M virt -m 2G -smp 4 -kernel
arch/riscv/boot/Image -bios fw_jump.bin

> Kconfig is bit misleading and
> I will send a patch to update the description.
>
> However, kernel should be able to ignore any memory beyond what it can
> address and continue.
> I will investigate more.
>
> > 32-bit 'virt' boots, but 32-bit 'sifive_u' still does not boot, which
> > should be another issue because reverting the original 1bd14a66ee52 it
> > still does not help 'sifive_u'.
> >
>
> Are you using more than 1G of memory ? Let me know if the kernel boots
> if you use 1G.

Kernel does not boot with 1G memory on 32-bit 'sifive_u', either with
fw_jump.bin or fw_dynamic.bin.

$ qemu-system-riscv32 -nographic -M sifive_u -m 1G -smp 5 -kernel
arch/riscv/boot/Image -bios fw_jump.bin

>
> > Tested-by: Bin Meng <bin.meng@windriver.com>
> >
> > I believe the following tag should also be added and patch cc'ed to
> > stable-kernel:
> >
> > Reported-by: Bin Meng <bin.meng@windriver.com>
> > Cc: <stable@vger.kernel.org> # 5.10

Regards,
Bin
