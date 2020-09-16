Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DB126C4A0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 17:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgIPPzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 11:55:00 -0400
Received: from condef-01.nifty.com ([202.248.20.66]:46660 "EHLO
        condef-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgIPP3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 11:29:30 -0400
Received: from conssluserg-04.nifty.com ([10.126.8.83])by condef-01.nifty.com with ESMTP id 08GEYf7r021718
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 23:34:41 +0900
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 08GESsgK002359
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 23:28:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 08GESsgK002359
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1600266535;
        bh=l/3HnRo/Gec7hqA9r+lhHIdPD22CJtChWt84JhWvbWs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DkgIgw+CJCWfK1+3msBMTP0928Z3dFGMphoh4u4/1AwvSsdk38tmKNiscTq8i4x6Z
         hZNIezFtba+cdctltTnOfgrVDNrQvOl+a4M3lcJ3DiOzGsMKbD8vU28b5z57AzjmbG
         VlNIityf5YxS7YB5SdZkQVBTj6qs97ANXxRQBHjYJ6qwWEZWEmfoUXsLtjzEnZYcdk
         WwGdmyKMqZ3U22CaUEozpfbN2mVvkSa28kNS14fwa9QofG2aZRogBNIRV4hAMmZa7z
         di1t+gGRxSEodOXbIAg7XaV1RKxn6z7pryik7BlEn7d+5/ElPpixb9G87WQ8n9WIuj
         SDgCM1vzCtp6A==
X-Nifty-SrcIP: [209.85.216.52]
Received: by mail-pj1-f52.google.com with SMTP id u3so1626882pjr.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 07:28:54 -0700 (PDT)
X-Gm-Message-State: AOAM531KmFbbe4qY+nrG2dxLFqE+IusZktQW1mHFXEhGGv8uZeS9fnDP
        aJfVPyclwHoT0mczUXLtxkjc9qMLaABHcGGT8a8=
X-Google-Smtp-Source: ABdhPJz07Ti3xlNz2VVnJ5B3pTKp2CBT5Ah0O2kIJIYzqnqXeaAfRw/PjYJvr/dn0fW8/ns+XRZenY1JlGuD+KtWlC8=
X-Received: by 2002:a17:902:34f:b029:d1:e5e7:bdcf with SMTP id
 73-20020a170902034fb02900d1e5e7bdcfmr6734757pld.47.1600266534034; Wed, 16 Sep
 2020 07:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200910112701.13853-1-linux@rasmusvillemoes.dk>
 <CAK7LNARE6NpCYAd7=--m-oO8_LweBWhP2aWfSRdTz=TX8dM5rw@mail.gmail.com>
 <CA+ASDXOuK=iCdzWbtc+aRhBy=8xy860XqxwJg+wFuQaXKfg3UQ@mail.gmail.com> <f3ce9b3e-d3c1-a96b-e14b-a8d3c4600b09@rasmusvillemoes.dk>
In-Reply-To: <f3ce9b3e-d3c1-a96b-e14b-a8d3c4600b09@rasmusvillemoes.dk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 16 Sep 2020 23:28:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNATJ2seAuYpi-WPdLNFn2C9Vwm494nk-SWvgBJB3CmCJrw@mail.gmail.com>
Message-ID: <CAK7LNATJ2seAuYpi-WPdLNFn2C9Vwm494nk-SWvgBJB3CmCJrw@mail.gmail.com>
Subject: Re: [PATCH] scripts/setlocalversion: make git describe output more reliable
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Brian Norris <briannorris@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 5:28 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 10/09/2020 21.05, Brian Norris wrote:
> > On Thu, Sep 10, 2020 at 7:35 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >> On Thu, Sep 10, 2020 at 8:57 PM Rasmus Villemoes
> >> <linux@rasmusvillemoes.dk> wrote:
> >>> So in order to avoid `uname -a` output relying on such random details
> >>> of the build environment which are rather hard to ensure are
> >>> consistent between developers and buildbots, use an explicit
> >>> --abbrev=15 option (and for consistency, also use rev-parse --short=15
> >>> for the unlikely case of no signed tags being usable).
> >
> > For the patch:
> >
> > Reviewed-by: Brian Norris <briannorris@chromium.org>
> >
> >> I agree that any randomness should be avoided.
> >>
> >> My question is, do we need 15-digits?
> > ...
> >> So, I think the conflict happens
> >> only when we have two commits that start with the same 7-digits
> >> in the _same_ release. Is this correct?
>
> No.
>
> > For git-describe (the case where we have a tag to base off):
> > "use <n> digits, or as many digits as needed to form a unique object name"
>
> Yes, the abbreviated hash that `git describe` produces is unique among
> all objects (and objects are more than just commits) in the current
> repo, so what matters for probability-of-collision is the total number
> of objects - linus.git itself probably grows ~60000 objects per release.
>
> As for "do we need 15 digits", well, in theory the next time I merge the
> next rt-stable tag into our kernel I could end up with a commit that
> matches some existing object in the first 33 hex chars at which point I
> should have chosen 34 - but of course that's so unlikely that it's
> irrelevant.
>
> But the upshot of that is that there really is no objective answer to
> "how many digits do we need", so it becomes a tradeoff between "low
> enough probability that anyone anywhere in the next few years would have
> needed more than X when building their own kernel" and readability of
> `uname -r` etc. So I decided somewhat arbitrarily that each time one
> rolls a new release, there should be less than 1e-9 probability that
> HEAD collides with some other object when abbreviated to X hexchars.
> X=12 doesn't pass that criteria even when the repo has only 10M objects
> (and, current linus.git already has objects that need 12 to be unique,
> so such collisions do happen in practice, though of course very rarely).
> 13 and 14 are just weird numbers, so I ended with 15, which also allows
> many many more objects in the repo before the probability crosses that
> 1e-9 threshold.
>
> Rasmus
>
> Side note 1: Note that there really isn't any such thing as "last
> tag/previous tag" in a DAG; I think what git does is a best-effort
> search for the eligible tag that minimizes #({objects reachable from
> commit-to-be-described} - {objects reachable from tag}), where eligible
> tag means at least reachable from commit-to-be-described (so that set
> difference is a proper one), but there can be additional constraints
> (e.g. --match=...).
>
> Side note 2: Linus or Greg releases are actually not interesting here
> (see the logic in setlocalversion that stops early if we're exactly at
> an annotated tag) - the whole raison d'etre for setlocalversion is that
> people do maintain and build non-mainline kernels, and it's extremely
> useful for `uname -a` to accurately tell just which commit is running on
> the target.



This is because you use the output from git as-is.

Why are you still trying to rely on such obscure behavior of git?


It is pretty easy to get the fixed number of digits reliably.

For example,
git rev-parse --verify HEAD 2>/dev/null | cut -c1-7


It always returns a 7-digits hash,
and two different people will get the same result for sure.

Your solution, --short=15, means "at least 15",
which still contains ambiguity.



As I already noted, the kernelrelease string is
constructed in this format:

<kernel-version>-<number-of-commits-on-top>-<abbreviated-commit-hash>


For example, if I enable CONFIG_LOCALVERSION_AUTO=y
in today's Linus tree, I got this:

5.9.0-rc5-00005-gfc4f28bb3daf


What if the number of digits were 7?

5.9.0-rc5-00005-gfc4f28b

I see no problem here.

Even if we have another object that starts with "fc4f28b",
the kernelrelease string is still unique thanks to the
<kernel-version>-<number-of-commits-on-top> prefix.

Why do we care about the uniqueness of the abbreviated
hash in the whole git history?



Note:
We prepend $(KERNELVERSION) to the result
of setlocalversion. [1]

[1] https://github.com/torvalds/linux/blob/v5.9-rc4/Makefile#L1175


-- 
Best Regards
Masahiro Yamada
