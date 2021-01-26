Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C32303BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405201AbhAZLeW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Jan 2021 06:34:22 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:33580 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391839AbhAZKHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 05:07:39 -0500
Received: by mail-ot1-f52.google.com with SMTP id 63so15699249oty.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 02:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7rwgQ+jtQJy524gPL1rOIz9IKh66R93uWQ9zyZX1c9s=;
        b=kbv50VCkJehW5DCAN4FXyOF4CZEXfNa7dGvaFsGugaAr5d+he5IZeEEmk5hmzqFBKO
         4ht28J3oty6WAYkwZ7h8t+QZkesH6E510mW7v/B/ARF6Ql4k52y58I728Fk+Ym4rq1r8
         M2NVLxdXKzYnfWsqmajI39C04wd8Wf7Q/xhz0VIaDBs6sxbQ8hEHdKlELk+8cpEaMqZx
         47yzG4uoYNAiH9aK6nFehzYk+/JAPRhlgo+L9rJ8KyP3wu+53zjWOwgt/532hU905G0/
         5z2VQpmd2QAb4V4LKVA+0SgtcivC2dVYRaYA6Q96cv74Zt+jq2JinfzInBq340dKdhUc
         wvgg==
X-Gm-Message-State: AOAM533l7XzxWbnbSDFdm68fAgjX5afMJRfvfEDyesJCyfsFHLFobSXX
        8OdXTghhATOLL9Ih9DUb+aGtm3m+Ka1aT8Y1Yw8LYIaTccc=
X-Google-Smtp-Source: ABdhPJw2x8euj0Qptna0PxYJ+ehfyicaDLcQrxYyslAvFnMfiijYGGE517SlpGSQoNy/AGZg3rAXAlP/I+BnKdYbzzs=
X-Received: by 2002:a05:6830:1489:: with SMTP id s9mr2718860otq.250.1611655617566;
 Tue, 26 Jan 2021 02:06:57 -0800 (PST)
MIME-Version: 1.0
References: <20201215103026.2872532-1-geert+renesas@glider.be> <12e192f7-cef5-5dc1-32e4-75a97e77e9c6@huawei.com>
In-Reply-To: <12e192f7-cef5-5dc1-32e4-75a97e77e9c6@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Jan 2021 11:06:46 +0100
Message-ID: <CAMuHMdX-X7+tMBZuVzEo3MyMsDU7rR-oKVCgNg7Mz-Y5i1U9Qw@mail.gmail.com>
Subject: Re: [PATCH] arm64/smp: Remove unused irq variable in arch_show_interrupts()
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wanghaibin.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On Fri, Dec 25, 2020 at 8:05 AM Zenghui Yu <yuzenghui@huawei.com> wrote:
> On 2020/12/15 18:30, Geert Uytterhoeven wrote:
> >      arch/arm64/kernel/smp.c: In function ‘arch_show_interrupts’:
> >      arch/arm64/kernel/smp.c:808:16: warning: unused variable ‘irq’ [-Wunused-variable]
> >        808 |   unsigned int irq = irq_desc_get_irq(ipi_desc[i]);
> >         |                ^~~
> >
> > The removal of the last user forgot to remove the variable.
> >
> > Fixes: 2f516e34383d0e97 ("arm64/smp: Use irq_desc_kstat_cpu() in arch_show_interrupts()")
>
> This is in mainline now and the commit id is 5089bc51f81f.
>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > One more issue in irq-core-2020-12-14.
> >
> >   arch/arm64/kernel/smp.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index 3aef3bc22d3250b5..10b39328268687e3 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -805,7 +805,6 @@ int arch_show_interrupts(struct seq_file *p, int prec)
> >       unsigned int cpu, i;
> >
> >       for (i = 0; i < NR_IPI; i++) {
> > -             unsigned int irq = irq_desc_get_irq(ipi_desc[i]);
> >               seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
> >                          prec >= 4 ? " " : "");
> >               for_each_online_cpu(cpu)
>
> And I guess we have the same problem on 32-bit ARM. 'irq' in
> show_ipi_list() is no longer used since commit 88c637748e31
> ("ARM: smp: Use irq_desc_kstat_cpu() in show_ipi_list()").

Indeed. I didn't see it with my compiler version, but Wolfram did, and
sent a patch:
https://lore.kernel.org/linux-arm-kernel/20201228120147.59387-1-wsa+renesas@sang-engineering.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
