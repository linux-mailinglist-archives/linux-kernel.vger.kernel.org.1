Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EB225B464
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 21:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgIBT2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 15:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgIBT2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 15:28:21 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D054C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 12:28:21 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h12so168214pgm.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 12:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ow1ubksHg2fW7r+dLInAj3bLacIWDt2iKSFX/lPoWI=;
        b=oxn45NiKqloVSGS5JH3/3SwkVezuia8rHntWvKPtBaPV0aW7ZfIid4c8lVPK7H2Jx4
         DHdaYxSQNxnuGN14cpSVzkz3QJPeJJkPfF8LiGHpez+tvIcEPUd7BfCxn1Fd6kYcgSpe
         fHXGHbQWhypou1gH4oghjCMIeOeYx9VImDf7skvfmkgK9Ygs3CY3Vzi06X+A2kGopGJ4
         Y0vHpXsBCV6CWPX2X0vsWFmCjwKmO0a3kEEqEXaemdctuu2qpqOlL7WjS8mwayxBvLd9
         URKkmtAk+HgQiA/GrNqJwemHTwPNo7kkUbiIAJsxBFkbon4HmXS2j9J4s1tQ3/BjaLgV
         TVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ow1ubksHg2fW7r+dLInAj3bLacIWDt2iKSFX/lPoWI=;
        b=rKK91CFZG/xdJd+yd1wFCQre9niG+S/urRdln6s6glcyLOkeeHhFdFWxd53TPNlAxy
         WmMJcF+FKP68/nkn3ys2y3YDv1F570oCKJGFU+HU5DcwB7JYZrvdmTB+OkDJRqOd7jgI
         txlmNad+1XVJyWF2lkUQe8yQAFadnZ9/S/xVH/Rol+1sBtJvV2fs1Vamkevjtnt2TPF6
         C6pN178EtdEF/c59HdA7Ag5p2RJlLbZ0/ncAAr7S4nyD59Yt0xOJTxCU9OzPdOgxU5Is
         xBpnVq51e/DjwUWz5glayptHGxdM7+lVrCv8f3nUClnp+OJBxKidWuHm8aN6MO3I+Tut
         +ixg==
X-Gm-Message-State: AOAM531Ee/dFKnrZPeUGkCO1cVDzf1I65NkpvMWEzMaul8ogdrluZncz
        XlThBMDcLSV7BDptJYVKVW/92exx5mF/RCpFKdlG9Q==
X-Google-Smtp-Source: ABdhPJy0tlS63y55UqhNg1LfoDiFRWnEGQsCGw75DnDFSLSpXLAsR0Piyb1fMk30LM15kxbAmkzq/sOq188SsHHg/H4=
X-Received: by 2002:a63:9d09:: with SMTP id i9mr2941158pgd.381.1599074900374;
 Wed, 02 Sep 2020 12:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200901002326.1137289-1-ndesaulniers@google.com> <202009011255.5BBF4F31F1@keescook>
In-Reply-To: <202009011255.5BBF4F31F1@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 2 Sep 2020 12:28:09 -0700
Message-ID: <CAKwvOdmq7d4PhKH28HhbiNDhk4qoAT1n0TobQiNe+7_PapVTYA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] set clang minimum version to 10.0.1
To:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 1:01 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Aug 31, 2020 at 05:23:19PM -0700, Nick Desaulniers wrote:
> > Adds a compile time #error to compiler-clang.h setting the effective
> > minimum supported version to clang 10.0.1. A separate patch has already
> > been picked up into the Documentation/ tree also confirming the version.
> >
> > Next are a series of reverts. One for 32b arm is a partial revert.
> >
> > Then Marco suggested fixes to KASAN docs.
> >
> > Finally, improve the warning for GCC too as per Kees.
> > [...]
> >  8 files changed, 16 insertions(+), 27 deletions(-)
>
> A nice simplification!
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> (I do note that for Ubuntu 20.04, they're going to need to do an LLVM
> 10.0.0 -> 10.0.1 bump to do kernel builds for their latest LTS...)
>
> --
> Kees Cook

I'll collect relevant tags and fixup feedback and send akpm a v3,
maybe this afternoon.  Thanks everyone for the reviews+feedback.

--
Thanks,
~Nick Desaulniers
