Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826CC2D467E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 17:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbgLIQMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 11:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731095AbgLIQLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 11:11:55 -0500
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25BCC061793
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 08:11:14 -0800 (PST)
Received: by mail-ua1-x944.google.com with SMTP id 4so657740uap.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 08:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RAzf84xm2mgxYvHDSz3COzuojd6IcnSxMMVRpqKMx58=;
        b=gIACvSNIaNgfk8yYU6S+oPUv61DEJWlMah84jEakzPWNcyXSQgGfZRUQCmTA2z2H68
         OBzeyFblbpXMDN4KMc97LtU39WqbsHFa8AfAomXUSKTieYHPNM7GEZ6ZC1XAJfkKWHDD
         N/rGmO7I1HBChFKlMvhDUHT+DD0u7soRUGjQ6XTsXx6XX9hNVWvtKbx0EmKVXSx0x63q
         uSx0K2QC6qZIjcT/Vy+GTkse17WcJ35wK97vuG6odXGIYTCqk24f8kQwlYGGa1smU8sB
         zozuG5IW1kXDMdiObqppDeT7967KYlhg+uX66AupNL004gGWmHXS7ElwVjsdgyVqwHeF
         qKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RAzf84xm2mgxYvHDSz3COzuojd6IcnSxMMVRpqKMx58=;
        b=fAXnMALUhi8hxF24ZP0gvT7ikL6GyaIj0EGb3TQ29pT7efda4q8YR2N57kCr/nV+Xa
         Ri9MZH1jO2mWyUiXjxO7YYeHVYXt+cLWFlElEMJ6knenyRtGpxf+N2Wsw9KYAn38vrlS
         /0xKjnYYq6ApDpOVcxD//vwIzTflrCX+N0mOQkQJ/hw4mHgCCd26i+mTJXzGFzLjYS8A
         CPf19OOXTLBu1YOrUi5deZhpLESoaKzPgKk4YgJ2k58ZIUz8fc0pSTs62OJAFIOSi6bw
         hD8Xi7BNCQ4kPWYt2mbZDAtEMdhuLZ/oVIfIfnPTSWWxdu8Jia92ryI9rY/+irgxJIVw
         3cxg==
X-Gm-Message-State: AOAM530so+ifgvdgZqWFlM5BMIv/KohWR/qghkBXbWli8T6UOvK/i9gd
        7uoQpe6gM3MvltQ29zcXR1Xv94WTDxrbwVvvJvq8Xg==
X-Google-Smtp-Source: ABdhPJxCOtYM6wE6I23ECIs2Qe4RqO9Fsld+KWhukNaUvLqxacy6A4k/Hk6QX5PPXhxx/JBHh4wZPl2Wms4urz4X8pg=
X-Received: by 2002:ab0:1c0a:: with SMTP id a10mr2343531uaj.89.1607530273519;
 Wed, 09 Dec 2020 08:11:13 -0800 (PST)
MIME-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com>
 <CAK8P3a1WEAo2SEgKUEs3SB7n7QeeHa0=cx_nO==rDK0jjDArow@mail.gmail.com>
 <CABCJKueCHo2RYfx_A21m+=d1gQLR9QsOOxCsHFeicCqyHkb-Kg@mail.gmail.com>
 <CAK8P3a1Xfpt7QLkvxjtXKcgzcWkS8g9bmxD687+rqjTafTzKrg@mail.gmail.com>
 <CAKwvOd=hL=Vt1ATYqky9jmv+tM5hpTnLRuZudG-7ki0EYoFGJQ@mail.gmail.com> <CAK8P3a1k_cq3NOUeuQC4-uKDBaGq49GSjAMSiS_M9AVMBxv51g@mail.gmail.com>
In-Reply-To: <CAK8P3a1k_cq3NOUeuQC4-uKDBaGq49GSjAMSiS_M9AVMBxv51g@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 9 Dec 2020 08:11:02 -0800
Message-ID: <CABCJKucn6HnOw+oonjGU8q7w3uC0H727JZ30LzTbXx9BVLb0Zg@mail.gmail.com>
Subject: Re: [PATCH v8 00/16] Add support for Clang LTO
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 8, 2020 at 2:20 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, Dec 8, 2020 at 10:10 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > On Tue, Dec 8, 2020 at 1:00 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > On Tue, Dec 8, 2020 at 5:43 PM 'Sami Tolvanen' via Clang Built Linux
> > > <clang-built-linux@googlegroups.com> wrote:
> > > >
> > > > On Tue, Dec 8, 2020 at 4:15 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > > > >
> > > > > - one build seems to take even longer to link. It's currently at 35GB RAM
> > > > >   usage and 40 minutes into the final link, but I'm worried it might
> > > > > not complete
> > > > >   before it runs out of memory.  I only have 128GB installed, and google-chrome
> > > > >   uses another 30GB of that, and I'm also doing some other builds in parallel.
> > > > >   Is there a minimum recommended amount of memory for doing LTO builds?
> > > >
> > > > When building arm64 defconfig, the maximum memory usage I measured
> > > > with ThinLTO was 3.5 GB, and with full LTO 20.3 GB. I haven't measured
> > > > larger configurations, but I believe LLD can easily consume 3-4x that
> > > > much with full LTO allyesconfig.
> > >
> > > Ok, that's not too bad then. Is there actually a reason to still
> > > support full-lto
> > > in your series? As I understand it, full LTO was the initial approach and
> > > used to work better, but thin LTO is actually what we want to use in the
> > > long run. Perhaps dropping the full LTO option from your series now
> > > that thin LTO works well enough and uses less resources would help
> > > avoid some of the problems.
> >
> > While all developers agree that ThinLTO is a much more palatable
> > experience than full LTO; our product teams prefer the excessive build
> > time and memory high water mark (at build time) costs in exchange for
> > slightly better performance than ThinLTO in <benchmarks that I've been
> > told are important>.  Keeping support for full LTO in tree would help
> > our product teams reduce the amount of out of tree code they have.  As
> > long as <benchmarks that I've been told are important> help
> > sell/differentiate phones, I suspect our product teams will continue
> > to ship full LTO in production.
>
> Ok, fair enough. How about marking FULL_LTO as 'depends on
> !COMPILE_TEST' then? I'll do that locally for my randconfig tests,
> but it would help the other build bots that also force-enable
> COMPILE_TEST.

Sure, that sounds reasonable to me. I'll add it in v9.

Sami
