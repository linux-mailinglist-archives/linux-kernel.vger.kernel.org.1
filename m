Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A1C2B1A39
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgKMLoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 06:44:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:33474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbgKMLlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:41:44 -0500
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1724C2224F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 11:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605267678;
        bh=IKXPZInFuWv5+BduGuX9Ec2McK9C8JFS4284M+7/ykg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lM+vBoKxbv6L6YLuwthIY1oYPPMreS0XXqZP5fQE26ZyswUeF2R1oBIH5N/O7+be4
         +L4C8tRN4faA93315ZnKT20XFJBfPSM1HW8Mp5GvlVGTGU4uSi4MhrqBwUgblSMqas
         KA5fkBb2cAIKlsduGofN+tzaO41a4Pg3aOr8iRm4=
Received: by mail-oo1-f51.google.com with SMTP id c25so2077619ooe.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 03:41:18 -0800 (PST)
X-Gm-Message-State: AOAM5309AIluMItgS+Qr2a8ikDcIDnsOk22EyDbBD3JRJ5A4eZ/ahl79
        rtYP++A6Zh0LIndeESnxscUPScXZMmYIK0tEUks=
X-Google-Smtp-Source: ABdhPJwKeQwo/74xzJBDAboTV0FH5bd9URhUDHXyRWsprng3fVdbZ6ZVwxb9CrO1o1UUn0txwIG6Cw1GfUnJUFmvq9w=
X-Received: by 2002:a4a:9806:: with SMTP id y6mr1196261ooi.45.1605267677271;
 Fri, 13 Nov 2020 03:41:17 -0800 (PST)
MIME-Version: 1.0
References: <20201112212457.2042105-1-adrian.ratiu@collabora.com>
 <20201112212457.2042105-2-adrian.ratiu@collabora.com> <CAMj1kXFbLRTvGuRt5J3-oEuJrrHFV9+SBGFFDNsAftGUbwoTPw@mail.gmail.com>
 <87mtzljz12.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
In-Reply-To: <87mtzljz12.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 13 Nov 2020 12:41:04 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHQ94ZzoSUg6U70FnRtFs0KeVXT=Zg6ri2+OU_TKQcGfg@mail.gmail.com>
Message-ID: <CAMj1kXHQ94ZzoSUg6U70FnRtFs0KeVXT=Zg6ri2+OU_TKQcGfg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm: lib: xor-neon: remove unnecessary GCC < 4.6 warning
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Collabora Kernel ML <kernel@collabora.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020 at 12:05, Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>
> Hi Ard,
>
> On Fri, 13 Nov 2020, Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Thu, 12 Nov 2020 at 22:23, Adrian Ratiu
> > <adrian.ratiu@collabora.com> wrote:
> >>
> >> From: Nathan Chancellor <natechancellor@gmail.com>
> >>
> >> Drop warning because kernel now requires GCC >= v4.9 after
> >> commit 6ec4476ac825 ("Raise gcc version requirement to 4.9").
> >>
> >> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> >> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> >> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> >
> > Again, this does not do what it says on the tin.
> >
> > If you want to disable the pragma for Clang, call that out in
> > the commit log, and don't hide it under a GCC version change.
>
> I am not doing anything for Clang in this series.
>
> The option to auto-vectorize in Clang is enabled by default but
> doesn't work for some reason (likely to do with how it computes
> the cost model, so maybe not even a bug at all) and if we enable
> it explicitely (eg via a Clang specific pragma) we get some
> warnings we currently do not understand, so I am not changing the
> Clang behaviour at the recommendation of Nick.
>
> So this is only for GCC as the "tin" says :) We can fix clang
> separately as the Clang bug has always been present and is
> unrelated.
>

But you are adding the IS_GCC check here, no? Is that equivalent? IOW,
does Clang today identify as GCC <= 4.6?

> >
> > Without the pragma, the generated code is the same as the
> > generic code, so it makes no sense to build xor-neon.ko at all,
> > right?
> >
>
> Yes that is correct and that is the reason why in v1 I opted to
> not build xor-neon.ko for Clang anymore, but that got NACKed, so
> here I'm fixing the low hanging fruit: the very obvious & clear
> GCC problems.
>
>

Fair enough.

> >> ---
> >>  arch/arm/lib/xor-neon.c | 9 +--------
> >>  1 file changed, 1 insertion(+), 8 deletions(-)
> >>
> >> diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> >> index b99dd8e1c93f..e1e76186ec23 100644
> >> --- a/arch/arm/lib/xor-neon.c
> >> +++ b/arch/arm/lib/xor-neon.c
> >> @@ -19,15 +19,8 @@ MODULE_LICENSE("GPL");
> >>   * -ftree-vectorize) to attempt to exploit implicit parallelism and emit
> >>   * NEON instructions.
> >>   */
> >> -#if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 6)
> >> +#ifdef CONFIG_CC_IS_GCC
> >>  #pragma GCC optimize "tree-vectorize"
> >> -#else
> >> -/*
> >> - * While older versions of GCC do not generate incorrect code, they fail to
> >> - * recognize the parallel nature of these functions, and emit plain ARM code,
> >> - * which is known to be slower than the optimized ARM code in asm-arm/xor.h.
> >> - */
> >> -#warning This code requires at least version 4.6 of GCC
> >>  #endif
> >>
> >>  #pragma GCC diagnostic ignored "-Wunused-variable"
> >> --
> >> 2.29.2
> >>
