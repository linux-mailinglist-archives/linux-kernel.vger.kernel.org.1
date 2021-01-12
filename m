Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB7C2F2905
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 08:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732979AbhALHg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 02:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731203AbhALHg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 02:36:56 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1DBC061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 23:36:15 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id h16so1176960edt.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 23:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QNdUwmP/bjE+bXvgAZ73Eu7+OzOEZkpRNhrcydgte+s=;
        b=XlBjwaCM+jUC4Q5cSaFAtag5bUIHFqvSNG6K4O28AqOysr7XCMzyDykjxQwBNGogCz
         NREwVy3yYvPVioet30InNPRjIZuKkuaVOIXjfwBRPYFP9wYFSNR5DtlF+41tDOcmt7RM
         xdMBrCRfcYgK2/jF1fQrqsuJ+mnJXyPC1Vu3Wnk77kZTn9YrigCySqX1n1p0uKo5Ppc/
         6I5RrOkyjwcTP1+uld5IWIb17l97SRm52RcLFuwvjahbfdfkdLHEfcsLBELxH92YnJ6v
         iH6nuGowy2oDvXgvUa0vvSEAaR1dxLkiCl58zO2O2Nf+ca33v5XpahaPyT3YwAQtC5aS
         1D6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QNdUwmP/bjE+bXvgAZ73Eu7+OzOEZkpRNhrcydgte+s=;
        b=VxZDXZDydAv27Bxj2Ch7ff4RII1CNFz6Q3r8xUJZFYkiQCJRL5cgc0f+an1cl/t/7G
         Zr6NM03hO8GZj6GVbt+gU71BP0YjDBmuyTyP8OcxqYGXR4LzbudOjXH+FuDjFoqn/L/h
         ENpQwD6vnv6TLGd67IqGqV+5O20cvDB3LLdJ9M4827BwI8Cg3X41++L3oMqET1Zz6xNK
         v+hkeXj6JhDTBhMrW4MXGmJVAtPF70punBfkQB2g0/Q0ghtqzCfWP/xPi3K2W8ZEfVvG
         35bSeQyKGlsqmTnlD0GVRkN34yBswv9kEaxu7rzGJu6+ZxneEdgZlsbq6KBzZhXfoYdZ
         fdXg==
X-Gm-Message-State: AOAM532Mc7eQLt/STQmZY64GPPq14o/DsEqzPnvVhK6zrmCohL7kcfQN
        hW1IEjM6/51otkZWYbcY4dOj+Dzc6QlUhnwnyrRmgA==
X-Google-Smtp-Source: ABdhPJzW67O6C9vTlewmPYueZEWXgOta5/XROIcEoGN53ysnR0hJd/d7skgEkNmYyu3AEUmA6VNv4b9QrbPT3pkFggU=
X-Received: by 2002:a05:6402:3074:: with SMTP id bs20mr2323306edb.365.1610436974032;
 Mon, 11 Jan 2021 23:36:14 -0800 (PST)
MIME-Version: 1.0
References: <20210111130033.715773309@linuxfoundation.org>
In-Reply-To: <20210111130033.715773309@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Jan 2021 13:06:02 +0530
Message-ID: <CA+G9fYs7DbYcEHx6UmS=3rCS6+QU6T=+r8kkP8xX1jM2sLOWWA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/57] 4.14.215-rc1 review
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

On Mon, 11 Jan 2021 at 18:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.215 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 13 Jan 2021 13:00:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.215-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Summary
------------------------------------------------------------------------

kernel: 4.14.215-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: e3be7c59d3c1eb71d34a1927c0fbc89052ce93ca
git describe: v4.14.214-58-ge3be7c59d3c1
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14=
.y/build/v4.14.214-58-ge3be7c59d3c1


No regressions (compared to build v4.14.214)

No fixes (compared to build v4.14.214)

Ran 38840 total tests in the following environments and test suites.

Environments
--------------
- arm
- arm64
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- mips
- qemu-arm64-kasan
- qemu-x86_64-kasan
- qemu_arm
- qemu_arm64
- qemu_arm64-compat
- qemu_i386
- qemu_x86_64
- qemu_x86_64-compat
- sparc
- x15 - arm
- x86_64
- x86-kasan

Test Suites
-----------
* build
* linux-log-parser
* install-android-platform-tools-r2600
* libhugetlbfs
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-ipc-tests
* ltp-mm-tests
* ltp-tracing-tests
* v4l2-compliance
* fwts
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-io-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* ltp-open-posix-tests
* perf
* kvm-unit-tests
* rcutorture

--=20
Linaro LKFT
https://lkft.linaro.org
