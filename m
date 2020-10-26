Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB95299085
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783165AbgJZPG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:06:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56590 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1747645AbgJZPG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:06:57 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1kX45H-0004Ps-8I
        for linux-kernel@vger.kernel.org; Mon, 26 Oct 2020 15:06:55 +0000
Received: by mail-ej1-f71.google.com with SMTP id b19so5156447eju.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 08:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EnLWDCtLm8RMcdow/BSYVBH9rX7uMoRshyF3616LTAE=;
        b=gLYwcqgaFAUD/8U8GAd2v75QVcddcIyLmqHSW/ksUYFRW8V7s3uYkupVsB1AOT++AR
         fTKYBBtmbQ5W5uWHQc45vwaNEQNgU+13kt4Q5MIVWx7LXi+zSQ+UGOql+JG3x5lytmQ2
         Ryq62mG9Qf8VbRtcMkFESKJLwfHqoKpICCBfVMij4QPIKvIIueXmUXBwnKcERZlGwwXT
         Ex7DvL2SpbJwKkQzr8BXA3NtERd5oT3BTbcofcdJQs1m6uEswreyrRX1H7OIokA29PgN
         axJzaQryam20sQ1LBJ3/Io9DB16g2g18X4WY5iUKXMkUN0IMSTCVjtaov3TkeBQZ9U0S
         iCcg==
X-Gm-Message-State: AOAM530WP+Y5ru+mFNUS6ISYID85Ra6NOiO4V34K1kXGoiwYDbjT2Wm1
        auk9ZC0kFgSLiZ4sZa1zwNTY7IFCw0h55F1BSZh0qx7SgAzeh8RT0Vbx99mxfJLnJTQJbzSa8K8
        EtPi16D1CW8bn0gM1MHGDeeA5IQqsEdANEqT7NgmmH6f+jcmAUMqCWDFA1A==
X-Received: by 2002:a17:906:c7d9:: with SMTP id dc25mr16060255ejb.482.1603724814867;
        Mon, 26 Oct 2020 08:06:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy2+1nDxG6rQe5jCDR4OJ+uU4A2LI5vFUSrKkDIr9eqbArccXIMK+FWxloSfXRldQDtErReSz9wiiCYnUurTw=
X-Received: by 2002:a17:906:c7d9:: with SMTP id dc25mr16060111ejb.482.1603724813209;
 Mon, 26 Oct 2020 08:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
 <871rhq7j1h.fsf@nanos.tec.linutronix.de> <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com>
In-Reply-To: <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Mon, 26 Oct 2020 12:06:17 -0300
Message-ID: <CAHD1Q_x99XW1zDr5HpVR27F_ksHLkaxc2W83e-N6F_xLYKyGbQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] warn and suppress irqflood
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        Kexec Mailing List <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 25, 2020 at 8:12 AM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> On Thu, Oct 22, 2020 at 4:37 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Thu, Oct 22 2020 at 13:56, Pingfan Liu wrote:
> > > I hit a irqflood bug on powerpc platform, and two years ago, on a x86 platform.
> > > When the bug happens, the kernel is totally occupies by irq.  Currently, there
> > > may be nothing or just soft lockup warning showed in console. It is better
> > > to warn users with irq flood info.
> > >
> > > In the kdump case, the kernel can move on by suppressing the irq flood.
> >
> > You're curing the symptom not the cause and the cure is just magic and
> > can't work reliably.
> Yeah, it is magic. But at least, it is better to printk something and
> alarm users about what happens. With current code, it may show nothing
> when system hangs.

Thanks Pingfan and Thomas for the points - I'd like to have a
mechanism in the kernel to warn users when an IRQ flood is potentially
happening.
Some time ago (2 years) we faced a similar issue in x86-64, a hard to
debug problem in kdump, that eventually was narrowed to a buggy NIC FW
flooding IRQs in kdump kernel, and no messages showed (although kernel
changed a lot since that time, today we might have better IRQ
handling/warning). We tried an early-boot fix, by disabling MSIs (as
per PCI spec) early in x86 boot, but it wasn't accepted - Bjorn asked
pertinent questions that I couldn't respond (I lost the reproducer)
[0].

Cheers,


Guilherme

[0] lore.kernel.org/linux-pci/20181018183721.27467-1-gpiccoli@canonical.com
