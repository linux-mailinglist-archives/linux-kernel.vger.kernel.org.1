Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B381300AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 19:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbhAVSRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 13:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbhAVSLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 13:11:24 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3A9C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 10:10:41 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id e6so4393751pjj.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 10:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=onXgfk50DtN3v5QEyv/WEjxxRRdvu/axfAB5ohqM2OM=;
        b=C4jkq5xmcB+ZeTo05iJ06ocpH9ip/Zsk7CKP3RK/yl2ddkSQRUq2cSuvVYT/PCtHQe
         71mwa5HHq9JIUz0TuNnT/nfsvU2vEJ542cFygkppmTuGFDKUqXT2pOBJfHBE7f1tqNnG
         sW2BE/vuIZVpIjaiX5ORB6uNwhBLjr1LxotEfH9iGDacrRnlS9oPf/SUoc1G9q94t7Uy
         jwu9ZaUYlwAKMnQfBYNZ3Cqf9H74FeG+EXyMM+16i++DFnTD0VgncsYYgaoI1JiTCwfm
         t7DYrO1fsTgctg7D/Rsw80ESw29uej1MgpK/JUnHy5Qc489W8GK8vOSSY1pSh/Sa6XoJ
         z3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=onXgfk50DtN3v5QEyv/WEjxxRRdvu/axfAB5ohqM2OM=;
        b=XdrCgYWntIN9O989b8T90HkoykJPazU6FxE//L/b+rAlYgqqzeteIqJuic/uEW9dfb
         5FJqEs4jSgHBLoTpztTdNanYUOpNb4N8G1s6YroRVgJhe/+ZtupNrjOIPGxhjz86uxQ2
         2fIAkY8uTgc0G8s+U06lE11p3ns+rHYy+RfFE+/J2sZOl36rGZno7bYJtaM/IoUQei+i
         faCMMC1+MfDuXaNChqUZCPD7NPgyIzTbw8ujIW6uNQ6Tf/s67YknSaEezMylSW4u6cnc
         WGzdEtr68p+fp11XdJs7DW69XZCPcwUP0uIY6jKLIU4H9nj0VrwZDKlE48pz3UMtSioA
         Ykqg==
X-Gm-Message-State: AOAM5303nS2pGTcGUUADQvqzMGgt9aWRpiyn+UpH0JqJiTE0LcINrc23
        GFkyEFwkI93q51ICtJxvmn5yaHABYJ6MuYTDQ/NgWw==
X-Google-Smtp-Source: ABdhPJzUdUHao/vHbLpY3xSQqNryEHu6kUEFxJ2oNrPBgHPfVW7EGsQ6fb/nU8aWuzwuYZfZqYK50TbJupBxDmt6fz4=
X-Received: by 2002:a17:90a:9915:: with SMTP id b21mr6730628pjp.101.1611339040406;
 Fri, 22 Jan 2021 10:10:40 -0800 (PST)
MIME-Version: 1.0
References: <20210122135735.176469491@linuxfoundation.org> <CA+G9fYso4QNbRWdrQiiOiMb5RUr8VtM3AkKEGLasgN+KsPSvDw@mail.gmail.com>
 <YArqULK9c1Cnt5gM@kroah.com> <CA+G9fYuzE9WMSB7uGjV4gTzK510SHEdJb_UXQCzsQ5MqA=h9SA@mail.gmail.com>
 <20210122153604.GA24972@willie-the-truck> <20210122154246.GA1308786@ubuntu-m3-large-x86>
In-Reply-To: <20210122154246.GA1308786@ubuntu-m3-large-x86>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 22 Jan 2021 10:10:29 -0800
Message-ID: <CAKwvOdkaW3abbZOzf4zj=e2OcNQKiAgc4afnxFcFdT3Di8LZUA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/50] 4.14.217-rc1 review
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        linux-stable <stable@vger.kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 7:42 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Fri, Jan 22, 2021 at 03:36:04PM +0000, Will Deacon wrote:
> > On Fri, Jan 22, 2021 at 08:43:18PM +0530, Naresh Kamboju wrote:
> > > On Fri, 22 Jan 2021 at 20:38, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Fri, Jan 22, 2021 at 08:32:46PM +0530, Naresh Kamboju wrote:
> > > > > On Fri, 22 Jan 2021 at 19:45, Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > This is the start of the stable review cycle for the 4.14.217 release.
> > > > > > There are 50 patches in this series, all will be posted as a response
> > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > let me know.
> > > > > >
> > > > > > Responses should be made by Sun, 24 Jan 2021 13:57:23 +0000.
> > > > > > Anything received after that time might be too late.
> > > > > >
> > > > > > The whole patch series can be found in one patch at:
> > > > > >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.217-rc1.gz
> > > > > > or in the git tree and branch at:
> > > > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > > > > > and the diffstat can be found below.
> > > > > >
> > > > > > thanks,
> > > > > >
> > > > > > greg k-h
> > > > >
> > > > > arm64 clang-10 builds breaks due to this patch on
> > > > >    - stable-rc 4.14
> > > > >    - stable-rc 4.9
> > > > >    - stable-rc 4.4
> > > > >
> > > > > > Will Deacon <will@kernel.org>
> > > > > >     compiler.h: Raise minimum version of GCC to 5.1 for arm64
> > > > >
> > > > > arm64 (defconfig) with clang-10 - FAILED
> > > >
> > > > How is a clang build breaking on a "check what version of gcc is being
> > > > used" change?
> > > >
> > > > What is the error message?
> > >
> > > make --silent --keep-going --jobs=8
> > > O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=arm64
> > > CROSS_COMPILE=aarch64-linux-gnu- 'HOSTCC=sccache clang' 'CC=sccache
> > > clang'
> > > In file included from <built-in>:1:
> > > include/linux/kconfig.h:74:
> > > include/linux/compiler_types.h:58:
> > > include/linux/compiler-gcc.h:160:3: error: Sorry, your version of GCC
> > > is too old - please use 5.1 or newer.
> > > # error Sorry, your version of GCC is too old - please use 5.1 or newer.
> > >   ^
> > > 1 error generated.
> > >
> > > build error link:
> > > https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc/-/jobs/980489003#L514
> >
> > Urgh, looks like we need backports of 815f0ddb346c
> > ("include/linux/compiler*.h: make compiler-*.h mutually exclusive") then.
> >
> > Greg -- please drop my changes from 4.14, 4.9 and 4.4 for now and I'll
> > look at this next week.
>
> That backport is going to be pretty gnarly, there was a pretty decent
> tailwind of fixes around that patch IIRC.
>
> The simple solution would be to stick a !defined(__clang__) in that
> preprocessor conditional so that it truly fires only for GCC.

I agree with that approach.
-- 
Thanks,
~Nick Desaulniers
