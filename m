Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81161CEA03
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 03:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgELBKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 21:10:54 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:36388 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbgELBKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 21:10:53 -0400
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 04C1AdSl006506
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 10:10:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 04C1AdSl006506
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1589245839;
        bh=K5pQ0hFUamxU3xDLOrlg3dPizqeqv2tllzaHsV47Xww=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pa9iDFGLBXYgPJqDz/QwTqmPG5oekFgMxEK5JyH6ksenZrZAEtEdhBLH+SXhb6Dsy
         ygyfdGTlf7jEeHjtneblYz5GvSV13aqWmt9QUepF9Z3IQP3jhOBbZUPJSZ/z+7AU/o
         yQbnvjj9D9+OyuykgLRk/ZO+o0nGRvVRhyu5FXGpTWtbzJ07lRa2huXYVrlE7ka0Pm
         pmUFG+pfdHjskujX7BKkMCHfkE6le8qx+N7YEFf0IGDPoFuTc+88/bMS6yJM/RVRBj
         OD5anqGert/7P/TIoy7CX+F3S4Y1jKFgtfmpSvWuipT35MNHFAd0ovnmO00q/i16Ba
         ndjGtZGfWgujw==
X-Nifty-SrcIP: [209.85.221.173]
Received: by mail-vk1-f173.google.com with SMTP id j127so2882769vke.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 18:10:39 -0700 (PDT)
X-Gm-Message-State: AOAM530kaPS9mYOZ/Rz6zIlPXoCUU4RM7J5xOalbgQkRdnbrDm+r1bqL
        5r1KDsTCHk/RGMRsvR2FS9bBbJsq5AGkW9v4MYI=
X-Google-Smtp-Source: ABdhPJzT8cfk4Vw/UMZidHhfEFfI760psS+Z6D1KRvKDkAo0qESubVlXCPpQbhHvfSsFAJQX0r87/SXSJIIPLQXK5Ns=
X-Received: by 2002:a1f:9093:: with SMTP id s141mr3699393vkd.96.1589245838591;
 Mon, 11 May 2020 18:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200507224530.2993316-1-Jason@zx2c4.com> <20200508090202.7s3kcqpvpxx32syu@butterfly.localdomain>
 <CAHmME9pTZTa9AEUL0-ojTr7P-F7NYe8OR9=-GBPaQNpnSDrEiw@mail.gmail.com>
 <20200508113336.2vdfdnc6tqyx4pu6@butterfly.localdomain> <CAK8P3a0dJ0vNnktcoWFiPKB4NJbeyf7nvwWf0YLyeUyxT5pvQg@mail.gmail.com>
 <c774d7371a9599526090e63e85f61e69bddf4795.camel@perches.com> <9590a4674863448e8b13fee5086fcf73@AcuMS.aculab.com>
In-Reply-To: <9590a4674863448e8b13fee5086fcf73@AcuMS.aculab.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 12 May 2020 10:10:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQJR5JUc37QcYS2P=WOfDQmGyAh3nJ_m8qTQDnT6LOnyA@mail.gmail.com>
Message-ID: <CAK7LNAQJR5JUc37QcYS2P=WOfDQmGyAh3nJ_m8qTQDnT6LOnyA@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: default to CC_OPTIMIZE_FOR_PERFORMANCE_O3 for
 gcc >= 10
To:     David Laight <David.Laight@aculab.com>
Cc:     Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 9:47 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Joe Perches
> > Sent: 08 May 2020 16:06
> > On Fri, 2020-05-08 at 13:49 +0200, Arnd Bergmann wrote:
> > > Personally, I'm more interested in improving compile speed of the kernel
> >
> > Any opinion on precompiled header support?
>
> When ever I've been anywhere near it it is always a disaster.
> It may make sense for C++ where there is lots of complicated
> code to parse in .h files. Parsing C headers is usually easier.
>
> One this I have done that significantly speeds up .h file
> processing is to take the long list of '-I directory' parameters
> that are passed to the compiler and copy the first version
> of each file into a separate 'object headers' directory.
> This saves the compiler doing lots of 'failed opens'.
>
> If each fragment makefile lists its 'public' headers make
> can generate dependency rules that do the copies.
>
> FWIW make is much faster if you delete all the builtin and
> suffix rules and rely on explicit rules for each file.


Kbuild disables Make's builtin rules at least.


# Do not use make's built-in rules and variables
# (this increases performance and avoids hard-to-debug behaviour)
MAKEFLAGS += -rR



--
Best Regards
Masahiro Yamada
