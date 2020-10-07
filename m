Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F24285FA9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 15:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgJGNBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 09:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbgJGNBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 09:01:20 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A04C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 06:01:20 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id g3so1645227qtq.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 06:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+X5C10wNiQ5h4TLjgr2La86JSVoLJfjveI9FFVrvlIs=;
        b=XJ6YLwA8lgEAd5b26TU2Ap8GzNfR2IjEmS6+dUn75OhpB2OTVCV+dRMivCJ+wM77PN
         HdRQCDOsO9KVh4YdPI6g4YDurW2+AZqLfgWKWhHRuyBAps4+v8gA9YExS4Vo7oRCg/vC
         tW15snol03iauiEUq0Ds+tG/MCtIL66TRVjaF6P3w90yk81xPzTb+CDAL0dmF7xcTh7y
         hOTaJZoNInjkKM0k4BY/MOyuMHvxyqtfI6q7xSg3u2JCSR3qRJigIZuMq0JTwUa9h/bv
         JQLfkjz6owWPzEsPjt/cEOGYP0Dv3oGBal79OOaE/BZgjJ+JSIpzxxxa/R8+/qFNsdUn
         gT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+X5C10wNiQ5h4TLjgr2La86JSVoLJfjveI9FFVrvlIs=;
        b=eiIsDgTw9iF3BqFHJizHF70SPPll9EUooHBFlUsHWj5l37Tvw5TUQipKTv/u4lrUn3
         Dy/dO1eus21IEE8VHarc4M3R3Zkvt2Xprte+Ij2ArIoufnpUnjqRH4m4BtkEXsvwZLb6
         o8D+YcUpPThrZLgbfs9ketjV6t3YYf6CbE7lXlKeSbdeRNWBAKCxkTMKsYirvQW2YRFJ
         QUfxYYZV3Zx5QYM36J3erCv1Y+9MY5YntfFjl7Tlfm2dB3caL2hZmf0pxfq/GmGe+gbW
         vgexFUBbcbo2H9OSMFwZUIWSXMO9MaWO1rA6JO/6dum0gQsoF+Le85LGy092XziQJmfz
         Obnw==
X-Gm-Message-State: AOAM5305wtV9/RXTKbM+9mRy9aD7VFN/V3SLnPY0tX8DzbRjMvaTGwwK
        NSODWbFz9ObYaauRGylYUz4n4Qwak5MzJ/Uvt0g=
X-Google-Smtp-Source: ABdhPJy3gXOopSXxi9iKT/4M8Z/ED7WQe1gnKU+SfPDIhsJS2ZC3sinADrqTsr4Nc6oSadPpaK0IySyOlfVg1gv6qoQ=
X-Received: by 2002:ac8:5ac1:: with SMTP id d1mr1729397qtd.82.1602075677643;
 Wed, 07 Oct 2020 06:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201005093024.16032-1-geert@linux-m68k.org> <CAMuHMdVqpgro9Qzn39fK9R2-2xDm6LDe6uOB5gSTrdRxbecNXQ@mail.gmail.com>
 <20201005125840.GP3956970@smile.fi.intel.com> <d1457a75d5f38002c063c3801af7819af43e0bfc.camel@tiscali.nl>
 <CAFLxGvyvgSvcizZFZxezFKhZCP79yyMuM7izFbcUtzRTpiOb6A@mail.gmail.com> <5f5c303d30eaa32c21131502cc6f28db9d655329.camel@tiscali.nl>
In-Reply-To: <5f5c303d30eaa32c21131502cc6f28db9d655329.camel@tiscali.nl>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 7 Oct 2020 15:01:05 +0200
Message-ID: <CAFLxGvxcz78aKRAHOz=oLCNFk-Xxm4sFMJk9DiR6aZOEbZ0Nog@mail.gmail.com>
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

On Wed, Oct 7, 2020 at 2:47 PM Paul Bolle <pebolle@tiscali.nl> wrote:
>
> Richard Weinberger schreef op wo 07-10-2020 om 14:08 [+0200]:
> > UML has no ia32 emulation and therefore no in_ia32_syscall().
> > Maybe you can check for CONFIG_IA32_EMULATION too?
>
> The pending fix is:
>     #if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>
> Since this check guards in_ia32_syscall() just checking CONFIG_IA32_EMULATION
> should do too.
>
> (Way outside my limited expertise, but anyway: is does look odd to see a call
> to in_ia32_syscall() in drivers/. All other calls are in arch/x86/. Isn't this
> a bit too x86 specific for an arch independent driver?)

Indeed. in_compat_syscall() seems to be more suitable.

But for UML this does not really help, I fear, it has also no CONFIG_COMPAT.

-- 
Thanks,
//richard
