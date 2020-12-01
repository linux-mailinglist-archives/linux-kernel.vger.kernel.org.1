Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F6F2CACDD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbgLAT5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLAT5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:57:14 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597B0C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:56:34 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id v1so1920419pjr.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wNrUoO5GhGjJ+F0ga/x1uzDpCFyyeAqcGZvey2hPlFA=;
        b=C70FTDvUfhgCOJfzTxUA5eEUmvVh0GQGj2pAVU9HmbC/YznEBWoEUH9FNJwDRm4ouu
         yTVSK0/sAqW6YZ/IDDB0Y+sDeW+YcWxqo8Of+BSpxImWP0hxbHBQMYae8E5RMew7reWX
         JmxzA82GJnHtHuYCmeZwTp3vc1Ypt5tK9QpIc3Qv1GCm6RxNFoc8C/5rmdVVmiASEBRl
         0XiFtWFykza4PvjOIcNtJDwSz/yJhjjaRm659ZFKfsBKEZ0l5W+j/2IOMphwM/mbeeTi
         eoR0Ao9X5szwLJRIYwZcYAgJPtJOfTd8t0oeM7p1fvo6aXjil0MLGFAfpVkgR6Vpmq3R
         84jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wNrUoO5GhGjJ+F0ga/x1uzDpCFyyeAqcGZvey2hPlFA=;
        b=qJYsp3fSu6YFoG9is+DGpm9dMuF8eX0V3H8AeQjxDx5/xWh+HowkSFfPyPI4fHFznt
         JfryKmqE+MH9Rw+Pox5Gsi5cNTPgT5w1bqo2zBIFmk5hW/4O57BwtLGrw2WdIt42wF3e
         R8CTiVpwiGC86bd36ONep8OQX2m+Gbm0E26MKKEJ7Qc1e9N37SlQjFvCiAILaw/yRzDr
         KkNfOxQxn7ds7ZEkpcdAJt/7AuXEsAYTIyLTvfPsdBTKkgJtRyi2XnrT6CvwIXTP6afa
         20x0IFngXBz+psjDk49uLs7JT09dIcS5PRi48wZdhZpY8bVV3LHZKCTD+vUR901ga1Qd
         91Ug==
X-Gm-Message-State: AOAM5308A74LxG5SPE8qnKmQK01goCW6aLgXfOxezCzqxYaC+Wlyr1SC
        MTjU5PH6zmIvIkoLJPXP2oHZ6R1a26hj/lePzHKP8Q==
X-Google-Smtp-Source: ABdhPJxpcDc6ufvuBegVL6oa+h2CuIjnaWMgHccWQjKvjwXwUF7GYmiZJXrocMXXMLjjglDJEsKqR6vXwPwYYdy6VZU=
X-Received: by 2002:a17:90a:dc16:: with SMTP id i22mr4567464pjv.32.1606852593726;
 Tue, 01 Dec 2020 11:56:33 -0800 (PST)
MIME-Version: 1.0
References: <20201201152017.3576951-1-elver@google.com> <20201201161414.GA10881@infradead.org>
 <20201201170421.GA3609680@elver.google.com>
In-Reply-To: <20201201170421.GA3609680@elver.google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Dec 2020 11:56:22 -0800
Message-ID: <CAKwvOdkhBTjjtEm9dc9irp8hpWoEDEAMj_Zp4ntKspgDkjrATg@mail.gmail.com>
Subject: Re: [PATCH] genksyms: Ignore module scoped _Static_assert()
To:     Marco Elver <elver@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>,
        George Burgess <gbiv@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 9:04 AM Marco Elver <elver@google.com> wrote:
>
> On Tue, Dec 01, 2020 at 04:14PM +0000, Christoph Hellwig wrote:
> > Why not use the kernels own BUILD_BUG_ON instead of this idiom?
>
> BUILD_BUG_ON() was conceived before there was builtin compiler-support
> in the form of _Static_assert() (static_assert()), which has several
> advantages (compile-time performance, optional message) but most
> importantly, that it can be used at module/global scope (which
> BUILD_BUG_ON() cannot).
>
> From include/linux/build_bug:
>
>         /**
>          * static_assert - check integer constant expression at build time
>          *
>          [...]
>          *
>          * Contrary to BUILD_BUG_ON(), static_assert() can be used at global
>          * scope, but requires the expression to be an integer constant
>          * expression (i.e., it is not enough that __builtin_constant_p() is
>          * true for expr).
>          [...]
>
> .. and there are plenty of global/module scoped users of it already.

And to proactively address the inevitable: why do we have both?  We
looked into wholesale replacing BUILD_BUG_ON's implementation with
_Static_assert, but found that they differ slightly in the handling of
integer constant expressions; BUILD_BUG_ON was reliant on some
compiler optimizations in expressions making use of
__builtin_constant_p that cannot be evaluated when the compiler
performs the _Static_assert check.  So the current implementation is
more flexible for expressions that use __builtin_constant_p than
_Static_assert is.  If we needed a rule of thumb, I'd recommend "use
_Static_assert unless you're passing an expression that relies on
__builtin_constant_p evaluation, at which point BUILD_BUG_ON must be
used."
-- 
Thanks,
~Nick Desaulniers
