Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B607D299795
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 21:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbgJZUCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 16:02:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42126 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgJZT77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:59:59 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603742396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HcxD8cvr4m2E7nYWZH8VSGjteDBWyZgfwDuVWY+FQfs=;
        b=FhY2z9T0i3dCMMBAUbn25V/hUkj6A2GJELIQz4b1whSe/gRIHyRWJWaWRwZKnFMS5vMF1c
        sfGykHoEtzl5Mr9FqP2oqxOX8Q0u1zTMoX1f+yXojEDO7ztcMm2V33RGl3WRm4Bk5cTkdB
        1/TbDGOsbuOy0gYfQZEbZy0vBmgV/6TLKZopFK+ErcTD22jv5HPc4BxSkZYFDEKFcCgdHp
        Xe3aLtpRQIXtDg5/BgyqPtQ4Zv7ueKykRETRQPbe4adhTjbTT1aQRXxcVZGuZdB6AC0c+H
        aUHcu0BO7X95SqOKOuFoFBbJlFwQh/qAuUt6ayIL4+XxnTgKLCe+I32Pp4DtVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603742396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HcxD8cvr4m2E7nYWZH8VSGjteDBWyZgfwDuVWY+FQfs=;
        b=ThqFstrtyu1YATdBCd9nTnN0iyqg0KDpfrKuqOH/t6oREHRn1zpWAQPHKNEZ7CAvGKa1PA
        eGHhbxhG4rukR7AA==
To:     Guilherme Piccoli <gpiccoli@canonical.com>,
        Pingfan Liu <kernelfans@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Lina Iyer <ilina@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Maulik Shah <mkshah@codeaurora.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oliver Neukum <oneukum@suse.com>, linux-doc@vger.kernel.org,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 0/3] warn and suppress irqflood
In-Reply-To: <CAHD1Q_x99XW1zDr5HpVR27F_ksHLkaxc2W83e-N6F_xLYKyGbQ@mail.gmail.com>
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com> <871rhq7j1h.fsf@nanos.tec.linutronix.de> <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com> <CAHD1Q_x99XW1zDr5HpVR27F_ksHLkaxc2W83e-N6F_xLYKyGbQ@mail.gmail.com>
Date:   Mon, 26 Oct 2020 20:59:56 +0100
Message-ID: <87y2js3ghv.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26 2020 at 12:06, Guilherme Piccoli wrote:
> On Sun, Oct 25, 2020 at 8:12 AM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> Some time ago (2 years) we faced a similar issue in x86-64, a hard to
> debug problem in kdump, that eventually was narrowed to a buggy NIC FW
> flooding IRQs in kdump kernel, and no messages showed (although kernel
> changed a lot since that time, today we might have better IRQ
> handling/warning). We tried an early-boot fix, by disabling MSIs (as
> per PCI spec) early in x86 boot, but it wasn't accepted - Bjorn asked
> pertinent questions that I couldn't respond (I lost the reproducer)
> [0].
...
> [0] lore.kernel.org/linux-pci/20181018183721.27467-1-gpiccoli@canonical.com

With that broken firmware the NIC continued to send MSI messages to the
vector/CPU which was assigned to it before the crash. But the crash
kernel has no interrupt descriptor for this vector installed. So Liu's
patches wont print anything simply because the interrupt core cannot
detect it.

To answer Bjorns still open question about when the point X is:

  https://lore.kernel.org/linux-pci/20181023170343.GA4587@bhelgaas-glaptop.roam.corp.google.com/

It gets flooded right at the point where the crash kernel enables
interrupts in start_kernel(). At that point there is no device driver
and no interupt requested. All you can see on the console for this is

 "common_interrupt: $VECTOR.$CPU No irq handler for vector"

And contrary to Liu's patches which try to disable a requested interrupt
if too many of them arrive, the kernel cannot do anything because there
is nothing to disable in your case. That's why you needed to do the MSI
disable magic in the early PCI quirks which run before interrupts get
enabled.

Also Liu's patch only works if:

  1) CONFIG_IRQ_TIME_ACCOUNTING is enabled

  2) the runaway interrupt has been requested by the relevant driver in
     the dump kernel.

Especially #1 is not a sensible restriction.

Thanks,

        tglx


