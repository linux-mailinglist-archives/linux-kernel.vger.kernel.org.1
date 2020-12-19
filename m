Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A252DF116
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 19:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgLSSrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 13:47:04 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:58936 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgLSSrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 13:47:04 -0500
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 0BJIjwTp005664
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 03:45:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 0BJIjwTp005664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1608403559;
        bh=U8bbTcBzDUtd553JTraMgkqAyy/20OqDdW6B6zx0xZ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o+tFqSMDnWjM3gFg5Vr2o2aQfZLYg+N2Ol7CftPxAKNLg74/RiM/RW5WyJbpUSJLS
         6apDJLHb0hNGh/WJLCNdOIJQ2AlbCq5mOZ1BkqNytMLbydQhVB3atJTb7Ppz6fX8ra
         I1GRGGjSPZG17CXz5jPKvstTp0jnOXywvmsczsh/4ERZUnpI4Y1I3E8NwwIOPhobgO
         6U8HuLmu4NaNn5esJzq/Pat42tSguiWuuUxBzBPBPRlAF0tLth/NYxAOR3p/Vftvo2
         xO8IzPZRIwpXkEM9eWSF4xJiasRmJHPwPJ7BtB7Tzqj/trllBiNgJzgq7DN3xygVwN
         SqtZY0HHsXIQA==
X-Nifty-SrcIP: [209.85.215.182]
Received: by mail-pg1-f182.google.com with SMTP id w16so3475089pga.9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 10:45:59 -0800 (PST)
X-Gm-Message-State: AOAM530ZGWNjBEreq1gx5F0UHz6zicZ+FGKLqOmm6NYwvUMU8HzY+t7I
        sk48kv0n/uZmWCCjuX7p1+v4kvgRPkjnfBx1PSM=
X-Google-Smtp-Source: ABdhPJyhwDbpadZoeWJaORs2zMYi89Efwv3Bh8XkncygQxSlKW/fZ5IfSHnx3+OAH4wpRkmnb1DH9OHIuq4Q5Mijqh8=
X-Received: by 2002:a62:e519:0:b029:197:bcec:7c0c with SMTP id
 n25-20020a62e5190000b0290197bcec7c0cmr8913637pff.63.1608403558034; Sat, 19
 Dec 2020 10:45:58 -0800 (PST)
MIME-Version: 1.0
References: <202012151215.E7AA7D6@keescook> <CAHk-=wgg1-Cp=WmE2nGXfDuE8TLKDCQibRdhxbu9MnooLGDHWg@mail.gmail.com>
 <202012161221.18C0E3B5CC@keescook> <CAHk-=wieoN5ttOy7SnsGwZv+Fni3R6m-Ut=oxih6bbZ28G+4dw@mail.gmail.com>
In-Reply-To: <CAHk-=wieoN5ttOy7SnsGwZv+Fni3R6m-Ut=oxih6bbZ28G+4dw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 20 Dec 2020 03:45:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR1+vxpwLVYgX1jaREav6EkJDoZtwGoKmEPoQLkSbPeHA@mail.gmail.com>
Message-ID: <CAK7LNAR1+vxpwLVYgX1jaREav6EkJDoZtwGoKmEPoQLkSbPeHA@mail.gmail.com>
Subject: Re: [GIT PULL] gcc-plugins updates for v5.11-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 19, 2020 at 3:50 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Dec 16, 2020 at 12:23 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Hmm. Yeah, that's a bug. I think that's an existing bug, though. I feel
> > like I scratched my head on that too. I will see if there is a sensible
> > way to have Kbuild "notice" that -- I hope there's an easier way to
> > invalidate all object files instead of adding all the plugins as a dep
> > to all .o builds. O_o
>
> Side note, there's actually a more annoying issue with the gcc plugin
> config code.
>
> Namely that when I get a compiler update, the rest of the Kconfig
> system is smart, and rebuilds all my files.


True. The full rebuild happens after commit 8b59cd81dc5e724.


>
> The gcc-plugins code? The code that *really* depends on the compiler
> version even more? Yeah, not so much. It ends up instead causing a
> build error like
>
>    cc1: error: incompatible gcc/plugin versions
>    cc1: error: failed to initialize plugin
> ./scripts/gcc-plugins/stackleak_plugin.so
>
> because the plugins don't depend on the compiler version.
>
> Again, this is not new, but it's another example of how fragile and
> annoying the gcc-plugins code can be.
>
>                Linus


OK, I will fix it. Thanks.





-- 
Best Regards
Masahiro Yamada
