Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F9F24E0A6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 21:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgHUTaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 15:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgHUTaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:30:01 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E69BC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:30:00 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m22so3071522ljj.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9gB440Ze4ZBHaiJd3Tg8xGm277dDUwBE5I6gf2Si2z0=;
        b=WOJ24K7m95T6qyq7uMw1ZdUwa/ZY4iGih7G5ZretzrJOrNpRBizAWpzqXrw1KWVWpc
         9TkDhakIq2vNEGCc92t86ZIgDgIbr11x7Ktk8FlZyRm+v8heqUVRBJ7OMmGX9+L9XQtV
         J5Et6X/zWbSvpX6upyCYcudXQqtPQNKhJtMC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9gB440Ze4ZBHaiJd3Tg8xGm277dDUwBE5I6gf2Si2z0=;
        b=iRz6bSuPa9AJoJy68KxVTg0hc061h2zZwxDKVNsbGsYT2sl2aNEqcl4Aa5nIwWo/so
         KXB7JET2VIzWLmDuh+/m65ZJiQ4dBCF+K6no6FUCwOqFXSBisAxMozWvCQyI/2rzUfKK
         h7uXSePk8oAjolTR6QW7yWmUAe0NWT+01e9U2AkYRQjTsH/OwhM+0rKBhFmZKUDMuYxo
         BPc0zHOia00uBhGYH7Sk4SjNht/eLHKfNSLD5xwkiDXf7JgQsV0NyqJW4LX8Spk8XxVl
         6KAZO6wQfKgwJ/LmrLn8T+fWxPQZ1iKgJ5XFeZ+GJnJ7x7+QJQy/qp9XBs9cHCbnpSxa
         fPpQ==
X-Gm-Message-State: AOAM533x7k3UIN8iwN1QSEqSQIYoB71jEFts9xsWPh/nTm+ASyl9/xA3
        cN8exwF8xsQb3sDaNb0mWXnMg5yCAo3nmw==
X-Google-Smtp-Source: ABdhPJyOwIvAGo88yZqJ6ZS1ta9NQJpzdG+F8ASBsfInlBQ1hQBSNJsq0+ALuTwSQqNLcMX82ubfIA==
X-Received: by 2002:a05:651c:1343:: with SMTP id j3mr2016036ljb.112.1598038198025;
        Fri, 21 Aug 2020 12:29:58 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 20sm570387ljj.51.2020.08.21.12.29.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 12:29:57 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id v9so3074394ljk.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:29:57 -0700 (PDT)
X-Received: by 2002:ac2:58d5:: with SMTP id u21mr2053187lfo.31.1598037806053;
 Fri, 21 Aug 2020 12:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200818202407.GA3143683@rani.riverdale.lan> <CAKwvOdnfh9nWwu1xV=WDbETGiabwDxXxQDRCAfpa-+kSZijb9w@mail.gmail.com>
 <CAKwvOdkA4SC==vGZ4e7xqFG3Zo=fnhU=FgnSazmWkkVWhkaSYw@mail.gmail.com>
 <20200818214146.GA3196105@rani.riverdale.lan> <df6c1da4-b910-ecb8-0de2-6156dd651be6@rasmusvillemoes.dk>
 <20200820175617.GA604994@rani.riverdale.lan> <CAHk-=whn91ar+EbcBXQb9UXad00Q5WjU-TCB6UBzVba682a4ew@mail.gmail.com>
 <20200821172935.GA1411923@rani.riverdale.lan> <CAHk-=wi8vdb+wo-DACDpSijYfAbCs135YcnnAbRhGJcU+A=-+Q@mail.gmail.com>
 <CAHk-=whjVCTjZG0Y88WhJruLdbxF=7q3mmFThD+N5WK0P5giSw@mail.gmail.com> <20200821191458.GA1475504@rani.riverdale.lan>
In-Reply-To: <20200821191458.GA1475504@rani.riverdale.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Aug 2020 12:23:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjX6jaRH+yozTh3kV3ocF2Qv0v96o8JofvbV6=U_K2mXw@mail.gmail.com>
Message-ID: <CAHk-=wjX6jaRH+yozTh3kV3ocF2Qv0v96o8JofvbV6=U_K2mXw@mail.gmail.com>
Subject: Re: [PATCH 0/4] -ffreestanding/-fno-builtin-* patches
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        =?UTF-8?B?RMOhdmlkIEJvbHZhbnNrw70=?= <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Axtens <dja@axtens.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Yury Norov <yury.norov@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Marco Elver <elver@google.com>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 12:15 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> How are you testing it?
>
> https://godbolt.org/z/eahdGn

Ugh. I tested the reverse thing - that the builtin is still available
for manual use despite the -fno-builtin.

Because I - stupidly - assumed that fno-builtin would do *something*.

But if it's available for manual use _and_ it's used implicitly by the
compiler, then that was clearly very naive of me.

                     Linus
