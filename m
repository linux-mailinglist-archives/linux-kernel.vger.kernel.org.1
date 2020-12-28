Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FB82E6BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbgL1Wzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbgL1UJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 15:09:02 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2F1C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 12:08:22 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id v3so10409495ilo.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 12:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=86RrN+iEPFXzKm01CrosRjADFTrM1gJXsHHqXe6tZqQ=;
        b=RzPcnZ+Pzccww6ZWZJMn09EhAO9EHAuiVuC2/XWdDrrC19EcqKJh6I1u63S9FLyZpa
         sXjBS7euJ34EGBqgYFCo+c29Rn6Pt4nlIV2O8H8b3HNe1BMSZKuyEW5D4hJPVL+8O0aA
         C49q7hxQW+HqGIdAkvq2RbQK9zT0JQCsATbwHaKb4LQPgr8aKuk4NrpvmLib8+uaaNvv
         zm6YsoLtB2gS2L8x7MglKyK2UPZD6Wde3VPNP8V+R5TDsO6my2EhA2BE2C1RJnpOB2nI
         UbLpiWtd9rGD1xu3+IEd3jpkVjLsOZLfWo0SyUrWFRQqCy1zaACOhYRmF9n3JUVCCQxG
         9ACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=86RrN+iEPFXzKm01CrosRjADFTrM1gJXsHHqXe6tZqQ=;
        b=HFd7x0zdCxV1R+Ph5z2URyPzwZQZfP4cGt3bopP8QRWr9Kg1PoV3S6W6NzTqPd3Mi6
         BYNFQvu/HYL+9DIGLdote4lVwb9no3QgzIEDudYjVi4s9I1yj7VDS48cU/1WcEm66jWw
         UaQFWjNyUDSQqguMBy5C9RZkyx7Bc/HZRx0evVzquLL+XU08h34Xm1z/0iC+XID8nNyg
         kiMadmIL1jukqp3MHO2WZZPJJSjnYX9pfs1wsVY3f32rCfKBzbL8whs7pheakBHP2ZcX
         0ygXO3Uxubc2u5yeIcnBfV1kE8ZoWs7NUMOZ8T36F/1G5nQ3c0g9H7zIs9cHcTKiQDoy
         5efg==
X-Gm-Message-State: AOAM5312G7PpTEBKcrkpFBjEVUFi0U0vdy6R7qDpra01AS843cZgRZMw
        q032jd74Ac6/FfG/exseuJ/SApZPfPz01d8NW18=
X-Google-Smtp-Source: ABdhPJzkZo5ip32M7zXAH41X74E6f6qFCB2kGOugmL+1a5Wv7KLIPjweGq2JeB7L20jMLd7oqLU+fdt4Ub/Old6KXNs=
X-Received: by 2002:a05:6e02:1ba3:: with SMTP id n3mr45394561ili.10.1609186101698;
 Mon, 28 Dec 2020 12:08:21 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUUQRKuZzN0ZbaG6vprRWcKPKYVYTryiMFac7q_PRcBvgA@mail.gmail.com>
 <CA+icZUXfVF49iBYTvz-g9f=Fo04jkgLhHiYRxoon9NjZtWzGQg@mail.gmail.com> <CAHk-=wj+V1dkij1vTH+pk7LgwQ4snBH1Y+6Ts6jgSXRGDuFKdg@mail.gmail.com>
In-Reply-To: <CAHk-=wj+V1dkij1vTH+pk7LgwQ4snBH1Y+6Ts6jgSXRGDuFKdg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 28 Dec 2020 21:08:09 +0100
Message-ID: <CA+icZUWkBfMT+aVTNUQyrqZoU13p6fNVLp241pMxCEvKOpZmjA@mail.gmail.com>
Subject: Re: Linux 5.11-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 8:45 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Dec 28, 2020 at 7:26 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > I also tested with LLVM toolchain v11.0.1-rc2 together with passing
> > LLVM=1 and LLVM_IAS=1 to my make line.
> >
> > I had one ERROR:
> >
> > error: too few operands for instruction in arch/x86/kvm/svm/sev.c
>
> Looks like Paolo already picked up the fix, so this should be fixed
> when I get the next kvm pull request.
>
> That said, you might want to make sure the  LLVM people know about this too.
>

Done.

- Sedat -

[1] https://github.com/ClangBuiltLinux/linux/issues/1216
[2] https://github.com/ClangBuiltLinux/linux/issues/1216#issuecomment-751846419

> The whole "implicit arguments" is a common thing in x86, where lots of
> instructions don't need to spell them out explicitly, because of fixed
> register allocation (example: divide/multiply instructions only work
> with ax/dx as a target etc).
>
>              Linus
