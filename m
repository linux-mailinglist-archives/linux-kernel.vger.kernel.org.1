Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9099026DD99
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 16:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbgIQOKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 10:10:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727221AbgIQOAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:00:46 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F21AD2220F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 14:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600351239;
        bh=Z+Q+oKy6kYMCPhHXhxfLXbvQ3jss6nDsyWD/Z4O5YlM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j40ylg4m8LXKEAxubcz7ahDOZqsGBCvC86g7ieq5yzcqybVi5FgGMImstlii4I0QX
         Ir2itplg8NWLltZJzHiI+OdB5T45n5vwlMrzFMhCanLTREwxlpky2FUy8YEARuSvY9
         G+UVS7OiTv9/UbJXWra4Ql2LRXT8h8/mQapPDTyc=
Received: by mail-ot1-f54.google.com with SMTP id g96so1948373otb.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 07:00:38 -0700 (PDT)
X-Gm-Message-State: AOAM530RoaWT7ba/xejkhcX+f78tPh7qZTJQQb5KrjcX+RSdeuPtARL4
        cgMnXfoGwcHbtSPzC6gziO9m1rx41YY/ajsDV9c=
X-Google-Smtp-Source: ABdhPJx3K8tRbfYK2iUD9eIc020QUDlT6Vbmpmw/XcQWT30fU0+YPmOu00DxmCq6NhBa4cLa83PrwQVgZN+ZvoGPrAE=
X-Received: by 2002:a9d:6193:: with SMTP id g19mr19256118otk.108.1600351238208;
 Thu, 17 Sep 2020 07:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200915131615.3138-1-thunder.leizhen@huawei.com>
 <20200915131615.3138-3-thunder.leizhen@huawei.com> <20200915190143.GP1551@shell.armlinux.org.uk>
In-Reply-To: <20200915190143.GP1551@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 17 Sep 2020 17:00:27 +0300
X-Gmail-Original-Message-ID: <CAMj1kXHdX5cCZKvbBO+hCkkt46aOgf4NjK2jba2Gb2tziZm2DQ@mail.gmail.com>
Message-ID: <CAMj1kXHdX5cCZKvbBO+hCkkt46aOgf4NjK2jba2Gb2tziZm2DQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: support PHYS_OFFSET minimum aligned at 64KiB boundary
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Jianguo Chen <chenjianguo3@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        patches-armlinux <patches@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 at 22:06, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Tue, Sep 15, 2020 at 09:16:15PM +0800, Zhen Lei wrote:
> > Currently, only support the kernels where the base of physical memory is
> > at a 16MiB boundary. Because the add/sub instructions only contains 8bits
> > unrotated value. But we can use one more "add/sub" instructions to handle
> > bits 23-16. The performance will be slightly affected.
> >
> > Since most boards meet 16 MiB alignment, so add a new configuration
> > option ARM_PATCH_PHYS_VIRT_RADICAL (default n) to control it. Say Y if
> > anyone really needs it.
> >
> > All r0-r7 (r1 = machine no, r2 = atags or dtb, in the start-up phase) are
> > used in __fixup_a_pv_table() now, but the callee saved r11 is not used in
> > the whole head.S file. So choose it.
> >
> > Because the calculation of "y = x + __pv_offset[63:24]" have been done,
> > so we only need to calculate "y = y + __pv_offset[23:16]", that's why
> > the parameters "to" and "from" of __pv_stub() and __pv_add_carry_stub()
> > in the scope of CONFIG_ARM_PATCH_PHYS_VIRT_RADICAL are all passed "t"
> > (above y).
> >
> > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> > ---
> >  arch/arm/Kconfig              | 18 +++++++++++++++++-
> >  arch/arm/include/asm/memory.h | 16 +++++++++++++---
> >  arch/arm/kernel/head.S        | 25 +++++++++++++++++++------
> >  3 files changed, 49 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index e00d94b16658765..19fc2c746e2ce29 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -240,12 +240,28 @@ config ARM_PATCH_PHYS_VIRT
> >         kernel in system memory.
> >
> >         This can only be used with non-XIP MMU kernels where the base
> > -       of physical memory is at a 16MB boundary.
> > +       of physical memory is at a 16MiB boundary.
> >
> >         Only disable this option if you know that you do not require
> >         this feature (eg, building a kernel for a single machine) and
> >         you need to shrink the kernel to the minimal size.
> >
> > +config ARM_PATCH_PHYS_VIRT_RADICAL
> > +     bool "Support PHYS_OFFSET minimum aligned at 64KiB boundary"
> > +     default n
>
> Please drop the "default n" - this is the default anyway.
>
> > @@ -236,6 +243,9 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
> >        * in place where 'r' 32 bit operand is expected.
> >        */
> >       __pv_stub((unsigned long) x, t, "sub", __PV_BITS_31_24);
> > +#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_RADICAL
> > +     __pv_stub((unsigned long) t, t, "sub", __PV_BITS_23_16);
>
> t is already unsigned long, so this cast is not necessary.
>
> I've been debating whether it would be better to use "movw" for this
> for ARMv7.  In other words:
>
>         movw    tmp, #16-bit
>         adds    %Q0, %1, tmp, lsl #16
>         adc     %R0, %R0, #0
>
> It would certainly be less instructions, but at the cost of an
> additional register - and we'd have to change the fixup code to
> know about movw.
>
> Thoughts?
>

Since LPAE implies v7, we can use movw unconditionally, which is nice.

There is no need to use an additional temp register, as we can use the
register holding the high word. (There is no need for the mov_hi macro
to be separate)

0:     movw    %R0, #low offset >> 16
       adds    %Q0, %1, %R0, lsl #16
1:     mov     %R0, #high offset
       adc     %R0, %R0, #0
       .pushsection .pv_table,"a"
       .long 0b, 1b
       .popsection

The only problem is distinguishing the two mov instructions from each
other, but that should not be too hard I think.
