Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF692AE365
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbgKJWgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgKJWgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:36:39 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBBFC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:36:39 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id y22so2204515plr.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6e9bQzOYpSKr6lgwRrQrnk79+N3XZZYvyW04ZYowHus=;
        b=P81zf05Nc+7lwqt2tliJpfEWjkF5gyZggbG+njYiLfUd1k+bDQkC4VhOtbzb9eV2qh
         loUqW1fYIisWI7lWYy5OY2x89/lzkqmoYjCwslCEYZPi81QWEdFjJNcVI/YVVxJSj5cR
         zMhw4dq2ciWuZ2iKe8OShvsifhaMKcfQEPtUDSSULv7D3ikDAjyzwCIsrve6OtDGdlIh
         Dg7wIVWKbEWcA+hZt9j78cUMv1mTd3Ob7LxmPetSelYW1cSQY4arDTVXQ+KqWLiKq97I
         d4EDmcGw/xwcn1+stTWTVPah9NgB+ySCgVVHDREnAcByxqgID2r+EGOIlzuxI8x+fFhj
         1CDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6e9bQzOYpSKr6lgwRrQrnk79+N3XZZYvyW04ZYowHus=;
        b=tBHfxTUybdmsG27EEsfsnuDpnkgnp0B8bEI248X3t8sqeqOXl7P9zmQ1j8kwBWAuyZ
         L6p0I1WXoa6Fmh+kG6DW2pjRs1PxL4X1LaNVNKOpVRWmNXjGuBbSnod1Rg+nvbyjV5v5
         QfbJgLz5mqGmGOUVcJkNEMyHxMx7WHrHotbE6I7j2l2tX68nKwpkCxv0SbWZGnEaU9YT
         1GfvOoBYcRPx4xrBgLpGGpEAMWaXJFkFvQ6vyTwL7tIkm4xayKY8ahRdrXzUbE1TEp6M
         4lnJ9qnOkVZfK6Y1Np0rdW+w5KSVxpwkAomd/+YO6RjmsGws344sT6wvDDrkVCktZ0+u
         3dsA==
X-Gm-Message-State: AOAM531wotldOvjnt1chHcRBH1DncmOrWpJdZ5OmnW1+ebiFIb5HKvIs
        wqVDA2ZBUYFBDHR6ezIM+Ie6/vQt/pqHJpXs++p08A==
X-Google-Smtp-Source: ABdhPJx2tvwZu0qqS7tiJtnWby2DT7paqQTL2bhcMkKr0gp+8zVIPJBAIEgIcKlX3KZRBnxzSRkzFNCRguGAVLHKJis=
X-Received: by 2002:a17:902:760c:b029:d6:efa5:4cdd with SMTP id
 k12-20020a170902760cb02900d6efa54cddmr18256727pll.56.1605047798846; Tue, 10
 Nov 2020 14:36:38 -0800 (PST)
MIME-Version: 1.0
References: <20201106051436.2384842-1-adrian.ratiu@collabora.com>
 <20201106051436.2384842-3-adrian.ratiu@collabora.com> <20201106101419.GB3811063@ubuntu-m3-large-x86>
 <87wnyyvh56.fsf@collabora.com> <CAKwvOdkodob0M0r_AK_4nG3atLGMyNENMd6qVAHSPa92Zh7UZA@mail.gmail.com>
 <871rh2i9xg.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
 <CAKwvOdkm3u83TQDBB-fC0TwKZCFXGh5sAfahKXxA+mnzgDid_w@mail.gmail.com> <20201110221511.GA1373528@rani.riverdale.lan>
In-Reply-To: <20201110221511.GA1373528@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 10 Nov 2020 14:36:27 -0800
Message-ID: <CAKwvOd=NQ==umC+N_Sgji5HCCFTRARh4jWiB3DaBfV6jDd5cRg@mail.gmail.com>
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

On Tue, Nov 10, 2020 at 2:15 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Tue, Nov 10, 2020 at 01:41:17PM -0800, Nick Desaulniers wrote:
> > On Mon, Nov 9, 2020 at 11:51 AM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
> > >
> > > On Fri, 06 Nov 2020, Nick Desaulniers <ndesaulniers@google.com>
> > > wrote:
> > > > +#pragma clang loop vectorize(enable)
> > > >         do {
> > > >                 p1[0] ^= p2[0] ^ p3[0] ^ p4[0] ^ p5[0]; p1[1] ^=
> > > >                 p2[1] ^ p3[1] ^ p4[1] ^ p5[1];
> > > > ``` seems to generate the vectorized code.
> > > >
> > > > Why don't we find a way to make those pragma's more toolchain
> > > > portable, rather than open coding them like I have above rather
> > > > than this series?
> > >
> > > Hi again Nick,
> > >
> > > How did you verify the above pragmas generate correct vectorized
> > > code?  Have you tested this specific use case?
> >
> > I read the disassembly before and after my suggested use of pragmas;
> > look for vld/vstr.  You can also add -Rpass-missed=loop-vectorize to
> > CFLAGS_xor-neon.o in arch/arm/lib/Makefile and rebuild
> > arch/arm/lib/xor-neon.o with CONFIG_BTRFS enabled.
> >
>
> https://godbolt.org/z/1oo9M6
>
> With the __restrict__ keywords added, clang seems to vectorize the loop,
> but still reports that vectorization wasn't beneficial -- any idea
> what's going on?

I suspect that loop-vectorize is a higher level pass that relies on
slp-vectorizer for the transform.

$ clang -O2 --target=arm-linux-gnueabi -S -o - foo.c -mfpu=neon -mllvm
-print-after-all
...
*** IR Dump After SLP Vectorizer ***
(bunch of <4 x i32> types)

If you add -Rpass-missed=slp-vectorizer, observe that the existing
warnings from -Rpass-missed=loop-vectorize disappear; I suspect
loop-vectorize will print a "remark" if passes it calls did not, but
returned some for of error code.

-Rpass=slp-vectorizer shows that it vectorizes two sequences of the
loop, and warns that some third portion (that's
non-immediately-obvious to me) was non beneficial.

-- 
Thanks,
~Nick Desaulniers
