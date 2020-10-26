Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4182997F0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 21:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgJZU3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 16:29:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37067 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgJZU3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 16:29:18 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1kX97D-0003tT-VL
        for linux-kernel@vger.kernel.org; Mon, 26 Oct 2020 20:29:16 +0000
Received: by mail-ed1-f69.google.com with SMTP id be19so5468519edb.22
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 13:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pBEYO4XpwYRaYgTmmtMnIBKfcuzOYxJIxnd6Dc7SwVo=;
        b=ZUl6J9E5Zp59A0x6UUADrfkARzqn30flbuqRNTcm0yiYVynEcIbd0erq+viF2hCsMp
         sicpm4ZMaseE9USO0+1PieWiK/3WKq4o0F7ikchRaGdGjILvB4qtXOEJHIBHXNcIGp1R
         hjWS9PXMPdRtoYWW3zTkXE+T1hHO30fQMVLSj7Bw5V7Q91ZjjRCENZDowWbFjfbfudWQ
         6CYb7ZolwS1KQnW374OnIPJggeo3c29z035kNKEDZnseocvCKsBPHNTTVZ3Z6KTSqxI8
         xJkUpkm7xu9qjjgNIj2kqaixXyjd6iVcg82+v2sPd934r8qmkXxNerKi1Pbi2LOkXoNM
         F93A==
X-Gm-Message-State: AOAM530YOU7XlES1l4qIPrfHmWCL8LPeV6wEZCekSTn/Q5m1UhKvFYU9
        YS84qx9udL2LhsDbZPurz7TQMD5PcWX2GAxBFoU6OhxO+tiJvqzvaHb73o49H8Q9Ps0XKgF8tL+
        ZjIZZTvaZmNKEhJ0TJvN9fDXfaJXs22iahHN2mzrlpiGUtiHt0oMBiYbSBw==
X-Received: by 2002:a17:906:72cd:: with SMTP id m13mr18246235ejl.387.1603744153160;
        Mon, 26 Oct 2020 13:29:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdSiJoWemUST4jJlevJDxhbD24GUf2WsP6pUei9p5YDGRPprwvS5OD5sx9fFb0y0Geb5r1UOtnZM/V2qblhL4=
X-Received: by 2002:a17:906:72cd:: with SMTP id m13mr18246030ejl.387.1603744149971;
 Mon, 26 Oct 2020 13:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
 <871rhq7j1h.fsf@nanos.tec.linutronix.de> <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com>
 <CAHD1Q_x99XW1zDr5HpVR27F_ksHLkaxc2W83e-N6F_xLYKyGbQ@mail.gmail.com> <87y2js3ghv.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87y2js3ghv.fsf@nanos.tec.linutronix.de>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Mon, 26 Oct 2020 17:28:33 -0300
Message-ID: <CAHD1Q_yvb43P+b6PUzK4a1jU+RH3Shv2=4bO69nh5VDWXgv-ww@mail.gmail.com>
Subject: Re: [PATCH 0/3] warn and suppress irqflood
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 4:59 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, Oct 26 2020 at 12:06, Guilherme Piccoli wrote:
> > On Sun, Oct 25, 2020 at 8:12 AM Pingfan Liu <kernelfans@gmail.com> wrote:
> >
> > Some time ago (2 years) we faced a similar issue in x86-64, a hard to
> > debug problem in kdump, that eventually was narrowed to a buggy NIC FW
> > flooding IRQs in kdump kernel, and no messages showed (although kernel
> > changed a lot since that time, today we might have better IRQ
> > handling/warning). We tried an early-boot fix, by disabling MSIs (as
> > per PCI spec) early in x86 boot, but it wasn't accepted - Bjorn asked
> > pertinent questions that I couldn't respond (I lost the reproducer)
> > [0].
> ...
> > [0] lore.kernel.org/linux-pci/20181018183721.27467-1-gpiccoli@canonical.com
>
> With that broken firmware the NIC continued to send MSI messages to the
> vector/CPU which was assigned to it before the crash. But the crash
> kernel has no interrupt descriptor for this vector installed. So Liu's
> patches wont print anything simply because the interrupt core cannot
> detect it.
>
> To answer Bjorns still open question about when the point X is:
>
>   https://lore.kernel.org/linux-pci/20181023170343.GA4587@bhelgaas-glaptop.roam.corp.google.com/
>
> It gets flooded right at the point where the crash kernel enables
> interrupts in start_kernel(). At that point there is no device driver
> and no interupt requested. All you can see on the console for this is
>
>  "common_interrupt: $VECTOR.$CPU No irq handler for vector"
>
> And contrary to Liu's patches which try to disable a requested interrupt
> if too many of them arrive, the kernel cannot do anything because there
> is nothing to disable in your case. That's why you needed to do the MSI
> disable magic in the early PCI quirks which run before interrupts get
> enabled.
>
> Also Liu's patch only works if:
>
>   1) CONFIG_IRQ_TIME_ACCOUNTING is enabled
>
>   2) the runaway interrupt has been requested by the relevant driver in
>      the dump kernel.
>
> Especially #1 is not a sensible restriction.
>
> Thanks,
>
>         tglx

Wow, thank you very much for this great explanation (without a
reproducer) - it's nice to hear somebody that deeply understands the
code! And double thanks for CCing Bjorn.

So, I don't want to hijack Liu's thread, but do you think it makes
sense to have my approach as a (debug) parameter to prevent such a
degenerate case? Or could we have something in core IRQ code to
prevent irq flooding in such scenarios, something "stronger" than
disabling MSIs (APIC-level, likely)?

Cheers,


Guilherme
