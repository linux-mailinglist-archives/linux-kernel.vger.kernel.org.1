Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE2A3006E1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 16:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbhAVPOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 10:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbhAVPOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:14:12 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE89C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 07:13:32 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id 6so8152954ejz.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 07:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x6lEXEYlBycVbeohirMEw6ub/Wz8ckmFQxXY6Dkjps8=;
        b=H+wA3DVWuzzLbXKlcV0REJZlVYshMccSoBVK00FNNZzD+B9KIaMvMBQvboQjKZmCkS
         GasfIs9l/CIibLMZf7+jz5ZoOpj0qCe9xBBFijTe/9VVDXQhN66jZemp77/jZvNk7qzR
         jPYOzC8/skA/iGfD3g6qPle9LZas0pqd6PNZwuK5RHO9zUT4IyVUyC7wrwIahz5rLsmV
         Odb1Wfe88cS0dV+a0tmQ4XJkHqPyDqvR79qBEk/cPfpUkAuKwvPEZ7Od/DnkbI7mkxLa
         y5+nlNTeN9mwL4PKT+J3H/C3x027JjvOfDBrDAl33vn2HuX0y6RjEKxeDZAQq1MoOd2u
         QwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x6lEXEYlBycVbeohirMEw6ub/Wz8ckmFQxXY6Dkjps8=;
        b=bSMPiA8WysYx9O/ZmS5TVJ5M6WC0f3U8qYCTOKKnOBWffO/fxx0egRxdloL2AfI2uQ
         OB3qQx9PPlovrs/X4IM+Q+U+UWDtBt9CU70zf65S8weLOi1M9KLAJl0Kc55k6iO9w+U7
         imFVkzHiJRmg7YAPYdYNUuRPYgcUTUeCuhzUyChql8NitOA2Jr/kYuiu+8Q3e3+R3Dy+
         QMv0i7Ra9tN8Vt2wlJR58mWconS1BRax09RXWartksxdD5GT3oqrNlHqWaLtQ+Dk8bFv
         cA0g0gNi79C5uXwW6kC/x0teokjxD9nIJB8LyRgCG1BfX6I8nQo3BUipQmgKVBwkad9N
         VPjg==
X-Gm-Message-State: AOAM531GMiy9T5hJU5l5+/oePMYL7Ku9H464/iFCHqG7xgNuacnwBZNi
        CWWXH82w8O6TWzDof+DAOAxP3U67+2Iul7f51KNFTg==
X-Google-Smtp-Source: ABdhPJypZeBPSZGj/JwPhVDbhgOaTwYCxHp8xLjZDl2Fnh5KofUbUUbawpfbhlAFT8/cQR3I94woT9KsRs3tMBbgQOw=
X-Received: by 2002:a17:906:2695:: with SMTP id t21mr3434030ejc.287.1611328410832;
 Fri, 22 Jan 2021 07:13:30 -0800 (PST)
MIME-Version: 1.0
References: <20210122135735.176469491@linuxfoundation.org> <CA+G9fYso4QNbRWdrQiiOiMb5RUr8VtM3AkKEGLasgN+KsPSvDw@mail.gmail.com>
 <YArqULK9c1Cnt5gM@kroah.com>
In-Reply-To: <YArqULK9c1Cnt5gM@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 22 Jan 2021 20:43:18 +0530
Message-ID: <CA+G9fYuzE9WMSB7uGjV4gTzK510SHEdJb_UXQCzsQ5MqA=h9SA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/50] 4.14.217-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        linux-stable <stable@vger.kernel.org>, pavel@denx.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jan 2021 at 20:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jan 22, 2021 at 08:32:46PM +0530, Naresh Kamboju wrote:
> > On Fri, 22 Jan 2021 at 19:45, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 4.14.217 release.
> > > There are 50 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Sun, 24 Jan 2021 13:57:23 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.217-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > arm64 clang-10 builds breaks due to this patch on
> >    - stable-rc 4.14
> >    - stable-rc 4.9
> >    - stable-rc 4.4
> >
> > > Will Deacon <will@kernel.org>
> > >     compiler.h: Raise minimum version of GCC to 5.1 for arm64
> >
> > arm64 (defconfig) with clang-10 - FAILED
>
> How is a clang build breaking on a "check what version of gcc is being
> used" change?
>
> What is the error message?

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=arm64
CROSS_COMPILE=aarch64-linux-gnu- 'HOSTCC=sccache clang' 'CC=sccache
clang'
In file included from <built-in>:1:
include/linux/kconfig.h:74:
include/linux/compiler_types.h:58:
include/linux/compiler-gcc.h:160:3: error: Sorry, your version of GCC
is too old - please use 5.1 or newer.
# error Sorry, your version of GCC is too old - please use 5.1 or newer.
  ^
1 error generated.

build error link:
https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc/-/jobs/980489003#L514

- Naresh
