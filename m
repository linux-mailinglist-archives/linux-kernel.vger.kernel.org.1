Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EDF2E6F37
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 10:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgL2JAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 04:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgL2JAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 04:00:01 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9ACC061793
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 00:59:21 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qw4so17248665ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 00:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=auzRq/WF9+PTvabIevpBHQzlvNB7wqSVZ8j+j07kOYQ=;
        b=NC8ojlYEyf7mX3rN8/r6ldCDWWw+1T5cEJlBx8oZ2SHZ3lHMH+k9YDhKXPIZKhGt5l
         WXu2m0Q2ZNpmybe5yb1ER8z+5pjsjM3oi7I8/upy0P3PwV/0YrdzqA/ySTQtuHM4uqK/
         Wy0+5JK6Tfyg1a2F8Ouo53hfKHehph+tRSL0cifNmQ62QZ2evMXVN2LIw5EZUGWDTzd8
         iRR3e9RKdpllOZ7EkNOfXULRC5nlqsQ9c4twDiYDjEMzdVGzvE6SrYFELs1cFUpN4G7N
         dPGrsd9iCqi/BAdtZ+FXj3WqACmEVyyBxgr5N3QSg6U3fP3/eFmfM7BiPliPAGzjBDn4
         uNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=auzRq/WF9+PTvabIevpBHQzlvNB7wqSVZ8j+j07kOYQ=;
        b=sZEmgIV9ZGjg1Rh647/TTDVdswCFih0WQRg/5NQ0DOn+lcF1iwm3edTRszxQzHKUNn
         3dEKlwVhvEevHdlqSXRn6Qz3Hjz57yHpPg3xNnflMBmIr7RZHMdpi9obZdWBdlkrCvQY
         9p81WBm8L8fZZgEWfz8fziHkgQUhXKlUJnYurbjK0UYqeIz91+KrPFPD9c2suWb7on+0
         z9S+nGKVNn07ykR9lScFGzD4nI803QUcX/TOs7UvhaO5c1F/aUFMC95kp1wWD8JlzxVI
         xH2DngDXgTw4kgYaEaFSTLYxUmETRDSUSrzkiIbG9PvuJZQiOhRb15EqZ1kH51gJ4/Jl
         9+yw==
X-Gm-Message-State: AOAM530YqF9HzLgOAUkO9CNLwwVMTMIie0lu0v1Ab4D/VLvey7HLcPkc
        Gm1ZXBGH6ziepeglhU0ZA0W+d3uicMgKw4yLjXmNLQ==
X-Google-Smtp-Source: ABdhPJz/XWXFEkZ1Jt3/VQ4XpDl+AoLBTXf8u/i9Np3rnfd8mkcmHKAlhOdDUV7hVw3xd70qxjNf9Q+mqI1Nq06IGZc=
X-Received: by 2002:a17:906:4443:: with SMTP id i3mr42069662ejp.133.1609232359999;
 Tue, 29 Dec 2020 00:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20201228124904.654293249@linuxfoundation.org>
In-Reply-To: <20201228124904.654293249@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 29 Dec 2020 14:29:08 +0530
Message-ID: <CA+G9fYuL1eV5ZCBa-nVq1WUQfpzGop0n-WDP70s2_ic=o+v2vQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/242] 4.14.213-rc1 review
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

On Mon, 28 Dec 2020 at 18:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.213 release.
> There are 242 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 30 Dec 2020 12:48:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.213-rc1.gz
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

kernel: 4.14.213-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: caadb02efa3e1be5616bc1cae5b2a4a628b4730c
git describe: v4.14.212-243-gcaadb02efa3e
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14=
.y/build/v4.14.212-243-gcaadb02efa3e

No regressions (compared to build v4.14.212)

No fixes (compared to build v4.14.212)

Ran 38814 total tests in the following environments and test suites.

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
* fwts
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-sched-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* network-basic-tests
* ltp-controllers-tests
* ltp-open-posix-tests
* v4l2-compliance
* kvm-unit-tests
* rcutorture

--=20
Linaro LKFT
https://lkft.linaro.org
