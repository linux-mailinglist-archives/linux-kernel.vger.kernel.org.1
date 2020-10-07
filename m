Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37232285EC5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 14:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbgJGMIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 08:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgJGMIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 08:08:53 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E742C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 05:08:53 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q63so2349100qkf.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 05:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cwtbfDyrO5AA38aItSqutSKSXKI+daYXyBW3PzNQ4Lc=;
        b=fOdRdHQAb1tUFAUfJ+/h6TqhYxVVw8zdNFdjjScTnXHtfxBRoIpzLUZSAkYYRPbqxo
         ohhN3a2yClnO1rSIgDZWI+FBmCDkh1RVaBt62Lii+r9zvoHZCpav/cJqLBBT2Yat6jWH
         AFjxOjcT18U9QkkE9q5l1HQuztrNikxEbNYhtnRQxjSgPGOIHOFraQ1rxc+i+SB96WXw
         fkdl2DtSspMJYmb73w/tGZizsdURWO01kkGrEZIXaUe0dz6IyTr2W7iCWq1LhmHQJ8GZ
         81OtwYxFRGxFx9kcjaFYd1or9btPNYWcTk5ifMNlcnqr0FKpy3PGTRv0V6Wt++oLkoim
         8VOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cwtbfDyrO5AA38aItSqutSKSXKI+daYXyBW3PzNQ4Lc=;
        b=g0yuV1KRqPZcMeSACx2cXA0GCRnWFkZvgBpFJw1++CKnOUr6fHLuk2uvXc6dZklbfR
         fXVq5w7QEVTqX1nTUvH4lhdV+u3DvE7x3Inmkm11ju7ca7MTwQwx95BEOr8ye4bO6yUc
         BFRCmtwMXCF6LEfoSY36KkDtyk9LTjiUXG9JiSsB5F07VHnUlGRtmunuy+40+rC3cQp3
         /SMNmJmacO/oAFyG9OA/f/ilvco80ty5t/oY4gOPdryRqeYAXKjeIPLTb+Wfsbo+N/+r
         hsLuj/TqDOyloHFH5EVOdE9pX3A8Tkfru8WV3VITsZ9hD41bO8Rxib/rtzY2etLVSOaT
         RjnA==
X-Gm-Message-State: AOAM531okGreipDd0n51HF1XPqkrP8ui2RCTPxaHwgs01kLBle98dBX1
        R7XeJoN97FO82sg+SQe05c1AYjRq3GxYGO7e6FU=
X-Google-Smtp-Source: ABdhPJxwl7APqf+vqOW9LXxIzrrvJP6yeZ+e1RQGoUWd/I6HGZWUNDHqvcXTIXN+s8VJMt/Ov5zfyct5/Dm9I+mhJaQ=
X-Received: by 2002:ae9:e70c:: with SMTP id m12mr2482257qka.52.1602072532602;
 Wed, 07 Oct 2020 05:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201005093024.16032-1-geert@linux-m68k.org> <CAMuHMdVqpgro9Qzn39fK9R2-2xDm6LDe6uOB5gSTrdRxbecNXQ@mail.gmail.com>
 <20201005125840.GP3956970@smile.fi.intel.com> <d1457a75d5f38002c063c3801af7819af43e0bfc.camel@tiscali.nl>
In-Reply-To: <d1457a75d5f38002c063c3801af7819af43e0bfc.camel@tiscali.nl>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 7 Oct 2020 14:08:41 +0200
Message-ID: <CAFLxGvyvgSvcizZFZxezFKhZCP79yyMuM7izFbcUtzRTpiOb6A@mail.gmail.com>
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

On Wed, Oct 7, 2020 at 1:51 PM Paul Bolle <pebolle@tiscali.nl> wrote:
>
> [Added Richard and Anton.]
>
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

UML has no ia32 emulation and therefore no in_ia32_syscall().
Maybe you can check for CONFIG_IA32_EMULATION too?

-- 
Thanks,
//richard
