Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AF728B47D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388417AbgJLMTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388209AbgJLMTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:19:24 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3ABC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 05:19:24 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b1so14782074lfp.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 05:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hz9+UR8vgWlEErBmlAks6gwBc4rojM0m/9wND5ml4Pg=;
        b=Zk/N3bevPcHY95+DG8fWGjXgh1wRF/zeFkgCONGKHBNvd7ietWrSYV2JKRkGBtUmMw
         51CrCf6+HZo7rASqOASaGwDPpd1kzfDVin6DCbxhHVRO+JUmegHgflpViH5LRNYtR5+w
         fFJ09AImL7q+YsmxQS59buiXFw7dp5hG6WR9JAXzhMKXXendeBs2+voPppL1s3d+ydaq
         Xd2DT83eepfpJHwS1SL1ipYyLjA3FM0/4JwMHbkff50ZzCzMv3jLkTpypvP7iJ5t6pwi
         3RhwTY6s253WbEOgGllIpl+FtHNlzh4AOdZTz9Eho63pE+2fEu7aCLpkhdCoxuWrVJt2
         lLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hz9+UR8vgWlEErBmlAks6gwBc4rojM0m/9wND5ml4Pg=;
        b=FvHIF/Zhkj8+wSEOmijMyxmP9SqPn9n2b9eKhUK0x2zYRjklTFNHbfwdSD72eNLbl3
         zf77w4e1WrHD7wHaa4jit/xPG/F92jlWtDJEJ9pz3RmQYr46nMomX+XxPKRLuoaAxbL/
         6f7Z17LfOmw+TRg/8etCcGLKdXLyQuB6XuhcXpk2pVngf2ffoJ0hdO5QD20yaCiFy8uL
         PEkQYLHRp+B92V2okptjS+5VungPam/gndhiJuTiy55X4n1C+yJceg9giPkysS5y3rQY
         ldeA4aRT5moM5whj8Xbi8RD6o6f9GVmJXGTg3p48KEfxKKKpod2By8+ptqgjfsPSMGrs
         2tRw==
X-Gm-Message-State: AOAM533XOGwVYrni/s/Jdckd768qeiJZfURX2LJGz2wJFnUzR4koLZe2
        EqZDIf+3netghjQEF17SNKU+pQV0mvBTf5QIHWhJEw==
X-Google-Smtp-Source: ABdhPJyd8IVmtPN6WxlmD3goe4qadYT73jlhbM3RYsE5ppkYNOi1GGukFXDDoXi88fsIfBkcuj4tPGFJu6XoFvhuKBQ=
X-Received: by 2002:ac2:5588:: with SMTP id v8mr3577970lfg.435.1602505161755;
 Mon, 12 Oct 2020 05:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <1599830924-13990-1-git-send-email-sumit.garg@linaro.org>
 <1599830924-13990-2-git-send-email-sumit.garg@linaro.org> <20201010015855.vksetnj4luft5enc@gabell>
 <877drypgqb.wl-maz@kernel.org> <20201010151307.vq74if4mndjn4nhm@gabell>
In-Reply-To: <20201010151307.vq74if4mndjn4nhm@gabell>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 12 Oct 2020 17:49:09 +0530
Message-ID: <CAFA6WYOHs+yYvdR-6eQR3ZJPK8nF3sN0fbd8XsQ8pwGL63cdCQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] arm64: Add framework to turn IPI as NMI
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        kgdb-bugreport@lists.sourceforge.net,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        julien.thierry.kdev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masa,

On Sat, 10 Oct 2020 at 20:43, Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
>
> On Sat, Oct 10, 2020 at 10:34:04AM +0100, Marc Zyngier wrote:
> > On Sat, 10 Oct 2020 02:58:55 +0100,
> > Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
> >
> > [...]
> >
> > > > +void ipi_nmi_setup(int cpu)
> > > > +{
> > > > + if (!ipi_desc)
> > > > +         return;
> > >
> > > ipi_nmi_setup() may be called twice for CPU0:
> > >
> > >   set_smp_ipi_range => set_smp_ipi_nmi => ipi_nmi_setup
> > >                     => ipi_setup => ipi_nmi_setup
> > >
> > > Actually, I got the following error message via the second ipi_nmi_setup():
> > >
> > >   GICv3: Pseudo-NMIs enabled using relaxed ICC_PMR_EL1 synchronisation
> > >   GICv3: Cannot set NMI property of enabled IRQ 8
> > >   genirq: Failed to setup NMI delivery: irq 8
> > >

Ah, thanks for catching this which I missed during my testing.

> > > Why don't we have a check to prevent that? Like as:
> > >
> > >        if (cpumask_test_cpu(cpu, ipi_desc->percpu_enabled))
> > >                return;
> >
> > That's definitely the wrong thing to do. prepare_nmi_setup() shouldn't
> > be called twice, and papering over it isn't acceptable.
>
> Got it. How about moving ipi_nmi_setup() from ipi_setup() to
> secondary_start_kernel() ? so that CPU0 can call ipi_nmi_setup() only
> from set_smp_ipi_nmi().
>
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -245,6 +245,7 @@ asmlinkage notrace void secondary_start_kernel(void)
>         notify_cpu_starting(cpu);
>
>         ipi_setup(cpu);
> +       ipi_nmi_setup(cpu);
>
>         store_cpu_topology(cpu);
>         numa_add_cpu(cpu);
> @@ -966,8 +967,6 @@ static void ipi_setup(int cpu)
>
>         for (i = 0; i < nr_ipi; i++)
>                 enable_percpu_irq(ipi_irq_base + i, 0);
> -
> -       ipi_nmi_setup(cpu);
>  }
>
>  #ifdef CONFIG_HOTPLUG_CPU
>

IMO, it would be more consistent to keep invocation of ipi_nmi_setup()
from ipi_setup(). So let me remove other invocation from
set_smp_ipi_nmi():

diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
index d3aa430..000e457 100644
--- a/arch/arm64/kernel/ipi_nmi.c
+++ b/arch/arm64/kernel/ipi_nmi.c
@@ -87,7 +87,4 @@ void __init set_smp_ipi_nmi(int ipi)
        ipi_desc = irq_to_desc(ipi);
        irq_set_status_flags(ipi, IRQ_HIDDEN);
        ipi_id = ipi;
-
-       /* Setup the boot CPU immediately */
-       ipi_nmi_setup(smp_processor_id());
 }

Do let me know if this works for you?

-Sumit

> Thanks,
> Masa
