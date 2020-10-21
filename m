Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18491294CF4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440777AbgJUMnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:43:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395096AbgJUMnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:43:08 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CCC622275
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 12:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603284187;
        bh=foR2I9na45RfgZ8XF/B0L81dQ5zjTMkWJtVbS1BEcgU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=euVMfjGbN8/O2abyZBt+61Fj15CVagY/4cKj1241p2psemlc7Rf4XQBGf1msjEBUS
         +1WgUTPIyZIbbx2yhsoPiD7/3GsmExuShl/ItZzlEzPV9PdbkZ9uXVgBOfxWGf9gUq
         bylt/oR5b+GP+hywkqEYcOrRbXbrOnhNgD2M1wX4=
Received: by mail-qk1-f170.google.com with SMTP id q199so1664884qke.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 05:43:07 -0700 (PDT)
X-Gm-Message-State: AOAM531olkDayO54cuqlOCPMr+K+QCTN1MVPBHehb4uFYuK8tMAfQY4b
        SuI3BSLUg/+shTiLuhDHfXQv5Qsqel5F8aK4Oh4=
X-Google-Smtp-Source: ABdhPJx/cRVrg4frjAeUuBkMoUIgt0Wc9bvsyGCFmJy+msozbo3Rbf5+jhmckqiEjyYjwFDM+hhvi1+nZfbr3seKxcE=
X-Received: by 2002:a37:2dc6:: with SMTP id t189mr2904370qkh.394.1603284184218;
 Wed, 21 Oct 2020 05:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20201008071639epcas5p465f13d992a25936ba63436baf1fb6f83@epcas5p4.samsung.com>
 <1602141333-17822-1-git-send-email-maninder1.s@samsung.com>
 <1602141333-17822-3-git-send-email-maninder1.s@samsung.com> <CAK8P3a2RYeNiTy9QmwFVKtFifXxWc9XfAT6ThPoSH9wGYsKGpA@mail.gmail.com>
In-Reply-To: <CAK8P3a2RYeNiTy9QmwFVKtFifXxWc9XfAT6ThPoSH9wGYsKGpA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 21 Oct 2020 14:42:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3eZjBVSuhv=Cx4aYC+E9tex+BbJH1b6YyMMief-mO7kQ@mail.gmail.com>
Message-ID: <CAK8P3a3eZjBVSuhv=Cx4aYC+E9tex+BbJH1b6YyMMief-mO7kQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm: introduce IRQ stacks
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jian Cai <caij2003@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Nathan Huckleberry <nhuck@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Will Deacon <will@kernel.org>, v.narang@samsung.com,
        a.sahrawat@samsung.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(also resending this reply from @kernel.org)

On Fri, Oct 16, 2020 at 12:19 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Oct 8, 2020 at 9:20 AM Maninder Singh <maninder1.s@samsung.com> wrote:
> >
> > This patch adds code for switching to IRQ stack.
> > IRQ stack and Kernel SVC stack have below design.
> >
> > IRQ STACK:-
> >                     ------------ IRQ stack top
> >                     |          |
> >                     ------------
> >                     .          .
> >                     .          .
> >                     .          .
> >                     ------------
> >                     |    sp    | <- irq_stack_base + 0x8
> >                     ------------
> >                     |    fp    | <- irq_stack_base + 0x4
> >                     ------------
> >                     |tinfo_ptr | /* pointer to thread info */
> > irq_stack_ptr -->   ------------ IRQ stack base
> >
> > Kernel SVC stack:-
> >                     ------------  Kernel stack top
> >                     |          |
> >                     ------------
> >                     .          .
> >                     .          .
> >                     .          .
> >                     ------------
> >                     |          |
> >                     |          |
> >                     ------------
> >                     |tinfo_ptr |  /* pointer to thread info */
> >                     ------------ Kernel stack base
>
> The extra indirection doesn't look great, and I don't see any of the
> other architectures need that. Since we can access percpu data
> without going through thread_info, maybe doing the same as
> x86 would work here:
>
> - define 'current' as 'this_cpu_read_stable(current_task);'
> - convert to CONFIG_THREAD_INFO_IN_TASK
>
>        Arnd
