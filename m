Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84142A6F20
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 21:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbgKDUoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 15:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730347AbgKDUoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:44:17 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0164FC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 12:44:17 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id t6so10836800plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 12:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhARirJve0xr71kjKUehqalK8pIZFFMyz5pxSgB5WdY=;
        b=J64alzyzWHnKMYj4MnT1sTFwRbzbKw8j1MuAc3PdOS5kTcWNQ24soMCCrmMAxV78RE
         pExeFQYVCL7U4cwBtWksT7BKpn4quMio7+4fep6MPN8MGcK3Dc3QyTrE+mQ/Q/NZVAd/
         U7A3rAyPckV8UHqckbNohgkoumn81QUaDVwv/S9ZSNQqxCnK6Fm27DgDzfrsC32zWNS5
         SMRHIipcN1I4rQ+ocaK9XOLpEUHRk0hFZ2CiN9bVTW952M15IUOYrln248MGaa1lTP8k
         ggYh1lyUTvRUVtlhqksIHMnJ8MzIIdKZGcU/jhuuNajG+NgONVVIaEvE8nV/x8TOpqQ0
         tvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhARirJve0xr71kjKUehqalK8pIZFFMyz5pxSgB5WdY=;
        b=o3VmcZlKoU/KfA6Fo1yOXbpbm/La3sUxOol3/nRoU92Au1qHd8eSLy23DjjGCh10CM
         8GbnjlgxclRizKWlVl1pRD5EpUGZFCtunl4EFIJJAKf+z5EJPiUHSDHniwS1NsNs4+pO
         bc8Ek3JNvAKmTL3Q5qD8DXw97J0VILIC0w2Bkhope5EB8EZIR6OwSJc6+aIUGsMgWh6T
         Wu/Od/cFEBHslHKpcpETXv+jaVGiMg9PXPUu2GuI8uZd1gUzapWwby3rJxhDqlVpPEWE
         a6O2CGwM5z/3hIO26HjyrgLel9DdM8hR14k9Ya9v8hytwNvM6LDcRdaRf9h/lHEzMT/A
         QACQ==
X-Gm-Message-State: AOAM533ip3oFUajlwWwtIwh5ya7VDBnsF7ZzXv+O47tUc4jx6/XcucFR
        tXC+8tWaAhM5vpFLRSnY0FFcnTMYtwqj0RGjJZI8Ug==
X-Google-Smtp-Source: ABdhPJwB1fp9602OASNEwvffp6kTM0tQZ+BOELSs5IJByFYZmvx98KW+EXfX9eKXBtV5Rl0bUengf4POtHqshWM8jdU=
X-Received: by 2002:a17:902:760c:b029:d6:efa5:4cdd with SMTP id
 k12-20020a170902760cb02900d6efa54cddmr3130038pll.56.1604522656305; Wed, 04
 Nov 2020 12:44:16 -0800 (PST)
MIME-Version: 1.0
References: <20200409232728.231527-1-caij2003@gmail.com> <CAK8P3a3uj7AHbAo4sNzr6KQx5Fk6v99k4ZixCgKo1tUuGoat9Q@mail.gmail.com>
 <CAMj1kXGXNxXGiC4dmNXHkZ6n=J0Fhim3oSwNx4Bz5m9fEphJvQ@mail.gmail.com>
 <20200410123301.GX25745@shell.armlinux.org.uk> <CAKwvOd=-u3grX3O4CtBayJYhv=mmsxMrRTF=AMcKMbphN5Xkgg@mail.gmail.com>
 <20200413210049.GQ25745@shell.armlinux.org.uk>
In-Reply-To: <20200413210049.GQ25745@shell.armlinux.org.uk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 4 Nov 2020 12:44:04 -0800
Message-ID: <CAKwvOd=6chv+goJ1-8RhcMmUPSU4OMwMWVmvkHO8yxgmHiLKyw@mail.gmail.com>
Subject: Re: [PATCH] ARM: do not assemble iwmmxt.S with LLVM toolchain
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Peter Smith <Peter.Smith@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Manoj Gupta <manojgupta@google.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jian Cai <caij2003@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jian Cai <jiancai@google.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 2:01 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Mon, Apr 13, 2020 at 12:23:38PM -0700, Nick Desaulniers wrote:
> > On Fri, Apr 10, 2020 at 5:33 AM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > >
> > > For older CPUs, it doesn't matter what the latest ARM ARM says, the
> > > appropriate version of the ARM ARM is the one relevant for the CPU
> > > architecture.  This is a mistake frequently made, and it's been pointed
> > > out by Arm Ltd in the past (before ARMv6 even came on the scene) that
> > > keeping older revisions is necessary if you want to be interested in
> > > the older architectures.
> >
> > As if it never existed *waves hands*.  Interesting.  Does ARM still
> > distribute these older reference manuals? Do you keep copies of the
> > older revisions?
>
> I keep copies of every document I've needed that I'm allowed to keep
> as a general rule, including the early paper copies of the ARM
> architecture reference manual. I even have the original VLSI ARM2
> databook.
>
> For the ARMv5TE architecture, you're looking for DDI0100E which can be
> found via google.

Russell, Arnd found
http://read.pudn.com/downloads78/ebook/297953/WirlessMMX251669_devguide.pdf
"Intel Wireless MMX Technology - Developer Guide - August, 2002".

I thought you might be interested in fetching a copy for historical reference.
-- 
Thanks,
~Nick Desaulniers
