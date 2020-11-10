Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411092AD7A3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbgKJNfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:35:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:48780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730097AbgKJNfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:35:36 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EB0720825
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605015335;
        bh=UdSLbo7EDDIsFl49OPtUX28MCUCIQOcedfBVOANR+0E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZHVnw8uwtjbaSJBRQmdI+w7yxo5rOJlCeEg1YgJ/X+NaIBeexlVTYyhJuOPwPRz5q
         dPLoAaencKIgEJV0FA38zl49gMR2o/cicZd+Rr+w+SkBCf7SODATM3X6dDVXXM7kju
         Ajr76tKHAhlRpIxls7XcEP+ExJ4HUoS5U9aK9mVk=
Received: by mail-ot1-f51.google.com with SMTP id k3so12459927otp.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:35:35 -0800 (PST)
X-Gm-Message-State: AOAM5334Y+qUF1VEQNKX0kIhbOfnEfy1/S+/j0jUoXcMAZVs9Ht9264x
        dvrtKzsxwGPCPGd3JNRQXpbTbwdRCDBZ8fYP22I=
X-Google-Smtp-Source: ABdhPJzrNzZjooAFpqKeVuxuB7hk2bHjyXqWaVV07LjZM++y42H2QXGO9GH+FlAwRKv5VU23fGqpasu68px2f/vJfZE=
X-Received: by 2002:a05:6830:22d2:: with SMTP id q18mr12737619otc.305.1605015334402;
 Tue, 10 Nov 2020 05:35:34 -0800 (PST)
MIME-Version: 1.0
References: <1602141333-17822-3-git-send-email-maninder1.s@samsung.com>
 <CAK8P3a2RYeNiTy9QmwFVKtFifXxWc9XfAT6ThPoSH9wGYsKGpA@mail.gmail.com>
 <CAK8P3a3eZjBVSuhv=Cx4aYC+E9tex+BbJH1b6YyMMief-mO7kQ@mail.gmail.com>
 <20201021124542.GL1551@shell.armlinux.org.uk> <20201021125740.GM1551@shell.armlinux.org.uk>
 <CAK8P3a3s9JJpeBpH38utw9aA1VaEkcBqKEGtwcmoP1zS6xDj5Q@mail.gmail.com>
 <20201109144549.GA26857@atomide.com> <CAK8P3a2tM1Gzy7Y98tiYGoNcLye77je_UCtTUQYcP2UuRNRKwQ@mail.gmail.com>
 <20201110091904.GC26857@atomide.com> <CAK8P3a3dZMnEV-Sg_ep6_dQ3XEf73fEpCF0T03255KxMrJZH8g@mail.gmail.com>
 <20201110120422.GE26857@atomide.com>
In-Reply-To: <20201110120422.GE26857@atomide.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 10 Nov 2020 14:35:17 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2Hh=-VtvCiztNDZvW=ssx5zbvbccYcLXSNUt=xF6mwwQ@mail.gmail.com>
Message-ID: <CAK8P3a2Hh=-VtvCiztNDZvW=ssx5zbvbccYcLXSNUt=xF6mwwQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm: introduce IRQ stacks
To:     Tony Lindgren <tony@atomide.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        v.narang@samsung.com, a.sahrawat@samsung.com,
        Marc Zyngier <maz@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nathan Huckleberry <nhuck@google.com>,
        Jian Cai <caij2003@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 1:06 PM Tony Lindgren <tony@atomide.com> wrote:

> > Are these actually ARMv6? Most ARM11 cores you'd come across
> > in practice are ARMv6K (ARM1136r1, ARM1167, ARM11MPCore),
> > in particular every SoC that has any mainline support except for
> > the ARM1136r0 based OMAP2 and i.MX3.
>
> I've been only using smp_on_up for the ARMv6 ARM1136r0 variants
> for omap2, no SMP on those.

Obviously all SMP hardware is ARMv6K, the only question I raised
in point "c)" is what we would lose by making ARMv6 (ARM1136r0)
support and SMP mutually exclusive in a kernel configuration, and
I suppose the answer remains "testing".

      Arnd
