Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540C71B9120
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 17:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgDZPVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Apr 2020 11:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgDZPVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 11:21:49 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C14C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 08:21:47 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v4so13976381wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 08:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oec0onKReyMxClDdJY4/0WsT5jFsmRnzuCNfEJGndcY=;
        b=fKbv3cWkTUyDAeQhb386kJbwXWqxg0I/EcVVdTNgbFlmukh7OcHDr2el0Z133lHTDQ
         rxS5IcZtRpqE7nRsGYrFhrIxnCFwjYWP8IHg976WeSQXCo84T11bEpYW+0MFzEOk508C
         E4HMKA28awoKmTVPkiBCsjG4JdS9bGt2ybDf2ODOKYwVBpEWqTihfRcew5iQt5iUkV21
         S2GF1loV+k1tDi3VZLnM44qJcJSKXqPVN37UynAL89yRacAXTShmZBdmSemblCffHmOI
         7istGl3jc1IU3ewbbuDUApzG8AQHnda1YIXrVCYAMfUc1oFW80T6k3GjL1gYAof3SA5p
         qoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oec0onKReyMxClDdJY4/0WsT5jFsmRnzuCNfEJGndcY=;
        b=CJlka0ytl0sZAxP/RP9zrIsWVeJj9/TFzVM7qYTLuVIIzBnj939HoMv68uRI+i+Bp5
         gCXlgnm/z2j6+IIilq6niTe73QWbbSZ+uwiqrDb2qj1hh/6nYphDOHdsWeUdOuHpiobR
         kRDSsw/5DPbStn2lsxpmdcCi2K2E3Fxw+Tl+v7OTSD4n7EyldzlOajj+LESpOOlbBYmi
         RStknDowXl5XeoP+CDkk21BneCpTkNy0ENEdNVGNTZMWxAHsVMwsPzv0m0RkLtEKeoZV
         ob7h95Admy6y+k58YTjCn+DftA9G+vMtNFSSSxY+dF7lSKuR+Xea2QiJcxmdlkTl6PlP
         2HRQ==
X-Gm-Message-State: AGi0PubfdNg6N/pcFIjBHy18zYbqEguHAY85x86O0oFLeH1x72aH1R3J
        gTnoc+EDygpVtSAKCUb8g9i8/hb2DEodSfXg68czgA==
X-Google-Smtp-Source: APiQypJbk1KuqjHN1WWjZ35IfpPcCrrEJbET0XHjFL6wF5iUqZ47hcKHcFlXnzwn/3ge4BYKCgPzZPxodt9DTgzjh68=
X-Received: by 2002:a1c:7301:: with SMTP id d1mr22595992wmb.26.1587914505976;
 Sun, 26 Apr 2020 08:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200426110740.123638-1-zong.li@sifive.com> <CAAhSdy3FCdzLV-nH03T=PBxB2tdZXhRrugcC2NcoA=22qpv+Lw@mail.gmail.com>
 <CANXhq0qW9ORoZ5qc5g8ikO9QdeYX=p0fwoP8pyFFkk02a7imnw@mail.gmail.com>
 <CAAhSdy2f2-SQP6TdgxA0HM2ft3eBJd6kEkB--RH=2gUuLktXLQ@mail.gmail.com> <CANXhq0pDYa2QfGZX87d5gyO5V2uzA3-ttPZXf7s1EkMUcG37Cw@mail.gmail.com>
In-Reply-To: <CANXhq0pDYa2QfGZX87d5gyO5V2uzA3-ttPZXf7s1EkMUcG37Cw@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 26 Apr 2020 20:51:34 +0530
Message-ID: <CAAhSdy188_Kkfsz2bX05T3Rr12XDNtwGiwfqaT2TFVW7auGUaw@mail.gmail.com>
Subject: Re: [PATCH] irqchip/sifive-plic: allow many cores to handle IRQs
To:     Zong Li <zong.li@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 8:42 PM Zong Li <zong.li@sifive.com> wrote:
>
> On Sun, Apr 26, 2020 at 9:38 PM Anup Patel <anup@brainfault.org> wrote:
> >
> > +Mark Z
> >
> > On Sun, Apr 26, 2020 at 6:49 PM Zong Li <zong.li@sifive.com> wrote:
> > >
> > > On Sun, Apr 26, 2020 at 8:47 PM Anup Patel <anup@brainfault.org> wrote:
> > > >
> > > > On Sun, Apr 26, 2020 at 4:37 PM Zong Li <zong.li@sifive.com> wrote:
> > > > >
> > > > > Currently, driver forces the IRQs to be handled by only one core. This
> > > > > patch provides the way to enable others cores to handle IRQs if needed,
> > > > > so users could decide how many cores they wanted on default by boot
> > > > > argument.
> > > > >
> > > > > Use 'irqaffinity' boot argument to determine affinity. If there is no
> > > > > irqaffinity in dts or kernel configuration, use irq default affinity,
> > > > > so all harts would try to claim IRQ.
> > > > >
> > > > > For example, add irqaffinity=0 in chosen node to set irq affinity to
> > > > > hart 0. It also supports more than one harts to handle irq, such as set
> > > > > irqaffinity=0,3,4.
> > > > >
> > > > > You can change IRQ affinity from user-space using procfs. For example,
> > > > > you can make CPU0 and CPU2 serve IRQ together by the following command:
> > > > >
> > > > > echo 4 > /proc/irq/<x>/smp_affinity
> > > > >
> > > > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > > > > ---
> > > > >  drivers/irqchip/irq-sifive-plic.c | 21 +++++++--------------
> > > > >  1 file changed, 7 insertions(+), 14 deletions(-)
> > > > >
> > > > > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > > > > index d0a71febdadc..bc1440d54185 100644
> > > > > --- a/drivers/irqchip/irq-sifive-plic.c
> > > > > +++ b/drivers/irqchip/irq-sifive-plic.c
> > > > > @@ -111,15 +111,12 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
> > > > >  static void plic_irq_unmask(struct irq_data *d)
> > > > >  {
> > > > >         struct cpumask amask;
> > > > > -       unsigned int cpu;
> > > > >         struct plic_priv *priv = irq_get_chip_data(d->irq);
> > > > >
> > > > >         cpumask_and(&amask, &priv->lmask, cpu_online_mask);
> > > > > -       cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
> > > > > -                                          &amask);
> > > > > -       if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
> > > > > -               return;
> > > > > -       plic_irq_toggle(cpumask_of(cpu), d, 1);
> > > > > +       cpumask_and(&amask, &amask, irq_data_get_affinity_mask(d));
> > > > > +
> > > > > +       plic_irq_toggle(&amask, d, 1);
> > > > >  }
> > > > >
> > > > >  static void plic_irq_mask(struct irq_data *d)
> > > > > @@ -133,24 +130,20 @@ static void plic_irq_mask(struct irq_data *d)
> > > > >  static int plic_set_affinity(struct irq_data *d,
> > > > >                              const struct cpumask *mask_val, bool force)
> > > > >  {
> > > > > -       unsigned int cpu;
> > > > >         struct cpumask amask;
> > > > >         struct plic_priv *priv = irq_get_chip_data(d->irq);
> > > > >
> > > > >         cpumask_and(&amask, &priv->lmask, mask_val);
> > > > >
> > > > >         if (force)
> > > > > -               cpu = cpumask_first(&amask);
> > > > > +               cpumask_copy(&amask, mask_val);
> > > > >         else
> > > > > -               cpu = cpumask_any_and(&amask, cpu_online_mask);
> > > > > -
> > > > > -       if (cpu >= nr_cpu_ids)
> > > > > -               return -EINVAL;
> > > > > +               cpumask_and(&amask, &amask, cpu_online_mask);
> > > > >
> > > > >         plic_irq_toggle(&priv->lmask, d, 0);
> > > > > -       plic_irq_toggle(cpumask_of(cpu), d, 1);
> > > > > +       plic_irq_toggle(&amask, d, 1);
> > > > >
> > > > > -       irq_data_update_effective_affinity(d, cpumask_of(cpu));
> > > > > +       irq_data_update_effective_affinity(d, &amask);
> > > > >
> > > > >         return IRQ_SET_MASK_OK_DONE;
> > > > >  }
> > > > > --
> > > > > 2.26.1
> > > > >
> > > >
> > > > I strongly oppose (NACK) this patch due to performance reasons.
> > > >
> > > > In PLIC, if we enable an IRQ X for N CPUs then when IRQ X occurs:
> > > > 1) All N CPUs will take interrupt
> > > > 2) All N CPUs will try to read PLIC CLAIM register
> > > > 3) Only one of the CPUs will see IRQ X using the CLAIM register
> > > > but other N - 1 CPUs will see no interrupt and return back to what
> > > > they were doing. In other words, N - 1 CPUs will just waste CPU
> > > > every time IRQ X occurs.
> > > >
> > > > Example1, one Application doing heavy network traffic will
> > > > degrade performance of other applications because with every
> > > > network RX/TX interrupt N-1 CPUs will waste CPU trying to
> > > > process network interrupt.
> > > >
> > > > Example1, one Application doing heavy MMC/SD traffic will
> > > > degrade performance of other applications because with every
> > > > SPI read/write interrupt N-1 CPUs will waste CPU trying to
> > > > process it.
> > > >
> > > > In fact, the current PLIC approach is actually a performance
> > > > optimization. This implementation also works fine with in-kernel
> > > > load-balancer and user space load balancer.
> > > >
> > >
> > > Yes, it's exactly, I know what you pointed out. But the idea of this
> > > patch is just providing a way that users could enable other cores if
> > > they wanted, it could still enable only one core by this change. The
> > > purpose here is thinking of flexible use, rather than limitation.
> > > Maybe it would be a happy medium that we make the default case enable
> > > only one core? It is a good open discussion.
> >
> > Making the default case as enable only one core is just a work-around.
> >
> > As-per my understanding, if we set affinity mask of N CPUs for IRQ X
> > then it does not mean all N CPUs should receive IRQ X rather it means
> > that exactly one of the N CPUs will receive IRQ X and the IRQ receiving
> > CPU will be fixed (reflected by effective affinity returned by the driver).
>
> is there a case that we only bundle the IRQ to CPU0, but CPU0 is more
> much busy than other CPUs, and it would be better if another CPU could
> take the IRQ?

This is a common problem across architectures.

To tackle this, we typically run irqbalance daemon in user-space which will
change IRQ affinity based on CPU load.

Refer, https://linux.die.net/man/1/irqbalance

>
> >
> > If we ignore above semantics and still provide a mechanism to target
> > IRQ X to N CPUs then most likely someone will try and run into
> > performance issues.
> >
> > Please don't go this path. The performance impact in case of Guest/VM
> > is even worst because PLIC is trap-n-emulated by hypervisors as MMIO
> > device.
>
> OK, I won't persist in that, just wanna figure out the situation.
>
> >
> > Regards,
> > Anup

Regards,
Anup
