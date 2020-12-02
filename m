Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BBD2CC613
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbgLBS7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbgLBS7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:59:00 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C088C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:58:14 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id b26so1186321pfi.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kE16meeOG0npqUhLGgArmVgFAjXfqtmka154+p0CSe0=;
        b=SFHVoEZ1ou8dIcNfmXHkNSFRA2TGorf8peBWqq8IAOJBgq3pTYasdxZOojyBm6sM2P
         3585eWlWosp063Mtd8q5R5Mnuvq4k95+wkeFPZ7dyilCFgQRqQyqtcENrRCVOdKGAkPL
         mNfTpZX3Ph1bk3b1xxFE/uFyeDdgrUEpFqr+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kE16meeOG0npqUhLGgArmVgFAjXfqtmka154+p0CSe0=;
        b=YDbVsuwZMOO17RToOShyODmsLfjxNSbJx3Bqr9u/ibzT2c4FHCLpXEbIuPZnvITqcj
         GEdRAD+CRoXam3McxWxqdawQ3hAhVvci6E5zdoBQu8S44mjDk/C8qpggi9z9J2Wosd9Z
         vqCsY9K/tMCCh7aYOMaCqEUN2q0egWK9bQ5OW4NoniVQdHOwryIA8cXe91ixBJiBme/8
         ZzbkT8A25XW7SACmKmIW+MoKx4TAa6QshsUqfK7X+kf5/ca83/H1oeBZ06jSMXwL//YV
         hYGv98v2p2LG0zGTr6VbHDNFDqh1MdWFccuyAFningYEWa0FReubzeWs0HZKinmr2O3Y
         SYeg==
X-Gm-Message-State: AOAM532JcQujbYhH5R1/5JffdktSoodY34/Xf8zTXbg/OgpmIAkAW8/T
        bRZMTRhJNcLdG49HG9MxwbbMBA==
X-Google-Smtp-Source: ABdhPJxtOYeNphgt1oKFMrz0wHeC9Pq/UKO8pRwQniQrcwwzBL0kF4npgqkN5PB6fGtvpn8sBwQTFg==
X-Received: by 2002:a65:64c9:: with SMTP id t9mr1154966pgv.418.1606935494113;
        Wed, 02 Dec 2020 10:58:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x7sm498010pfn.85.2020.12.02.10.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 10:58:13 -0800 (PST)
Date:   Wed, 2 Dec 2020 10:58:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Emese Revfy <re.emese@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL 2/2] Kconfig updates for v5.10-rc1
Message-ID: <202012021057.68B54233E@keescook>
References: <CAK7LNASn4Si3=YhAPtc06wEqajpU0uBh46-4T10f=cHy=LY2iA@mail.gmail.com>
 <CAHk-=wihYvkKOcXWPjY7wN13DXbh3k2YX_6JxK_1cQ=krbi9kg@mail.gmail.com>
 <CAHk-=wi86Eu8Whu66CVu+GVTxbuJG+QNvDuk-hXnWu+5q90Zeg@mail.gmail.com>
 <CAHk-=winw=9xh6SmFJPZgi8ngVR-ECTA-kDAAU3DEPLMoUrzVA@mail.gmail.com>
 <CAHk-=wjU4DCuwQ4pXshRbwDCUQB31ScaeuDo1tjoZ0_PjhLHzQ@mail.gmail.com>
 <CAK7LNAQtABssBH2LGThgv-F3_aSrz9Hd-ra9Yyu4-FFzY1nsUw@mail.gmail.com>
 <CAHk-=whK0aQxs6Q5ijJmYF1n2ch8cVFSUzU5yUM_HOjig=+vnw@mail.gmail.com>
 <CAK7LNAQGHjLYteCt+8BXSY-5CB0gaO1JtHY-SpPFrfdchoHKrQ@mail.gmail.com>
 <CAK7LNAS_18S9_OasKOaoEW6os3=bYf4wi7fPewfdHyCS2mLsyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAS_18S9_OasKOaoEW6os3=bYf4wi7fPewfdHyCS2mLsyA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 10:03:47PM +0900, Masahiro Yamada wrote:
> On Wed, Dec 2, 2020 at 9:53 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Hi Linus,
> >
> > On Sun, Nov 29, 2020 at 3:28 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Fri, Nov 27, 2020 at 11:05 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > >
> > > > As for the cc1plus cost, I got a similar result.
> > > >
> > > > Running scripts/gcc-plugin.sh directly
> > > > took me 0.5 sec, which is a fourth
> > > > of the allmodconfig run-time.
> > > >
> > > > Actually, I did not know this shell script
> > > > was so expensive to run...
> > >
> > > So it turns out that one reason it's so expensive to run is that it
> > > does a *lot* more than it claims to do.
> > >
> > > It says "we need a c++ compiler that supports the designated
> > > initializer GNU extension", but then it actually includes a header
> > > file from hell, rather than just test designated initializers.
> > >
> > > This patch makes the cc1plus overhead go down a lot. That said, I'm
> > > doubtful we really want gcc plugins at all, considering that the only
> > > real users have all apparently migrated to clang builtin functionality
> > > instead.
> > >
> > >         Linus
> >
> >
> > The attached patch looks OK to me.
> >
> > Just a nit:
> > Now that the test code does not include any header,
> > you can also delete
> > "-I $srctree/gcc-plugins -I $gccplugins_dir/include"
> >
> >
> > If you apply it directly, please feel free to add
> >
> > Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
> 
> 
> BTW, gcc plugins are always compiled with g++.
> 
> Why do we need to compile the following in the first place?
> 
> class test {
> public:
>         int test;
> } test = {
>         .test = 1
> };
> 
> 
> I think any C++ compiler will succeed
> in compiling such simple code.
> 
> 
> 
> So,
> 
> test -e "$gccplugins_dir/include/plugin-version.h"
> 
> looks enough to me.
> 
> 
> 
> What is the intention of this compile test?

Yeah, I'd agree: we're just looking for a g++ and plugin-version.h.

-- 
Kees Cook
