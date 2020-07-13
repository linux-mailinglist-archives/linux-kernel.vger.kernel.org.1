Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407C621E2E4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 00:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgGMWRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 18:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgGMWRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 18:17:15 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A8BC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:17:15 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id m18so2759358vkk.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qKpldInd0UQzs9lkRKWSogG99psFT1V4t4FwC+4/XQY=;
        b=jxmhxHp+YYEP6Xnmqo2YvZQO8FnSceWy8+ER2HvNzZcNXNmM4LM/k3f4SwVTbQV7N7
         +OQdr7dx9J80L6AB8PhlsWFvNtQCL3yQwFeKn+x/oAq9yRZD0eaQpE3Vk0c6Ab9ajuDB
         XgRvtje+8zwnuYP2BEau9eFhzaDfaiIFtNV1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qKpldInd0UQzs9lkRKWSogG99psFT1V4t4FwC+4/XQY=;
        b=EMTHUH81Z2zKafBq3RKoQ/GqJ4Z4i+JKcBdV9XC1Ug89QJmoualgkbe4GXnVPMuvM2
         1E/UjLYLOhCRdP5a2qkAUdbqjA/iztNtRkWiiQ7Fsr+OzWRqShdwYBcUjgfzH5Ga2ZGq
         fRTA1WaIca/a59GpPKf4g+SA2p+B1wzWqorG/p64V1LtboWC56Jt557DURNexOftD3AK
         O8rr4EsoN3a+BddIGmz/fdgDyucoXa78TVrbR2rmKLUUIrQf8wIxEFKU0+c7/cgl9ezz
         fpmKquAn/6SFAyiSWqebb3sirUyxaZvhMLLZUb68DgKDw7eO2SNTZ8CV4Fgyif0A225X
         fDVg==
X-Gm-Message-State: AOAM5330a9SsPs9bv7vUwzT8Ao4z1rTWaSBSsChq1NyKSs4cu6rk3I8H
        1rrL0ap0VQvsNJPPgr86bzal/qzgKIs=
X-Google-Smtp-Source: ABdhPJwTLz/6KpaJK8Ty3ry+VjEF7I+cp+Tco519oPxgUHH+fxcVRTyDpxWSi9enoU1G7xEj5SWVFg==
X-Received: by 2002:a1f:dc06:: with SMTP id t6mr1759320vkg.10.1594678634031;
        Mon, 13 Jul 2020 15:17:14 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id 79sm1523768uas.2.2020.07.13.15.17.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 15:17:13 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id q15so4745424uap.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:17:11 -0700 (PDT)
X-Received: by 2002:ab0:6e8e:: with SMTP id b14mr1590042uav.0.1594678630551;
 Mon, 13 Jul 2020 15:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <1592818308-23001-1-git-send-email-mkshah@codeaurora.org> <1592818308-23001-5-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1592818308-23001-5-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 Jul 2020 15:16:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wa6mUAM_bMN7E-D1Wi9qbFNJWWjfVsgcAVUBmwGqBhSg@mail.gmail.com>
Message-ID: <CAD=FV=Wa6mUAM_bMN7E-D1Wi9qbFNJWWjfVsgcAVUBmwGqBhSg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] irqchip: qcom-pdc: Introduce irq_set_wake call
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        LinusW <linus.walleij@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Srinivas Rao L <lsrao@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 22, 2020 at 2:33 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Remove irq_disable callback to allow lazy disable for pdc interrupts.
>
> Add irq_set_wake callback that unmask interrupt in HW when drivers
> mark interrupt for wakeup. Interrupt will be cleared in HW during
> lazy disable if its not marked for wakeup.
>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  drivers/irqchip/qcom-pdc.c | 34 ++++++++++++++++------------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
> index 6ae9e1f..8beb6f7 100644
> --- a/drivers/irqchip/qcom-pdc.c
> +++ b/drivers/irqchip/qcom-pdc.c
> @@ -36,6 +36,7 @@ struct pdc_pin_region {
>         u32 cnt;
>  };
>
> +static DECLARE_BITMAP(pdc_wake_irqs, PDC_MAX_IRQS);
>  static DEFINE_RAW_SPINLOCK(pdc_lock);
>  static void __iomem *pdc_base;
>  static struct pdc_pin_region *pdc_region;
> @@ -87,22 +88,17 @@ static void pdc_enable_intr(struct irq_data *d, bool on)
>         raw_spin_unlock(&pdc_lock);
>  }
>
> -static void qcom_pdc_gic_disable(struct irq_data *d)
> +static int qcom_pdc_gic_set_wake(struct irq_data *d, unsigned int on)
>  {
> -       if (d->hwirq == GPIO_NO_WAKE_IRQ)
> -               return;
> -
> -       pdc_enable_intr(d, false);
> -       irq_chip_disable_parent(d);
> -}
> -
> -static void qcom_pdc_gic_enable(struct irq_data *d)
> -{
> -       if (d->hwirq == GPIO_NO_WAKE_IRQ)
> -               return;
> +       if (on) {
> +               pdc_enable_intr(d, true);
> +               irq_chip_enable_parent(d);
> +               set_bit(d->hwirq, pdc_wake_irqs);
> +       } else {
> +               clear_bit(d->hwirq, pdc_wake_irqs);
> +       }
>
> -       pdc_enable_intr(d, true);
> -       irq_chip_enable_parent(d);
> +       return irq_chip_set_wake_parent(d, on);
>  }
>
>  static void qcom_pdc_gic_mask(struct irq_data *d)
> @@ -111,6 +107,9 @@ static void qcom_pdc_gic_mask(struct irq_data *d)
>                 return;
>
>         irq_chip_mask_parent(d);
> +
> +       if (!test_bit(d->hwirq, pdc_wake_irqs))
> +               pdc_enable_intr(d, false);

I _think_ this will break masking, right?  In other words, consider
the following (having nothing to do with suspend/resume):

1. Driver requests an interrupt.
2. Driver masks interrupt (calls disable_irq())
3. Interrupt fires while it is masked.
4. Driver unmasks interrupt (calls enable_irq().

After step #4 the interrupt should fire since it was only masked, not
disabled (yes, it's super confusing that the driver calls
disable_irq() but it expecting it to be masked--as I understand it
that's just how it is).  I haven't tested, but I suspect that's broken
for you now (assuming you're working on a pin that wasn't a wakeup
pin) because you won't track edges when you're "disabled".

I suspect that the right thing to do here is to:

a) Make qcom_pdc_gic_set_wake() just keep "pdc_wake_irqs" up to date
and then call parent.

b) Implement irq_suspend and irq_resume.  In irq_suspend() you disable
all interrupts that aren't in "pdc_wake_irqs".  In irq_resume() you
just re-enable all of them (masking will be handled by the parent).

Would that work?

...oh, drat!  The .irq_suspend() callback is only there if you're
using "irq/generic-chip.c".  OK, well unless we want to move over to
using generic-chip we can just register for syscore ourselves.  OK, I
tested and <https://crrev.com/c/2296160> works.



>  }
>
>  static void qcom_pdc_gic_unmask(struct irq_data *d)
> @@ -118,6 +117,7 @@ static void qcom_pdc_gic_unmask(struct irq_data *d)
>         if (d->hwirq == GPIO_NO_WAKE_IRQ)
>                 return;
>
> +       pdc_enable_intr(d, true);
>         irq_chip_unmask_parent(d);
>  }
>
> @@ -197,15 +197,13 @@ static struct irq_chip qcom_pdc_gic_chip = {
>         .irq_eoi                = irq_chip_eoi_parent,
>         .irq_mask               = qcom_pdc_gic_mask,
>         .irq_unmask             = qcom_pdc_gic_unmask,
> -       .irq_disable            = qcom_pdc_gic_disable,
> -       .irq_enable             = qcom_pdc_gic_enable,
>         .irq_get_irqchip_state  = qcom_pdc_gic_get_irqchip_state,
>         .irq_set_irqchip_state  = qcom_pdc_gic_set_irqchip_state,
>         .irq_retrigger          = irq_chip_retrigger_hierarchy,
>         .irq_set_type           = qcom_pdc_gic_set_type,
> +       .irq_set_wake           = qcom_pdc_gic_set_wake,
>         .flags                  = IRQCHIP_MASK_ON_SUSPEND |
> -                                 IRQCHIP_SET_TYPE_MASKED |
> -                                 IRQCHIP_SKIP_SET_WAKE,
> +                                 IRQCHIP_SET_TYPE_MASKED,
>         .irq_set_vcpu_affinity  = irq_chip_set_vcpu_affinity_parent,
>         .irq_set_affinity       = irq_chip_set_affinity_parent,
>  };
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
