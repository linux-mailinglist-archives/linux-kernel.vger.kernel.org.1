Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE46D2F895D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 00:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbhAOXZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 18:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbhAOXZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 18:25:09 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332A5C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 15:24:27 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id f17so12097983ljg.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 15:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lspkB+h5s6b8Zyih98xTfXCRcGn+GFR4ecpzXtZclcQ=;
        b=VCNEYkEerxNDCrTb2mbn7JMafLojLFMdQLNUQfC/wOLAL4m2Ta+MvY725eGmDVqfnn
         H7hwRghFneD6WqMDm/Q/QhCiCow/CkY/+gFvcUeWCS0WRy4nZ6muR/2qyOkHE9wI78Kz
         gdFOqzLN74IPJor0B8Y5gNPtcoiNIILZOGCMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lspkB+h5s6b8Zyih98xTfXCRcGn+GFR4ecpzXtZclcQ=;
        b=EwXbC+0w9Gkibmuspu1vrm7qGSw1sxWmgeT1RR4UUow2RvWNg5G4LBCZjCV4EYCsCu
         mXwN8VSNSgrLrU26YmSUnNHH/QXv6KuDq9sTW4SQEY+Xk2mab1k35HJF+HOPtr+YaH4V
         hBRI48ru5B4rcFkLIJwx/5HyYOeQ8gMCgt6hBNGLgjQVatGD2i9lY0czG/RmOesbPQQT
         upfZKAehB2mVevgtPST6deR0iIRKPiB9/j9Z7N8rlTVXmYO3LLZz6IKG5f5Gr85IYQza
         JoOeEjCr3N9/iz5iuRcfmFoOPoRq/AV5exnbeFTs7QlyeacqHQsKGs7RKHBbSF7Fui13
         qHeQ==
X-Gm-Message-State: AOAM532FiLEgumhrhoNVStcL+8Z0J7DxH6pV5340XGDC1HX16nY9Iiia
        H79CzGQc2HdBhuUuKb/TRaJXDs3wJrrE6Q==
X-Google-Smtp-Source: ABdhPJzrUx8CvxnM07/KVWDGYP/5kdumZaDidS5i5HlkKfTdQ9ka50jA0dTnqWczEshkpqqThMlE3g==
X-Received: by 2002:a05:651c:cb:: with SMTP id 11mr6120561ljr.509.1610753065309;
        Fri, 15 Jan 2021 15:24:25 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 206sm1078048lfd.180.2021.01.15.15.24.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 15:24:23 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id f17so12097878ljg.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 15:24:23 -0800 (PST)
X-Received: by 2002:a2e:3211:: with SMTP id y17mr5928600ljy.61.1610753063004;
 Fri, 15 Jan 2021 15:24:23 -0800 (PST)
MIME-Version: 1.0
References: <20210112224832.10980-1-will@kernel.org> <161055398865.21762.12236232732054213928.b4-ty@arm.com>
 <CAK7LNASs6dvU6D3jL2GG3jW58fXfaj6VNOe55NJnTB8UPuk2pA@mail.gmail.com>
 <CAHk-=wiQ_tp8NmKV8PJ-6WMo3dTEZwDo3a0hYjcUFqMdviNTYw@mail.gmail.com>
 <20210113214436.GL1551@shell.armlinux.org.uk> <CAHk-=wjqGRXUp6KOdx-eHYEotGvY=a5tSY1mF-BkAcX2YAuBYw@mail.gmail.com>
 <CAMj1kXFaDNRbDvr43VLEHFRHHS0sGGcF=iTfES4sxPg-rZ34NA@mail.gmail.com>
 <CAHk-=wjHTpG+gMx9vqrZgo8Uw0NqA2kNjS87o63Zv3=WG2K3zA@mail.gmail.com>
 <fd3f26b7a70d3b90f1368c55532e463ef2fb9fa4.camel@perches.com>
 <CAHk-=wjgvt1Ei72BTrEH5fgfqykVH-AYt56-7yBT8Lcprj7bEg@mail.gmail.com> <eabb211c3ba394845ec3258d86406137f4c23b33.camel@perches.com>
In-Reply-To: <eabb211c3ba394845ec3258d86406137f4c23b33.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Jan 2021 15:24:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=whrJ_3iTz+Wz2cSufxnw2+g39P=YsTGaE6M24Qg4=Ef5Q@mail.gmail.com>
Message-ID: <CAHk-=whrJ_3iTz+Wz2cSufxnw2+g39P=YsTGaE6M24Qg4=Ef5Q@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: Raise minimum version of GCC to 5.1 for arm64
To:     Joe Perches <joe@perches.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 4:30 PM Joe Perches <joe@perches.com> wrote:
>
> KASAN v5 instead of all the old versions
> gcc 7.1 supports fallthrough.

Considering that most people won't even enable KASAN, I think that's
not a huge reason to then force people to potentially upgrade their
compilers.

That said, I do think that it might be good to just try to standardize
on the KASAN v5 code - but that could easily be done by simply making
KASAN depend as a feature on having a newer compiler version.

So the KASAN option itself could just have something like

       depends on !CC_IS_GCC || GCC_VERSION >= 70000

in it, which would allow us to just say "only v5 need apply".

As to "fallthrough", I think it's more than enough that lots of people
build with compilers that support it, and then any warnings they see
will be fixed. No need to force upgrades - it doesn't buy kernel
developers anything.

          Linus
