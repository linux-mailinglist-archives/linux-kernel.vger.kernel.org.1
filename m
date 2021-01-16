Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3AB2F8B1E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 05:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbhAPESx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 23:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbhAPESx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 23:18:53 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56ABC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 20:18:12 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id g12so16193531ejf.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 20:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oVeAh9XH1tHjATPaFlf3b6/mzNod8uC1zJeVizGigjE=;
        b=ttchKzrCk5QeWQgwrgKoLb635GFuhheINWChlDPvaCBJc1GHJGEl8cXvs/yBbI4Gke
         XQok1KQ27AtcyLbVi85X+/n5tEuIPuHaRvHBDUsUQ58dhQvqIUkHVTNW3MlBDXVKFHZu
         JYciCt7AwUKzBDfMe+DryvbC1j+7CvOPob89Is6t9IM5XoUJCH6WNcBdiqMsobcugJfy
         AypQc+ZBTsXuz0Es/vf2y4Yqrlx3cOiiiXpaXKQ4ua7xWjRA0EWAnNmleFF3rVWdyqb/
         gSPbapPpR5qugLquskVn1PQakhnyZCkMyipFWnsrusfhvc/nOmBUGX25wE3vM+RKUFCU
         jX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oVeAh9XH1tHjATPaFlf3b6/mzNod8uC1zJeVizGigjE=;
        b=b5vl+ibsH2JxijVZ/N095VjHAeHhERklj1HKqKnaa+U+F9oAwHrtXlS4ZotSOn30ik
         zb0CPEpnBvELCp1E0H29eRiGAqaJrUI6F3Y2qsQOveNey2BwcyNMeTzuNln6cg44J8wM
         Ks9E1/ElS7cVcYWFmXrH9lfARgJ7xfogVWtt5a/QGdfmfEFeiDFb9u1k+F2hECCF4CwB
         7ERBWPidkTSlz7vKlo+zHbDeczs5bL8PlWaVVF/ZiCGAHGYY7BUXEFinbxRVmRNRhpGj
         O9p3C1ngYIx/XlS79IpRneeUplm7ARbM2XbbzG02DinqcId5yima3T8jPpPh4mezWhcS
         SlxQ==
X-Gm-Message-State: AOAM5316lY2CL7lhfL2yMY6JGWFnyMdy2LwzTjTnhIxFw2RRPlBvwnaE
        CrkRjVtSp7TD7YvPN/FbsCuK9dhTI6O0wjkBZLLkXaaF1zgdL0MK
X-Google-Smtp-Source: ABdhPJyl6/J0N8HeJAnidSikL3m6Lo7D+uZDgKyheQo2ZDBdglJoBa9Czw4EoX7bX21e6YaGL3EpnpPLeEZcicvbA1s=
X-Received: by 2002:a17:906:1498:: with SMTP id x24mr10699884ejc.170.1610770691287;
 Fri, 15 Jan 2021 20:18:11 -0800 (PST)
MIME-Version: 1.0
References: <20210115121958.391610178@linuxfoundation.org>
In-Reply-To: <20210115121958.391610178@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 16 Jan 2021 09:47:59 +0530
Message-ID: <CA+G9fYs4tH9n6CxmF9wBprXdX9iq+gM7GsR-pK031g0yJC=j2Q@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/62] 5.4.90-rc1 review
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

On Fri, 15 Jan 2021 at 18:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.90 release.
> There are 62 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 17 Jan 2021 12:19:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.90-rc1.gz
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

kernel: 5.4.90-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: addd8d79e8f6b991ed5ff59f0ad22a1170dcabd0
git describe: v5.4.89-63-gaddd8d79e8f6
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.=
y/build/v5.4.89-63-gaddd8d79e8f6

No regressions (compared to build v5.4.89)

No fixes (compared to build v5.4.89)

Ran 52491 total tests in the following environments and test suites.

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
- parisc
- powerpc
- qemu-arm-clang
- qemu-arm64-clang
- qemu-arm64-kasan
- qemu-x86_64-clang
- qemu-x86_64-kasan
- qemu-x86_64-kcsan
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
- x86_64

Test Suites
-----------
* build
* linux-log-parser
* igt-gpu-tools
* install-android-platform-tools-r2600
* kselftest
* kvm-unit-tests
* libhugetlbfs
* ltp-commands-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* perf
* v4l2-compliance
* fwts
* ltp-cap_bounds-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-ipc-tests
* network-basic-tests
* ltp-open-posix-tests
* rcutorture
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
