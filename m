Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A382CB619
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgLBICO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgLBICO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:02:14 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F713C0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 00:01:27 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id d18so2339913edt.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 00:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hPAfLN0W+r0v8UbD8c5WdNj6VpYJo5AjbqSpHz/Yo4Y=;
        b=AlHATBEx3clTaQ07Iit5BYMPWT0L8k+pA79madja45+u4T03OkEW7KPTDo40sJotuc
         S+7fp0pN8VFCzy33jPEK0FxBYo/4oWm1U8oFuvrJd61TniQ8CaVhrFjd1vYQXIAQeJbn
         ZPSHEPzUIEtoeh+VOEGUmTicBD3pkjLI/uV4MBEw4CKA/56bnJng57Yau6DQo7AyIe8a
         DEESONnPV1Vcah5FxVV5jt+0CaZ+vD/0yxXo5xb8ChraAmXafw9UOwLVDNMbKboPIWNU
         NtxJMCHMT7QgUE3YQhAajlQ25XzMoAmOgT5FuZ8QhPAUhnIH3BTSYswfALz3CzURF2Ea
         1lcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hPAfLN0W+r0v8UbD8c5WdNj6VpYJo5AjbqSpHz/Yo4Y=;
        b=Cv4BEwkZwI8ukPDTKdsC98q1zDmfALhE+ZROCXeRys/qWq4MmzygHrxyijSDDIB4GF
         eWN2LHtjoZJpBjzgHeQFbpYvt0VDqKtjlJAN2f5LqWBil0/8zBxarceqR6EcNykQbm39
         03cYKPmPc081MVjGsTI60Ef8cGLMpzikhKI2MKhbukhqlS7LSNIpBcbkCyra1SGZurhB
         sYVAx3mUzrSuHnKYpn+KyFhTJfdvMoyxtomIdj+Ex7GxctGweBlCiKyuDMQrFlbjFitc
         Qr1wiiG3YtE0VQIi/j37ZgQ5tkEXGCHNOzf1r/u2nXQMHl8X99Ei39yFsEpR5B3QkTRp
         SHrQ==
X-Gm-Message-State: AOAM532HfXRcWhdGa3GA2jbhqMvUxaQARl9r+oa4Zc79PhYnCnq4Oz1j
        WgA4G2duvkmoqbP/f+LL8FtKf9+MJ9FJ4QSY/V0uTA==
X-Google-Smtp-Source: ABdhPJwmnqGA4Nhuu2ieSdkMpSjQim81cIIxXYyOfz4b13FL06C2JA3X3EOzsuxEedP5mRNnvF0PkTQDJWtRfmeTebQ=
X-Received: by 2002:aa7:d341:: with SMTP id m1mr1407227edr.230.1606896086079;
 Wed, 02 Dec 2020 00:01:26 -0800 (PST)
MIME-Version: 1.0
References: <20201126130606.2290438-1-anders.roxell@linaro.org>
 <8affd609-f037-8b21-853a-8b87299db044@gmx.de> <CADYN=9+pSK2SHY4ncFaseT9qz6BoTCUxi0e3poTDao4v=S_84g@mail.gmail.com>
In-Reply-To: <CADYN=9+pSK2SHY4ncFaseT9qz6BoTCUxi0e3poTDao4v=S_84g@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 2 Dec 2020 13:31:14 +0530
Message-ID: <CA+G9fYtNgeOgymsVwj423eXOFP1B=mS4KKvy+1Bu3tUapXyxDA@mail.gmail.com>
Subject: Re: [PATCH] parisc: signal: remove _SA_SIGGFAULT
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Helge Deller <deller@gmx.de>,
        James.Bottomley@hansenpartnership.com,
        linux-parisc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anders,

On Fri, 27 Nov 2020 at 04:10, Anders Roxell <anders.roxell@linaro.org> wrote:
>
> On Thu, 26 Nov 2020 at 15:46, Helge Deller <deller@gmx.de> wrote:
> >
> > On 11/26/20 2:06 PM, Anders Roxell wrote:
> > > When building tinyconfig on parisc the following error shows up:
> > >
> > > /tmp/kernel/signal.c: In function 'do_sigaction':
> > > /tmp/arch/parisc/include/asm/signal.h:24:30: error: '_SA_SIGGFAULT' undeclared (first use in this function); did you mean 'SIL_FAULT'?
> > >  #define __ARCH_UAPI_SA_FLAGS _SA_SIGGFAULT
> > >                               ^~~~~~~~~~~~~
> > >
> > > The changes in the two individual patches listed in 'Fixes' below are
> > > OK.  Remove the _SA_SIGGFAULT define since PH-UX isn't going to be
> > > supported according to commit 41f5a81c07cd ("parisc: Drop HP-UX specific
> > > fcntl and signal flags").
> > >
> > > Fixes: 23acdc76f179 ("signal: clear non-uapi flag bits when passing/returning sa_flags")
> > > Fixes: 41f5a81c07cd ("parisc: Drop HP-UX specific fcntl and signal flags")
> > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Thanks for your patch the builds are successful now.

Fixes (compared to build next-20201130)
------------------------------------------------------------------------

parisc:
  build:
    * gcc-10-allnoconfig
    * gcc-10-defconfig
    * gcc-10-tinyconfig
    * gcc-8-allnoconfig
    * gcc-8-defconfig
    * gcc-8-tinyconfig
    * gcc-9-allnoconfig
    * gcc-9-defconfig
    * gcc-9-tinyconfig

- Naresh
