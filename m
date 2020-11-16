Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB0B2B492D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbgKPP1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:27:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728433AbgKPP07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:26:59 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2021920715
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 15:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605540419;
        bh=TdjljZas82Klfz7KMfoEYcx1d5Hp8TQ19pIW82o2aHM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TjYsMFAe4P9WVhddB/LlDGoNYU7TVVocerNTK5R+6aoT3EFoY8TIYgvSzPYlvHaX6
         9nGpfAslyo3ORr+vIek5H8YpKCNPMtqC3gW5KwbSrX5Rl/T1J7E8yoaw4z/ZNqF6eW
         qE8qprT9DAsXV0jmu59SrwbUr6iU0NN00yQQRUz4=
Received: by mail-ot1-f53.google.com with SMTP id l36so16369560ota.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 07:26:59 -0800 (PST)
X-Gm-Message-State: AOAM5312eklyQfO4Vkbdy2CcNtzps9PwtOu6sW5W4VGods7XIYq3NKfj
        4PyVYS6R/WGthjGFOD0ETBN4lKaLBatDQWNUk60=
X-Google-Smtp-Source: ABdhPJwhet+SwyMBiqbppkcd3dYEsGU5RzrFvJ+5Sdf61XDp0fTatCkGAnQznKAjG8JLapZ+2A7OAk0LVxFMtUWdqno=
X-Received: by 2002:a9d:65d5:: with SMTP id z21mr10259369oth.251.1605540418384;
 Mon, 16 Nov 2020 07:26:58 -0800 (PST)
MIME-Version: 1.0
References: <20201026162022.3710091-1-arnd@kernel.org> <87h7ppz9ew.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87h7ppz9ew.fsf@nanos.tec.linutronix.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 16 Nov 2020 16:26:41 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2fprKoq3D-u4vV7RvqdpCL06ET2QWS9HJkLuOnNU5Ntg@mail.gmail.com>
Message-ID: <CAK8P3a2fprKoq3D-u4vV7RvqdpCL06ET2QWS9HJkLuOnNU5Ntg@mail.gmail.com>
Subject: Re: [PATCH] irqdomain: fix -Wshadow warning
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 3:03 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, Oct 26 2020 at 17:20, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > When building with W=2, there are tons of warnings about conflicting
> > local and global definitions of 'nr_irqs' in common header files:
> >
> > include/linux/irqdomain.h: In function 'irq_domain_alloc_irqs':
> > include/linux/irqdomain.h:482:17: warning: declaration of 'nr_irqs' shadows a global declaration [-Wshadow]
> >   482 |    unsigned int nr_irqs, int node, void *arg)
> >       |    ~~~~~~~~~~~~~^~~~~~~
> > In file included from ../include/linux/interrupt.h:10,
> >                  from ../include/linux/kernel_stat.h:9,
> >                  from ../include/linux/cgroup.h:26,
> >                  from ../include/linux/perf_event.h:57,
> >                  from ../include/linux/trace_events.h:10,
> >                  from ../include/trace/syscall.h:7,
> >                  from ../include/linux/syscalls.h:84,
> >                  from ../init/main.c:21:
> > include/linux/irqnr.h:8:12: note: shadowed declaration is here
> >     8 | extern int nr_irqs;
> >       |            ^~~~~~~
> >
> > Rename the local in irqdomain.h to shut up those warnings
>
> That's lame tinkering. There are gazillion of other functions which have
> the very same problem and nr_irqs is used all over the place for local
> variables.
>
> So instead of trying to chase all these places we really want to rename
> the global 'nr_irqs' variable.

Fair enough, yes.

> Something like the uncompiled below which is purely mechanical and does
> not even try to look at some of the places which use it for the very
> wrong reasons and purpose * Shudder *.

Looks good to me.

If we rename it, we might want to pick an even longer name to make
it stand out in code review when it does get used, and easier to
grep for.

I don't have my build testing infrastructure running at the moment,
once I get that back up, I can start testing your patch.

> --- a/arch/arm/kernel/irq.c
> +++ b/arch/arm/kernel/irq.c
> @@ -100,7 +100,7 @@ void __init init_IRQ(void)
>  #ifdef CONFIG_SPARSE_IRQ
>  int __init arch_probe_nr_irqs(void)
>  {
> -       nr_irqs = machine_desc->nr_irqs ? machine_desc->nr_irqs : NR_IRQS;
> -       return nr_irqs;
> +       max_nr_irqs = machine_desc->nr_irqs ? machine_desc->nr_irqs : NR_IRQS;
> +       return max_nr_irqs;
>  }
>  #endif

I think this one can just lose the assignment and return the value.

> --- a/arch/powerpc/platforms/cell/axon_msi.c
> +++ b/arch/powerpc/platforms/cell/axon_msi.c
> @@ -111,7 +111,7 @@ static void axon_msi_cascade(struct irq_
>                 pr_devel("axon_msi: woff %x roff %x msi %x\n",
>                           write_offset, msic->read_offset, msi);
>
> -               if (msi < nr_irqs && irq_get_chip_data(msi) == msic) {
> +               if (msi < max_nr_irqs && irq_get_chip_data(msi) == msic) {
>                         generic_handle_irq(msi);
>                         msic->fifo_virt[idx] = cpu_to_le32(0xffffffff);
>                 } else {

Most of the ones like this seem to have been simply converted from
old sanity checks using NR_IRQS and would work just as well without
the checks.

Actually removing the checks would have a small regression
potential.

> --- a/drivers/pcmcia/at91_cf.c
> +++ b/drivers/pcmcia/at91_cf.c

potential.

> @@ -312,7 +312,7 @@ static int at91_cf_probe(struct platform
>                         goto fail0a;
>                 cf->socket.pci_irq = gpio_to_irq(board->irq_pin);
>         } else
> -               cf->socket.pci_irq = nr_irqs + 1;
> +               cf->socket.pci_irq = max_nr_irqs + 1;
>
>         /*
>          * pcmcia layer only remaps "real" memory not iospace

This one would seem to actually warrant a bugfix, setting
the field to zero.

      Arnd
