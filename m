Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56912AE36C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732221AbgKJWja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgKJWja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:39:30 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F300AC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:39:29 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w6so228590pfu.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x01X3oGlO2FWJs/nEcm6l2z8oosZN74c8doXPDQlDH8=;
        b=PDaTbORqaF9OsJWeMMH4Nn/m77MsSx7JGQ/5Al2acvW7WJTSQmPK3mh3ELUjd6Vb3O
         COx/cSxK8sSFQEjj8eJdTDTraM3x7kC0wnksp7FH4z8sGeSInaOToS5W40xZjDNswPMQ
         aq6LJPf9mi1OMxThfF+hbQhV3gPzMy8KXUL2tWi12Wgwzra44xaM+h2Cg+XQCaWJe7TL
         SLPqFbTN+dbWZLGzkzl9VBpUHNs5t2n4WzAw/GHIsfFQZgkQzrvppdraQKnQaPG4CptH
         gb6KrzCG9ZG1o4IXqt8y5Ir5fz/NiHEoOohnOQVBh05jJb9airObpKVQSubg0FeEKg/V
         yWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x01X3oGlO2FWJs/nEcm6l2z8oosZN74c8doXPDQlDH8=;
        b=HuFu11NV/OeJgDs76Seago5heEdS0EawDD1GNyfZH/xwVdiax/zu/SbTCh19jdugVv
         y7kw7rMv7d0d/kAe/K3gHMvYNje2w3JGoYRDC7mTESnfipDQYNTdQfaUvDNgjRpYhY+h
         XCEihSav6XSduXaF/MBLQXNkDXLu8AcOBlV4gckQNwtFq7YsggoQ2YbIK0gy1HclKux8
         RmHKk9Ri7xkI1rymYGdBS8kQrz+sbZD05HHNpNrkmHzzpisD/njKj0ggR16L/ifaZdxu
         3zuMNfonKoGDgXqSpVn2VNAdmlzQIym5ywG1OnadSPqOAwedmP5qk/FhpU8ONa4OOZgl
         hyCg==
X-Gm-Message-State: AOAM533GsRNJyRjbfn0uYnyRxL+k4ZKREq+XT1YOuo/0HM53+OAKDH+L
        8xKtLavx/RBtPWlD6zmrsYa9o239futt6hVVISAVyg==
X-Google-Smtp-Source: ABdhPJwwavQAaG6gZxGaph8iG/csCdfimrEfLAaBTdf9DdMp4nGAeUNSNTHWttFdmhqHqubBstUPbM+0uY6iiNHdBu8=
X-Received: by 2002:a62:5e06:0:b029:164:a9ca:b07e with SMTP id
 s6-20020a625e060000b0290164a9cab07emr14974079pfb.36.1605047969331; Tue, 10
 Nov 2020 14:39:29 -0800 (PST)
MIME-Version: 1.0
References: <20201106051436.2384842-1-adrian.ratiu@collabora.com>
 <20201106051436.2384842-3-adrian.ratiu@collabora.com> <20201106101419.GB3811063@ubuntu-m3-large-x86>
 <87wnyyvh56.fsf@collabora.com> <CAKwvOdkodob0M0r_AK_4nG3atLGMyNENMd6qVAHSPa92Zh7UZA@mail.gmail.com>
 <871rh2i9xg.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
 <CAKwvOdkm3u83TQDBB-fC0TwKZCFXGh5sAfahKXxA+mnzgDid_w@mail.gmail.com>
 <20201110221511.GA1373528@rani.riverdale.lan> <CAKwvOd=NQ==umC+N_Sgji5HCCFTRARh4jWiB3DaBfV6jDd5cRg@mail.gmail.com>
In-Reply-To: <CAKwvOd=NQ==umC+N_Sgji5HCCFTRARh4jWiB3DaBfV6jDd5cRg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 10 Nov 2020 14:39:18 -0800
Message-ID: <CAKwvOdmsCY8Hb6t8t9jW5DKCZKbja27bGufO=tw3+-UuTTFBOQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm: lib: xor-neon: disable clang vectorization
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Adrian Ratiu <adrian.ratiu@collabora.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 2:36 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Nov 10, 2020 at 2:15 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Tue, Nov 10, 2020 at 01:41:17PM -0800, Nick Desaulniers wrote:
> > > On Mon, Nov 9, 2020 at 11:51 AM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
> > > >
> > > > On Fri, 06 Nov 2020, Nick Desaulniers <ndesaulniers@google.com>
> > > > wrote:
> > > > > +#pragma clang loop vectorize(enable)
> > > > >         do {
> > > > >                 p1[0] ^= p2[0] ^ p3[0] ^ p4[0] ^ p5[0]; p1[1] ^=
> > > > >                 p2[1] ^ p3[1] ^ p4[1] ^ p5[1];
> > > > > ``` seems to generate the vectorized code.
> > > > >
> > > > > Why don't we find a way to make those pragma's more toolchain
> > > > > portable, rather than open coding them like I have above rather
> > > > > than this series?
> > > >
> > > > Hi again Nick,
> > > >
> > > > How did you verify the above pragmas generate correct vectorized
> > > > code?  Have you tested this specific use case?
> > >
> > > I read the disassembly before and after my suggested use of pragmas;
> > > look for vld/vstr.  You can also add -Rpass-missed=loop-vectorize to
> > > CFLAGS_xor-neon.o in arch/arm/lib/Makefile and rebuild
> > > arch/arm/lib/xor-neon.o with CONFIG_BTRFS enabled.
> > >
> >
> > https://godbolt.org/z/1oo9M6
> >
> > With the __restrict__ keywords added, clang seems to vectorize the loop,
> > but still reports that vectorization wasn't beneficial -- any idea
> > what's going on?

Anyways, it's not safe to make that change in the kernel unless you
can guarantee that callers of these routines do not alias or overlap.

>
> I suspect that loop-vectorize is a higher level pass that relies on
> slp-vectorizer for the transform.
>
> $ clang -O2 --target=arm-linux-gnueabi -S -o - foo.c -mfpu=neon -mllvm
> -print-after-all
> ...
> *** IR Dump After SLP Vectorizer ***
> (bunch of <4 x i32> types)
>
> If you add -Rpass-missed=slp-vectorizer, observe that the existing
> warnings from -Rpass-missed=loop-vectorize disappear; I suspect
> loop-vectorize will print a "remark" if passes it calls did not, but
> returned some for of error code.
>
> -Rpass=slp-vectorizer shows that it vectorizes two sequences of the
> loop, and warns that some third portion (that's
> non-immediately-obvious to me) was non beneficial.
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
