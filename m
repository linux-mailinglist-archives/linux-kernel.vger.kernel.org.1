Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E059248E76
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 21:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgHRTNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 15:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgHRTNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:13:44 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0568C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:13:41 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w25so22640368ljo.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kRmD2QbAj0vfmoNVvNMP8rPvVPoSWyCAf8x4746i4Lw=;
        b=ZiA1XO+PyilZibQ5JpzVQt282FyQ/PBbpJhA+sKTp1s1vswJWQf1scFga1vTAE+ARg
         4xqurqK3liy7M7SNb2CHhwbyLKyZXfPwxp4DydMZ8KOiGYBOiuCjfb3aUjYuibGo3rSq
         HTV4diqJba5aOLalPMWyrvr+6H/PSP3/9c4Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kRmD2QbAj0vfmoNVvNMP8rPvVPoSWyCAf8x4746i4Lw=;
        b=Rk8QP5kAVTuPSKpWcIomyesCbKHZNzVuxhwmHSNou1a7vA0bZ8fnyfiFUXxXMhAhG8
         EzSpRCZ1QI9Sa8pz0zbjfiFGoEiWqZtRvRl+Dv1JA2vKSJcU3hZ4187vzyjObaMw9/8G
         PhGGoxFRbyGeMkfnR29M7b4lql3DqGkZteSo/7S5s5t5C6sO2FglXOv9Pdi8HQphP3Y8
         J3N/wzNk64CKlh46kIgiRbqeh6JaaPwJdfyWyfFHeTebtDPpBBdmvUdesFVNL35DgDQt
         m665vfJ+YOXVRpTrh9sxPSbLHTIzdge0jdpMBME4UUvtcIdrFrxLv1AQAfOSYQPWq1G2
         wccQ==
X-Gm-Message-State: AOAM533HY3tQzfxCxe1QrM/XZZgRqGttO89wLVC3mfosa+lCIIIRZsGv
        zncIwmYOBJZmQ+NJxPvBoxTO0/NutrQnDg==
X-Google-Smtp-Source: ABdhPJy9p1NPTfcAJilenKGci7l1+XHem4CpnOY+iWxjDQUZztDCqg20ynACc1Xpb8nklQKiKWQvvw==
X-Received: by 2002:a2e:8710:: with SMTP id m16mr175342lji.244.1597778019982;
        Tue, 18 Aug 2020 12:13:39 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id g6sm6767436lfr.51.2020.08.18.12.13.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 12:13:39 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id i10so22689662ljn.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:13:38 -0700 (PDT)
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr11115885ljp.312.1597778018119;
 Tue, 18 Aug 2020 12:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200817220212.338670-1-ndesaulniers@google.com>
 <fae91af3-4e08-a929-e5c3-25271ad7324b@zytor.com> <CAKwvOdk6A4AqTtOsD34WNwxRjyTvXP8KCNj2xfNWYdPT+sLHwQ@mail.gmail.com>
 <76071c24-ec6f-7f7a-4172-082bd574d581@zytor.com>
In-Reply-To: <76071c24-ec6f-7f7a-4172-082bd574d581@zytor.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Aug 2020 12:13:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPeRQU_5JXCN0TLoW-xHZHp7dmrhx0wyXUSKxiCxE02Q@mail.gmail.com>
Message-ID: <CAHk-=wiPeRQU_5JXCN0TLoW-xHZHp7dmrhx0wyXUSKxiCxE02Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] -ffreestanding/-fno-builtin-* patches
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Axtens <dja@axtens.net>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Yury Norov <yury.norov@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Marco Elver <elver@google.com>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>,
        Andi Kleen <ak@suse.de>,
        =?UTF-8?B?RMOhdmlkIEJvbHZhbnNrw70=?= <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 12:03 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> I'm not saying "change the semantics", nor am I saying that playing
> whack-a-mole *for a limited time* is unreasonable. But I would like to go back
> to the compiler authors and get them to implement such a #pragma: "this
> freestanding implementation *does* support *this specific library function*,
> and you are free to call it."

I'd much rather just see the library functions as builtins that always
do the right thing (with the fallback being "just call the standard
function").

IOW, there's nothing wrong with -ffreestanding if you then also have
__builtin_memcpy() etc, and they do the sane compiler optimizations
for memcpy().

What we want to avoid is the compiler making *assumptions* based on
standard names, because we may implement some of those things
differently.

And honestly, a compiler that uses 'bcmp' is just broken. WTH? It's
the year 2020, we don't use bcmp. It's that simple. Fix your damn
broken compiler and use memcmp. The argument that memcmp is more
expensive than bcmp is garbage legacy thinking from four decades ago.

It's likely the other way around, where people have actually spent
time on memcmp, but not on bcmp.

If somebody really *wants* to use bcmp, give them the "Get off my
lawn" flag, and leave them alone. But never ever should "use bcmp" be
any kind of default behavior. That's some batshit crazy stuff.

               Linus
