Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5197029C91F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370315AbgJ0Tjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:39:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38327 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1830357AbgJ0Tjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:39:39 -0400
Received: by mail-lj1-f194.google.com with SMTP id m20so3141628ljj.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 12:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/ZjpB7n4FkhzFJT9cWI1qyNowromE99mrhGgv/JAmU=;
        b=KeATWeNipyp1eWODhRbUlx9kFO99Nm9k6qs84jXqerWUcCzTZENLcty09ys+27qY3J
         4574zHE7ZbcZAn5FfJV86/stLb76ObZ7cu41BZldRsJWuzi8i/e2I0sB3ESm07n9QOeJ
         vsqcBbuFHVNwAHde6xQiI5oXO1vL63/dxhGLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/ZjpB7n4FkhzFJT9cWI1qyNowromE99mrhGgv/JAmU=;
        b=A7PS+pmQQRFpK2pNMYfcUQqrZf0YYMhOabHuKxUYIfnDaM9Ynvvr9rT6dCZSTKFTYR
         DV21PZ+4raMwI1C7XZgdyD/qot9sJpshokP8rZ+QAiEIGDVFvJMSkg8G6Nx/FHUhdpA4
         /kJVCD1a4oSdv8M+3RDCgUztPNUtc4R5SgEIJb7rD6tEExQHbFupMZxehITkrEfcsef5
         E8lpTD/HTIZbU3T9fl0I3SdMKvRdTvkVsSl9TfFrvuO9WLnn2IMTINvDF1iGsnMYR/f+
         YkhLsy+1J0NUOCsD8tYoCsqJSP1cVlxPfrech+8HAEmuL+ew4ZWl63nTE5EHIju3zd2t
         MFGA==
X-Gm-Message-State: AOAM531lwkTHkNffmk8NQoyEdjkqLjl010gBvmzOWiANOFv6b78pDB20
        aiiokOJxzz81QyJETEnvP+BtROnmdSwJ7w==
X-Google-Smtp-Source: ABdhPJwGLeMn0T069urLQ+voAfF/NdWvBjQ/lCJuQNxMM7tgMf0i3kFXu05XOvFNIzvAvM+v32xl4g==
X-Received: by 2002:a2e:7d08:: with SMTP id y8mr1685931ljc.257.1603827576321;
        Tue, 27 Oct 2020 12:39:36 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id e21sm290951ljl.44.2020.10.27.12.39.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 12:39:35 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 2so3066047ljj.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 12:39:34 -0700 (PDT)
X-Received: by 2002:a2e:2202:: with SMTP id i2mr1623327lji.70.1603827574410;
 Tue, 27 Oct 2020 12:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <20201027164255.1573301-1-trix@redhat.com> <CAKwvOd=83v0Sv-NhQ5xgqdNSRm2b=pOJDziX8axZ9t2YyYwz-A@mail.gmail.com>
In-Reply-To: <CAKwvOd=83v0Sv-NhQ5xgqdNSRm2b=pOJDziX8axZ9t2YyYwz-A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Oct 2020 12:39:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0urcZx_TU=U5_hWEFbuwd67QV=7k7H5q7uWtvnV72kg@mail.gmail.com>
Message-ID: <CAHk-=wi0urcZx_TU=U5_hWEFbuwd67QV=7k7H5q7uWtvnV72kg@mail.gmail.com>
Subject: Re: Subject: [RFC] clang tooling cleanups
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Tom Rix <trix@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-toolchains@vger.kernel.org, Joe Perches <joe@perches.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Huckleberry <nhuck15@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 11:42 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Most recently Joe sent a treewide fix for section attributes that
> Linux pulled just after the merge window closed, IIUC.  Maybe that
> would be the best time, since automation makes it trivial for anyone
> to run the treewide fixit whenever.

Well, it worked fine timing-wise, but the fact that it wasn't in
linux-next did mean that it then hit a few small snags once merged.

It's not a big deal - I never got the feeling that that patch was
rushed or that Joe hadn't vetted it enough, and it was well worth it,
but I'm pointing that out simply as an example of the model having a
few gotchas.

So avoiding linux-next (in order to avoid merge pain) does have
downsides. And even obvious and 100% automated fixes can cause issues
if there are #ifdef's or other architecture-specific things that then
mean that the extra semicolon might matter after all. Usually for
horribly bad reasons, but still..

So it would be best if this got a lot of multi-architecture (and
multi-config) coverage if it avoids linux-next.

                Linus
