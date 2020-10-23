Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418B9297874
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 22:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756425AbgJWUxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 16:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756412AbgJWUxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 16:53:19 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844D3C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 13:53:17 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id x16so2977301ljh.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 13:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H8PIAcZB+49cL/qkEaQxKoNrp5mF5VZb6QoBdo21438=;
        b=JAZXaC931XIpk3gt8AMxYg7YUQT1MXzQoOMEiIryFhi3PMtcehAhMwzTLjfi9ZiPp6
         IrWiK/S1OM0h6zf1hO34JH6gYZ8rvU2TTGjpDYhDCpP4Oex4/ZP0jryouAu6IlOxz3Yu
         OBKb9xXBU3PjhQEg0A1OeU3fcpQsr5UFb25YQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8PIAcZB+49cL/qkEaQxKoNrp5mF5VZb6QoBdo21438=;
        b=ipYWsrQwpMD1vo4u4pv5SFO06qsZL+xYB3r3gQCwY8FDl5WkK30Dq+8uYLmn420gDJ
         74FKdCkBv0mk3np+6IIL/7cUFXdBOMDOZ+i6jCHZv/LYDwatjUeDQM6Z+LjpaglnUkci
         x8WTu7tQcKlSsXOQ6RrNOrZujNEw3cD7SFTgCUsUYfReQF3Nwu3QSGY7X2aT3V0S3Ktd
         mT3Kf81+4sdBDw0BE29PLM7LTwwdIlaApqSjEZmKs2ZYWc5Vb36iC96+pYt4Oy9vnz+e
         ImMh5xTCXGK/o551SQLzBpXkJuGSzRD1SSFkZ5V5JK984AjhjUGW0Ve/UgqAuNDHb+Zl
         kktA==
X-Gm-Message-State: AOAM5339xuDo9LrM81kQXGF8z8STmLestfpvJS5lNSp7li3aHbdkDu/l
        YGhEkaatD7TIHT/YNc4iHC7BBNR/V2Skxw==
X-Google-Smtp-Source: ABdhPJxupI5kR8V+5YcRCMJWPAOuwwXW/+wx0V9M7K/ldO6qCpiEvNDcyeMTSZTiD3hXRRaIFaAl0Q==
X-Received: by 2002:a2e:8596:: with SMTP id b22mr1466033lji.455.1603486395699;
        Fri, 23 Oct 2020 13:53:15 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id r15sm238199lfn.65.2020.10.23.13.53.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 13:53:14 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id j30so3673215lfp.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 13:53:14 -0700 (PDT)
X-Received: by 2002:a19:83c9:: with SMTP id f192mr1269013lfd.148.1603486394019;
 Fri, 23 Oct 2020 13:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201023203154.27335-1-linux@rasmusvillemoes.dk> <CALCETrV2rzowdWqhEG7v-hmbUOpNHsBz-hR1RdxBFKuwU6rDTA@mail.gmail.com>
In-Reply-To: <CALCETrV2rzowdWqhEG7v-hmbUOpNHsBz-hR1RdxBFKuwU6rDTA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Oct 2020 13:52:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrmKk-94MTNwgf5oGP2VhU3iK5b9YqH-QS2AgvG4mSaw@mail.gmail.com>
Message-ID: <CAHk-=wjrmKk-94MTNwgf5oGP2VhU3iK5b9YqH-QS2AgvG4mSaw@mail.gmail.com>
Subject: Re: [PATCH] x86/uaccess: fix code generation in put_user()
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 1:42 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> This looks like the patch is an improvement, but this is still IMO
> likely to be very fragile.  Can we just do the size-dependent "a" vs
> "A" selection method instead?  Sure, it's a little more code, but it
> will be Obviously Correct.  As it stands, I can easily see our code
> failing on some gcc or clang version and the compiler authors telling
> us that we're relying on unsupportable behavior.

Well, the "register asm()" thing actually _is_ documented, and it's
something we've used before too (and still use in other places).

We actually have quite a bit of them - just do a

    git grep 'register.*asm('

to see literally hundreds of them. So gcc (and clang) actually has a
lot of test-cases for it.

In many ways, x86 actually tends to need _fewer_ of these than most
other architectures, since on x86, we almost always have specific
register naming in ways that other architectures often don't (because
x86 has all those specific register rules).

So the 64-bit issue for x86-32 is a bit of a special case for x86, but
this is in no way a special case in general, and is quite the common
pattern on other architectures.

The fact that KASAN could generate code in between the register asm
assignment was something I just overlooked (and embarrassingly similar
to the issues we had with objdump checking STAC/CLAC back when we
inlined that all).

It's a bit sad that gcc doesn't _warn_ about this kind of issue, since
the compiler certainly should see "oh, we just had a register clash".
But it is what it is..

                Linus
