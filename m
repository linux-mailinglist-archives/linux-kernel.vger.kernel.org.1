Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AC129AC17
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750978AbgJ0MaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:30:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57837 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505200AbgJ0MaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:30:08 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1kXO6C-00009u-1j
        for linux-kernel@vger.kernel.org; Tue, 27 Oct 2020 12:29:12 +0000
Received: by mail-ed1-f72.google.com with SMTP id j6so625357edh.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 05:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cTgjDePmf/qhP9yTlxEchVjAXLV59jrPV/VUxzJG83E=;
        b=RG+MQyHLAGNYRJ+uKaHmf/uEDgATPd/5n0HVzDSczQ82J1DPU0UBpmmElCie+6muYo
         CnUCCQYfXlvpizfC1NViFKnjfq8X+iPk5sjyUIWeCKEdbMAcLDyJICeb8JzPQFhdBSnN
         NVfatE4Icq7OzhpKAOIGuco+NEWcz0d330+YSg1C3XNYi90JyEksrL3KebS3fWfUGg+G
         5CUsOOeZ8G6sBNedNEkWkkhrdcFhpXMLXGBchcvW+06CcSmyvC/SvJ19eejOCQkMHSG3
         xpBZtG/2oJUWCRFFCKAH6dd5xFM9rTU/cBVBf4LtwHt1UlrC5o3RH/6e6BCmFhNpVMjt
         +m4A==
X-Gm-Message-State: AOAM531hvRGKap/LicO3KYLFOvKcQ/k7ZOwyfobIzGQRdmJADmffP7g9
        f5zQKw23y+3JDTCmmhc4qlSma21Q5BPHoGU0ZPO2p+JGgW+fwSc5CFYmKevZS1Enc1UlNAcV1XF
        UwYb6u347sbFc5gwL2p/Mum01XhWJN8oXnRCrBRhMNlI+mrDJFBYwo5O4Rg==
X-Received: by 2002:a50:9e87:: with SMTP id a7mr1981540edf.297.1603801751400;
        Tue, 27 Oct 2020 05:29:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/pzTCu7BD0cDL2tKkBWCEtjogacacAFo+K72z4fQQrd+XvzL97es2P0sE1mbTDypGKGkghTxouH9se1bgFxM=
X-Received: by 2002:a50:9e87:: with SMTP id a7mr1981519edf.297.1603801751118;
 Tue, 27 Oct 2020 05:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
 <871rhq7j1h.fsf@nanos.tec.linutronix.de> <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com>
 <CAHD1Q_x99XW1zDr5HpVR27F_ksHLkaxc2W83e-N6F_xLYKyGbQ@mail.gmail.com>
 <87y2js3ghv.fsf@nanos.tec.linutronix.de> <CAHD1Q_yvb43P+b6PUzK4a1jU+RH3Shv2=4bO69nh5VDWXgv-ww@mail.gmail.com>
 <87o8ko3cpr.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87o8ko3cpr.fsf@nanos.tec.linutronix.de>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Tue, 27 Oct 2020 09:28:35 -0300
Message-ID: <CAHD1Q_z1UZR-iAN=FWY3wsc2nKFWN1yxQ15U0jE0_2cGuGGSRQ@mail.gmail.com>
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

On Mon, Oct 26, 2020 at 6:21 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> [...]
> > So, I don't want to hijack Liu's thread, but do you think it makes
> > sense to have my approach as a (debug) parameter to prevent such a
> > degenerate case?
>
> At least it makes sense to some extent even if it's incomplete. What
> bothers me is that it'd be x86 specific while the issue is pretty much
> architecture independent. I don't think that the APIC is special in that
> regard. Rogue MSIs should be able to bring down pretty much all
> architectures.
>

Thanks Thomas! I partially agree with you, I can speak only for x86
and powerpc. In x86 we know that happens, OK. But in powerpc, we had a
special PCI reset, we called it IIRC "fundamental"/PHB reset - that
procedure would put the PCI devices in good shape, it was something
that the kernel could request from FW - see [0] for an example. It was
present in all incarnations of powerpc (bare-metal, powerVM/PHyp - a
virtual thing) except maybe in qemu (although it'd be possible to do
that, since the PCI devices are attached on host and passthrough'ed
via vfio).

Anyway, in powerpc the PCI devices are really reset across
"soft-reboots" be it kexec or what was called a fast reboot (that
skipped some FW initializations), effectively disabling MSIs - x86 has
no such default/vendor-agnostic reset infrastructure, BIOSes usually
do some kind of PCI reset but with no interface for the kernel to
request that in kexec, for example. That said, the option was to use
the arch code to early-clear the MSI state in all devices, that being
a kind of reset. And it's "supported" by the spec, that claims MSIs
should be clear before devices' initialization =)

Anyway, I'm glad to discuss more, and I'm even more glad that you
consider the approach useful. We could revive that if Bjorn agrees, I
could respin an updated version. ARM64/RISC-V or whatever other
architectures I can't say about, but I think if they have early-PCI
handlers (and !FW reset, like powerpc) it would be possible to
implement that in a more complete way.


> > Or could we have something in core IRQ code to prevent irq flooding in
> > such scenarios, something "stronger" than disabling MSIs (APIC-level,
> > likely)?
>
> For your case? No. The APIC cannot be protected against rogue MSIs. The
> only cure is to disable interrupts or disable MSIs on all PCI[E] devices
> early on. Disabling interrupts is not so much of an option obviously :)

Great to know that, we imagined if it would be possible to have a more
"soft" option, but it seems clearing MSIs is the way to go.
Cheers,


Guilherme

[0] kernel portion:
git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/platforms/powernv/pci-ioda.c#n3161
FW portion: github.com/open-power/skiboot/blob/master/core/pci-opal.c#L545
