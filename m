Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5982F8B17
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 05:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbhAPEKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 23:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbhAPEKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 23:10:22 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F534C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 20:09:42 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id hs11so13862465ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 20:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EHi84hZmWU8MIMsfAE9gQrT9RCXAf7IZ5fZ1br+tJqI=;
        b=RzQn+eeqBlWd67oe0geWsSLVFez8TXcTOSU39ZMDDqS6F1AiPlXH/QVYCEvVrIznK2
         dHYe9/W3a0QooFAqsrdmWhdfXHD76vfg/jGKPtbfMFbRoY1Ptyrrp3E70GdwNKLmn1Qb
         ENGIy+vyS70HwhB3mRbkWkEp6/PYTeQ3c2H62WreD+C5yee2UCg21S8Y81VRSxmvJ0JV
         MG3pDBnijfzM4SBO1REwGqDOsvTNSUcLoqOjKYs8VRNAl/GB9ahstzKiFcNjgLgJ32D0
         byyEp6MjafPzKQC57F4l1DBYJ5Vb9gBPY9zl27zyDomPaT0w/ywtzSbuE6QOhpxvtQh6
         naDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EHi84hZmWU8MIMsfAE9gQrT9RCXAf7IZ5fZ1br+tJqI=;
        b=e/rgsbV7L0Qpy/tTPBqbnsrSktRmW5t7LHbTVLtQyV3hqydvzk0dnzUr+dhbFm7U2s
         pg8w++cQMSFNZN7cxyCr5QE1rdYeSzE/aftTkUoZJU8Y35yDhbTvyksD6jAWuzRm/O1j
         OPI6aLuaxj4msHsqWnT3mgj/2f/eC2xo05/khFcAnRjf0wZzC07c2/KXq5ACkluqTMK/
         22iJJxlchlWmHYAklO/wo0I9bLra8yA9fA4/KgMLn3E9kwwuvWb+s/20vU8imOk5bjJp
         tLqOMg4iRfdSdrusW6/OmIt1PIkvPoNYDKYDmr3bK9nlkY3v9CgyGcyCoN7C3HyKhB5K
         PHew==
X-Gm-Message-State: AOAM530eBIPVpHDAUVoqIVDPGe4xEn1/E5fefzK6ylVzdmQxCydIIl9F
        4tT+NJxbOO2JVSM9qe3ua6I2Ig0XXIgwz+MGogemUg==
X-Google-Smtp-Source: ABdhPJyIu3C5En47whg3wuZQ/YoSt6C8oNtoewlnUm8rVfKCGwNv0RWvJrl6X+pxn2tuyYjiVgcngYvUEGm7iWY9d90=
X-Received: by 2002:a17:906:1498:: with SMTP id x24mr10686056ejc.170.1610770180681;
 Fri, 15 Jan 2021 20:09:40 -0800 (PST)
MIME-Version: 1.0
References: <20210115122006.047132306@linuxfoundation.org>
In-Reply-To: <20210115122006.047132306@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 16 Jan 2021 09:39:28 +0530
Message-ID: <CA+G9fYt4ptQmnqu_kYh2kpA-hPfRarzg8CdCJMeaxRf_CyGu9A@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/103] 5.10.8-rc1 review
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

On Fri, 15 Jan 2021 at 18:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.8 release.
> There are 103 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 17 Jan 2021 12:19:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
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

kernel: 5.10.8-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.10.y
git commit: c6e710bf849bb3f24b9359dc732ce6c3d89c5fc9
git describe: v5.10.7-104-gc6e710bf849b
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10=
.y/build/v5.10.7-104-gc6e710bf849b

No regressions (compared to build v5.10.7)


No fixes (compared to build v5.10.7)


Ran 51644 total tests in the following environments and test suites.

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
- qemu-i386-clang
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
* install-android-platform-tools-r2600
* kvm-unit-tests
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-fs-tests
* ltp-ipc-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* v4l2-compliance
* ltp-commands-tests
* ltp-containers-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* network-basic-tests
* kselftest
* ltp-controllers-tests
* ltp-open-posix-tests
* perf
* fwts
* kunit
* rcutorture
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
