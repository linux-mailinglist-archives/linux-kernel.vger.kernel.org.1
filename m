Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D382C2D7293
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 10:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437187AbgLKJEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 04:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437180AbgLKJD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 04:03:57 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09171C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 01:03:17 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id k4so8560929edl.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 01:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7eG8ZLZ/xVAV854Cr9rPHZMwrfiBKoLF1b5N8yhTFKU=;
        b=i6BuCzp/dMxRoIooTZiOai75LKgIQbtdFRfvvrEI2bbHGyTZRvm4oaHnlABU8fBWZI
         9w8iNdtlO/ekPQYa+lwOfX+WyN/Ty0oq8M94YCq6Oqbc5/QGqGi9xkgpJ8+Wrazo4SwP
         28gA+7YieIeLMZ5XK6rUVUkmefitODYYyK57lY163eoZABj52BLpVgUjq5Y/pFzaN75A
         2dUhlqzm7IIaQoNzMVFoMjhbkd756C4NQttg6fMsP+mR//2e3Sw5gftEOm2P9zfyUAeJ
         7ips6s4dqwDelwIryUbNdxrDvUDahiaM+vBJ2cuOoZ4qBEs9Xzh5RO0ID0EogI0ZvU76
         5acQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7eG8ZLZ/xVAV854Cr9rPHZMwrfiBKoLF1b5N8yhTFKU=;
        b=ITY6R7zxmR1eWPAu0X82Y+gIirSuAd+4MKg95w6walQJhT95ptyt3TiNgutussqhMx
         ZgZvORdt5kAn6FWTQZ4UUD1y3fqXEz+B9msHoZWoOIcQXPk7L4EsG5Ezrzr10duZZUAi
         0YI7cUn8WeipvdyLEcE6NMA2X5FFjXmjsx/5nFA/9Q6R/8ZIFlNz2T3bbs6XH5x9f2zv
         k9s2foecTSE3xOWh9Jl8sE9AMZsICinaVbTL8MJ9lda1Xgm3bXJ0LiMZAxtF+IcNUq51
         qr+eOoC8zA9QeEV0roB+fZtyoowmRfZlk3BzkvgwLrkJBr2qUiWOPnFlOI66/+3zJTvS
         BG/Q==
X-Gm-Message-State: AOAM532xX/PRybFEjFCZ42AsmZp4zltMp3eT6JEPAPslD+iAIBwYfVd5
        1z7+bAM0sJ2sNzfkMqdqXV8MP0qB1giiU94n2FeK9g==
X-Google-Smtp-Source: ABdhPJyIQCnTm4HJyiXqXkHG21u+NQTQ3sQLLYeEBXVSQ1fRQmxqBQ8a+/2KTo/YuGVJtcduc5cjPAfmeZ8E9mjm2pc=
X-Received: by 2002:aa7:d74d:: with SMTP id a13mr10878002eds.78.1607677395631;
 Fri, 11 Dec 2020 01:03:15 -0800 (PST)
MIME-Version: 1.0
References: <20201210142602.099683598@linuxfoundation.org>
In-Reply-To: <20201210142602.099683598@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 11 Dec 2020 14:33:04 +0530
Message-ID: <CA+G9fYtjw5Oi0=_o67iXibrVq4smmENGoV7YMCootiZWTY_Aqg@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/31] 4.14.212-rc1 review
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

On Thu, 10 Dec 2020 at 20:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.212 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 12 Dec 2020 14:25:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.212-rc1.gz
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

kernel: 4.14.212-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: ad2d75a4fc6e81e11297320a54abb176b5de8dca
git describe: v4.14.211-31-gad2d75a4fc6e
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14=
.y/build/v4.14.211-31-gad2d75a4fc6e


No regressions (compared to build v4.14.211)

No fixes (compared to build v4.14.211)


Ran 36132 total tests in the following environments and test suites.

Environments
--------------
- arm
- arm64
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
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
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* perf
* ltp-commands-tests
* ltp-controllers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-sched-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* network-basic-tests
* libhugetlbfs
* ltp-fs-tests
* ltp-open-posix-tests
* v4l2-compliance
* rcutorture
* fwts
* kvm-unit-tests

--=20
Linaro LKFT
https://lkft.linaro.org
