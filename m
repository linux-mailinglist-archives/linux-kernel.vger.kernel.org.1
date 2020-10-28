Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F8E29E47E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbgJ2HiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbgJ2HYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F9DC0613E2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 21:00:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l8so1165954wmg.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 21:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tpeooy8wpsToDwsOdwFpvl4B9ZetpSNBYYInBLrWE8U=;
        b=tKM+1r4Ut5sf5k2wb98FALa10lW2Kot9y9BiIkoPkHh5XdwtWcBN7uTiMgNMdPjXVT
         nP6AwjNmjjJb0OT9m2SHItlkHU6Ptuw2FVHBJqQkVgKWakxJRN165PlGxce8enYih7oq
         7nPtXyehHOHk1ldkJsDTImw/2stH9rjqgIE0G85QrFv5B/aZ0RoIrce15m2bY0L5rpmf
         0GufrCPFEyQKDhVlFdsJZV5R5/XLBDCUsTBmtp9qOR3z5v7dl3RuOqNBxVN7MZ+IKQXV
         VWrxinpNeMnX0pPGlkXnzFM1nLE1/3Y3w4sQE+vhqtepTpj7AlQnEUjcVtMcU2IBEgjj
         42tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tpeooy8wpsToDwsOdwFpvl4B9ZetpSNBYYInBLrWE8U=;
        b=Go3EBq15t0rDuy36hI/JBUkIexO0fNly1msqf6qrcyqQnKjftnumLNANHVUKm/JsYk
         0TjIn5IIBE87FBFYq3TJmZhocym72WMFEYwzwE9bN0jOMUwcGrJZl6ySOcXGWI+UP5xw
         14livuAXEAy9CaIO8WgzndWJ/QusL8spvByx/llov+z3+B+nK6aDXyXHzBXPe1bAMcJB
         TgBCxoe+TM+kqw7//a4r5K0d+yIC5t50qMfZkHnVApqo14UFDBe+H/+fKEZes1r21T8v
         DccEM8n1PHZo3cad7r2Esk03F84GjEzAqnv9odxkJAxSu0G3P97519lF8i4ky7rwBzUy
         z3TQ==
X-Gm-Message-State: AOAM532nGO6rb7WYKnjhku1sOSbMc/b1GqSgWaXEevtLX2BHvOPYHA60
        D9eFvXTHz/AjS6wQQ9KFwIuty/cFe8CF/Od0DEHVpQ+c7Y66FQ==
X-Google-Smtp-Source: ABdhPJzoT0s4+vop2ihCnVixx2wrnJC4maNK2V+TvBOApGJVpy9PWntQxCddR04yvblWGz9Rpwl1nCVxrdzEE2GmFoc=
X-Received: by 2002:a7b:c92c:: with SMTP id h12mr2145549wml.134.1603944021772;
 Wed, 28 Oct 2020 21:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201029023738.127472-1-greentime.hu@sifive.com>
In-Reply-To: <20201029023738.127472-1-greentime.hu@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 28 Oct 2020 21:39:15 +0530
Message-ID: <CAAhSdy2SWFNCj6D1FbjB_vp0f068Y0OpC9hr8V+-ohB-8bkT7w@mail.gmail.com>
Subject: Re: [RFC PATCH] irqchip/sifive-plic: Fix getting wrong chip_data when
 interrupt is hierarchy
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atish.patra@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 8:07 AM Greentime Hu <greentime.hu@sifive.com> wrote:
>
> This oops is caused by a wrong chip_data and it is because plic_irq_unmask
> uses irq_get_chip_data(irq_data->irq) to get the chip_data. However it may
> get another irq_data with the same irq_data->irq if it is hierarchy.
>
> In this case, it will get irq_data of sifive_gpio_irqchip instead of
> plic_chip so that it will get a wrong chip_data and then the wrong lmask
> of it to cause this oops.
>
> To fix this issue, we can use irq_data_get_irq_chip_data(irq_data) to get
> the correct chip_data of plic_chip.
>
> (gdb) p d
> $11 = (struct irq_data *) 0xffffffe1f695f620
> (gdb) p *d
> $9 = {
>   mask = 0,
>   irq = 57,
>   hwirq = 6,
>   common = 0xffffffe1f695f600,
>   chip = 0xffffffe0018b5630 <sifive_gpio_irqchip>,
>   domain = 0xffffffe1f692c400,
>   parent_data = 0xffffffe1f68482c0,
>   chip_data = 0xffffffe1f564a820
> }
>
> (gdb) p d
> $6 = (struct irq_data *) 0xffffffe1f68482c0
> (gdb) p *d
> $7 = {
>   mask = 0,
>   irq = 57,
>   hwirq = 29,
>   common = 0xffffffe1f695f600,
>   chip = 0xffffffe0018b5070 <plic_chip>,
>   domain = 0xffffffe1f6635e00,
>   parent_data = 0x0,
>   chip_data = 0xffffffe1f660f1a0
> }
>
> [    3.030165] ------------[ cut here ]------------
> [    3.034614] WARNING: CPU: 1 PID: 1 at drivers/irqchip/irq-sifive-plic.c:125 plic_irq_unmask+0xc4/0x114
> [    3.043887] Modules linked in:
> [    3.046932] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.9.0 #1
> [    3.052748] epc: ffffffe000588e90 ra : ffffffe000588e88 sp : ffffffe1f6753940
> [    3.059869]  gp : ffffffe001978f48 tp : ffffffe1f6748000 t0 : ffffffe001995cb0
> [    3.067080]  t1 : ffffffe001995be8 t2 : 73616d61202c343a s0 : ffffffe1f67539a0
> [    3.074288]  s1 : ffffffe1f4968140 a0 : 00000000000000b2 a1 : 0000000000000000
> [    3.081497]  a2 : 00000000000000c2 a3 : 0000000000000000 a4 : 381c5a89432fe900
> [    3.088707]  a5 : 0000000000000004 a6 : 0000000000000000 a7 : 00000000000001aa
> [    3.095916]  s2 : ffffffe1f5901020 s3 : ffffffe00197a0a8 s4 : ffffffe001978b0c
> [    3.103125]  s5 : ffffffe00197a1f0 s6 : 0000000000000008 s7 : ffffffe1f4983c9c
> [    3.110335]  s8 : ffffffe1f4983c68 s9 : ffffffe1f4983c00 s10: ffffffe00000117c
> [    3.117544]  s11: 0000000000000000 t3 : 0000000000000007 t4 : 0000000000000000
> [    3.124753]  t5 : 66666666663a6b73 t6 : ffffffe001988479
> [    3.130052] status: 0000000200000100 badaddr: ffffffe001978b0c cause: 0000000000000003
> [    3.137959] ---[ end trace dbc1129f842ecba3 ]---
>
> Fixes: f1ad1133b18f ("irqchip/sifive-plic: Add support for multiple PLICs")
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 4048657ece0a..6f432d2a5ceb 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -99,7 +99,7 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
>                                    struct irq_data *d, int enable)
>  {
>         int cpu;
> -       struct plic_priv *priv = irq_get_chip_data(d->irq);
> +       struct plic_priv *priv = irq_data_get_irq_chip_data(d);
>
>         writel(enable, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
>         for_each_cpu(cpu, mask) {
> @@ -115,7 +115,7 @@ static void plic_irq_unmask(struct irq_data *d)
>  {
>         struct cpumask amask;
>         unsigned int cpu;
> -       struct plic_priv *priv = irq_get_chip_data(d->irq);
> +       struct plic_priv *priv = irq_data_get_irq_chip_data(d);
>
>         cpumask_and(&amask, &priv->lmask, cpu_online_mask);
>         cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
> @@ -127,7 +127,7 @@ static void plic_irq_unmask(struct irq_data *d)
>
>  static void plic_irq_mask(struct irq_data *d)
>  {
> -       struct plic_priv *priv = irq_get_chip_data(d->irq);
> +       struct plic_priv *priv = irq_data_get_irq_chip_data(d);
>
>         plic_irq_toggle(&priv->lmask, d, 0);
>  }
> @@ -138,7 +138,7 @@ static int plic_set_affinity(struct irq_data *d,
>  {
>         unsigned int cpu;
>         struct cpumask amask;
> -       struct plic_priv *priv = irq_get_chip_data(d->irq);
> +       struct plic_priv *priv = irq_data_get_irq_chip_data(d);
>
>         cpumask_and(&amask, &priv->lmask, mask_val);
>
> --
> 2.28.0
>

The PATCH which added multi-PLIC support was not tested
with hierarchical GPIO irqchip. I guess that's why we never saw
this issue previously. Thanks for investigating and fixing this.

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
