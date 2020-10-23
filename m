Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A93296F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 14:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463630AbgJWMbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 08:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505954AbgJWMba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 08:31:30 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46506C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 05:31:29 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l15so1329381wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 05:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OgsYaNT7si4aUmj94LUjpDJPk7YDycSfzUdAI52Aub4=;
        b=VZpi6JBFejPcuHx/0xa8bObFcO7Gg481B13EEknIsI5tXtO9GC7/umRRZlu/BQ9Ron
         4ie4+8bOaIJpXzYB6uZ5FmseJDhSrW1dM+xFAy/aaVAT8a2NP4jJgOc1s7EF8khg1Ub0
         vRYCsHLJOTnGLCQb+a/2hJUQP1HWJQWs8slKF0XJXtOBM06bxlOIXVMOXoKh+EQr491C
         MrklP1atlg/A9GR7YdCYo76hDlqcOn0loczylzWCGgVVdR9vTCqIIJGtC+7NmlhtyG7y
         vkzKeZdX+N1CA2Oe4Qa31RBkDGqoIhcJhZc2hNZUGJnV/+sf34LHT5Qs+WZ/+ww7/26+
         MCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OgsYaNT7si4aUmj94LUjpDJPk7YDycSfzUdAI52Aub4=;
        b=LUbTtPVe0TUcV4hunVFYP3Az/+oRyygGwCldISHjyc+V3oqiEwqGgC5Yzz3yjLLZSA
         HVCabQJCBPwxkHJ/p44Em96gC58+vv1CDOx/l4QZlWPFrbqB+sgkRgEuNcFZfqTTJTTG
         a+PtDmoQ4EE/p4CQvxauOYmCoB290nS+tNIXcpy99R27oaNUn8LsjQ749m/HEK0GDT6P
         V5eHpIInf0P9pl4dgQxlNsc7kaB7aDfBk4CV24bwUkdf45NH/l/ptu+YKL/8sW1eADFe
         biZZzfFGzCgzF2E+HM42fbOVM8KKHcHOpHX/LoMXopeP2c89zu9zYJz3L0FLZlguT/Qj
         tHQg==
X-Gm-Message-State: AOAM530pChkki7NXQZRd+zI6W0ozRYasPrUzBazZHsXUvV+C2xR6Q62i
        OcRmKq0p84V8aE5meFZF7Xy1GXTns/EbzpD8c215HQ==
X-Google-Smtp-Source: ABdhPJzCrKXMDdLXDXqAEB5GIUv0k5E7npGAomI+NZQd7jBeyb84zmgrGhWm2O4AlDjcnRLEraHrM13t0zQVeTLIw5Y=
X-Received: by 2002:a1c:6743:: with SMTP id b64mr1986488wmc.157.1603456287911;
 Fri, 23 Oct 2020 05:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <1603448245-79429-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1603448245-79429-1-git-send-email-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 23 Oct 2020 17:12:09 +0530
Message-ID: <CAAhSdy1rqZBt5LSgs9yQwewwKXvaS23ou5Ah7Xfu3n7S9sK6RA@mail.gmail.com>
Subject: Re: [PATCH 1/3] irqchip/irq-sifive-plic: Fixup wrong size of
 xxx_PER_HART and reg base
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
> ENABLE and CONTEXT registers contain M & S status for per-hart, so
> ref to the specification the correct definition is double to the
> current value.
>
> The value of hart_base and enable_base should be calculated by real
> physical hartid not software id. Sometimes the CPU node's <reg>
> from dts is not equal to the sequence index.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index eaa3e9f..2e56576 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -44,16 +44,16 @@
>   * Each hart context has a vector of interrupt enable bits associated with it.
>   * There's one bit for each interrupt source.
>   */
> -#define ENABLE_BASE                    0x2000
> -#define     ENABLE_PER_HART            0x80
> +#define ENABLE_BASE                    0x2080
> +#define     ENABLE_PER_HART            0x100
>
>  /*
>   * Each hart context has a set of control registers associated with it.  Right
>   * now there's only two: a source priority threshold over which the hart will
>   * take an interrupt, and a register to claim interrupts.
>   */
> -#define CONTEXT_BASE                   0x200000
> -#define     CONTEXT_PER_HART           0x1000
> +#define CONTEXT_BASE                   0x201000
> +#define     CONTEXT_PER_HART           0x2000
>  #define     CONTEXT_THRESHOLD          0x00
>  #define     CONTEXT_CLAIM              0x04
>
> @@ -358,10 +358,10 @@ static int __init plic_init(struct device_node *node,
>                 cpumask_set_cpu(cpu, &priv->lmask);
>                 handler->present = true;
>                 handler->hart_base =
> -                       priv->regs + CONTEXT_BASE + i * CONTEXT_PER_HART;
> +                       priv->regs + CONTEXT_BASE + hartid * CONTEXT_PER_HART;
>                 raw_spin_lock_init(&handler->enable_lock);
>                 handler->enable_base =
> -                       priv->regs + ENABLE_BASE + i * ENABLE_PER_HART;
> +                       priv->regs + ENABLE_BASE + hartid * ENABLE_PER_HART;
>                 handler->priv = priv;
>  done:
>                 for (hwirq = 1; hwirq <= nr_irqs; hwirq++)
> --
> 2.7.4
>

There is no one-to-one mapping between PLIC context and HARTID. Instead,
we have many-to-one mapping between PLIC contexts and HARTID. In other
words, we have one PLIC context for each interrupt capable mode (i.e.
M/S-mode) of each HART.

For example, on SiFive Unleashed we have 5 HARTs but HARTID=0 has
only M-mode capable of taking interrupts so we have total (1 + 2x4) = 9
PLIC contexts.

I would also like to highlight that this patch is forcing PLIC driver to always
use PLIC S-mode context for each HART which breaks the Linux RISC-V
NoMMU kernel.

There is no issue with the existing defines because these are aligned with
above and latest PLIC spec.
(Refer, https://github.com/riscv/riscv-plic-spec/blob/master/riscv-plic.adoc)

NACK to this patch from my side.

Regards,
Anup
