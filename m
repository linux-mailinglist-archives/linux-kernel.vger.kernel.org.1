Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FEA297A87
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 05:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759398AbgJXDiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 23:38:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759389AbgJXDiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 23:38:54 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08096223EA
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 03:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603510733;
        bh=YMEvV6dcm7AXyyY8ChedIM35amwdXFyfa+CzZQS9MyQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HnHE3LKNsDzMMu0iWImTJUna+X9HmmVJG1IjwvSTCLQj3XaPgwExLsX+glRnjcLQ9
         bV4YUPoQXKICOdHSjxa/TSx1Yp1c+gNz1+p4ZN1D4c/Aa8yyshyZFKC2cxqyfttWSX
         kKnXCTsYHRn7zUj27u0yw48XhIcC6bQfYGGCxSj4=
Received: by mail-lj1-f179.google.com with SMTP id d24so3651288ljg.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 20:38:52 -0700 (PDT)
X-Gm-Message-State: AOAM533o9/VEaDdG6rnj+8M8WA2tIDqITjXJ3+wxn6+Et5iGxXvVDLa5
        6y6GlUvzW3SlRCyE/Ya85TO39LYTsUfot9fl8MU=
X-Google-Smtp-Source: ABdhPJwS47a6FTAP5XSOgGk7uEC69QnjfNkTN8FFkuqc3/SlH47dOWNVpu0Wmnq2yDK280vAeWi7bAn77duFmXouOKo=
X-Received: by 2002:a2e:85c4:: with SMTP id h4mr1842690ljj.250.1603510731255;
 Fri, 23 Oct 2020 20:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <1603448245-79429-1-git-send-email-guoren@kernel.org>
 <1603448245-79429-2-git-send-email-guoren@kernel.org> <CAAhSdy120ZR4ZbkHo8Us+CugaeegSR6iFu9jgHPuyvDAQwnOhQ@mail.gmail.com>
In-Reply-To: <CAAhSdy120ZR4ZbkHo8Us+CugaeegSR6iFu9jgHPuyvDAQwnOhQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 24 Oct 2020 11:38:40 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRnDxrOBTLL+=Kk9BjftH-xE=NX1zpLaxv7Xsb4L5XgAA@mail.gmail.com>
Message-ID: <CAJF2gTRnDxrOBTLL+=Kk9BjftH-xE=NX1zpLaxv7Xsb4L5XgAA@mail.gmail.com>
Subject: Re: [PATCH 2/3] irqchip/irq-sifive-plic: Fixup couldn't broadcast to
 multi CPUs
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Atish Patra <atish.patra@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, wesley@sifive.com,
        Yash Shah <yash.shah@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 8:17 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Fri, Oct 23, 2020 at 3:48 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > If "echo 3 > /proc/irq/1/smp_affinity", we want irq 1 could be
> > broadcast to CPU0 & CPU1 and one of them would pick up the irq
> > handler.
> >
> > But current implementation couldn't let multi CPUs process the
> > same IRQ concurrent.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > ---
> >  drivers/irqchip/irq-sifive-plic.c | 23 ++++++-----------------
> >  1 file changed, 6 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > index 2e56576..0003322 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -114,15 +114,12 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
> >  static void plic_irq_unmask(struct irq_data *d)
> >  {
> >         struct cpumask amask;
> > -       unsigned int cpu;
> >         struct plic_priv *priv = irq_get_chip_data(d->irq);
> >
> >         cpumask_and(&amask, &priv->lmask, cpu_online_mask);
> > -       cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
> > -                                          &amask);
> > -       if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
> > -               return;
> > -       plic_irq_toggle(cpumask_of(cpu), d, 1);
> > +       cpumask_and(&amask, &amask, irq_data_get_affinity_mask(d));
> > +
> > +       plic_irq_toggle(&amask, d, 1);
> >  }
> >
> >  static void plic_irq_mask(struct irq_data *d)
> > @@ -136,24 +133,16 @@ static void plic_irq_mask(struct irq_data *d)
> >  static int plic_set_affinity(struct irq_data *d,
> >                              const struct cpumask *mask_val, bool force)
> >  {
> > -       unsigned int cpu;
> >         struct cpumask amask;
> >         struct plic_priv *priv = irq_get_chip_data(d->irq);
> >
> >         cpumask_and(&amask, &priv->lmask, mask_val);
> > +       cpumask_and(&amask, &amask, cpu_online_mask);
> >
> > -       if (force)
> > -               cpu = cpumask_first(&amask);
> > -       else
> > -               cpu = cpumask_any_and(&amask, cpu_online_mask);
> > -
> > -       if (cpu >= nr_cpu_ids)
> > -               return -EINVAL;
> > +       irq_data_update_effective_affinity(d, &amask);
> >
> >         plic_irq_toggle(&priv->lmask, d, 0);
> > -       plic_irq_toggle(cpumask_of(cpu), d, 1);
> > -
> > -       irq_data_update_effective_affinity(d, cpumask_of(cpu));
> > +       plic_irq_toggle(&amask, d, 1);
> >
> >         return IRQ_SET_MASK_OK_DONE;
> >  }
> > --
> > 2.7.4
> >
>
> In the past, a similar patch was proposed by Zong Li (SiFive). We
> have good reasons to not allow multiple CPUs handle the same IRQ.
>
> Refer, https://lkml.org/lkml/2020/4/26/201
>
> NACK from my side.
Thx for sharing the information, I agree with Zong Li & Greentime's
aspect: Don't limit the usage of PLIC! We could let (one hart -> one
irq) as default.

I also agree that using irq broadcast indiscriminately can cause
performance problems. (Anup and Mark Z's view)

I think you've discussed enough at that time and l won't persist the patch.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
