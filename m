Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9486928BE96
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 19:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403894AbgJLRCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 13:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390355AbgJLRCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 13:02:52 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD46C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 10:02:51 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q5so18223004wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 10:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gCocwBk0zsLiLfxj4V7WicRiwG5RXcRHYmfk3RiD8UM=;
        b=REQjzzKGbFJr09J7c0ahMc56ZLqOPhPfVl1oT/bpeXleHnEO4aSqBrhI8dCH+bgxwH
         KWw8kayNxvvS0wSVrrF4Ma+eM2TiQbgl8pJ7jghVSLlVkRiI1+rAw+6z3XM3KhQsypB/
         YtoJb4HsnUxUdb5C/KMbjEEAQPqNqlq2ZBg7lpVje7rUuUOLSrB0F1Bf9iRrLIF+dpv8
         kKykuChTXtlWV6JG2nTS4RXnrpo/85JJ2lcMFRiRyjMN80MJdNV0eGVnoOE0MXoFLeCJ
         GCUGwwOnWQ0VSZT2XSv6c+Sgw+SFbYzN1pC5AW2mgYRjJceAmaFsWFCWVNGPg0r6lQq8
         utkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gCocwBk0zsLiLfxj4V7WicRiwG5RXcRHYmfk3RiD8UM=;
        b=lr+pN5S2ucDbqbVHLK9NPcQklaswsDegzc4pTsamUmttIpOn1SCMn6CQ5K5pik3GQe
         fqtII0SCzEfyGKjqEL7kbr0rQjJao//l7EQXUCev3A4j/UXiePAXzQwGcUejBkekcQuG
         6Ttc58q3pQ2L2dWdYmsvlKjzKwotJF1fkPjoLNihIbAs0gdXb2IcJQCF83LqyKZwgDSS
         kU0lG7aKKaeSM1cNY27dEBMEWP5VSNy+v6cY3IKYUgJarWn6byXPmIBiXboQhb/sNeuA
         kTsXzCjKzLsp+3LIIzB6Lyl4PgCElKBd5Jb/6SIYZtZY76q7j7opCan4OIFcYdyAxWkS
         zWjQ==
X-Gm-Message-State: AOAM530fSr5XslJ7R0DSfd4MbQtkWUAX3MPqH+W/SIt7AD5m/2DyArTR
        2SMnrqEMSBqWV2qIU+t+rr/igXAG0wM/UqxbPF4x6g==
X-Google-Smtp-Source: ABdhPJzou3eVrc5U7Gdikdm3S33pUaKtPuc3l97KtGAW6vrk8naWp/dq3nd6Ycudnc0FS+uVbMWphTDZ7ttwrYLIdX4=
X-Received: by 2002:a1c:4d13:: with SMTP id o19mr7352774wmh.185.1602522170285;
 Mon, 12 Oct 2020 10:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201012135724.110579-1-greentime.hu@sifive.com>
In-Reply-To: <20201012135724.110579-1-greentime.hu@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 12 Oct 2020 22:32:38 +0530
Message-ID: <CAAhSdy0Jj3+gsto8oj76GkDnm1WYiDFCntM=VuxKtoABGYTK5g@mail.gmail.com>
Subject: Re: [PATCH 1/2] irqchip/sifive-plic: Enable or disable interrupt
 based on its previous setting
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 7:27 PM Greentime Hu <greentime.hu@sifive.com> wrote:
>
> It will always enable the interrupt after calling plic_set_affinity()
> however it should set to its previous setting. Staying disabled or enabled.
>
> This patch can also fix this pwm hang issue in Unleashed board.
>
> [  919.015783] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [  919.020922] rcu:     0-...0: (0 ticks this GP)
> idle=7d2/1/0x4000000000000002 softirq=1424/1424 fqs=105807
> [  919.030295]  (detected by 1, t=225825 jiffies, g=1561, q=3496)
> [  919.036109] Task dump for CPU 0:
> [  919.039321] kworker/0:1     R  running task        0    30      2 0x00000008
> [  919.046359] Workqueue: events set_brightness_delayed
> [  919.051302] Call Trace:
> [  919.053738] [<ffffffe000930d92>] __schedule+0x194/0x4de
> [  982.035783] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [  982.040923] rcu:     0-...0: (0 ticks this GP)
> idle=7d2/1/0x4000000000000002 softirq=1424/1424 fqs=113325
> [  982.050294]  (detected by 1, t=241580 jiffies, g=1561, q=3509)
> [  982.056108] Task dump for CPU 0:
> [  982.059321] kworker/0:1     R  running task        0    30      2 0x00000008
> [  982.066359] Workqueue: events set_brightness_delayed
> [  982.071302] Call Trace:
> [  982.073739] [<ffffffe000930d92>] __schedule+0x194/0x4de
> [..]
>
> Fixes: bb0fed1c60cc ("irqchip/sifive-plic: Switch to fasteoi flow")
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index eaa3e9fe54e9..4cc8a2657a6d 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -137,6 +137,7 @@ static int plic_set_affinity(struct irq_data *d,
>                              const struct cpumask *mask_val, bool force)
>  {
>         unsigned int cpu;
> +       bool enable;
>         struct cpumask amask;
>         struct plic_priv *priv = irq_get_chip_data(d->irq);
>
> @@ -150,8 +151,10 @@ static int plic_set_affinity(struct irq_data *d,
>         if (cpu >= nr_cpu_ids)
>                 return -EINVAL;
>
> +       enable = !irqd_irq_disabled(d);
>         plic_irq_toggle(&priv->lmask, d, 0);
> -       plic_irq_toggle(cpumask_of(cpu), d, 1);
> +       /* Keep its original setting. */
> +       plic_irq_toggle(cpumask_of(cpu), d, enable);
>
>         irq_data_update_effective_affinity(d, cpumask_of(cpu));
>
> --
> 2.28.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Good catch. Your fix looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
