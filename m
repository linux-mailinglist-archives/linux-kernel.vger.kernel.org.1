Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E512EC6FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 00:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbhAFXlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 18:41:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:51246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbhAFXlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 18:41:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2757C2333B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 23:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609976440;
        bh=XOiJj+aIAGnC0jZGbQLlZOvHWe5wTw0/+J5P7xkZwX0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UAMnwaB6o+JwXiwksrAmeW979rrIGuvZgv+5DUP5gzQwPWBpt8/WmlXeImtv4P/Zn
         +wlNalsHsflksplnLfUtlC3uo2dFupvhMLuhMVVNl3byrutCcg0UyeNYb7N1PdDbm/
         o7b2Od2QDID6R5fkpvCox+7xF6MGW/eFZrQ9GcSVs/r+9fUny0yLTkqiYNqxbZ+ABt
         oItasfWLRftcA1wbuEhwXXinW7gOssFfRkKZf9+MmKCFb1kN/ENuDm7pSACYg6nMgq
         fg2ejhm+VrxtAZ/wjk5x3ClI7K07KYsnQCWNgyHVk69Z7ueOkzSoOxhw3EHHvlmrJV
         tP71J9gU69k4g==
Received: by mail-oo1-f45.google.com with SMTP id j21so1162470oou.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 15:40:40 -0800 (PST)
X-Gm-Message-State: AOAM531sfxOQ48t9hO8p/LQTvmL1PsEb+SYulZkAQCAKjvtQWkTlih5R
        Eibe6GwVgTESHbkx77CRMgPbCwuLqHx3LoPBkSA=
X-Google-Smtp-Source: ABdhPJzYP6hnb9oZ6wNpyv1Ub1x5f7idyWyyO81h4gsobHr4M5F25gNOrLSWibc5FTpJRLu/sPOeUdaeyBQi+Do+3C4=
X-Received: by 2002:a4a:9c01:: with SMTP id y1mr4394668ooj.15.1609976439445;
 Wed, 06 Jan 2021 15:40:39 -0800 (PST)
MIME-Version: 1.0
References: <20201230154749.746641-1-arnd@kernel.org> <202101061350.913E1FDF6@keescook>
 <CAK8P3a1tSaUE2uzb2JbQ1f7LWmkiHQtSxzJHmfa=fqT3fNXOPA@mail.gmail.com> <202101061516.F0EA5F0@keescook>
In-Reply-To: <202101061516.F0EA5F0@keescook>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 7 Jan 2021 00:40:23 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1KUr-zOvxc0hN0yDC7r+HTM_FGrr5GkuSTTNchgQ0PzA@mail.gmail.com>
Message-ID: <CAK8P3a1KUr-zOvxc0hN0yDC7r+HTM_FGrr5GkuSTTNchgQ0PzA@mail.gmail.com>
Subject: Re: [PATCH] ubsan: disable unsigned-integer-overflow sanitizer with clang
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        George Popescu <georgepope@android.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 12:17 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Jan 06, 2021 at 11:12:18PM +0100, Arnd Bergmann wrote:
> > On Wed, Jan 6, 2021 at 10:57 PM Kees Cook <keescook@chromium.org> wrote:
> > > On Wed, Dec 30, 2020 at 04:47:35PM +0100, Arnd Bergmann wrote:
> > > > diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> > > > index 8b635fd75fe4..e23873282ba7 100644
> > > > --- a/lib/Kconfig.ubsan
> > > > +++ b/lib/Kconfig.ubsan
> > > > @@ -122,6 +122,8 @@ config UBSAN_SIGNED_OVERFLOW
> > > >
> > > >  config UBSAN_UNSIGNED_OVERFLOW
> > > >       bool "Perform checking for unsigned arithmetic overflow"
> > > > +     # clang hugely expands stack usage with -fsanitize=object-size
> > > > +     depends on !CC_IS_CLANG
> > > >       depends on $(cc-option,-fsanitize=unsigned-integer-overflow)
> > >
> > > Because of Clang implementation issues (see commit c637693b20da), this is
> > > already "default n" (and not supported under GCC at all). IIUC, setting
> > > this to "depends on !COMPILE_TEST" won't work for randconfigs, yes?
> >
> > Ah, I had not realized this is clang specific. Adding the !COMPILE_TEST
> > dependency would hide it for me, which may be good enough for me.
>
> I thought COMPILE_TEST does not get set for randconfig?

It does on my kernel, though I never submitted that patch ;-)

        Arnd
