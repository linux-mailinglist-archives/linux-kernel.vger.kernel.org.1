Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E10271B11
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 08:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgIUGrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 02:47:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgIUGrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 02:47:53 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7262E20C09
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 06:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600670872;
        bh=SXh1WTRtObhgUYkGX7AGIy0nUq+ZwD7MVJkrUo2iS9A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hjJx556Sbylx93SYRGW13and540FWAbz9x7SEPLWJxYPoS09ylI5rAUeSkhW8Thli
         ZL61aLotrFwHSnNjI6YvDeDciSSaBs9/MoStSwkp8+F+6CJTiyYHos5McYXoMQx+z0
         st0IXPwZnq/FmHlxbaejX+LW+jbXoM7OcsYqH71s=
Received: by mail-oi1-f180.google.com with SMTP id z26so15756044oih.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 23:47:52 -0700 (PDT)
X-Gm-Message-State: AOAM530iHTV68TRE9AQDpoJRghOswKPgRt6Cl57lhtOcSXqCiT/ZjVWY
        lcC8213kgj+4Pi/SPROGv9QU+1ynN3F+UZHUg8w=
X-Google-Smtp-Source: ABdhPJzhkiHj6Xj/QEgv5HWzYbhP7ZNSTNyl7D9cjL/hU/T9DEVUT29ZreGJYYTTanDOFRFtVh86OqGlDDhtkW6MAVI=
X-Received: by 2002:a54:4517:: with SMTP id l23mr17535077oil.174.1600670871745;
 Sun, 20 Sep 2020 23:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200915131615.3138-1-thunder.leizhen@huawei.com>
 <20200915131615.3138-3-thunder.leizhen@huawei.com> <20200915190143.GP1551@shell.armlinux.org.uk>
 <CAMj1kXHdX5cCZKvbBO+hCkkt46aOgf4NjK2jba2Gb2tziZm2DQ@mail.gmail.com> <a196451d-fbef-bab6-e042-00a817db611c@huawei.com>
In-Reply-To: <a196451d-fbef-bab6-e042-00a817db611c@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 21 Sep 2020 08:47:40 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGdFj8KxqJB8WMOdKYWPChkHbM7+nLaAWBZ29o=q7N0Aw@mail.gmail.com>
Message-ID: <CAMj1kXGdFj8KxqJB8WMOdKYWPChkHbM7+nLaAWBZ29o=q7N0Aw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: support PHYS_OFFSET minimum aligned at 64KiB boundary
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
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

On Mon, 21 Sep 2020 at 05:35, Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
>
>
>
> On 2020/9/17 22:00, Ard Biesheuvel wrote:
> > On Tue, 15 Sep 2020 at 22:06, Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> >>
> >> On Tue, Sep 15, 2020 at 09:16:15PM +0800, Zhen Lei wrote:
> >>> Currently, only support the kernels where the base of physical memory is
> >>> at a 16MiB boundary. Because the add/sub instructions only contains 8bits
> >>> unrotated value. But we can use one more "add/sub" instructions to handle
> >>> bits 23-16. The performance will be slightly affected.
> >>>
> >>> Since most boards meet 16 MiB alignment, so add a new configuration
> >>> option ARM_PATCH_PHYS_VIRT_RADICAL (default n) to control it. Say Y if
> >>> anyone really needs it.
> >>>
> >>> All r0-r7 (r1 = machine no, r2 = atags or dtb, in the start-up phase) are
> >>> used in __fixup_a_pv_table() now, but the callee saved r11 is not used in
> >>> the whole head.S file. So choose it.
> >>>
> >>> Because the calculation of "y = x + __pv_offset[63:24]" have been done,
> >>> so we only need to calculate "y = y + __pv_offset[23:16]", that's why
> >>> the parameters "to" and "from" of __pv_stub() and __pv_add_carry_stub()
> >>> in the scope of CONFIG_ARM_PATCH_PHYS_VIRT_RADICAL are all passed "t"
> >>> (above y).
> >>>
> >>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >>> ---
> >>>  arch/arm/Kconfig              | 18 +++++++++++++++++-
> >>>  arch/arm/include/asm/memory.h | 16 +++++++++++++---
> >>>  arch/arm/kernel/head.S        | 25 +++++++++++++++++++------
> >>>  3 files changed, 49 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >>> index e00d94b16658765..19fc2c746e2ce29 100644
> >>> --- a/arch/arm/Kconfig
> >>> +++ b/arch/arm/Kconfig
> >>> @@ -240,12 +240,28 @@ config ARM_PATCH_PHYS_VIRT
> >>>         kernel in system memory.
> >>>
> >>>         This can only be used with non-XIP MMU kernels where the base
> >>> -       of physical memory is at a 16MB boundary.
> >>> +       of physical memory is at a 16MiB boundary.
> >>>
> >>>         Only disable this option if you know that you do not require
> >>>         this feature (eg, building a kernel for a single machine) and
> >>>         you need to shrink the kernel to the minimal size.
> >>>
> >>> +config ARM_PATCH_PHYS_VIRT_RADICAL
> >>> +     bool "Support PHYS_OFFSET minimum aligned at 64KiB boundary"
> >>> +     default n
> >>
> >> Please drop the "default n" - this is the default anyway.
> >>
> >>> @@ -236,6 +243,9 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
> >>>        * in place where 'r' 32 bit operand is expected.
> >>>        */
> >>>       __pv_stub((unsigned long) x, t, "sub", __PV_BITS_31_24);
> >>> +#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_RADICAL
> >>> +     __pv_stub((unsigned long) t, t, "sub", __PV_BITS_23_16);
> >>
> >> t is already unsigned long, so this cast is not necessary.
> >>
> >> I've been debating whether it would be better to use "movw" for this
> >> for ARMv7.  In other words:
> >>
> >>         movw    tmp, #16-bit
> >>         adds    %Q0, %1, tmp, lsl #16
> >>         adc     %R0, %R0, #0
> >>
> >> It would certainly be less instructions, but at the cost of an
> >> additional register - and we'd have to change the fixup code to
> >> know about movw.
> >>
> >> Thoughts?
> >>
> >
> > Since LPAE implies v7, we can use movw unconditionally, which is nice.
> >
> > There is no need to use an additional temp register, as we can use the
> > register holding the high word. (There is no need for the mov_hi macro
> > to be separate)
> >
> > 0:     movw    %R0, #low offset >> 16
> >        adds    %Q0, %1, %R0, lsl #16
> > 1:     mov     %R0, #high offset
> >        adc     %R0, %R0, #0
> >        .pushsection .pv_table,"a"
> >        .long 0b, 1b
> >        .popsection
> >
> > The only problem is distinguishing the two mov instructions from each
>
> The #high offset can also consider use movw, it just save two bytes in
> the thumb2 scenario. We can store different imm16 value for high_offset
> and low_offset, so that we can distinguish them in __fixup_a_pv_table().
>
> This will make the final implementation of the code look more clear and
> consistent, especially THUMB2.
>
> Let me try it.
>

Hello Zhen Lei,

I am looking into this as well:

https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=arm-p2v-v2

Could you please test this version on your hardware?
