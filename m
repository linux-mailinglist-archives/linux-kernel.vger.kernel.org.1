Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97122A73DF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbgKEAfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgKEAfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:35:16 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B83C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 16:35:16 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id z1so129172plo.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 16:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R/wPomTMkZj1Nomsd//HG7kN27omvaqNPJ+rtSAN1Co=;
        b=MeYISvHNTRMuvGpXWZoUJM2hxaPTm9Ojiv8X3ArMaTpIp5z6WG+BgLIU1f9ZP8zx+I
         gfrELiifLERsXD0PCux70mBvQJQX2fLIt+VraLrJEBVmHd5ELgSxjCL/OW0TCTF/9UgR
         AJTba0fbf1O1TcK+OhhvkT6E7c9kN65trWCUGh5sqgDKFILZEFa18yB+ZYSee/PAmPaG
         BO1/e9lJLsjSbM0QAcJI9LZTqkxDdRA65QdfZbq5gUGuF9c/hejxsHusH364n1ZQZQCU
         9knNUSxrp11opdM5jCLlwgv5zqC75ZKaH7fYwGRjVY/pnp38bcrjlRViOCAh0ntzThkQ
         dZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R/wPomTMkZj1Nomsd//HG7kN27omvaqNPJ+rtSAN1Co=;
        b=q2StGCL7y1t1tET9KUtkI6ZnJ9UE9KnIt0gSFmeHjhC3iGVRnZEukw66TY7slkD25C
         jFoJIsHcohGHe6R+I7dHQDLd7PAQ+ryQKVZcg3mhV85DimzsFio1OvzlEiJn9wdinXEz
         7fm15sy+29QJ6tFN5MruvC4phdklSKFI7yi50ftwGAdSJggIrxMt4Czg+Tw/wxJPvH73
         JVLsV6hQkNyZXaZxwkm4j7/btxvnCBjJlPdYt3JxqX4B3/SMhw4Mh2PEE0Ot92uNetiL
         dBLJzDYSepjB5tb+JRKnNYJnzGk1q0rK45iWWVZvrTeXOKdDjj86SPe93x4XEhwQEmzk
         gsPA==
X-Gm-Message-State: AOAM533xJjZtOJ+EcqbpxTNA8Id4WQsFQPcIWWCItOOaKWgO2cLP8Y41
        7ALJlWu5RUA3ixXa3tcDQGd1fOMUuTbuI+qm1aLtyg==
X-Google-Smtp-Source: ABdhPJwoPFp3wsgb8+dGYDWYo8JMKmpwfcYH7kUkSKWs5if+NjNf0ULEf7pQQ9XjT9uy9Aaoke3ytxEP0XFn31pdcLk=
X-Received: by 2002:a17:902:8a8b:b029:d5:f871:92bd with SMTP id
 p11-20020a1709028a8bb02900d5f87192bdmr533068plo.10.1604536515505; Wed, 04 Nov
 2020 16:35:15 -0800 (PST)
MIME-Version: 1.0
References: <363325b4a85f094ba9cf06301dd022912ec79d03.camel@perches.com>
 <CANiq72=r6oieZ-Nj-e6e+HriW8kADB75z2pj6W-gg7Cff3nqGw@mail.gmail.com>
 <CAKwvOdmnz-DJ-hG5FKJZYF7W-ujPrgfMkrb2hMLhmzhk8Hx6dA@mail.gmail.com> <ba3126e1424c578f5040c7a6f04cdd6a334b2db4.camel@perches.com>
In-Reply-To: <ba3126e1424c578f5040c7a6f04cdd6a334b2db4.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 4 Nov 2020 16:35:04 -0800
Message-ID: <CAKwvOdmoR9xph_TK5zaKdh1qHX4Sh9MW9xYcxLJf6wZfxSkv2Q@mail.gmail.com>
Subject: Re: [RFC PATCH] .clang-format: Remove conditional comments
To:     Joe Perches <joe@perches.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 5:31 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2020-11-03 at 17:08 -0800, Nick Desaulniers wrote:
> > On Tue, Nov 3, 2020 at 1:33 PM Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> > > On Tue, Nov 3, 2020 at 7:29 PM Joe Perches <joe@perches.com> wrote:
> > > >
> > > > Now that the clang minimum supported version is > 10.0, enable the
> > > > commented out conditional reformatting key:value lines in the file.
> > > >
> > > > Signed-off-by: Joe Perches <joe@perches.com>
> > > > ---
> > > >
> > > > Hey Miguel.
> > > >
> > > > I don't use this, but on its face it seems a reasonable change
> > > > if the commented out key:value lines are correct.
> >
> > Joe,
> > what would it take to get you to use clang-format, or at least try it?
> >  Beers?  Bribes? Dirty deeds, done dirt cheap?
>
> Hey Nick.
>
> Paint my house? ;)

I'll help you paint your bikeshed. Oh, but what color?  I see a red
door, and I want it painted black.

Sounds to me like Miguel could win over a critic by addressing some of
your (quite valid) concerns. ;)
--
Thanks,
~Nick Desaulniers
