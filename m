Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D8B285E86
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 13:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgJGL5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 07:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgJGL5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 07:57:18 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04ACC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 04:57:16 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b26so1213776pff.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 04:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cwm4zDn9ljbFZPKUydUSNtDryo6m1+1+OZ3G4Zk6/bU=;
        b=gH6ss9U/zr9dB9r913dqtqA0EMf7LkDf5A6QBpcrwwQmBcUCdva9leLV/3h8J64sBe
         hgaox9x0fbrPuQcfbiKwmdCsQcesl1aZ/pH+KJMmJzPYJL0amLw7tKIWNPwVEe7F1jiH
         PaIvkNDrMY8i4s/SpUqkrRjq+Xr+ZBw0UEkwhZKXQWPEVKbq9qHRxWYZR3njitztbgD1
         EmR66r2Dkoej0dXtj8Kqak6imMqAUZaUiZZFh9TqKyHuFtii9oYXbF4fX9x16Nxni+za
         dNIcpCqkDbhCrli67OvdkH4cnvu6FYDSPX7xHcQnOttUyFoTyIY8oWKrjoBrqYR9mvdD
         pHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cwm4zDn9ljbFZPKUydUSNtDryo6m1+1+OZ3G4Zk6/bU=;
        b=e+mnrIoO54SBCyM/Zsfs2sYhjjqF+uylIbbAK/VnNDFp7def3Zi2ZMKzCD4hz/j0/i
         Hgf79INncHB8W0JwjjxXA6VYAoFcve1iwV5bF0kJW8O1W9nFklb5E0LmpV1J7OC97AEX
         8PVQKzUQyOkQAJ6SUKYxiETYbLqBZQrgvquvt+cCSeVZbIx8+kNdWjP2o4JhIXrcS6Rc
         ToCvCv+tLnX0KZa1DYZJTIUYalqv+pcaP6vTBUnK4EbA1IJrkZmkXwgZb0w5vquiurNf
         IUgjq1drgLJA7bBdCZKsD3XC9UO1Aiyi9lGyFtzDE6oIwD37mfhk3ct51Ndf7UnrLu1w
         J6Sg==
X-Gm-Message-State: AOAM532cCOjcgBSa8/Cu2vzmv0Z1TRcx2S221feutsKu3QY0jKqcl1/L
        RsROYnbXz7rwJQRCyQT/MOmbVA94+h/AKoZ9sdg=
X-Google-Smtp-Source: ABdhPJw4ppH2wCGaZIAtqHTcKgPefWwCVrQkk6D7WXTaslXFFkUJbnDpwzC2lhK6SqhvFLsecq58UhGgGOcgFVwb/fQ=
X-Received: by 2002:a65:47c2:: with SMTP id f2mr2720554pgs.4.1602071836324;
 Wed, 07 Oct 2020 04:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201005093024.16032-1-geert@linux-m68k.org> <CAMuHMdVqpgro9Qzn39fK9R2-2xDm6LDe6uOB5gSTrdRxbecNXQ@mail.gmail.com>
 <20201005125840.GP3956970@smile.fi.intel.com> <d1457a75d5f38002c063c3801af7819af43e0bfc.camel@tiscali.nl>
In-Reply-To: <d1457a75d5f38002c063c3801af7819af43e0bfc.camel@tiscali.nl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Oct 2020 14:58:06 +0300
Message-ID: <CAHp75VcCkpLUAQU4YHvfeZ7gcUhYQSBp9Q1MZeN4xhYSjRTR1g@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.9-rc8
To:     Paul Bolle <pebolle@tiscali.nl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 2:50 PM Paul Bolle <pebolle@tiscali.nl> wrote:
> Andy Shevchenko schreef op ma 05-10-2020 om 15:58 [+0300]:
> > On Mon, Oct 05, 2020 at 11:35:33AM +0200, Geert Uytterhoeven wrote:
> > > On Mon, Oct 5, 2020 at 11:33 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > JFYI, when comparing v5.9-rc8[1] to v5.9-rc7[3], the summaries are:
> > > >   - build errors: +3/-6
> >
> > Thanks for the report!
> >
> > >   + /kisskb/src/drivers/gpio/gpiolib-cdev.c: error: implicit
> > > declaration of function 'in_ia32_syscall'
> > > [-Werror=implicit-function-declaration]:  => 430:6
> > >   + /kisskb/src/drivers/gpio/gpiolib-cdev.c: error: unknown type name
> > > 'compat_u64':  => 432:4
> > >
> > > x86_64/um-all{mod,yes}config
> >
> > I guess the quick fix is to disable that code for UML, I don't know how IOCTLs
> > are working in UML in cases when host - guest - guest app either from:
> >       1. x86_64 - x86_64 - i386;
> >       2. x86_64 - i386 - i386.
>
> I ran into this build error too.
>
> Perhaps the UML maintainers have an idea what to do here. The commit that
> triggers this error is 5ad284ab3a01 ("gpiolib: Fix line event handling in
> syscall compatible mode").

Does [1] fix the issue?

[1]: https://lore.kernel.org/linux-gpio/20201005131044.87276-1-andriy.shevchenko@linux.intel.com/


-- 
With Best Regards,
Andy Shevchenko
