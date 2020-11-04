Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B822A64A3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 13:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgKDMtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 07:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbgKDMtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 07:49:05 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7452DC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 04:49:04 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id v19so17888481lji.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 04:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w2Q9j4dO1fhVv8kSZbKiWc5aiYlzjfa6KTzUODZGeUM=;
        b=s3dk2/f6Bn+Y56+Xrxfn5AmVpHd6Yke08lmPTwmsmgBcuN6Y0jOH+eeJF/ZJmOsZFo
         32+BUhb1ppR3qMDpuGd7tmN3I1wXP5+p2K1Fc2wLb1YblwYrGltpjUG8C8UAYlxVAmnB
         +1JvSYdP1EUHcnPPzE/rNTKEKUBTAsnJ4LVK4hFLlDnKcuI2MU0JD95MVV28xxfUy6+j
         1+3JoK3T7Wo7to0G+uVdOMJpH28CpgSpk34zZEP44Ngq/UZgLUzHKm5qDX+Zt1XhX3Pe
         wO9O2Vsv47Q0x2GJP8btfmOTBofuns2eZaBPlhzHQGPRCXTLccddb1iAi4T2qvgegOSg
         wRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w2Q9j4dO1fhVv8kSZbKiWc5aiYlzjfa6KTzUODZGeUM=;
        b=S2WHjbnO8Z5uFJmnKJONYLyo7A29GrOv53pYd/hm3L0C+D8JdAjypBhvVHOl+kosoI
         6VjL/NiP9XS2iRzK30Vgl7WKQIfcsVnqaJZxIKsz8VJNnJSB8HlQedSnvzZjqZg6xdNB
         0ZUATRlfnwCfdDy/ETZBeKBIMbiDuLuyuG2Q+w8q3z0/2Ju83e63hadZZyDGAQIuiG+X
         1AI6NERIacvbRNarv3ukLYFwch3briqrD1juIQ+scEE2c5BRVivim7OEsXY/XU0+yCkM
         GLQWu5R6xuFKU9u/KQLAsASeeejaUzi/9zJeAMb4a+lV4Iywz1l3sgimBpY3Op+IPljh
         6g7g==
X-Gm-Message-State: AOAM532SBFy8Rh6UkJjW6je4WnMMtqf2/nTZz3ajssLIgWQAGvoWr/Dy
        KUoTiFGwLdu+i8mcZegZuCB3Mxew96OBZfQxLe+tbg==
X-Google-Smtp-Source: ABdhPJzUr3mwkNbQhVPC+KAtjkwrgUU1V/MZfbwQJg1Fc5DcLVFajd2Q3ARFw7xL8WkF2FN1nerMr9yRteWYA7Fuv64=
X-Received: by 2002:a05:651c:32a:: with SMTP id b10mr9600926ljp.256.1604494142894;
 Wed, 04 Nov 2020 04:49:02 -0800 (PST)
MIME-Version: 1.0
References: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org>
 <1604317487-14543-2-git-send-email-sumit.garg@linaro.org> <20201102153349.fay4f5iam76gfapu@gabell>
In-Reply-To: <20201102153349.fay4f5iam76gfapu@gabell>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 4 Nov 2020 18:18:51 +0530
Message-ID: <CAFA6WYNP+dSMVcsXw+aTiyzOOT7QY+ksckW4=L9u1rOej2MNNw@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] arm64: Add framework to turn IPI as NMI
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au,
        "David S. Miller" <davem@davemloft.net>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        julien.thierry.kdev@gmail.com,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Nov 2020 at 21:03, Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
>
> On Mon, Nov 02, 2020 at 05:14:41PM +0530, Sumit Garg wrote:
> > Introduce framework to turn an IPI as NMI using pseudo NMIs. The main
> > motivation for this feature is to have an IPI that can be leveraged to
> > invoke NMI functions on other CPUs.
> >
> > And current prospective users are NMI backtrace and KGDB CPUs round-up
> > whose support is added via future patches.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  arch/arm64/include/asm/nmi.h | 17 ++++++++++++
> >  arch/arm64/kernel/Makefile   |  2 +-
> >  arch/arm64/kernel/ipi_nmi.c  | 65 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 83 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm64/include/asm/nmi.h
> >  create mode 100644 arch/arm64/kernel/ipi_nmi.c
> >
> > diff --git a/arch/arm64/include/asm/nmi.h b/arch/arm64/include/asm/nmi.h
> > new file mode 100644
> > index 0000000..4cd14b6
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/nmi.h
> > @@ -0,0 +1,17 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __ASM_NMI_H
> > +#define __ASM_NMI_H
> > +
> > +#ifndef __ASSEMBLER__
> > +
> > +#include <linux/cpumask.h>
> > +
> > +extern bool arm64_supports_nmi(void);
> > +extern void arm64_send_nmi(cpumask_t *mask);
> > +
> > +void set_smp_dynamic_ipi(int ipi);
> > +void dynamic_ipi_setup(int cpu);
> > +void dynamic_ipi_teardown(int cpu);
> > +
> > +#endif /* !__ASSEMBLER__ */
> > +#endif
> > diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> > index bbaf0bc..525a1e0 100644
> > --- a/arch/arm64/kernel/Makefile
> > +++ b/arch/arm64/kernel/Makefile
> > @@ -17,7 +17,7 @@ obj-y                       := debug-monitors.o entry.o irq.o fpsimd.o              \
> >                          return_address.o cpuinfo.o cpu_errata.o              \
> >                          cpufeature.o alternative.o cacheinfo.o               \
> >                          smp.o smp_spin_table.o topology.o smccc-call.o       \
> > -                        syscall.o proton-pack.o
> > +                        syscall.o proton-pack.o ipi_nmi.o
> >
> >  targets                      += efi-entry.o
> >
> > diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
> > new file mode 100644
> > index 0000000..a945dcf
> > --- /dev/null
> > +++ b/arch/arm64/kernel/ipi_nmi.c
> > @@ -0,0 +1,65 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * NMI support for IPIs
> > + *
> > + * Copyright (C) 2020 Linaro Limited
> > + * Author: Sumit Garg <sumit.garg@linaro.org>
> > + */
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/smp.h>
> > +
> > +#include <asm/nmi.h>
> > +
> > +static struct irq_desc *ipi_nmi_desc __read_mostly;
> > +static int ipi_nmi_id __read_mostly;
> > +
> > +bool arm64_supports_nmi(void)
> > +{
> > +     if (ipi_nmi_desc)
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> > +void arm64_send_nmi(cpumask_t *mask)
> > +{
> > +     if (WARN_ON_ONCE(!ipi_nmi_desc))
> > +             return;
> > +
> > +     __ipi_send_mask(ipi_nmi_desc, mask);
> > +}
> > +
> > +static irqreturn_t ipi_nmi_handler(int irq, void *data)
> > +{
> > +     /* nop, NMI handlers for special features can be added here. */
> > +
> > +     return IRQ_NONE;
> > +}
> > +
>
> > +void dynamic_ipi_setup(int cpu)
>
> cpu isn't used here, so void is better?
>
> void dynamic_ipi_setup(void)
>

Ack.

> > +{
> > +     if (!ipi_nmi_desc)
> > +             return;
> > +
> > +     if (!prepare_percpu_nmi(ipi_nmi_id))
> > +             enable_percpu_nmi(ipi_nmi_id, IRQ_TYPE_NONE);
> > +}
> > +
>
> > +void dynamic_ipi_teardown(int cpu)
>
> Same as here:
> void dynamic_ipi_teardown(void)
>

Ack.

> > +{
> > +     if (!ipi_nmi_desc)
> > +             return;
> > +
> > +     disable_percpu_nmi(ipi_nmi_id);
> > +     teardown_percpu_nmi(ipi_nmi_id);
> > +}
> > +
> > +void __init set_smp_dynamic_ipi(int ipi)
> > +{
> > +     if (!request_percpu_nmi(ipi, ipi_nmi_handler, "IPI", &cpu_number)) {
> > +             ipi_nmi_desc = irq_to_desc(ipi);
> > +             ipi_nmi_id = ipi;
> > +     }
> > +}
> > --
>
> Otherwise, looks good to me. Please feel free to add:
>
>         Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>

Thanks.

-Sumit

> Thanks,
> Masa
