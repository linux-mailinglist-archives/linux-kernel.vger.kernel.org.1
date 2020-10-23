Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF201296E75
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 14:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463645AbgJWMWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 08:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900850AbgJWMWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 08:22:48 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAB7C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 05:22:47 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 13so1239653wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 05:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9PzWNp1gapi2QMM7K0A8RjxDrdVI4G9KGleb9XwWLYs=;
        b=bLfzWbNTGQTfmmImm9vWqjH4/GLqLxGMr30A9Y9BfMsJe6syrNASgumzYzosat8UP3
         0iK12RgRxgfYnqqISklRgM/Qz+HDv+Roe8MTal30h71Lkb0g7PcPTOHP6cA//+NZ8cCE
         jtI1KMcnEvuPpcopNXrAssk7imrF45z2krQpbHpcpaJnQkZHWt5VWE2UesfYry8APnjl
         YHH7kWTanIlrp+CaMWs3JG/HOQy70+To+rXCC6Qy3YFcDmazmSnSxnXjpgrMJk8cPGh9
         LGMl+rZqihaZMxZP2j3H4dTL0+5ubh1uMHC+rNqDSgXgUYJxYKydyFyvzWUo5A2ZLMS/
         ilNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9PzWNp1gapi2QMM7K0A8RjxDrdVI4G9KGleb9XwWLYs=;
        b=eCg4dt2vs9fnupYFmYBOvrwEQHAfZ8it3AA5Mtn7nEEKZ3wwxfnqOClmJiQStgKDBL
         ULuIkQejyYn0OEP0WAa+nPyWNoAM0vDggXO02saXkdLgYWY71lq28ohJNQVK/b4VByZ9
         GdBi0MFQwUrVoYBoESW9nWwX6wz0x1Qhp0NFwlC2cZLkm2OjCpzFLYWsGLyXmf+BAEFy
         iEcNl6WliH/fU75fwbHX2wSqKpyTHqu6cGYsgAi50MZAHbdepp4TCrkAXR5NANg0Ocdz
         n3OYReWPZjYHl0xpBgGuwmI7QbNPl4vtUnkKo82qMtK8n98L9iiWZI1SHV0ZhMeP2Ik0
         1k7A==
X-Gm-Message-State: AOAM530qlUZXGMZWl3BodnBbxqA4ZZJGzBz80Q4vqMK9PD/+nWqFxltn
        rK7uZmEv4+KZP5BZUUPHv6eu+5OBFXsz1CwrerhgDQ==
X-Google-Smtp-Source: ABdhPJzZmJ/UymdTn7PKAA7QJE2WqXkpVPyGxZB8LmuUohWRLn0nbQ4JIga6IOwlIPnkUyZ3qClwKuJDeYtT3QyLphw=
X-Received: by 2002:a1c:41d6:: with SMTP id o205mr2020662wma.152.1603455765620;
 Fri, 23 Oct 2020 05:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <1603448245-79429-1-git-send-email-guoren@kernel.org> <1603448245-79429-3-git-send-email-guoren@kernel.org>
In-Reply-To: <1603448245-79429-3-git-send-email-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 23 Oct 2020 17:03:26 +0530
Message-ID: <CAAhSdy3aOmUSY7x=BVVKCb5JD39H+_zOhBCuwgUxgtJLKqTrDw@mail.gmail.com>
Subject: Re: [PATCH 3/3] irqchip/irq-sifive-plic: Fixup set_affinity enable
 irq unexpected
To:     Guo Ren <guoren@kernel.org>
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

On Fri, Oct 23, 2020 at 3:48 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> For PLIC, we only have enable registers to control per hart's irq
> affinity and irq_set_affinity would call plic_irq_toggle to enable
> the IRQ's routing. So we can't enable irq in irq_domain_map before
> request_irq, it'll let uninitialized devices' irq exception.
>
> The solution is to check the irq has been enabled, just like what
> irq-gic-v3 has done in gic_set_affinity.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 45 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 0003322..1a63859 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -130,6 +130,36 @@ static void plic_irq_mask(struct irq_data *d)
>  }
>
>  #ifdef CONFIG_SMP
> +static inline bool plic_toggle_is_enabled(struct plic_handler *handler,
> +                                               int hwirq)
> +{
> +       u32 __iomem *reg = handler->enable_base + (hwirq / 32) * sizeof(u32);
> +       u32 hwirq_mask = 1 << (hwirq % 32);
> +
> +       if (readl(reg) & hwirq_mask)
> +               return true;
> +       else
> +               return false;
> +}
> +
> +static inline bool plic_irq_is_enabled(const struct cpumask *mask,
> +                                  struct irq_data *d)
> +{
> +       int cpu;
> +
> +       for_each_cpu(cpu, mask) {
> +               struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
> +
> +               if (!handler->present)
> +                       continue;
> +
> +               if (plic_toggle_is_enabled(handler, d->hwirq))
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  static int plic_set_affinity(struct irq_data *d,
>                              const struct cpumask *mask_val, bool force)
>  {
> @@ -141,8 +171,10 @@ static int plic_set_affinity(struct irq_data *d,
>
>         irq_data_update_effective_affinity(d, &amask);
>
> -       plic_irq_toggle(&priv->lmask, d, 0);
> -       plic_irq_toggle(&amask, d, 1);
> +       if (plic_irq_is_enabled(&priv->lmask, d)) {
> +               plic_irq_toggle(&priv->lmask, d, 0);
> +               plic_irq_toggle(&amask, d, 1);
> +       }
>
>         return IRQ_SET_MASK_OK_DONE;
>  }
> @@ -168,12 +200,19 @@ static struct irq_chip plic_chip = {
>  static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
>                               irq_hw_number_t hwirq)
>  {
> +       unsigned int cpu;
>         struct plic_priv *priv = d->host_data;
>
>         irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
>                             handle_fasteoi_irq, NULL, NULL);
>         irq_set_noprobe(irq);
> -       irq_set_affinity(irq, &priv->lmask);
> +
> +       cpu = cpumask_any_and(&priv->lmask, cpu_online_mask);
> +       if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
> +               return -EINVAL;
> +
> +       irq_set_affinity(irq, cpumask_of(cpu));
> +
>         return 0;
>  }
>
> --
> 2.7.4
>

Greentime (SiFive) has already proposed a patch to fix this.
Refer, https://lkml.org/lkml/2020/10/20/188

Only the plic_irqdomain_map() change which sets the correct
default affinity looks good to me.

Regards,
Anup
