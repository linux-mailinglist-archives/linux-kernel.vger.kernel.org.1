Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851272CD062
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 08:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388002AbgLCH1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 02:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgLCH1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 02:27:14 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC4CC061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 23:26:33 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id g1so1006138ilk.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 23:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=emdEKRg+VtY/b+Z/ynezlyfsfNTHHLZTMnNrAokmFjM=;
        b=M4vgdMjZf2x1nn/AQnqq9jh3h3bWajwWcXOOxy+t9I4VWE7v8Jr55g1jrHNgQOvWfu
         bptyc5Ai+iuw/BELUSCS4cTASaaZsWNfsNyvKEHXkhf/ShtjEN0M4i88zUmOFv75wIs1
         xPT5nDPSYn/UgxXveDBvfHkIUVFQGhyj6pYjXaNPW9/0cLsisSOnN1xMoKtKaibhyvUs
         G7KoRkyqp66uoBPCAqqmmanv9oi+2Fd/Uzp53/J6maTEJsKgjmcub8qG/UWD/CRYJm9Z
         +NrBfDJ/C6gi8UI80M9a5tFnZogaD/+POdi15a01ET9VgFO2/RkXkGkFkBr+L5u+qzz1
         ZRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=emdEKRg+VtY/b+Z/ynezlyfsfNTHHLZTMnNrAokmFjM=;
        b=QA5ymm+DfCT4rDoKM8bvX2+QK9hw7Y/IhSmVK2Uyjxoqdux+1k6wt+cl6EFFqUH2E8
         G3FQPGLkpRFEFImvbXPEiMTOP/vNylTYydSZeeopRmXeOQ3T32j0SiQc7AUD8YxPB7f7
         fCWK4gGBCid8frjyOnJ3Kw/WJeT+xIYQ8gWVv9RNfMu9JGrm3RwQnJ4+7APMK2sRVvNk
         OzzXzAbrDNeBEumm7hh81vP6acfNCx+l84Qz7v3BvR9Gr5G9sui2FtvMAS3HvgSspS/M
         OE9T2mZatUujWwBj+0KSxe3BUrxyvObyGKl5IitmCmpU04S/K8WNHs25Vdsngy4A9NSt
         kIEg==
X-Gm-Message-State: AOAM532uStTMW9DdKnn0c9AgNJMdkeffeDauREmZLgYSft6xRT2GFzNu
        YfgeQsb/dxpoHk1oM3wl1Ff2GL3IDOAgYXji3q8=
X-Google-Smtp-Source: ABdhPJzNHFSYWxGkSpCzIgmMqHvKErvevZLpnB4cMnLcvAD/OIGeXmm5kCzukkgVXxqlynG/wXKiHZhkuY4ABQuJZxM=
X-Received: by 2002:a92:aacc:: with SMTP id p73mr1915136ill.64.1606980393025;
 Wed, 02 Dec 2020 23:26:33 -0800 (PST)
MIME-Version: 1.0
References: <20201107075550.2244055-1-ndesaulniers@google.com>
 <4910042649a4f3ab22fac93191b8c1fa0a2e17c3.camel@perches.com>
 <CAKwvOdn50VP4h7tidMnnFeMA1M-FevykP+Y0ozieisS7Nn4yoQ@mail.gmail.com>
 <26052c5a0a098aa7d9c0c8a1d39cc4a8f7915dd2.camel@perches.com>
 <CAKwvOdkv6W_dTLVowEBu0uV6oSxwW8F+U__qAsmk7vop6U8tpw@mail.gmail.com> <7ca84085-f8e1-6792-7d1c-455815986572@redhat.com>
In-Reply-To: <7ca84085-f8e1-6792-7d1c-455815986572@redhat.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 3 Dec 2020 08:26:23 +0100
Message-ID: <CAKXUXMx0nSZqFfOF63J+awCpkPkgr-kuchUxd2-tuMbA2piD5A@mail.gmail.com>
Subject: Re: [PATCH] netfilter: conntrack: fix -Wformat
To:     Tom Rix <trix@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 1:46 AM Tom Rix <trix@redhat.com> wrote:
>
>
> On 12/2/20 2:34 PM, Nick Desaulniers wrote:
> > On Tue, Nov 10, 2020 at 2:04 PM Joe Perches <joe@perches.com> wrote:
> >> On Tue, 2020-11-10 at 14:00 -0800, Nick Desaulniers wrote:
> >>
> >>> Yeah, we could go through and remove %h and %hh to solve this, too, right?
> >> Yup.
> >>
> >> I think one of the checkpatch improvement mentees is adding
> >> some suggestion and I hope an automated fix mechanism for that.
> >>
> >> https://lore.kernel.org/lkml/5e3265c241602bb54286fbaae9222070daa4768e.camel@perches.com/
> > + Tom, who's been looking at leveraging clang-tidy to automate such
> > treewide mechanical changes.
> > ex. https://reviews.llvm.org/D91789
>
> This looks like a good one to automate.
>
> If you don't mind, I'll give it a try next.
>
> Need a break from semicolons ;)
>
> Tom
>
> >
> > See also commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging
> > use of unnecessary %h[xudi] and %hh[xudi]") for a concise summary of
> > related context.
>

Nick, Tom,

It is not a competition between checkpatch and clang-format, but if it would be:

...checkpatch was first...

But jokes aside: Dwaipayan Ray, a mentee Joe and I are working with,
has already submitted a patch to checkpatch that identifies those
patterns and provides a fix:

https://lore.kernel.org/lkml/20201128200046.78739-1-dwaipayanray1@gmail.com/

Maybe that is helpful; and of course, clean-up patches to the various
places still need to be sent out and having a second tool with
clang-format that can check and provide automatic fixes as well is
great.

Tom, go for it: that clean-up is certainly helpful to get a "make
CC=clang -W1" warning-free kernel build. For some smaller x86 kernel
config (my playground config), there were not too many warnings
outstanding, but the -Wformat was still among the larger class among
them.

Lukas
