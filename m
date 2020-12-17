Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D462DDC18
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 00:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbgLQXpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 18:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732406AbgLQXpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 18:45:19 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBB5C0611CE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 15:44:28 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id n4so343892iow.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 15:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YEsoTw48HMH8u6aKM5ZpQGVmiSJ4UnL8pOP47zgvLqg=;
        b=AIS4fbcrDeyed9MR+yN2RrrrnUxX9oiei4nj/N9mZ4k332HAQBBeKxZQ2t6Phuhqji
         JTUeuxE7UwMIi4tMkfeHX1gl8RBiuU4vYPe7Kgqd84BwrrX2J1IPSI7LKg0+cwmt7e6Q
         0nmYSu2TD6tpiGu6AUoTRb9Xsyt8+XdYqe8XU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YEsoTw48HMH8u6aKM5ZpQGVmiSJ4UnL8pOP47zgvLqg=;
        b=C6qItO+TWdQvvAemir1NDYUGts5D2avqttVRysDZXbtANEBWnSBOtd/LoyJXAmcoIN
         k7TE9fE5zNkNYqWm7Se+tzZmXtHCuhANNqebM4BCzwit9FWaKECFj19JOXZrjvYmF3TL
         hnVi5A0XQb/j8SKmyCc/OolkF55rdbpWNNi6wtXo86IDKFhMBb0NZAG/vRMCunoZjmkJ
         pvsUrJvqDRdJyuJrC0sacJxqrfTfG5gbUneWiBFODyaozDNtrNXT3EKii3N4oYUmh0bG
         LAq1tVGf5j73sdhrCSoLGn+kQvPKulZyruogFJuJeSpYrQ3adLf554dM/LXTAyYUM45v
         JzHg==
X-Gm-Message-State: AOAM5330LOxXrmAjbzOsbXgNEYiT8MiP8Hc2dAeBeQ3SIMul18Ayg93L
        YTX9TfF+xnd8oGnvychNqiZqQs/R/N+j552XMSEF
X-Google-Smtp-Source: ABdhPJxj1CDRaWz46oHY3Jchfo7ka+jUSepiJY1e2m3W1CRcmz+5I8hUc4CDF0PrQrRT7sznVrdT0Tr5pQOCXQETvRk=
X-Received: by 2002:a6b:2c52:: with SMTP id s79mr1494649ios.53.1608248668030;
 Thu, 17 Dec 2020 15:44:28 -0800 (PST)
MIME-Version: 1.0
References: <20201217074855.1948743-1-atish.patra@wdc.com> <CAEUhbmV-AirwmVDN9xWi8eLwH53PFdoc+eU3sKzosA19Xd36Ag@mail.gmail.com>
 <CAOnJCUJSKn-QNwKCcHXc+kYtuwFQE2qatnOtGfqTOG0_Jzt4og@mail.gmail.com> <CAEUhbmUXXH2P=jagTx88J86ec=C9eur9fkfGM=OdN7oqmD7W0g@mail.gmail.com>
In-Reply-To: <CAEUhbmUXXH2P=jagTx88J86ec=C9eur9fkfGM=OdN7oqmD7W0g@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 17 Dec 2020 15:44:17 -0800
Message-ID: <CAOnJCUJJCSjCYfALAUXJoZbChi617Nd_Yeu6o4q_jyvoofQE3Q@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Fix usage of memblock_enforce_memory_limit
To:     Bin Meng <bmeng.cn@gmail.com>
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

On Thu, Dec 17, 2020 at 12:53 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Atish,
>
> On Thu, Dec 17, 2020 at 4:43 PM Atish Patra <atishp@atishpatra.org> wrote:
> >
> > On Thu, Dec 17, 2020 at 12:12 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > Hi Atish,
> > >
> > > On Thu, Dec 17, 2020 at 3:49 PM Atish Patra <atish.patra@wdc.com> wrote:
> > > >
> > > > memblock_enforce_memory_limit accepts the maximum memory size not the last
> > > > address. Fix the function invocation correctly.
> > > >
> > > > Fixes: 1bd14a66ee52 ("RISC-V: Remove any memblock representing unusable memory area")
> > > >
> > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > ---
> > > >  arch/riscv/mm/init.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > >
> > > Thank you for working on this.
> > >
> > > Tested with QEMU 5.2.0 on 32-bit 'virt' and 'sifive_u', with
> > > fw_jump.bin used as the -bios.
> >
> > fw_dynamic should also work unless you are using more than 1G of memory.
> > Linux kernel can only support 1G of memory for RV32. The current
>
> I have always been using -m 2G for testing both 32-bit and 64-bit.
> 32-bit 'virt' with 2G memory boots the 32-bit kernel fine.
>

2GB issue with fw_dynamic is fixed with this patch.

https://www.mail-archive.com/qemu-devel@nongnu.org/msg768341.html

> $ qemu-system-riscv32 -nographic -M virt -m 2G -smp 4 -kernel
> arch/riscv/boot/Image -bios fw_jump.bin
>
> > Kconfig is bit misleading and
> > I will send a patch to update the description.
> >
> > However, kernel should be able to ignore any memory beyond what it can
> > address and continue.
> > I will investigate more.
> >
> > > 32-bit 'virt' boots, but 32-bit 'sifive_u' still does not boot, which
> > > should be another issue because reverting the original 1bd14a66ee52 it
> > > still does not help 'sifive_u'.
> > >
> >
> > Are you using more than 1G of memory ? Let me know if the kernel boots
> > if you use 1G.
>
> Kernel does not boot with 1G memory on 32-bit 'sifive_u', either with
> fw_jump.bin or fw_dynamic.bin.
>
> $ qemu-system-riscv32 -nographic -M sifive_u -m 1G -smp 5 -kernel
> arch/riscv/boot/Image -bios fw_jump.bin
>

This happened because of the incorrect loading address. It is already
fixed by Alistair.
https://www.mail-archive.com/qemu-devel@nongnu.org/msg768279.html

> >
> > > Tested-by: Bin Meng <bin.meng@windriver.com>
> > >

Thanks for testing it.

> > > I believe the following tag should also be added and patch cc'ed to
> > > stable-kernel:
> > >
> > > Reported-by: Bin Meng <bin.meng@windriver.com>
> > > Cc: <stable@vger.kernel.org> # 5.10
>

Sure. I will add that and resend it.

> Regards,
> Bin



-- 
Regards,
Atish
