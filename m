Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D66621BFCE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jul 2020 00:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgGJWbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 18:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgGJWbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 18:31:21 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA75C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 15:31:20 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q7so8166516ljm.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 15:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ylUmvhX6MYRi6Lzt+ERLlRxoNBMnVFwPcX/4GYDixbQ=;
        b=GvrgqBQCzjZRZpf67abT/azNraXd5m9yHs1v9YY510nj6VdmvQ6bEoqFO10xIEJrIJ
         s4R7WuDXxz8KqMEuj8MXp6JM7lTl6jqKDAmrldf8ePfuByTl2VIr6/+2qFVPjRvDVVve
         5VeNJxys7d0oXdVIdpat+a87h7fKeAVaJQi9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ylUmvhX6MYRi6Lzt+ERLlRxoNBMnVFwPcX/4GYDixbQ=;
        b=jDHTXABuG12wbTiDJe8syn1tn8io4agVp/yfGfxLPpkf+BbTH0BfVWE0f43TUs89q+
         zFrufjxHp2FqUbm1rUb+sMEGArwGe9OsaC2TjQCHL49/SO82YADI20V8JzBYlX3lucIB
         vjkJ9maTRE9jQrgagz3iXLy5Y3Tqe59bo0S9X/QeL9yeWJIAxt0G67eSvbAL+G+qa9NE
         4yh7WkPB70Lj0/41WUMshvtn9Daq7/EHqqa0R7BX0uZsnkBYw/JWFKX8y8XxwbsQXkPr
         83GwzJV5h97cD4TxPK4he/qbzm9/Bp+/zcSUbM4/ToX5mPWF4yALiGNjkzMKxC6rMcvp
         hMLg==
X-Gm-Message-State: AOAM530g5sQZiF5Z9HKe8jw6mRe8yYd5PEzXCJTCpQ6KFyE1Opory1go
        +2o/b1guyRE1kb7aER58jef4+CJyc18=
X-Google-Smtp-Source: ABdhPJzPOUX/Hf+GaDyqoMGDe8Dx3jtkJVBhkgVO5fwwEESoBfy3QBY+BG33z7t76021epO5bHl3tQ==
X-Received: by 2002:a05:651c:512:: with SMTP id o18mr44423049ljp.226.1594420278475;
        Fri, 10 Jul 2020 15:31:18 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id k6sm2630562lfm.89.2020.07.10.15.31.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 15:31:17 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 9so8105336ljv.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 15:31:17 -0700 (PDT)
X-Received: by 2002:a05:651c:1b6:: with SMTP id c22mr36364030ljn.421.1594420276931;
 Fri, 10 Jul 2020 15:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200709221102.323356-1-cesarb@cesarb.eti.br> <CAHk-=wjUEmO4GiC9mCyzZ8_WS=ZWgfg6CnpxPSLq=uoF1F3Xyw@mail.gmail.com>
 <CAKwvOdnbtbetfN5zF51QOXVhrutE8ak4uPe82iY6g9f6gwk=Vg@mail.gmail.com>
In-Reply-To: <CAKwvOdnbtbetfN5zF51QOXVhrutE8ak4uPe82iY6g9f6gwk=Vg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Jul 2020 15:31:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=whaqVGHSGstM4yHnJ+WkoHDBKWxMuZvgOYoxe9sYBOjEw@mail.gmail.com>
Message-ID: <CAHk-=whaqVGHSGstM4yHnJ+WkoHDBKWxMuZvgOYoxe9sYBOjEw@mail.gmail.com>
Subject: Re: [PATCH] Restore gcc check in mips asm/unroll.h
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Cesar Eduardo Barros <cesarb@cesarb.eti.br>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 11:43 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> What I'd really like to see as a policy in the kernel going forward in
> that ANY new commit that adds some hack or workaround for a specific
> compiler version add a comment about which toolchain version was
> problematic, that way when we drop support for that version years
> later, we can drop whatever hacks and technical debt we've accumulated
> to support that older version.

The problem is that at the time we find and fix things, it's often
_very_ unclear which compiler versions are affected.

We also have the situation that a lot of distro compilers aren't
necessarily completely "clean" versions, particularly for the
"enterprise" ones that get stuck on some old version and then fix up
their breakage by backporting fixes.

When it's some particular version of a compiler that supports a
particular feature, that tends to be much more straightforward. But
we've had bugs where it was very unclear when exactly the bug was
fixed (fi it was fixed at all by the time we do the workaround).

              Linus
