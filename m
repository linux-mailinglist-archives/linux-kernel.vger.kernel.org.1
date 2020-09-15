Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8454726B394
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 01:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgIOXFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 19:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgIOXFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 19:05:22 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA1DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 16:05:21 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 7so2771408pgm.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 16:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S5KmI53f3KHMFavKkBNkcps6Xx80r3fYm9P+l0f83X0=;
        b=QoUUESYk7Kw1Q2iPemo3iG0eInZpKexPjg+o6frhBsFPuL9L4X+25/f7vWSEcPdKEN
         57RgMTTaH9NEjea2QlR4lvZHNJ18jQbx+9qajiO4U65SuLXnhYpZQ1dbeOqj9sCfMStx
         XcNG9afjfajdQ8R3uRRxlflyGRpPmIZQJu6oiofcGSZ+q7lyp51qe74Z811hFjXFxst2
         MDUb+1jy3+9mEy20uX+bTrYg2qb5LaJ/JigCqCiPg0HVhw7vq97Mlk/RrDLDjDUZfgv6
         SV5XE7N7ETCzAp2AR3FmproErmDJABp9MXA1hF2q+G/E2maquMVzPWsXANWShdEU90dk
         0cPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S5KmI53f3KHMFavKkBNkcps6Xx80r3fYm9P+l0f83X0=;
        b=GnUd6x0Ueqb+rmN33Pze2bDk6UiWzv4tNJOXIuEDuMRShPdX5KBPSLt9LC/2A+BsrL
         JqmtGxesaIqTZ4aj2Ty7m9asj5doZHmv8Qy+kSIwv+Nu3hvDQC+DqO7nirNVTDuO80u0
         H7+U+Nb/fToAsQh5hEMGkhcKAYbTYr6/dZZqH2AxD1Jei2zznzeYP1e9jnHCrrN3FMda
         oVRcuo3FgR+6pGFaXiIScIpSWrgkcUO3Rhq3HhfewAHuwRn34fkQ1H+kolnEcXfyACbE
         iKM9KaaXkbJAde3rqc6znd4nj4MotSqmyckILHxziX9bpJIOLEV+PT7Y8UPMB56F16tJ
         43Tg==
X-Gm-Message-State: AOAM5325r9YF4Tw78A3VHgZV5cnTsZk1F7eKAEYw6fdZVSkglHhOUt4O
        k3rsiSImvpbpCbxSnIql8p8llOxzAIj1JxoN2Bv44w==
X-Google-Smtp-Source: ABdhPJxl7l7gn+EyvsleuLt+OxvpTEYdMC75KYT0r9iCS8WJirUSRmOznia7YRIsv1bO7+LSF7oB/WJwrDSN7wS2b7o=
X-Received: by 2002:a62:d44e:0:b029:13c:1611:652f with SMTP id
 u14-20020a62d44e0000b029013c1611652fmr19903521pfl.15.1600211120970; Tue, 15
 Sep 2020 16:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200914160958.889694-1-ndesaulniers@google.com>
 <20200914161643.938408-1-ndesaulniers@google.com> <20200915042233.GA816510@ubuntu-n2-xlarge-x86>
 <5a9007605dec96c81ec85bc3dcc78faaa9ed06a0.camel@perches.com>
In-Reply-To: <5a9007605dec96c81ec85bc3dcc78faaa9ed06a0.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Sep 2020 16:05:08 -0700
Message-ID: <CAKwvOdn6ohOi-KSSOkC8BirHgXRRkbCk3Z_ySEyPPMg31cDB-A@mail.gmail.com>
Subject: Re: [PATCH v5] lib/string.c: implement stpcpy
To:     Joe Perches <joe@perches.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 9:28 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2020-09-14 at 21:22 -0700, Nathan Chancellor wrote:
> > It would be nice to get this into mainline sooner rather than later so
> > that it can start filtering into the stable trees. ToT LLVM builds have
> > been broken for a month now.
>
> People that build stable trees with new compilers
> unsupported at the time the of the base version
> release are just asking for trouble.

It is asymmetry that we have a minimum supported version of a
toolchain, but no maximum supported version of a toolchain for a given
branch.  I think that's a good thing; imagine if you were stuck on an
old compiler for a stable branch.  No thanks.  I guess we just like to
live dangerously? :P

Also, GKH has voiced support for newer toolchains for older kernel
releases before.  Related to this issue, in fact.
https://lore.kernel.org/lkml/20200818072531.GC9254@kroah.com/
--
Thanks,
~Nick Desaulniers
