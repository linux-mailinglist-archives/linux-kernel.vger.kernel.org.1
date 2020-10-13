Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDB528C6C4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 03:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgJMBb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 21:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbgJMBb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 21:31:56 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF78DC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 18:31:54 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id d16so1364902iln.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 18:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0+6Ztw7jbOmA581hZd3dtxpZftTR2fcd6tnRuJa6WYo=;
        b=pZEbmEr9bQcIZ2o9YE29d8a/NvK5F3YeHSshot4Y7g5dNDbfoCqvMnHBRCi9UJRqeN
         Thb0/GdQ193YqnvZLBd8jn1YlAo2iKikyVMjFSVsX1wvo3IJYiFCal27S3QjDa2hgnT6
         nrLwZmhigVmhALy8FJnOcQzyRsNYOXPA+QPtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+6Ztw7jbOmA581hZd3dtxpZftTR2fcd6tnRuJa6WYo=;
        b=C34fAzUidwCXDMz4aUa4nHgEBwklVj1FyaL7cXkMWW1PFlNC52pceGaGBKMt/VqdIE
         W5KGng+5vUENxZY/Lq1I7D9folvGb9JXZHARyL3gIlci+cOYSXV9QcNOMygDJsX2ABp6
         OPavxLqI0jjdY+bywSE9BzQj8wyWy2bREu8WDbtQ5gA3dIAydQSkEazcsKoWrmJFacPq
         shDDET4a8G2X4Idw19WUSiJQ6IWVyWJ/u2pNI/YGxRFNVXkszO4qfJjI+GbIdLC2nj8l
         OBRkxwLZsMSUFb1WHG9Hi2PWBGMAfVlZj6MjdtrK2NtmgEz2XuQwXFJJd7H6SPfHuKhj
         iI4A==
X-Gm-Message-State: AOAM532poXiSm3kxqiBzLNLxvho2zhnTIh8Q8j2TOPZYSHyQJCySv6yA
        gc7u2n66c/o/zKua/VXfT/cZlrGJpXqCXu+NXT27
X-Google-Smtp-Source: ABdhPJyrzsYD5zMnBZ/1QiHJ4BOApq7CZqI4Dso1cg5+duue25ZASsBHhP1llxgj03dQFqrMSTwYL8hP5liEYyS/wtc=
X-Received: by 2002:a92:91db:: with SMTP id e88mr1178834ill.126.1602552713836;
 Mon, 12 Oct 2020 18:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201012135724.110579-1-greentime.hu@sifive.com>
In-Reply-To: <20201012135724.110579-1-greentime.hu@sifive.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 12 Oct 2020 18:31:43 -0700
Message-ID: <CAOnJCULYeoBGOBwbBo3izZsQpkgFvPotaH+FJ+5M2SWG=m=ypA@mail.gmail.com>
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

On Mon, Oct 12, 2020 at 6:57 AM Greentime Hu <greentime.hu@sifive.com> wrote:
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

LGTM.

Reviewed-by: Atish Patra <atish.patra@wdc.com>

-- 
Regards,
Atish
