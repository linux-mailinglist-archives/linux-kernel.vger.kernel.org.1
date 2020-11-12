Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F902B0829
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgKLPJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgKLPJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:09:38 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E29C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:09:38 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id 199so5487634qkg.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CoGYL/qpX4DTdicVvMAnSSNFSp8J2Bcqtm1uW4R8eNw=;
        b=gnR8Ce66rzxuhfKbOZw6yNQHhGoSSDN1NJC+WZJoHdZBKxgZVJWg48QvKpsf/ZxcgQ
         njRphhUsypMHg597vVPRfY5FoMuM7BJ0yZMIycYXJ2ne8mhVsQWnTtr+tLDO11YTcDsd
         KRKTH2wxQhz1ondJZZY7PasdcvcO3bvOu3crpiD6xzPtKrojBbZ8Csfryh63M7WksKkg
         jUsa2sjJIoqinl3AYVaMZUpqVg1GqyFp6LyqPthkD/q+zaAME5Li0PuvWLcgT06eb3IP
         ID+qGpkICMB0ymlNd4tuTOXgDwtBooZqotNURoVQfHJKtb/jRYNDf3FNUPyOZZmB2ZBc
         rWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CoGYL/qpX4DTdicVvMAnSSNFSp8J2Bcqtm1uW4R8eNw=;
        b=Rtih3reqGyjxKLabMRBRYmZ0+Qv1VUMJBeK5HP/SzSUY9KfvGd9vEeW20dNcBtcKbl
         pWYslil7dVOQtfHWIBSt/uWde6jFjlMmbINjX4KkxVTQyfFtskG2A7I4e6clT6M+sKhP
         rf+15QtboO1hrhyLex+7Qau04JvvG/aBjqjrTtF3rMxLPVhma3nC+bpAGtOPZZoct1Uh
         8NfXPiV8WITh/S7UwUFRtnprHdbkWqhQ7VCOKgykGy/h4a+mMdj3sbPvH4t6eCe02Xp8
         lGGNvXoCjI9frnQUudO3ofD7aKlAclflYsoPkqYF1O+3nzE7jzbvw4mxF/N9gnxvm+3Q
         AwTA==
X-Gm-Message-State: AOAM531lie9wLHStpjLfwC6yW4jvoiSzheKZS38hbTuIiwPzESKyi3Iu
        lzuh79yrGwTfO9WNz9jqW1XBJx8UvUPKOSmba14F9Q==
X-Google-Smtp-Source: ABdhPJyoRTmzJUSMlMiQQcxVEqJ/8FJ/nWh57GUiA27VdMzgblETurxtH9pp4CGtm5ZNBg+WajX37g8EsWwWVOK70TI=
X-Received: by 2002:a37:b545:: with SMTP id e66mr183119qkf.392.1605193777579;
 Thu, 12 Nov 2020 07:09:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <619cb0edad35d946c4796976c25bddb5b3eb0c56.1605046192.git.andreyknvl@google.com>
 <CAG_fn=UKSp8shtYujRbM=8ndhLg_Ccdpk9eSfOeb=KpwNi7HBg@mail.gmail.com> <CAAeHK+zh6tOh91Dg4n4NrJwdPWRaDEtz_Btitg8viQQk7Zm_JQ@mail.gmail.com>
In-Reply-To: <CAAeHK+zh6tOh91Dg4n4NrJwdPWRaDEtz_Btitg8viQQk7Zm_JQ@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 12 Nov 2020 16:09:25 +0100
Message-ID: <CAG_fn=Vs35BOdyg1BUmLWEK3SzMT7z9_otMtu_BJbz4dTXVyag@mail.gmail.com>
Subject: Re: [PATCH v9 17/44] kasan, arm64: move initialization message
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 7:50 PM Andrey Konovalov <andreyknvl@google.com> wr=
ote:
>
> On Wed, Nov 11, 2020 at 4:04 PM Alexander Potapenko <glider@google.com> w=
rote:
> >
> > On Tue, Nov 10, 2020 at 11:11 PM Andrey Konovalov <andreyknvl@google.co=
m> wrote:
> > >
> > > Software tag-based KASAN mode is fully initialized with kasan_init_ta=
gs(),
> > > while the generic mode only requires kasan_init(). Move the
> > > initialization message for tag-based mode into kasan_init_tags().
> > >
> > > Also fix pr_fmt() usage for KASAN code: generic.c doesn't need it as =
it
> > > doesn't use any printing functions; tag-based mode should use "kasan:=
"
> > > instead of KBUILD_MODNAME (which stands for file name).
> > >
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Reviewed-by: Alexander Potapenko <glider@google.com>

> > Cannot we have a single kasan_init() function that will call
> > tool-specific initialization functions and print the message at the
> > end?
>
> Unfortunately no. For different modes we need different functions that
> are called in different places in the kernel. E.g. for generic KASAN
> we only need kasan_init() to setup shadow pages; for SW tags we also
> need kasan_init_sw_tags() which initializes per-cpu state and
> finilizes initialization process.

Ok, got it.

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
