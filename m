Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13AB1DAF5E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 11:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgETJw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 05:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETJw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 05:52:27 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EB4C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 02:52:27 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z22so1951476lfd.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 02:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=di+O7XWs9ew3gUtMoYcWmBuPK/6Y39LUbfM4jyNZioU=;
        b=Bkiib2E1jLuFPY15fCRf+7JQdoxbF3iKCIjM6xO2ybauEwrN+kkNn3yF6U0CxGSCBN
         hjF3olr4S0Lahwhh3OEJ9LTMUPWjcsO2ANYLpoZutsEZKIXBsHqHfSR74lDjzEAlpt+j
         FD6vVnnxfGdmNmiD4tr4ZsR5Z1G0q0YmJ5iC9xyF9CQz68orEZAOv3EKOf44ooCxVf1q
         ff4vlvq4tePlbWv75MV1Fvi+YWNf06pYGlcHrBxB25WQiTwPMVuax1CPQ26nIne47ueo
         Jc+jYiybNSMf3Cu2xYWJUtsCeeZcCuztK8FbRU61j1Fdjb2bp8FRnRAK7katn0LhYeNH
         SrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=di+O7XWs9ew3gUtMoYcWmBuPK/6Y39LUbfM4jyNZioU=;
        b=jJYPT9QcThihj0Pke4rdyOeopgDnPRDZQvbHMknx0+1Jn6vUJQbwNdoOlLF0XVHEww
         s2BiT9P3KhMgrDCErXNMdzqSe4S/R5tQRgUu8PST5jeCgIiywyc3SCYZyu15G468Chzo
         7uGZOqcEEqRRrYpkkuSvZSPN1z6CO8DC8bdC6RfSlJuP4yTJZO2vFnumMCHe3RnR2piB
         miDleeAXNrNt2tdpZFqoVWuCmDgbewruf8g8hpqwG1XtoF3EKy2SgHoJ3XYhhn07EujW
         zs7SQvfW4TE6qpTvv7iMdkFjYA94QzP4cW4/RIaW4GnGcnDb/Jj83MHBAc1RaAr1onSW
         gvNA==
X-Gm-Message-State: AOAM532S1ZBbpKYnARX1mO47bReFI10snAbD6KBVSF5/l7ojruV1SvMg
        Ptr1KEaj7iiBsUVVVKaZKagwNb+l4D39ITWo5tuzOw==
X-Google-Smtp-Source: ABdhPJw8gIkRM0QVsro6/yY54EJWPqe2jja5SjnIIYgyrem445Og3OnBcxkeEHEefxqJu3koBMNevXAtNiXobO+bSLs=
X-Received: by 2002:ac2:4567:: with SMTP id k7mr2093376lfm.122.1589968345369;
 Wed, 20 May 2020 02:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200519161755.209565-1-maz@kernel.org> <20200519161755.209565-7-maz@kernel.org>
In-Reply-To: <20200519161755.209565-7-maz@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 20 May 2020 15:22:13 +0530
Message-ID: <CAFA6WYNfZKpQMTX8qP0eFHwyzJK4HK8z59G3OVLN8h0Uuc7P7w@mail.gmail.com>
Subject: Re: [PATCH 06/11] irqchip/gic-v3: Configure SGIs as standard interrupts
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Tue, 19 May 2020 at 21:48, Marc Zyngier <maz@kernel.org> wrote:
>
> Change the way we deal with GICv3 SGIs by turning them into proper
> IRQs, and calling into the arch code to register the interrupt range
> instead of a callback.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-gic-v3.c | 91 +++++++++++++++++++++---------------
>  1 file changed, 53 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 23d7c87da407..d57289057b75 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -36,6 +36,9 @@
>  #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996    (1ULL << 0)
>  #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539  (1ULL << 1)
>
> +#define GIC_IRQ_TYPE_PARTITION (GIC_IRQ_TYPE_LPI + 1)
> +#define GIC_IRQ_TYPE_SGI       (GIC_IRQ_TYPE_LPI + 2)
> +
>  struct redist_region {
>         void __iomem            *redist_base;
>         phys_addr_t             phys_base;
> @@ -657,38 +660,14 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
>         if ((irqnr >= 1020 && irqnr <= 1023))
>                 return;
>
> -       /* Treat anything but SGIs in a uniform way */
> -       if (likely(irqnr > 15)) {
> -               int err;
> -
> -               if (static_branch_likely(&supports_deactivate_key))
> -                       gic_write_eoir(irqnr);
> -               else
> -                       isb();
> -
> -               err = handle_domain_irq(gic_data.domain, irqnr, regs);
> -               if (err) {
> -                       WARN_ONCE(true, "Unexpected interrupt received!\n");
> -                       gic_deactivate_unhandled(irqnr);
> -               }
> -               return;
> -       }
> -       if (irqnr < 16) {
> +       if (static_branch_likely(&supports_deactivate_key))
>                 gic_write_eoir(irqnr);
> -               if (static_branch_likely(&supports_deactivate_key))
> -                       gic_write_dir(irqnr);
> -#ifdef CONFIG_SMP
> -               /*
> -                * Unlike GICv2, we don't need an smp_rmb() here.
> -                * The control dependency from gic_read_iar to
> -                * the ISB in gic_write_eoir is enough to ensure
> -                * that any shared data read by handle_IPI will
> -                * be read after the ACK.
> -                */
> -               handle_IPI(irqnr, regs);
> -#else
> -               WARN_ONCE(true, "Unexpected SGI received!\n");
> -#endif
> +       else
> +               isb();
> +
> +       if (handle_domain_irq(gic_data.domain, irqnr, regs)) {
> +               WARN_ONCE(true, "Unexpected interrupt received!\n");
> +               gic_deactivate_unhandled(irqnr);
>         }
>  }
>
> @@ -1136,11 +1115,11 @@ static void gic_send_sgi(u64 cluster_id, u16 tlist, unsigned int irq)
>         gic_write_sgi1r(val);
>  }
>
> -static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
> +static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
>  {
>         int cpu;
>
> -       if (WARN_ON(irq >= 16))
> +       if (WARN_ON(d->hwirq >= 16))
>                 return;
>
>         /*
> @@ -1154,7 +1133,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>                 u16 tlist;
>
>                 tlist = gic_compute_target_list(&cpu, mask, cluster_id);
> -               gic_send_sgi(cluster_id, tlist, irq);
> +               gic_send_sgi(cluster_id, tlist, d->hwirq);
>         }
>
>         /* Force the above writes to ICC_SGI1R_EL1 to be executed */
> @@ -1163,10 +1142,36 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>
>  static void gic_smp_init(void)
>  {
> -       set_smp_cross_call(gic_raise_softirq);
> +       struct irq_fwspec sgi_fwspec = {
> +               .fwnode         = gic_data.fwnode,
> +       };
> +       int base_sgi;
> +
>         cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
>                                   "irqchip/arm/gicv3:starting",
>                                   gic_starting_cpu, NULL);
> +
> +       if (is_of_node(gic_data.fwnode)) {
> +               /* DT */
> +               sgi_fwspec.param_count = 3;
> +               sgi_fwspec.param[0] = GIC_IRQ_TYPE_SGI;
> +               sgi_fwspec.param[1] = 0;
> +               sgi_fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
> +       } else {
> +               /* ACPI */
> +               sgi_fwspec.param_count = 2;
> +               sgi_fwspec.param[0] = 0;
> +               sgi_fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
> +       }
> +
> +       /* Register all 8 non-secure SGIs */
> +       base_sgi = __irq_domain_alloc_irqs(gic_data.domain, -1, 8,
> +                                          NUMA_NO_NODE, &sgi_fwspec,
> +                                          false, NULL);
> +       if (WARN_ON(base_sgi <= 0))
> +               return;
> +
> +       set_smp_ipi_range(base_sgi, 8);
>  }
>
>  static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
> @@ -1215,6 +1220,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>  }
>  #else
>  #define gic_set_affinity       NULL
> +#define gic_ipi_send_mask      NULL
>  #define gic_smp_init()         do { } while(0)
>  #endif
>
> @@ -1257,6 +1263,7 @@ static struct irq_chip gic_chip = {
>         .irq_set_irqchip_state  = gic_irq_set_irqchip_state,
>         .irq_nmi_setup          = gic_irq_nmi_setup,
>         .irq_nmi_teardown       = gic_irq_nmi_teardown,
> +       .ipi_send_mask          = gic_ipi_send_mask,
>         .flags                  = IRQCHIP_SET_TYPE_MASKED |
>                                   IRQCHIP_SKIP_SET_WAKE |
>                                   IRQCHIP_MASK_ON_SUSPEND,

It looks like you missed to update "struct irq_chip gic_eoimode1_chip"
with similar change as follows:

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 2a09634..ceef63b 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1291,6 +1291,7 @@ static struct irq_chip gic_eoimode1_chip = {
        .irq_set_vcpu_affinity  = gic_irq_set_vcpu_affinity,
        .irq_nmi_setup          = gic_irq_nmi_setup,
        .irq_nmi_teardown       = gic_irq_nmi_teardown,
+       .ipi_send_mask          = gic_ipi_send_mask,
        .flags                  = IRQCHIP_SET_TYPE_MASKED |
                                  IRQCHIP_SKIP_SET_WAKE |
                                  IRQCHIP_MASK_ON_SUSPEND,

After incorporating this change, your patch-set works fine on my
Developerbox machine.

-Sumit

> @@ -1289,6 +1296,13 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
>
>         switch (__get_intid_range(hw)) {
>         case SGI_RANGE:
> +               irq_set_percpu_devid(irq);
> +               irq_domain_set_info(d, irq, hw, chip, d->host_data,
> +                                   handle_percpu_devid_fasteoi_ipi,
> +                                   NULL, NULL);
> +               irq_set_status_flags(irq, IRQ_NOAUTOEN);
> +               break;
> +
>         case PPI_RANGE:
>         case EPPI_RANGE:
>                 irq_set_percpu_devid(irq);
> @@ -1319,8 +1333,6 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
>         return 0;
>  }
>
> -#define GIC_IRQ_TYPE_PARTITION (GIC_IRQ_TYPE_LPI + 1)
> -
>  static int gic_irq_domain_translate(struct irq_domain *d,
>                                     struct irq_fwspec *fwspec,
>                                     unsigned long *hwirq,
> @@ -1353,6 +1365,9 @@ static int gic_irq_domain_translate(struct irq_domain *d,
>                         else
>                                 *hwirq += 16;
>                         break;
> +               case GIC_IRQ_TYPE_SGI:
> +                       *hwirq = fwspec->param[1];
> +                       break;
>                 default:
>                         return -EINVAL;
>                 }
> @@ -1657,9 +1672,9 @@ static int __init gic_init_bases(void __iomem *dist_base,
>
>         gic_update_rdist_properties();
>
> -       gic_smp_init();
>         gic_dist_init();
>         gic_cpu_init();
> +       gic_smp_init();
>         gic_cpu_pm_init();
>
>         if (gic_dist_supports_lpis()) {
> --
> 2.26.2
>
