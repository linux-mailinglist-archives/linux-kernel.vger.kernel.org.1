Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7832936EC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 10:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392091AbgJTIkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 04:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgJTIkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 04:40:01 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3198DC061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 01:40:01 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e17so1058256wru.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 01:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SUh/HgM+ua4NwVRYsXhIRglonIVZJrlor5QZYC9gpY4=;
        b=V77vpMhwIw+3HwH8CM2qAFK9RNuXrN0WlM5hHqoxwPYWYnGcsQZLYmrHXsTwC/b2tB
         sfBDlilU4lbEbEX0u1ypCLPJb9Y1vSL45IUIFn7+B2TZetoF/mN44NgeDciJrq+K7hmy
         08M4MO7L0ZPiEaqz/cJbv+Wm8KnaO9sXrd1VXJ2nPkQuUVCDqE2hBMRokScAToTyxKDC
         xFKQSkiQ4RzVCFK2qnolRi0rcSNYvrWhV4/zej+NrE7pHpX3sH/iZ2DbVx1K/trt4sCk
         oY+qr4BwzBVx7M0SpACF/9PglsL8rUUtZt8amrflzFponix3FEhAa9dWoqZ/+eobe535
         Qebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SUh/HgM+ua4NwVRYsXhIRglonIVZJrlor5QZYC9gpY4=;
        b=pl4I8zFaK3JuPf4+LzRJ8AAkpuuZwmZZ+y3cmvcIs6f+ItXA4LHk02VfeTf4Rd4E9Z
         urdu9wJlnW59hfC0Zjv5eUfG+dMnN+HIS3zja8IKm/NiWAQyIcI/Q/TBX7wrarGHMroP
         9jwVqJDsAzaW2lv0nJKkuEczS53T/bNFsvtdlV7wyStdnxNCxHyWLg2izp4+24mFToek
         La3DWvzQEcXuuwPxM78zo1BG/Qw2ntuy2F5t63h5X+jYP5Ffm+aqoIcmAIOTCK/u20Vy
         jiVwvyZ8fFuh8GA8c/gpNiEy8oN0f7rkbg9woWaFJ/IgDMrAUnncfNFTnRsLinopJWkT
         WeVw==
X-Gm-Message-State: AOAM533eyRqoue3EDTVMgdlIxKDbmv2qPxOYIztm2/zrfFUVh74kP1pl
        PaEF24/l8bjNFId6B4UWPgb8zt2OV5LnutINb0KCIw==
X-Google-Smtp-Source: ABdhPJy0EL3UjDDNNuZAniLHen9U7rto6vYZuH3dFUFv/RgLwXnsa/7SzTYVK7flT9RIxnMIfo0tzicZLcvmsBWzegA=
X-Received: by 2002:adf:80cb:: with SMTP id 69mr2124137wrl.325.1603183199773;
 Tue, 20 Oct 2020 01:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201020081532.2377-1-greentime.hu@sifive.com>
In-Reply-To: <20201020081532.2377-1-greentime.hu@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 20 Oct 2020 14:09:48 +0530
Message-ID: <CAAhSdy0kQBHvOirK1haPajEXS5X4e6KGE1kx2YwtoK2k+aVsLg@mail.gmail.com>
Subject: Re: [PATCH] irqchip/sifive-plic: Fix broken irq_set_affinity() callback
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

On Tue, Oct 20, 2020 at 1:45 PM Greentime Hu <greentime.hu@sifive.com> wrote:
>
> It will always enable the interrupt after calling plic_set_affinity()
> however it should set to it previous setting. Staying disabled or enabled.
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
>  drivers/irqchip/irq-sifive-plic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index eaa3e9fe54e9..4048657ece0a 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -151,7 +151,7 @@ static int plic_set_affinity(struct irq_data *d,
>                 return -EINVAL;
>
>         plic_irq_toggle(&priv->lmask, d, 0);
> -       plic_irq_toggle(cpumask_of(cpu), d, 1);
> +       plic_irq_toggle(cpumask_of(cpu), d, !irqd_irq_masked(d));
>
>         irq_data_update_effective_affinity(d, cpumask_of(cpu));
>
> --
> 2.28.0
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
