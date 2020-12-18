Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304C42DE89C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 18:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgLRRzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 12:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727967AbgLRRzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 12:55:46 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0632FC0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:55:06 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 23so7505761lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b10g2p9lft/UmhtwJiz67G2XWjBhcNCBTJqBJz2XXw0=;
        b=DFvI9G2QV3GE6hgNxpKnSdceMlfY8WGRpcxo+yQ4bfAwz8eIGMGMHsoj9gAEDOrQv6
         TR4eRr4EBep4U+bfNin6wuLs2YX0MMYGnkBgaf8mc+rWarMYW/hA0MQ4J0x08fQM1TSY
         TPdckUkPTHZxUwHmFBA6zpCqxeqf5+bvxnLLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b10g2p9lft/UmhtwJiz67G2XWjBhcNCBTJqBJz2XXw0=;
        b=r0oRjjECQVVzbdxzzNVmzGWvxTndH5i36HLLCBePHGgv/Rydw8cmY22hQLnWDDuAr6
         AStvFHXJyIixsxPCQT8zYHJt7OqC9eB43AvLsUJCaXX+UKkbgmhanNcy8ojFSggyGyBr
         M4UIzzC+rQ/ufsh6kaHWtue4/eMe1yFBuwJjRn40oDDoOpsz8Z9rRNLWypx72nw9sCIT
         l8LltZZfkcP772GtoS+5H0Ahr85G5LaaSlkV/HucJwXaVZ/ARxrANTpObwdIjHiRoX3I
         cRdQPaC6RWx2WwaX+xmCOrkdbpUZTT5gS7dMvp+SHsCDCjz1VdjPu+fufn8CBb44OskR
         /wsw==
X-Gm-Message-State: AOAM53336isxkCJVCPrKZOA9/E46mpVRvqoBWMgd5TzWWzP3yoSP6CKc
        VyvEzRxBGtiZ1qpj/dWYx0AR7pLzy+WjEw==
X-Google-Smtp-Source: ABdhPJwvB0JbS2B3QAX0+VnlQUV4k8m9e/D79aaPr1gR1xGRkZu8bzjQk5XH01mE4dbWtMEG0BzHyA==
X-Received: by 2002:a19:c511:: with SMTP id w17mr1793496lfe.557.1608314103839;
        Fri, 18 Dec 2020 09:55:03 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id r18sm997402lfm.184.2020.12.18.09.55.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 09:55:02 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id a12so7556913lfl.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:55:02 -0800 (PST)
X-Received: by 2002:a2e:9d89:: with SMTP id c9mr2380283ljj.220.1608314101731;
 Fri, 18 Dec 2020 09:55:01 -0800 (PST)
MIME-Version: 1.0
References: <CGME20201218075758eucas1p1605768803a5c9edce4fbe54b3e3b859a@eucas1p1.samsung.com>
 <20201203125700.161354-1-masahiroy@kernel.org> <b9b17126-9af5-2f73-526e-91bb9fd27f71@samsung.com>
 <CAK7LNART2qQBY7Vc8rhMiXS_Fwty7qpWjwwfPrUegTb-gjy6sA@mail.gmail.com>
 <9f959875-1a30-b1a1-b626-3805e24a6df3@samsung.com> <e5b06d9a-9b24-2440-e0c2-8bf7095eccd9@nvidia.com>
 <25030057-86b1-5619-25fd-acfa0728b850@samsung.com> <4ab4f62f-8b37-01e1-f81c-270155b13a51@nvidia.com>
 <7e691a61-bf4b-0594-8d6d-36d62a5def0b@nvidia.com>
In-Reply-To: <7e691a61-bf4b-0594-8d6d-36d62a5def0b@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Dec 2020 09:54:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjjiYjCp61gdAMpDOsUBU-A2hFFKJoVx5VAC7yV4K6WYg@mail.gmail.com>
Message-ID: <CAHk-=wjjiYjCp61gdAMpDOsUBU-A2hFFKJoVx5VAC7yV4K6WYg@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: simplify GCC plugin-dev capability test
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>,
        linux-hardening@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 7:33 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>
> However, if you are saying that this is a problem/bug with our builders,
> then of course we will have to get this fixed.

This seems to be a package dependency problem with the gcc plugins -
they clearly want libgmp, but apparently the package hasn't specified
that dependency.

If this turns out to be a big problem, I guess we can't simplify the
plugin check after all.

We historically just disabled gcc-plugins if that header didn't build,
which obviously meant that it "worked" for people, but it also means
that clearly the coverage can't have been as good as it could/should
be.

So if it's as simple as just installing the GNU multiprecision
libraries ("gmp-devel" on most rpm-based systems, "libgmp-dev" on most
debian systems), then I think that's the right thing to do. You'll get
a working build again, and equally importantly, your build servers
will actually do a better job of covering the different build options.

                     Linus
