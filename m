Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D581D2F76EC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbhAOKoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 05:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbhAOKo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 05:44:28 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB93CC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 02:43:42 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 190so6913194wmz.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 02:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1GOy62bJEqZmaaaVa7bc8fN/pAm+7HJUXrlW/loQbn4=;
        b=GRA245+v6+D969lm0qdoKR5AIDYU7qHRSngOxiM5SoTxd9sjQn12AxYh2ioJablJDK
         82B+TLMQVl3gdj6R7N4eJRd0XG1kulYPA9fZ/82s6ZvlGkW42ze7LCVgBdBdDt6B5RMf
         9epB4HQiaITY4kh2oapeXqrKn2uFmqlFcxUQjgb460lyFY6aVMOFdRHcEyu+VjcpKS1d
         UXMLUEYvOaNkScqT9oLQoMVeftjmqKWqqKHKy6loT4rvjqRKSooA3Ps+6dFkB2OROOtX
         IO2nOQGkRmFpd4tFT0SODWqSDYv9eToLvAcI1nnVkIc9iRm62m4eq5N5f00V+avYhMw9
         DA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1GOy62bJEqZmaaaVa7bc8fN/pAm+7HJUXrlW/loQbn4=;
        b=p69akgC6U0B1k+UXtdY/tBDZYci17dtbT/DQF0x8TcLwFO4gadLKUcpxkDsosEB/8L
         K1f/B97cSy85E8S8vqp99rsljGjdiJKTV04ZeAmHUhRLa1kG7xYEFRgYUWpDt60n1ddg
         qgK910FhYPFdvWRrvmcWAVL1Cam/DYwyDCTcbGs1AeB/BNrVPUv0WXfcHKU9THpSbS3n
         ZlBmSIj15wYvBG3dgbr2IU4/ySlzezwEJymQQUbovSVBuRPguHquSdR0JRD7DgljLH0Y
         gpVEz/f4AsIs8uDJ6bw8k5TKf/XPai7tgnY7NX56pOSU++42r/D/qskNTdvBJyr9CIXj
         68Jw==
X-Gm-Message-State: AOAM5326uIiUP2h4NLHya2V39Mjh1z4fwPfAKcGh+lRUsBl0c2/1qenF
        6k18KrzYCHYO1UCVbldvxhWz4mK9ALp/0yqRV39ZHA==
X-Google-Smtp-Source: ABdhPJzSOXIQTfntvA3kJDnEuvoCbjy6DhMm6SSdgl6w+Wjwi5svPoulGemqVvF5Ip9r2PbEaJje5Vbbfi95JJdENvQ=
X-Received: by 2002:a05:600c:2042:: with SMTP id p2mr8266838wmg.152.1610707421375;
 Fri, 15 Jan 2021 02:43:41 -0800 (PST)
MIME-Version: 1.0
References: <20210111212031.2422-1-vitaly.wool@konsulko.com>
 <CAAhSdy04Nm+ET3Oepe5zRyVWiWpZzmfe=0BrdOEPUHGEOF86Vw@mail.gmail.com> <CAM4kBBKsYxaMe_R=JU=FxWdxS3vsgvpcMY3PCKBW080-9uSOrA@mail.gmail.com>
In-Reply-To: <CAM4kBBKsYxaMe_R=JU=FxWdxS3vsgvpcMY3PCKBW080-9uSOrA@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 15 Jan 2021 16:13:30 +0530
Message-ID: <CAAhSdy190iZJsuiMRfPeeFCciG=ag7kn7CbL-Rmzc++QF4QGCw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: simplify BUILTIN_DTB processing
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 3:18 PM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
>
>
>
> On Fri, 15 Jan 2021, 10:39 Anup Patel, <anup@brainfault.org> wrote:
>>
>> On Tue, Jan 12, 2021 at 2:51 AM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
>> >
>> > Provide __dtb_start as a parameter to setup_vm() in case
>> > CONFIG_BUILTIN_DTB is true, so we don't have to duplicate
>> > BUILTIN_DTB specific processing in MMU-enabled and MMU-disabled
>> > versions of setup_vm().
>> >
>> > Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
>> > ---
>> >  arch/riscv/kernel/head.S | 4 ++++
>> >  arch/riscv/mm/init.c     | 4 ----
>> >  2 files changed, 4 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>> > index 16e9941900c4..f5a9bad86e58 100644
>> > --- a/arch/riscv/kernel/head.S
>> > +++ b/arch/riscv/kernel/head.S
>> > @@ -260,7 +260,11 @@ clear_bss_done:
>> >
>> >         /* Initialize page tables and relocate to virtual addresses */
>> >         la sp, init_thread_union + THREAD_SIZE
>> > +#ifdef CONFIG_BUILTIN_DTB
>> > +       la a0, __dtb_start
>> > +#else
>> >         mv a0, s1
>> > +#endif /* CONFIG_BUILTIN_DTB */
>> >         call setup_vm
>> >  #ifdef CONFIG_MMU
>> >         la a0, early_pg_dir
>> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> > index 5b17f8d22f91..45faad7c4291 100644
>> > --- a/arch/riscv/mm/init.c
>> > +++ b/arch/riscv/mm/init.c
>> > @@ -615,11 +615,7 @@ static void __init setup_vm_final(void)
>> >  #else
>> >  asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>> >  {
>> > -#ifdef CONFIG_BUILTIN_DTB
>> > -       dtb_early_va = (void *) __dtb_start;
>> > -#else
>> >         dtb_early_va = (void *)dtb_pa;
>> > -#endif
>> >         dtb_early_pa = dtb_pa;
>> >  }
>> >
>> > --
>> > 2.20.1
>> >
>>
>> We can avoid the early DTB mapping for MMU-enabled case when
>> BUILTIN_DTB is enabled (same as previous discussion). Otherwise
>> looks good to me.
>
>
> Right, but I had already submitted the patch which takes care of that, and you have reviewed it too IIRC :)

Ahh, I assumed this patch is based on latest stable Linux-5.11-rcX.

Either you can create a series with two patches OR you can squash this patch
into your previous patch.

Regards,
Anup
