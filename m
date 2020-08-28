Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A8F2554E5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 09:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgH1HJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 03:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbgH1HJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 03:09:57 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FEBC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 00:09:56 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id h4so49937oop.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 00:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DVuVd6p5WUIda7pE1WrjTg4zSVXkLhlT+xCt0yR++Os=;
        b=aCtNnk7zEgx71MZ0li20Hed24dO1JYlQFvABddQov9B6BuQZwUGuM9rYoDcmcR52Rb
         PLiEcsslY2WP24AjQJw0BfdIs+Mi7yvPixtAe5JqSdWZv3MZHTAWBUnPiZJPdkNsdgZi
         TyQSEdNsqUa4842GX2ezZu2bFoau1JHYZnTi6c7jBCcctQz1uzXZ7aCz6j4JEEggblI1
         9D4LNbT9BHiNPm7NVKLCf337hPFe0CzJWkwey3I3Rs2FE4ciiAXnRx/JmhEAeezsnNy3
         dzVfgYQY8R7nCi/ooqV5pAoMs4ZYs7X1IUIkYr+yd6PUDPx/dnoZuyP9xuH3fmyXKqAl
         boxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DVuVd6p5WUIda7pE1WrjTg4zSVXkLhlT+xCt0yR++Os=;
        b=IHGP/DkPKLlOnp/5vAoTLko92cH8IC3lbWFThlO0pRjc7fFFX4lTV5EQmIrf24+bSj
         sTj389HrAsm9dI8Y4V4Ngq6o7bFSfDh+VmJTZUtoXhXxzemhUYzT8+J55sAMTZuC3uSg
         bL8iAbTB0JnandTxu+dc9Mlaz5rQ33/oa00lbph6cwZPGjLnNFXy6PMcSvzvtz3IM8eC
         6VwmYQmyv5G+Hh+gDR4810DjHzFyy7zvP1HCnVh1ctHIAPCyOdbyIVTxz0KJJtrG7nFf
         FJ3KkkycX4i2v5Qqd3it+MMW83IeYKJlzFL/SusssmDUJVOsltnzMV4D52UKqWnjAio9
         45pw==
X-Gm-Message-State: AOAM5333mxWXwFuVrGuhghsLQIjaX20jM25xqxZ5olo1ILAlQ2ehMQCn
        5ZCAHmiLq54LM8mUeYESKi0HpyvhSOeDly0LVZg=
X-Google-Smtp-Source: ABdhPJw0ppKKCCfdqyVwaJ4pWjujRJHaStvQsL6Ksle+Mc6vIXt525LQ25yGxEEjVinfwZcZgCvdJuLOA0c59GPZ9Rg=
X-Received: by 2002:a4a:d588:: with SMTP id z8mr164471oos.84.1598598594507;
 Fri, 28 Aug 2020 00:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200827013636.149307-1-allen.lkml@gmail.com> <CAHk-=whiEUUrtnbgUH2xsD0+jNyoXudYJ4hGCA55MCjryaHGjw@mail.gmail.com>
 <1598553133.4237.8.camel@HansenPartnership.com> <CAHk-=wi8o+FvfQkUiH_2MUs3J19FzfMzumOViAJ2aboGg9qY7Q@mail.gmail.com>
 <CAHk-=wingJWToQfoc+m2am7Q=7r8XD+6p0FXasCRAzOdcRyngw@mail.gmail.com>
 <202008271150.7231B901@keescook> <CAHk-=whDhHWQo_QjZp36=x=GLMGOJ2xnfsUk9xkUuWRz=i9gOg@mail.gmail.com>
 <20200827213636.GF1236603@ZenIV.linux.org.uk> <202008271503.181A6A609@keescook>
In-Reply-To: <202008271503.181A6A609@keescook>
From:   Allen <allen.lkml@gmail.com>
Date:   Fri, 28 Aug 2020 12:39:42 +0530
Message-ID: <CAOMdWSLJuG+EN3gDUYpoPjYU2cuRrN34NYZZ9Uhb08_egw3ZCA@mail.gmail.com>
Subject: Re: [PATCH] linux/kernel.h: add container_from()
To:     Kees Cook <keescook@chromium.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > You really have to pick some pretty excessive type names (or variable
> > > names) to get close to 80 characters. Again, to pick an example:
> > >
> > >         struct timer_group_priv *priv = container_of(handle,
> > >                         struct timer_group_priv, timer[handle->num]);
> > >
> > > ends up being long even if you were to split it, but that funky
> > > container_from() wouldn't have helped the real problem - the fact that
> > > the above is complex and nasty.
>
> The point about doing the assignment with the declaration certainly makes
> the "ugliness" worse, I agree. I'm still not generally convinced about
> the redundancy level pros/cons, but I concede that having a common idiom
> (rather than a succinct but subsystem-dependent idiom) is better for
> people reading the code for the first time.
>
> > > And I had to _search_ for that example. All the normal cases of
> > > split-line container-of's were due to doing it with the declaration,
> > > or beause the first argument ended up being an expression in itself
> > > and the nested expressions made it more complex.
> >
> > Speaking of searching, this kind of typeof use is, IMO, actively
> > harmful - it makes finding the places where we might get from
> > e.g. linked list to containing objects much harder.  container_of
> > (unless combined with obfuscating use of typeof()) at least gives
> > you a chance to grep - struct foo *not* followed by '*' is a pattern
> > that doesn't give too many false positives.  This one, OTOH, is
> > essentially impossible to grep for.
>
> And this observation about workflow does strike a chord with me. I do end
> up with those kind of searches too. In trying to examine my preferences
> here, I think my instincts are to avoid open-coded types (leading me to
> want to use typeof()) but I think those instincts were actually developed
> from dealing with _sizeof_ and all the way it goes terribly wrong. So,
> okay, I'm convinced. container_of() it is.

 so container_of() it is :)
Will start updating the rest of the patches.

Thanks,
- Allen

> Doing these conversions becomes a little less mechanical if assignment
> needs to be split from declaration, but hey, we've got a 100 character
> line "limit" now, so maybe it'll be less needed. :)
>
> --
> Kees Cook
