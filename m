Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73452A4F51
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbgKCSsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 13:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgKCSsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:48:38 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CCEC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 10:48:38 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 72so8340232pfv.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 10:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5esmZTIDSPwFgm48WzjRwJqywpsnP/cE9qQCx6CwSYI=;
        b=rTsKDoMEipZMnCwU25maQ3Gkaq5rJG6y1YtHwrYo7AkjXjeUgATobH1MOFSAcU9QU3
         51lP21kpghehflvd9HwTJTOj39G6SuYQoAnd2aG/TjdVc7SK34FSnY5fq+BYEFAbMkfZ
         OsRFv1SdupXBD8+rW/ESZsXge/kt/hqZmN8QX+TmRm/1lP75TuXoNU1bjxRohqnQmlEV
         fh2qkuxJtnZpJgtXcyuAvFjQzWFHeV31Gdqv9D84AZfK+peSGFGKny7xg8QShJOa81hP
         utKqd14h6ilxIOGfPQXwVUBIKkhqAghaWk60wn4xBh70buRLvr7/luK+KuunlPVjlZzB
         wX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5esmZTIDSPwFgm48WzjRwJqywpsnP/cE9qQCx6CwSYI=;
        b=Vfj/SPbfQgi23Qgnb2bvJ7i7F+Q7nU9pdsrLb+ZpdC+TmJcCKx/e9P6tHpbhVC5zO+
         CKlinX0PhuvtKIaFHfgJMJjNIOWVgCUJAAUWrQGKAR0DzOmkfPHz3kxh6vKvvtY+L+01
         UUqe68z+muaNKPs65DyaLmvSzUc7QzDWX2zz6Clf5gjCVJHHaHFyefUPAt7kRkfxAW1+
         0+xMXBTVRwBR54Wyzd21hZ8HJqgcWhouoown2VOmXBkEtW+/h+B5P6ZuU0yRPcDbiCzV
         2G99Yx8nuN0QLG/7YFfZOWd+WW67FCjPMiiEKz/Sftm7R+b8ii1XZBrFdTrf6mRwV2k6
         GyJg==
X-Gm-Message-State: AOAM533riD5l9FgS0TCzVVTjFWT0rebPsyrc2aAU1XkUt/KEI1d6P0T7
        wIMXIfdr2n5ZVZNzPNKcysZ9I0A1Mdg23tQc7BDUiQ==
X-Google-Smtp-Source: ABdhPJxHqEhYpzELZQINdDfc267jcT1mMqqQ/2JBGDMJHmHonMIT3+XAdUMVZ7MH2NcwnVCh5VNgLZaGtaizV8Yxt44=
X-Received: by 2002:a17:90a:d486:: with SMTP id s6mr622007pju.32.1604429318312;
 Tue, 03 Nov 2020 10:48:38 -0800 (PST)
MIME-Version: 1.0
References: <20200902225911.209899-1-ndesaulniers@google.com>
 <20200902225911.209899-2-ndesaulniers@google.com> <20201103045521.GA58906@kernel.org>
In-Reply-To: <20201103045521.GA58906@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 3 Nov 2020 10:48:27 -0800
Message-ID: <CAKwvOdk-bMx3Jt6=oN=PHqRv_tx5cF=9cVmumazb4vMNHdj5Ag@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] compiler-clang: add build check for clang 10.0.1
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 8:55 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Wed, Sep 02, 2020 at 03:59:05PM -0700, Nick Desaulniers wrote:
> > +#define CLANG_VERSION (__clang_major__ * 10000       \
> > +                  + __clang_minor__ * 100    \
> > +                  + __clang_patchlevel__)
> > +
> > +#if CLANG_VERSION < 100001
> > +# error Sorry, your version of Clang is too old - please use 10.0.1 or=
 newer.
> > +#endif
>
>
> I'm trying to compile a BPF enabled test kernel for a live system and I
> get this error even though I have much newer clang:
>
> =E2=9E=9C  ~ (master) =E2=9C=94 clang --version
> Ubuntu clang version 11.0.0-2
> Target: x86_64-pc-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
>
> Tried to Google for troubleshooter tips but this patch is basically the
> only hit I get :-)

To check the values of the above preprocessor defines, please run:
$ clang -dM -E - < /dev/null | grep -e __clang_m -e __clang_p

If you have multiple versions of clang installed, you might not be
running the version you think you are.  Particularly, if you're using
bcc, idk if it includes a copy of clang?  If that's the case, we may
have to work out how we can support older versions of clang for the
express purposes of bpf.
--=20
Thanks,
~Nick Desaulniers
