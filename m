Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5272D989E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407824AbgLNNQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 08:16:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:58090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgLNNQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:16:25 -0500
X-Gm-Message-State: AOAM533fCbREzfACd5I8f9vC+VzXkpKUf+lyBnytQC5DYAWnIkSX8bXr
        c/jTzWTq8o2itWwPlxn7HDUrOwRRjLbXDiDoy+U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607951744;
        bh=X7NfmqFfeZxN9ZZWHM4FSxFJ7dLG2FO+7mXQYFgN0xU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h5s4ri4H+20pEzRL3JhNoK9BP5C5LvZrlFo6iMhvJJoXYW7SEnmswysV/x0rOiAD2
         Nyfi1Bq00QJwXDFq1V+ssj58s0FQUYJ0bB3OjIfDztXfPSWYcdZUm47qV2nomjvfSz
         Fv+Mzs7bZ7EFBan544VLAzSqiGBlFOeW1sUgoQmemAG54yuKsB/p7RwjSQuAeQLjoG
         H+hqygPcQbm2wiA3k1izV81QSlgncvHIAXNmXnOr23+4r+Wq/QfT5CUhxIC7AN9Fkd
         3zVCJQ9yjgfwUPL33PA0lCerbagulkYGapUrVVkO0f7f6C8V1yddnI6EP/bxM/u3u+
         C6LfeRDQ1IpWQ==
X-Google-Smtp-Source: ABdhPJwneBXIbGc4q2UDyJgiJ3+uJZH1pPDANBY87SMMfQGTFfmv+G+j1p8TNNjg6eMN42mNCUMwLX+OWlLV2W508rA=
X-Received: by 2002:a05:6830:2413:: with SMTP id j19mr10871981ots.251.1607951742989;
 Mon, 14 Dec 2020 05:15:42 -0800 (PST)
MIME-Version: 1.0
References: <20190307091514.2489338-1-arnd@arndb.de> <X9S28TcEXd2zghzp@elver.google.com>
 <87czzeg5ep.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87czzeg5ep.fsf@nanos.tec.linutronix.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 14 Dec 2020 14:15:26 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0LWjNgwm605TM4dKCsn078X7NC3sEfdBSgcMNEocQ5iA@mail.gmail.com>
Message-ID: <CAK8P3a0LWjNgwm605TM4dKCsn078X7NC3sEfdBSgcMNEocQ5iA@mail.gmail.com>
Subject: Re: [PATCH 1/2] futex: mark futex_detect_cmpxchg() as 'noinline'
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
        sparclinux <sparclinux@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 12, 2020 at 9:01 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sat, Dec 12 2020 at 13:26, Marco Elver wrote:
> > On Thu, Mar 07, 2019 at 10:14AM +0100, Arnd Bergmann wrote:
> >> -static void __init futex_detect_cmpxchg(void)
> >> +static noinline void futex_detect_cmpxchg(void)
> >>  {
> >>  #ifndef CONFIG_HAVE_FUTEX_CMPXCHG
> >>      u32 curval;
> >
> > What ever happened to this patch?
>
> It obviously fell through the cracks.
>
> > I'm seeing this again with the attached config + next-20201211 (for
> > testing https://bugs.llvm.org/show_bug.cgi?id=48492). Had to apply this
> > patch to build the kernel.
>
> What really bothers me is to remove the __init from a function which is
> clearly only used during init. And looking deeper it's simply a hack.
>
> This function is only needed when an architecture has to runtime
> discover whether the CPU supports it or not. ARM has unconditional
> support for this, so the obvious thing to do is the below.
>

Ah perfect, that is clearly the right solution here.

> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -86,6 +86,7 @@ config ARM
>         select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>         select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
>         select HAVE_FUNCTION_TRACER if !XIP_KERNEL
> +       select HAVE_FUTEX_CMPXCHG if FUTEX
>         select HAVE_GCC_PLUGINS
>         select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
>         select HAVE_IDE if PCI || ISA || PCMCIA

I had a look at what other architectures always implement
futex_atomic_cmpxchg_inatomic() or can use the asm-generic non-SMP version,
and I found that it's pretty much all of them, the odd ones being just sparc32
and csky, which use asm-generic/futex.h but do have an SMP option,
as well as xtensa

I would guess that for csky, this is a mistake, as the architecture is fairly
new and should be able to implement it. Not sure about sparc32.

       Arnd
