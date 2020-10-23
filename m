Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A98296E46
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 14:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463530AbgJWMRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 08:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463489AbgJWMRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 08:17:02 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E62BC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 05:17:02 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id n18so1559048wrs.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 05:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7/Fm6XaJlnf+0GZcokzUQVnv0XVQ9vwBMmUnKtUMoVY=;
        b=GPfFzo6wzNR5nULW/kco1+wYGucDFxTXnF/4x5Fhckacdc5uoFBSkDMSuf4m0I5zkp
         HVI7LtmdOiU0OpBhxqw1chCau8Q4g9r8Ahft4HuJd1NPHaBFC6y+arE2iizxUmix5uYG
         T7k8W1zPkCqJ7DwX7SPhfKYstXMV1s40rsq6jNYabfCT5hP0tReLgj4FjOdB3Ew5HyOv
         wXR/Z5QsyGssiHTL/flxO/4d33gFqUGlglolQxG9zzKhZ64N4L/P4el7XjI0iJc4ANEp
         O4+x+kXfpLTgZQXn116vT58EW16z5tWJN5GvwSZV70TOSyqPyYvIjVrN40j8tPoI37J2
         MFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/Fm6XaJlnf+0GZcokzUQVnv0XVQ9vwBMmUnKtUMoVY=;
        b=j218In8o3czZLM4Eij2hvWwRmmcFFIEc/U7tdIb/uUgmahetgteFtXJzF3hiwpST/O
         JfoGENDm3fdTFO5hMtwLzWCSNaRf/6AdBEzkCo7AssxbQ/D6llmBE5+oWX+uw7RImSLo
         Jj/NLo2qGLKWTP8ji4S4QjQHRALiTSG5AcF+zHmvh4JP9xvW9Pbp+mu/JWQc/8txLR5b
         MTNgM1GWjo5Yb3s2C+uon28CXqhMVRTTD0u3o+z8bD+ZNl2/t/VWTw9FsSu3qUPDoH8r
         vwRWThifCkNcx9Cf4NpSTNRv2nRsX1ab/b/M5J9QBIofHMLqLDRnmNAoArLQ/iuONa9A
         yy8w==
X-Gm-Message-State: AOAM532Pw9lAqPq0qjk82XVUCL7nmjmYIXplbZiT5dg6bhP6ZcUC6RW5
        PyhyFeOflUWVBplDa2GrxYEKCwLOdRdBnS4LZfHUQQ==
X-Google-Smtp-Source: ABdhPJzL5F1aOLgTEEtR6hKrRFXkK5t7ulAjkYe//QYMi/EC1tUVESIcHmYJcmmKVM69YJLF5YNLmhKj8ITc0YhyLFc=
X-Received: by 2002:a5d:6681:: with SMTP id l1mr2348523wru.356.1603455421182;
 Fri, 23 Oct 2020 05:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <1603448245-79429-1-git-send-email-guoren@kernel.org> <1603448245-79429-2-git-send-email-guoren@kernel.org>
In-Reply-To: <1603448245-79429-2-git-send-email-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 23 Oct 2020 16:57:41 +0530
Message-ID: <CAAhSdy120ZR4ZbkHo8Us+CugaeegSR6iFu9jgHPuyvDAQwnOhQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] irqchip/irq-sifive-plic: Fixup couldn't broadcast to
 multi CPUs
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
> If "echo 3 > /proc/irq/1/smp_affinity", we want irq 1 could be
> broadcast to CPU0 & CPU1 and one of them would pick up the irq
> handler.
>
> But current implementation couldn't let multi CPUs process the
> same IRQ concurrent.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 2e56576..0003322 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -114,15 +114,12 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
>  static void plic_irq_unmask(struct irq_data *d)
>  {
>         struct cpumask amask;
> -       unsigned int cpu;
>         struct plic_priv *priv = irq_get_chip_data(d->irq);
>
>         cpumask_and(&amask, &priv->lmask, cpu_online_mask);
> -       cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
> -                                          &amask);
> -       if (WARN_ON_ONCE(cpu >= nr_cpu_ids))
> -               return;
> -       plic_irq_toggle(cpumask_of(cpu), d, 1);
> +       cpumask_and(&amask, &amask, irq_data_get_affinity_mask(d));
> +
> +       plic_irq_toggle(&amask, d, 1);
>  }
>
>  static void plic_irq_mask(struct irq_data *d)
> @@ -136,24 +133,16 @@ static void plic_irq_mask(struct irq_data *d)
>  static int plic_set_affinity(struct irq_data *d,
>                              const struct cpumask *mask_val, bool force)
>  {
> -       unsigned int cpu;
>         struct cpumask amask;
>         struct plic_priv *priv = irq_get_chip_data(d->irq);
>
>         cpumask_and(&amask, &priv->lmask, mask_val);
> +       cpumask_and(&amask, &amask, cpu_online_mask);
>
> -       if (force)
> -               cpu = cpumask_first(&amask);
> -       else
> -               cpu = cpumask_any_and(&amask, cpu_online_mask);
> -
> -       if (cpu >= nr_cpu_ids)
> -               return -EINVAL;
> +       irq_data_update_effective_affinity(d, &amask);
>
>         plic_irq_toggle(&priv->lmask, d, 0);
> -       plic_irq_toggle(cpumask_of(cpu), d, 1);
> -
> -       irq_data_update_effective_affinity(d, cpumask_of(cpu));
> +       plic_irq_toggle(&amask, d, 1);
>
>         return IRQ_SET_MASK_OK_DONE;
>  }
> --
> 2.7.4
>

In the past, a similar patch was proposed by Zong Li (SiFive). We
have good reasons to not allow multiple CPUs handle the same IRQ.

Refer, https://lkml.org/lkml/2020/4/26/201

NACK from my side.

Regards,
Anup
