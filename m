Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D402EE717
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 21:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbhAGUmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 15:42:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbhAGUmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 15:42:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4467D23444
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 20:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610052087;
        bh=quFeoS85KK6uAfqcXYRLfEGPpBGjuv76Ns9tqjYkT7k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dFVG6+/jZ7czQ+YIq9S1Dq4kc64QJh8XwChO67CtzNBtcvwb1OCzIPlWK9EllSppf
         h2J6uiCWkazQvzusHwVi4tj5SvB9Rm8aquDQHq6mF4i8LKgnHyVTdKIvqNqLPAtaGH
         HcnSvXGcZQcjt8OhzmrcknrOC07aDnUW8lZ/BIgq6sVaH/sx7454whrINuGEXMkbo2
         fIiGKu8H1/z0ga4pI9X+r/RSqOQ7sDJmWIey1nfgQPLaSXEyiFwknab/pzbexyEjuT
         eA7Q3ReJQyGW17kt8p//Ys+TtXBKhi1Zr3016bQjm1VMlOwmTDIi1iGdlpyLkuLl5C
         DNK3PygnSGQJA==
Received: by mail-oi1-f174.google.com with SMTP id x13so8853966oic.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 12:41:27 -0800 (PST)
X-Gm-Message-State: AOAM530Wp/kXxWlBEh3WPr4Ll6P9C+Dc3QzzJmOnCNFaZocoitqQ6avR
        Turz0HUVZ4EbQLlDi7RXt5c+i5xffS+BGlEjsxM=
X-Google-Smtp-Source: ABdhPJzxOcEyOMt7IRgTDYVXYei266YqeADBZDkeZsm1rOiXSmJqikTCy3doGwuzXJuNsG+Jv6HRLB7zJqig9ptQu70=
X-Received: by 2002:aca:fd91:: with SMTP id b139mr258112oii.67.1610052086633;
 Thu, 07 Jan 2021 12:41:26 -0800 (PST)
MIME-Version: 1.0
References: <20201230154749.746641-1-arnd@kernel.org> <202101061350.913E1FDF6@keescook>
 <CAK8P3a1tSaUE2uzb2JbQ1f7LWmkiHQtSxzJHmfa=fqT3fNXOPA@mail.gmail.com>
 <CAK8P3a220+yeN8_PjS-jzA85m7QPbqn0oxEqjCzVR9S7p4LaZg@mail.gmail.com>
 <202101070919.2E20432140@keescook> <20210107181547.GA436377@ubuntu-m3-large-x86>
In-Reply-To: <20210107181547.GA436377@ubuntu-m3-large-x86>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 7 Jan 2021 21:41:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1RZ3yUjG6eHKFh9E2fV9xkUtviGCQCaROOw-Sna7XCyA@mail.gmail.com>
Message-ID: <CAK8P3a1RZ3yUjG6eHKFh9E2fV9xkUtviGCQCaROOw-Sna7XCyA@mail.gmail.com>
Subject: Re: [PATCH] ubsan: disable unsigned-integer-overflow sanitizer with clang
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
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

On Thu, Jan 7, 2021 at 7:15 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
> On Thu, Jan 07, 2021 at 09:22:00AM -0800, Kees Cook wrote:

> > I think this is:
> > https://github.com/ClangBuiltLinux/linux/issues/256
> > and that bug needs re-opening? Or maybe there's a new bug I can't find?
>
> The problem is that applying the fix for that issue does not work, nor
> does converting p4d_index to a macro like mips and s390. I am not sure
> what exactly is going on there, it appears that clang cannot reason
> about ptrs_per_p4d because it is an extern variable with no assigned
> value in its translation unit?

Right, I tried the __always_inline trick already and concluded the same.

       Arnd
