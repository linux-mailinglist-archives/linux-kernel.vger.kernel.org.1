Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599812F41DE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 03:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbhAMCgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 21:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbhAMCgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 21:36:51 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824D2C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:36:10 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id f17so801912ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cYsC2k6W81EVp9O1j5ZowuzSt5cwgcQpE50X+ZuOV2c=;
        b=fUp14NfoOyMK2XZZbG2aiY2GbwA98yBwm5I9tygPSltjL/SDLxYtZlB/vrG07B4Imp
         7vC8upB7IS++uyMGOCxIkSePM+AE9RaL0nCNA0/AOVmJ+tiYlCijT2nc8RIsteGgQKuu
         AfN05xqlZVb8FNz1QKDAeH0HPSqXBrcuNBOF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cYsC2k6W81EVp9O1j5ZowuzSt5cwgcQpE50X+ZuOV2c=;
        b=fptJqi59gpzAHZRiNbHqT7QB/OJY7tzk5zMxXL+tVzj703OlqxShu3pZP81H97li26
         eaFzIkgUJF2eIJnuJEResbmo0pNLrsNUJ7Dj/aDVGJ4YrVsUBYoa4gvBXzAFt1Bs5zEO
         CMthezZR1s5owhyzeCCJFqTejBrMrZ6q5h92GW2AhMrcp+dXfgibMLDCH7k2uTHTrkn1
         B5d6/HoLSmeKaU5Gm73J0v4zPuWuRUwvgoMcgFZmCJcCurMktgLvfkCGjSzS0bxc1NDz
         K1BtI1PfgZhL89XRVztpSS5zNq6t9rJ4FOS/nrRuHu0F/+s4s8Xt9KLx27xRR0egmbO1
         xTsw==
X-Gm-Message-State: AOAM533NiD9TLHCJ2VFzbVGF31dhKnWm+SgcXcOgPnpIlEJCWOErgtpc
        BwOa68H5fmZ+k/8QDznRLRGf+/Pq5IuUUQ==
X-Google-Smtp-Source: ABdhPJzJ+14oQMUb1QN+4qZcXkXSH9UkqEuegU4glAjjbR33Mi4yNL3m0LsEt+BwCsxfFiZ0MfMnow==
X-Received: by 2002:a2e:740a:: with SMTP id p10mr964219ljc.409.1610505368306;
        Tue, 12 Jan 2021 18:36:08 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 192sm52307lfa.219.2021.01.12.18.36.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 18:36:06 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id y22so819603ljn.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 18:36:06 -0800 (PST)
X-Received: by 2002:a2e:3211:: with SMTP id y17mr901741ljy.61.1610505365883;
 Tue, 12 Jan 2021 18:36:05 -0800 (PST)
MIME-Version: 1.0
References: <20210112224832.10980-1-will@kernel.org> <CAHk-=wi5oACdjFwnaonTWPVpBpwohxeJJJDvLvMS85RzrX5SYQ@mail.gmail.com>
In-Reply-To: <CAHk-=wi5oACdjFwnaonTWPVpBpwohxeJJJDvLvMS85RzrX5SYQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Jan 2021 18:35:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh-+TMHPTFo1qs-MYyK7tZh-OQovA=pP3=e06aCVp6_kA@mail.gmail.com>
Message-ID: <CAHk-=wh-+TMHPTFo1qs-MYyK7tZh-OQovA=pP3=e06aCVp6_kA@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: Raise minimum version of GCC to 5.1 for arm64
To:     Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Florian Weimer <fweimer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 6:14 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ack. I'll assume I get this the usual ways from the arm64 tree..

Oh.. Actually, while you can use my ack if you decide to go this way,
I do wonder if it might not be better to introduce a notion of an
error at Kconfig time, and then we could make this whole GCC_VERSION
check be something that gets covered much earlier - when configuring
the kernel, rather than randomly (ok, very early) when building it.

We already have the CONFIG_GCC_VERSION config variable, after all.

And Kconfig already has an error functionality, which it uses for
things like compilers not found etc.

So something like

     $(error-if,CC_IS_GCC && GCC_VERSION < 90100,"Gcc version too old")

in the arm64 Kconfig file should do it.

Adding Masahiro, because I couldn't actually get it to work. I'm
probably doing something wrong, but it might also be that it cannot
depend on config variables currently (our only use is for running
shell script tests unconditionally).

           Linus
