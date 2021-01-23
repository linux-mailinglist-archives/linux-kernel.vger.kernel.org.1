Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02FA3013B8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 08:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbhAWHWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 02:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbhAWHWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 02:22:23 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42A9C061786
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 23:21:42 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id s3so755212edt.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 23:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PvKTSKj8P5moStS6B1vn0APN0D00BON1PHjs3lWs7pk=;
        b=dSAcAg79fHqMUiv/SpiWBf22NgSEXxDfl6CfEMmDp2uJsTwxobMFWsI155NhDrV/YZ
         7AlFMAmPaZckXtVKl9PLw8eQWBnWI5uR806jJNDsZEtRmQCMMZ6XJ8/k5tHlowr70iAZ
         UblcX6OgkHWMTn/g9OEuszmLqM0OBZwq8ZW4qyx6kFmQuJeJIDDBvPm7R1pWGRbRKeX1
         TrxliU5LQO4sfR/h9N3mYwFembRtaVsgVa44IXo4WeJ/jP/YQBWAOnaA2eDKJpXkYQ6Y
         LO8Yvtxul+Psrd5hskd0L8UzGg88E3CiGy2sujKYqQAnM6yCh2DlEptig9XOMFhdUxVV
         Onww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PvKTSKj8P5moStS6B1vn0APN0D00BON1PHjs3lWs7pk=;
        b=gPGe45MqE2EIKLjtrjdfhRnLALqJZKnlG9i8SEu5BxOjgxju3+ApqBYrOYQugH0RsL
         mLwhLx7MpdDXuIeqR81vdZYceFSEy4bjcFzgtCltNmkDiUVfDI9LXRjwjW/gYnxpQ0ar
         9UXVEnfZNsNporOzGg/Wr+On0gMi12cUT9deuBA5mCCV+GlbyaNy7lgJFeCt4Zmz8WR+
         tSeMx8kXwSzMivndo0ssdubSbXWMeBdDe/c58Ctft8cwnJac+K3t4HwLL3SDJTOOB/4H
         ZnJNyAuo2KFG5QePocBTTLi2GgFMDL28u443MbD+VVyR2WgAzFiAjM8+IVCPUw5KFfJu
         uNMw==
X-Gm-Message-State: AOAM533ExYj83LAp4BcXtiaNU4R/nqnyL6y3uSyUIcMOuRA+9JUr/6z1
        haY0lcDHBrFbypshAiiqxfNDwwh/283J57uVOhqMFw==
X-Google-Smtp-Source: ABdhPJxqrC6XyyDJzR6aujLPqNc3YJLEksDIHeeHvgxLTrpySvJuzRTPiUOujYt7fRADyRHfPhFNFRZf/mjPZe5+WJI=
X-Received: by 2002:a05:6402:60a:: with SMTP id n10mr1488138edv.230.1611386501608;
 Fri, 22 Jan 2021 23:21:41 -0800 (PST)
MIME-Version: 1.0
References: <20210122160829.171484729@linuxfoundation.org> <CA+G9fYta8vpUaovHZPukuO3_2_VCDSJS5zu01FyZTkTYZAy-fA@mail.gmail.com>
In-Reply-To: <CA+G9fYta8vpUaovHZPukuO3_2_VCDSJS5zu01FyZTkTYZAy-fA@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 23 Jan 2021 12:51:30 +0530
Message-ID: <CA+G9fYv7HgGcwKmGiGc56NQzG+ZuEV8J_YKL3J8=vgFz32nmiw@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/33] 4.9.253-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        linux-stable <stable@vger.kernel.org>, pavel@denx.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jan 2021 at 12:27, Naresh Kamboju <naresh.kamboju@linaro.org> wr=
ote:
>
> On Fri, 22 Jan 2021 at 21:40, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.9.253 release.
> > There are 33 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun, 24 Jan 2021 16:08:20 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patc=
h-4.9.253-rc2.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git linux-4.9.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> Results from Linaro=E2=80=99s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

>
> Summary
> ------------------------------------------------------------------------
>
> kernel: 4.9.253-rc2
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
> git branch: linux-4.9.y
> git commit: a4108af7f0fa9a58f591ef0bdc78216746dacbd5
> git describe: v4.9.252-34-ga4108af7f0fa
> Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.=
9.y/build/v4.9.252-34-ga4108af7f0fa
>
> No regressions (compared to build v4.9.252-36-g2d7bd2c1841b)
>
> No fixes (compared to build v4.9.252-36-g2d7bd2c1841b)
>
> Ran 39925 total tests in the following environments and test suites.
>
> Environments
> --------------
> - dragonboard-410c - arm64
> - hi6220-hikey - arm64
> - i386
> - juno-r2 - arm64
> - juno-r2-compat
> - juno-r2-kasan
> - qemu-arm64-kasan
> - qemu-x86_64-kasan
> - qemu_arm
> - qemu_arm64
> - qemu_arm64-compat
> - qemu_i386
> - qemu_x86_64
> - qemu_x86_64-compat
> - x15 - arm
> - x86_64
> - x86-kasan
>
> Test Suites
> -----------
> * build
> * linux-log-parser
> * ltp-commands-tests
> * ltp-containers-tests
> * ltp-hugetlb-tests
> * ltp-ipc-tests
> * ltp-math-tests
> * ltp-mm-tests
> * ltp-syscalls-tests
> * fwts
> * install-android-platform-tools-r2600
> * libhugetlbfs
> * ltp-cap_bounds-tests
> * ltp-controllers-tests
> * ltp-cpuhotplug-tests
> * ltp-crypto-tests
> * ltp-cve-tests
> * ltp-dio-tests
> * ltp-fcntl-locktests-tests
> * ltp-filecaps-tests
> * ltp-fs-tests
> * ltp-fs_bind-tests
> * ltp-fs_perms_simple-tests
> * ltp-fsx-tests
> * ltp-io-tests
> * ltp-nptl-tests
> * ltp-pty-tests
> * ltp-sched-tests
> * ltp-securebits-tests
> * ltp-tracing-tests
> * network-basic-tests
> * perf
> * v4l2-compliance
> * ltp-open-posix-tests
> * kvm-unit-tests
>
> --
> Linaro LKFT
> https://lkft.linaro.org
