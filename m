Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35E42777CA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 19:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgIXR2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 13:28:40 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:35911 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbgIXR2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 13:28:40 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 08OHSNZt028039
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:28:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 08OHSNZt028039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1600968503;
        bh=K/5GHH2uUZpshoyezregEoMnSllFLdZdmAfPlgoENww=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cyq/lIV1TRs6NWuo3py5nfadlxwuqV3+HSpTHIyXPEIZ3G5PKn0GUw/CtsNzm2GfI
         dpKU5s9ZoaitWaCiUMek4lf+uRWbv7GSxlB53n0d9p7WIU5fIdBCLgLwy0F29iz24o
         KjRR4+KdceGO5kf5uPPEM0tH1gBQRGTVsujPjR4E3rHsAqrRr4PAwRYc9WT/0TkJl3
         y26pwbS2wgCwyfzQ/aFmMKv939OQGwxgK+Z2d6UsvHxk5bVC0jHTGnl/Wu5MZ6ajTC
         SWhGS+tB8K1zSNmLFafFxUNFJ3JlAzQaEldRldOhTguVlBamYdalwRVmoIoPng8ku+
         f/T1lg67j/ZTA==
X-Nifty-SrcIP: [209.85.210.175]
Received: by mail-pf1-f175.google.com with SMTP id x123so2475pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 10:28:23 -0700 (PDT)
X-Gm-Message-State: AOAM531hZL+ybEQS0ttX0oMvYZa7gfal2fvO63bD0zoOBEdyKbJX/c69
        oPSiSK4RNqkLwzDC8SruUZfS61hpIQmTFavPUsc=
X-Google-Smtp-Source: ABdhPJx48x6/1Vyv0UZoEumeTmVEUg4DOw8EdffMCaGnHfwDR/WzdhW7wjbq8N3MWsseoQ6t9wsWDQQGVa1BZZnPsBE=
X-Received: by 2002:a63:1b44:: with SMTP id b4mr109433pgm.175.1600968502449;
 Thu, 24 Sep 2020 10:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200910112701.13853-1-linux@rasmusvillemoes.dk> <20200917065615.18843-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20200917065615.18843-1-linux@rasmusvillemoes.dk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 25 Sep 2020 02:27:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQauxa+R+hxuKrVk8g4o1GDdrdxY1dyJ58AMcoGMoByZg@mail.gmail.com>
Message-ID: <CAK7LNAQauxa+R+hxuKrVk8g4o1GDdrdxY1dyJ58AMcoGMoByZg@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/setlocalversion: make git describe output more reliable
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Brian Norris <briannorris@chromium.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Nico Schottelius <nico-linuxsetlocalversion@schottelius.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 3:56 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> When building for an embedded target using Yocto, we're sometimes
> observing that the version string that gets built into vmlinux (and
> thus what uname -a reports) differs from the path under /lib/modules/
> where modules get installed in the rootfs, but only in the length of
> the -gabc123def suffix. Hence modprobe always fails.
>
> The problem is that Yocto has the concept of "sstate" (shared state),
> which allows different developers/buildbots/etc. to share build
> artifacts, based on a hash of all the metadata that went into building
> that artifact - and that metadata includes all dependencies (e.g. the
> compiler used etc.). That normally works quite well; usually a clean
> build (without using any sstate cache) done by one developer ends up
> being binary identical to a build done on another host. However, one
> thing that can cause two developers to end up with different builds
> [and thus make one's vmlinux package incompatible with the other's
> kernel-dev package], which is not captured by the metadata hashing, is
> this `git describe`: The output of that can be affected by
>
> (1) git version: before 2.11 git defaulted to a minimum of 7, since
> 2.11 (git.git commit e6c587) the default is dynamic based on the
> number of objects in the repo
> (2) hence even if both run the same git version, the output can differ
> based on how many remotes are being tracked (or just lots of local
> development branches or plain old garbage)
> (3) and of course somebody could have a core.abbrev config setting in
> ~/.gitconfig
>
> So in order to avoid `uname -a` output relying on such random details
> of the build environment which are rather hard to ensure are
> consistent between developers and buildbots, make sure the abbreviated
> sha1 always consists of exactly 12 hex characters. That is consistent
> with the current rule for -stable patches, and is almost always enough
> to identify the head commit unambigously - in the few cases where it
> does not, the v5.4.3-00021- prefix would certainly nail it down.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> v2: use 12 instead of 15, and ensure that the result does have exactly
> 12 hex chars.
>
>  scripts/setlocalversion | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)



Applied to linux-kbuild.
Thanks.

-- 
Best Regards
Masahiro Yamada
