Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD3829504D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444320AbgJUQAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2444313AbgJUQAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:00:07 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 172202225F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 16:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603296006;
        bh=QoW86WhFQn8bUmhAjXtoqolAxbKLRswZa59WiwSGldo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j/l41rnNU22CF8GwbzOOeLOd/CyxWz9S6ZQhXJFsUlClt/j/QzNYrT4UcJgRIqMxJ
         fBpjgWyoTF/vnbrmmBS9Pl+lZKkVmkapAgwYtot4WVI1jPYcaFRWqyEU7HIrg4FslT
         kvitJ66u3e3joasdU4eEHgerixiH9oBoM14dRdtc=
Received: by mail-qv1-f49.google.com with SMTP id bl9so1346706qvb.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:00:06 -0700 (PDT)
X-Gm-Message-State: AOAM531eDZIpoJT7gAqyPXs+8/aMHRn4m4ZLMeciCfCaqZiJJJ4hB7ow
        Ae03lgs3o+PfQCo/8v03JylfOGq7BdMlwPV5mbA=
X-Google-Smtp-Source: ABdhPJyrcP2RxvXJZwS1rb6oe2/md7i5qoS4Dmvrwv7o/Fo8jHHIPWbwxWc5p3uNKu4NRpm+Inh9WVCV6cxQDpQga8M=
X-Received: by 2002:a0c:f447:: with SMTP id h7mr2307199qvm.7.1603296005031;
 Wed, 21 Oct 2020 09:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20201008071639epcas5p465f13d992a25936ba63436baf1fb6f83@epcas5p4.samsung.com>
 <1602141333-17822-1-git-send-email-maninder1.s@samsung.com>
 <1602141333-17822-3-git-send-email-maninder1.s@samsung.com>
 <CAK8P3a2RYeNiTy9QmwFVKtFifXxWc9XfAT6ThPoSH9wGYsKGpA@mail.gmail.com>
 <CAK8P3a3eZjBVSuhv=Cx4aYC+E9tex+BbJH1b6YyMMief-mO7kQ@mail.gmail.com>
 <20201021124542.GL1551@shell.armlinux.org.uk> <20201021125740.GM1551@shell.armlinux.org.uk>
In-Reply-To: <20201021125740.GM1551@shell.armlinux.org.uk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 21 Oct 2020 17:59:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3s9JJpeBpH38utw9aA1VaEkcBqKEGtwcmoP1zS6xDj5Q@mail.gmail.com>
Message-ID: <CAK8P3a3s9JJpeBpH38utw9aA1VaEkcBqKEGtwcmoP1zS6xDj5Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm: introduce IRQ stacks
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@kernel.org>, v.narang@samsung.com,
        a.sahrawat@samsung.com, Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Huckleberry <nhuck@google.com>,
        Will Deacon <will@kernel.org>, Jian Cai <caij2003@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 2:57 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
> On Wed, Oct 21, 2020 at 01:45:42PM +0100, Russell King - ARM Linux admin wrote:
> > > > - define 'current' as 'this_cpu_read_stable(current_task);'
> > > > - convert to CONFIG_THREAD_INFO_IN_TASK
> >
> > That means we need to also code that up in assembly - remember, we
> > need to access thread_info from assembly code.
>
> Note also that there is a circular dependency involved. If you make
> thread_info accessible via per-cpu, then:
>
> #ifndef __my_cpu_offset
> #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
> #endif
> #ifdef CONFIG_DEBUG_PREEMPT
> #define my_cpu_offset per_cpu_offset(smp_processor_id())
> #else
> #define my_cpu_offset __my_cpu_offset
> #endif

Right, I had missed the fallback path using asm-generic/percpu.h
that is used with CONFIG_SMP && CONFIG_CPU_V6
Almost everything either uses fixed percpu data (on UP builds)
or TPIDRPRW when building a v7-only or v6k/v7 kernel without
v6 support.

> smp_processor_id() ultimately ends up as raw_smp_processor_id() which
> is:
>
> #define raw_smp_processor_id() (current_thread_info()->cpu)
>
> and if current_thread_info() itself involves reading from per-cpu data,
> we end up recursing... infinitely.
>
> This is why I said in the other thread:
>
> "We don't do it because we don't have a separate register to be able
> to store the thread_info pointer, and copying that lump between the
> SVC and IRQ stack will add massively to IRQ latency, especially for
> older machines."

As discussed on IRC, I think it can still be done in one of these
ways, though admittedly none of them are perfect:

a) add runtime patching for __my_cpu_offset() when
  CONFIG_SMP_ON_UP is set. This adds complexity but avoids the
  fallback for for SMP&&CPU_V6. It possibly also speeds up
  running on single-cpu systems if the TPIDRPRW access adds
  any measurable runtime overhead compared to patching it out.

b) If irq stacks are left as a compile-time option, that could be
  made conditional on "!(SMP&&CPU_V6)". Presumably very
  few people still run kernels built that way any more. The only
  supported platforms are i.MX3, OMAP2 and Realview-eb, all of
  which are fairly uncommon these days and would usually
  run v6-only non-SMP kernels.

c) If we decide that we no longer care about that configuration
  at all, we could decide to just make SMP depend on !CPU_V6,
  and possibly kill off the entire SMP_ON_UP patching logic.
  I suspect we still want to keep SMP_ON_UP for performance
  reasons, but I don't know how significant they are to start with.

       Arnd
