Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91EF82C1E6C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 07:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgKXGjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 01:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbgKXGjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:39:19 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E92C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 22:39:19 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id l5so19637290edq.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 22:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z+h2jKR1HnxM4LLFYi0zdaEFDI6R7RmOjCgr7rLqgWY=;
        b=D5AWs3bV5mDoMD/n77P24DkEcXJ0IYm1yH7BFPUBmbVzec0y6zUWtvB2aHlc8Cf3gQ
         dC2CfwuJbt+JCMh8IpskwgZ7+ki0ZCpMjHsmbpy+Jb5NmX9yzFkGteAQLppJjY+FcYqi
         tEIWNUGnve6y1nbeUaatoMgFhLgcIy1SE8xO8PmzfPJTW3F2I25pAf3I84Gg0f5YIL+2
         QwwJ1fCgZI+Nt39lQrr9UY1wogcNv7IHCMCxy1uTYKNnQTYI0XmBEe8nqnxRPKo/Nfw8
         EY0kjU29wPkLICyR23XSd5phTCImJ4MOJaDnup3bpg87YKMsLc4WDfJvE8VGXMlfqNkw
         hxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z+h2jKR1HnxM4LLFYi0zdaEFDI6R7RmOjCgr7rLqgWY=;
        b=ukwk4pEIAgBXD6k1DFREnloTWoCgOjnwWbZf0ixeJeIsezZ3CV6pA3floNh84ogG0Z
         xtPN5QXSH83rCDVFI8fDUtDME5DlyxJZWfx97w1+Z/qhJFcpKJ4nnBE+DN9PS9zA8nu6
         54xs22LLD8ImBoiDuJuxL6NJtn2C2EIJSWok5wmc/SitTV1Jo3snhVcM3V5ZbuyYR/R1
         yYbhn6lxjmSwVmPfoJL0sRrWcTo5d6Cg5fVKyBb9KJK8fR9widzjIWhkPsqV4n4c2Mj/
         tAjIEPVURGHVlpa5K2xha3CkWOpYnXBbCB3U5vuQqEzrjr70MzZwchxSLTb/CpXbTVGc
         HyzA==
X-Gm-Message-State: AOAM5317WFmMUZSAWD1j7XJEpGMET1v3JS9WdM22ec15U+RSwYJuZgjk
        TBiKU5DbkmRe14omLT+Lutq56AZLhlSOFoTW7ae1Ag==
X-Google-Smtp-Source: ABdhPJzLnHu3hUdcqXmgoqK0MnPZjjUS+jpa10kuGCUYE3D4Yzrsy5mtugPj9dmWmDLlcgoPycotaiUI2Y+qv3RiW5k=
X-Received: by 2002:a05:6402:b35:: with SMTP id bo21mr2710696edb.52.1606199957697;
 Mon, 23 Nov 2020 22:39:17 -0800 (PST)
MIME-Version: 1.0
References: <20201123121819.943135899@linuxfoundation.org>
In-Reply-To: <20201123121819.943135899@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 24 Nov 2020 12:09:06 +0530
Message-ID: <CA+G9fYvn15eQaWNyAUgmkWzYaro581UAk0OSM_7WOO+UJgL0_w@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/158] 5.4.80-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        linux-stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Nov 2020 at 18:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.80 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 25 Nov 2020 12:17:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.80-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
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

kernel: 5.4.80-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: 0048695749b29788fab5e9fff442f5a5968290d3
git describe: v5.4.79-159-g0048695749b2
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.=
y/build/v5.4.79-159-g0048695749b2

No regressions (compared to build v5.4.79)

No fixes (compared to build v5.4.79)


Ran 46177 total tests in the following environments and test suites.

Environments
--------------
- arc
- arm
- arm64
- dragonboard-410c
- hi6220-hikey
- i386
- juno-r2
- juno-r2-compat
- juno-r2-kasan
- mips
- nxp-ls2088
- powerpc
- qemu-arm-clang
- qemu-arm64-clang
- qemu-arm64-kasan
- qemu-x86_64-clang
- qemu-x86_64-kasan
- qemu_arm
- qemu_arm64
- qemu_arm64-compat
- qemu_i386
- qemu_x86_64
- qemu_x86_64-compat
- riscv
- s390
- sh
- sparc
- x15
- x86
- x86-kasan

Test Suites
-----------
* build
* igt-gpu-tools
* install-android-platform-tools-r2600
* kselftest
* libhugetlbfs
* linux-log-parser
* ltp-commands-tests
* ltp-controllers-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-tracing-tests
* perf
* v4l2-compliance
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-sched-tests
* ltp-syscalls-tests
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests

--=20
Linaro LKFT
https://lkft.linaro.org
