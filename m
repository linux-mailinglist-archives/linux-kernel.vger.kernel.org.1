Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAB82EC612
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 23:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbhAFWNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 17:13:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727650AbhAFWNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 17:13:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05C5523142
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 22:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609971155;
        bh=l0h47PrTK+7sbOlxLanv6k+YDQ92GZKtuNEme2MpWjo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j66kdD6vBHfHeoYG5y63Qe+W8aNT82nSjXAgjR7Zr25bTa6QdVXLFjqnfUODaWcSK
         ZONpKYRuLu/k5UXvKJyNdRGmemzonJSfzbyan0cu1AkRnr/ARIOCNzqKPyMhlQyWwd
         Ne6+vPlWj95/wnsKFynxv313gO1g1CWhtFa06afgzjPhEItmTnTDrm9xcwBI2FoqCr
         EmRlqz1aZLIKGkTUxdGomrEj6BzMxCjzghm9JJdmpllME+LdQfgkZNcf9xdE2wx1cw
         n5GGidKteGA/l3h048Rarr2XN/UWg/dmSILIi1SL+UWPHVelP4iOkRZM5KjX6vthqS
         6KhzwJ7WoWAYQ==
Received: by mail-oo1-f42.google.com with SMTP id s19so1130152oos.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 14:12:34 -0800 (PST)
X-Gm-Message-State: AOAM533xsid9SKWYTGDBdV4sdIa5xGvxvEYskGiAsNRBZjJuIrX3uCKl
        2PqmXLQB5p65gec90FO5PKT9VQiNS96v5hvY8+o=
X-Google-Smtp-Source: ABdhPJyFCMU/FiooG5bydtj7jM/uhsSReMwQHnhOTKmfCJK3sZrTJ6C7D+X9PutTMCIXzaAtKvldDlFMTimT2duKYpU=
X-Received: by 2002:a4a:9c01:: with SMTP id y1mr4209442ooj.15.1609971154230;
 Wed, 06 Jan 2021 14:12:34 -0800 (PST)
MIME-Version: 1.0
References: <20201230154749.746641-1-arnd@kernel.org> <202101061350.913E1FDF6@keescook>
In-Reply-To: <202101061350.913E1FDF6@keescook>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 6 Jan 2021 23:12:18 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1tSaUE2uzb2JbQ1f7LWmkiHQtSxzJHmfa=fqT3fNXOPA@mail.gmail.com>
Message-ID: <CAK8P3a1tSaUE2uzb2JbQ1f7LWmkiHQtSxzJHmfa=fqT3fNXOPA@mail.gmail.com>
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

On Wed, Jan 6, 2021 at 10:57 PM Kees Cook <keescook@chromium.org> wrote:
> On Wed, Dec 30, 2020 at 04:47:35PM +0100, Arnd Bergmann wrote:
> > diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> > index 8b635fd75fe4..e23873282ba7 100644
> > --- a/lib/Kconfig.ubsan
> > +++ b/lib/Kconfig.ubsan
> > @@ -122,6 +122,8 @@ config UBSAN_SIGNED_OVERFLOW
> >
> >  config UBSAN_UNSIGNED_OVERFLOW
> >       bool "Perform checking for unsigned arithmetic overflow"
> > +     # clang hugely expands stack usage with -fsanitize=object-size
> > +     depends on !CC_IS_CLANG
> >       depends on $(cc-option,-fsanitize=unsigned-integer-overflow)
>
> Because of Clang implementation issues (see commit c637693b20da), this is
> already "default n" (and not supported under GCC at all). IIUC, setting
> this to "depends on !COMPILE_TEST" won't work for randconfigs, yes?

Ah, I had not realized this is clang specific. Adding the !COMPILE_TEST
dependency would hide it for me, which may be good enough for me.

> Is there some better way to mark this as "known to have issues, please
> don't include in randconfig?"
>
> I'd like to keep it around so people can continue to work out the
> problems with it, but not have unexpecting folks trip over it. ;)

I've reverted that patch locally now and default-enabled for randconfigs.
Now that I have an otherwise clean build, this should provide me
with a full set of files that produce the warning. If the number is
small enough, I could try opening individual github issues.

      Arnd
