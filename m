Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92782CC796
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbgLBUOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730845AbgLBUOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:14:39 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA75C0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 12:13:53 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id s27so6739422lfp.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 12:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JwDuNvESJRp4+4wFGB9eXTmw8LHatjPDAWUGnhDNQM0=;
        b=KUyCsmBcx+HvkQ1kf35woQhB1Qz1x70+qy7RY097/niHceovj20Z+xZSCDSq+d4F++
         YpHeiGGOgTuzGdTQONHv8+VtQ2144XQJw7ZA7Y2d4NhdhvP3uoSPeAUXSszMArwHx+4A
         2ou/o0cFxCawwIMqypcafgKaRFutrW3QJ9Od8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JwDuNvESJRp4+4wFGB9eXTmw8LHatjPDAWUGnhDNQM0=;
        b=LEBJVzE9FksML/3cR2ctopPjWQ9+q6dDDQAHoW9PDZr1MuwUIwHsJHrOEm1M9ok3ra
         Wi8vMY5HC0KiuFWKtjsicrZT7KCk7HSAG+gEPod/Sbf5YkoT/Sc6kh0ok0MD3rYee7CQ
         See1mC6tTrzIn0kIDx0J277NfrZ/HKmKqzw352BNdMzBm0AVttj1zkrGGBywwEvMeAK2
         iTriJKh/hcUbeFlufZ2Os5nZzlDDhJ90UAuoCrhJ1zcRdgZaQYILCCTGXxqVMLF8Trsw
         Yfxk3EjeGOAeraGY1fzyi5Tp4EQfiSJlq2TPqwF0kXV6O/c2R447KYCdXTH4R/U1pVN/
         rrIQ==
X-Gm-Message-State: AOAM531Lg4igbDdUN6buViWnL3cmMKLImOMp5I9AGNXCP6dIknWwtUOl
        1UHjVMvQh5pNzeGcGEp3NgL4iFKhG8QKLw==
X-Google-Smtp-Source: ABdhPJxXLNpX0n5s65gl9gSzc37lT0orKC1RMTjwiuGMndydCpV4sXzJvtw2d+66YcG2zMsa1rThfw==
X-Received: by 2002:a19:702:: with SMTP id 2mr1883592lfh.347.1606940031399;
        Wed, 02 Dec 2020 12:13:51 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id x2sm753903lfc.177.2020.12.02.12.13.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 12:13:48 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id t22so5326825ljk.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 12:13:48 -0800 (PST)
X-Received: by 2002:a2e:7f13:: with SMTP id a19mr2003590ljd.70.1606940027777;
 Wed, 02 Dec 2020 12:13:47 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNASn4Si3=YhAPtc06wEqajpU0uBh46-4T10f=cHy=LY2iA@mail.gmail.com>
 <CAHk-=wihYvkKOcXWPjY7wN13DXbh3k2YX_6JxK_1cQ=krbi9kg@mail.gmail.com>
 <CAHk-=wi86Eu8Whu66CVu+GVTxbuJG+QNvDuk-hXnWu+5q90Zeg@mail.gmail.com>
 <CAHk-=winw=9xh6SmFJPZgi8ngVR-ECTA-kDAAU3DEPLMoUrzVA@mail.gmail.com>
 <CAHk-=wjU4DCuwQ4pXshRbwDCUQB31ScaeuDo1tjoZ0_PjhLHzQ@mail.gmail.com>
 <CAK7LNAQtABssBH2LGThgv-F3_aSrz9Hd-ra9Yyu4-FFzY1nsUw@mail.gmail.com>
 <CAHk-=whK0aQxs6Q5ijJmYF1n2ch8cVFSUzU5yUM_HOjig=+vnw@mail.gmail.com> <CAK7LNAQGHjLYteCt+8BXSY-5CB0gaO1JtHY-SpPFrfdchoHKrQ@mail.gmail.com>
In-Reply-To: <CAK7LNAQGHjLYteCt+8BXSY-5CB0gaO1JtHY-SpPFrfdchoHKrQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Dec 2020 12:13:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=whfP8CBZGVKzuES9wU2BKTEdUTUhMMW-G90vxdMR8Zi0w@mail.gmail.com>
Message-ID: <CAHk-=whfP8CBZGVKzuES9wU2BKTEdUTUhMMW-G90vxdMR8Zi0w@mail.gmail.com>
Subject: Re: [GIT PULL 2/2] Kconfig updates for v5.10-rc1
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Emese Revfy <re.emese@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 4:54 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Just a nit:
> Now that the test code does not include any header,
> you can also delete
> "-I $srctree/gcc-plugins -I $gccplugins_dir/include"

Ahh,m yes.

It sounds like we might be able to delete the build test entirely if
we just always expect to have a recent enough gcc.

Testing the headers for existence would presumably still be needed,
just to verify "do we have plugin support installed at all".

But I'm not planning on applying this directly - I find the config
overhead to be a bit annoying, but it's not like it is _objectively_
really a problem. More of a personal hangup ;)

        Linus
