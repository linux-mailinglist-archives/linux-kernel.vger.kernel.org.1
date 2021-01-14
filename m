Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A4A2F5C4A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbhANITA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:19:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:60892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbhANIS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:18:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59A76239EF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610612299;
        bh=N5a/atXasUevjqMzJiK/W4ty6kZ/4vCWt3gzActcTYg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mjy6JA9jSp5PfOvVAi+GvjeqdW/DO59+DyAwcGONOdCYfddZ9U0BRXguQ63inG7B3
         V9D2wta4Qtl8EtjRvAiRUnqgpVXdtR8crp0+QSC/YfnI1PHiJHjbMWwbAHTXQad3iM
         wD5DhEhTrYjPfGPQkK0JcYaK1Jv2yq5244F1j7LFlhOCnVwOSQiFydufTRzPr2qHxr
         mwSWA4ulBIZA3DqN8+IuNc7/z4qDQnNjquw7C2HLjm2onsjlLUBmQco/ZtdTcpGLY1
         tVVcGCM9vnQelSg3rXF+zk61G9nGj6H84cAbke7hsgwT5DcvssQikdmtnvCjl18N4C
         xgr3r8uTCTWQQ==
Received: by mail-oo1-f46.google.com with SMTP id x203so1185647ooa.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 00:18:19 -0800 (PST)
X-Gm-Message-State: AOAM5317KmmrOQdOMlfbN71AuJlvOOnHwijI8VV8I/GZEemKIKcK8rr4
        /qvaxuEmQsUct50+MslyY4XjTZu/RODqHaxvns0=
X-Google-Smtp-Source: ABdhPJzx8azhVF1beD/V0rXaIBuAZoNnC2aHwFxMLkKAVC5qCL4dJBDnifu5IYM1MfZXDwuJ0FTcRUp6xtCPtx/OeUg=
X-Received: by 2002:a05:6820:41:: with SMTP id v1mr3970890oob.41.1610612298532;
 Thu, 14 Jan 2021 00:18:18 -0800 (PST)
MIME-Version: 1.0
References: <20210112224832.10980-1-will@kernel.org> <161055398865.21762.12236232732054213928.b4-ty@arm.com>
 <CAK7LNASs6dvU6D3jL2GG3jW58fXfaj6VNOe55NJnTB8UPuk2pA@mail.gmail.com>
 <CAHk-=wiQ_tp8NmKV8PJ-6WMo3dTEZwDo3a0hYjcUFqMdviNTYw@mail.gmail.com>
 <20210113214436.GL1551@shell.armlinux.org.uk> <CAHk-=wjqGRXUp6KOdx-eHYEotGvY=a5tSY1mF-BkAcX2YAuBYw@mail.gmail.com>
In-Reply-To: <CAHk-=wjqGRXUp6KOdx-eHYEotGvY=a5tSY1mF-BkAcX2YAuBYw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 14 Jan 2021 09:18:07 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFaDNRbDvr43VLEHFRHHS0sGGcF=iTfES4sxPg-rZ34NA@mail.gmail.com>
Message-ID: <CAMj1kXFaDNRbDvr43VLEHFRHHS0sGGcF=iTfES4sxPg-rZ34NA@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: Raise minimum version of GCC to 5.1 for arm64
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
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

On Wed, 13 Jan 2021 at 23:09, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Jan 13, 2021 at 1:44 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > So, maybe the Sparc issue was just a similar but different bug in gcc
> > 4.9.x.
>
> Good catch. And I know this bug has happened independently on
> different architectures several times (I remember this on x86-64 as
> well), so I started looking around.
>
> And in fact, 4.9 was buggy on x86-64 too:
>
>     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=61904
>
> And yeah, _that_ gcc bug wasn't actually x86-64 specific, but
> apparently a generic instruction scheduling bug.
>
> So it's an independent bug, but I do have to admit that the arguments
> against 4.9 are piling up (even if that particular fix apparently got
> fixed in the gcc branches and apparently backported to distro
> compilers too).
>

So if the arguments are piling up, what is holding us back, other than
inertia? RHEL 7 used to be a factor, but it ships with 4.8 not 4.9, so
its users already need to upgrade. Is anyone aware of a good reason to
keep 4.9 supported? Are any other long term supported distros using
4.9.x?

I know that distros probably backported fixes for all of these issues,
but without a way to interrogate the compiler about this, that doesn't
really make a difference IMHO.

Note that banning 4.9 for arm64 and banning it in general should be
two different changes in any case, as the former will need to be
backported to -stable kernels as well.

 --
Ard.
