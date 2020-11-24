Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B772C1ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 08:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgKXHVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 02:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730003AbgKXHVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 02:21:24 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A42C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 23:21:23 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id gj5so26981223ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 23:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EJ2fCqwl0eySHe3jwo+Hw3BwyNEcJk8739SIICPAssI=;
        b=OFDWI7MvlouDqI/Q5bMFuEtpfKtNa7xUw+VI2RR2B+RDR7H5MRH+SCIXULOX02ppZ8
         Iq17ZdG4e8yoLBErqe9ykQ61jhXSafdJpw9dRQexxNAu0iaFCdYOuZ5piOaiPVVWTGf0
         e6TAg8Bh55HUtweA+grxOsawebdJcUY6Hbfp3t0KroESOAb8C2rV4FfF+x3pd5C5AFzn
         GiYe0kNj4Z+MHiiwGXq2XtypSkyWCfPOumzKfc7pVv3sYAs5p5pTcOxl8yOJ41+DAahO
         0vt/d1WYACZmFlkJVuMutaLFVQEJNUNSrf30s5wzWooyH3mBHTKQ68R4mscXLfyEhaPW
         C+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EJ2fCqwl0eySHe3jwo+Hw3BwyNEcJk8739SIICPAssI=;
        b=RGqElCOgn8PJgc8QgYWEpRhzxb5R4LanUBqtVegrTbGbhVQuRAFfoBSCMNZlRUKTP9
         cJXpk2qMbzPe2K49NntwAra1seNpkETAKucQIqzJANVGwXLeu1IJ2Mz0l27NySSG4C3G
         /dfUrZ/wzW7GtWXtrWUc+F7WhZMfnnD/py2bZNg9HjKZQs5j9FscRG7wcIqjfBqE7zZP
         9ajRKddjfman3r6Eq5Fo7VRN0Ro6oZt1vdZMY4TFqzPnXqQStHgnQegTIW3WS/0Cyx/6
         q1QCZ/YpaKpS1KSAWfI/E5xDiWPvDvh8AeaBZc1g09PsBMRTgSXodB5LA0MX8E58saIZ
         EODQ==
X-Gm-Message-State: AOAM532vRdP8Nb6nx1xXt+mCHpX6tzVrbV9Zkydk8IwIcLFo75NIOuv3
        ZhnouuIL/J5WZUvqN/7MOtEawI5SVpTyEvz6H7fvxg==
X-Google-Smtp-Source: ABdhPJx7xDsX4OWoaMTMsbRiwhwu5oJ9YwqqdPwcixgx7Vi/H4WDPf81zb1RKvq3ECkUPIq1j8B/S0LE9zbvxifb1f8=
X-Received: by 2002:a17:906:bd2:: with SMTP id y18mr2821967ejg.503.1606202481868;
 Mon, 23 Nov 2020 23:21:21 -0800 (PST)
MIME-Version: 1.0
References: <20201123121805.028396732@linuxfoundation.org>
In-Reply-To: <20201123121805.028396732@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 24 Nov 2020 12:51:10 +0530
Message-ID: <CA+G9fYvnEr79wGM5w7YawUco4_nUyBgO_EiTvbuH+9et3F+VSg@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/60] 4.14.209-rc1 review
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

On Mon, 23 Nov 2020 at 17:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.209 release.
> There are 60 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 25 Nov 2020 12:17:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.209-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Summary
------------------------------------------------------------------------

kernel: 4.14.209-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: c3391de31d51a6a479f081994040a5fb99b29c9b
git describe: v4.14.208-61-gc3391de31d51
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14=
.y/build/v4.14.208-61-gc3391de31d51

No regressions (compared to build v4.14.208)

No fixes (compared to build v4.14.208)

Ran 41581 total tests in the following environments and test suites.

Environments
--------------
- arm
- arm64
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- juno-r2-kasan
- mips
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
- sparc
- x15 - arm
- x86_64
- x86-kasan

Test Suites
-----------
* build
* igt-gpu-tools
* install-android-platform-tools-r2600
* linux-log-parser
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-dio-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* perf
* v4l2-compliance
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-mm-tests
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests

--=20
Linaro LKFT
https://lkft.linaro.org
