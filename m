Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DD52BC439
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 07:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgKVGJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 01:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgKVGJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 01:09:32 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22F0C0613D2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 22:09:31 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id k9so3924528ejc.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 22:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aBBwBlA22QC656KlaaLPkAl+8ALxwXkiWH2H2fA7VlY=;
        b=g/wRc6nDv/a/dIxiL2XoKsCWDcJeuzyAYizXhnr9MYNYnG6buWzFu9LN2AL+23AmI3
         uygvZcjkVf/eYolW7Cpg5WfxR91wyZs0fQevq6WxlcJWky3AAZFYAPzxqmaLsXHbevyo
         6Dvrtgw2JhzNeJ0IeDlG6tMVYddZ7ny/nrIrPSG4ERDkgfOTv+SxSj1MOVi6G4JHgJ+x
         Q4nNZPbnnAHai1C1O+mpSK6hWWr67lRHC1jELnTsITYTK5l8US6p3uG+pY2Sy2jQngiM
         cBBS78pedd7wZ5w4ZKSuDWDZta+h6gZrVT6zYCuSyR+9r9mLUmy8mVhUIbMBl0qoAnDd
         Mhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aBBwBlA22QC656KlaaLPkAl+8ALxwXkiWH2H2fA7VlY=;
        b=tb/prNGY1cGrQQJ90+ojSLyx5pNQdldo/sPpp/WtK+fP9WpM3UsWzHlKCdlN6VQ045
         bsDqAA8vX95zb50O7W17VLZke2GBzd4ZWaSzRAUQYD9LXK9SXzw2cPrJns+4zoGT9+9U
         WAxtYmGdbg87k0iwXZheHG3puaY3WODOR+bw2SMV7frCCazIhA86tJ9kdKgkG2UjcV8S
         0x/o+n3MlAAwDHnij6TPcf7lrSkiceA9Ds3EzzxyxAv0QR2N+AvogY8SMsjeu/fVzCDV
         KONzjOuaPfS4J3egJRl9PXJpeFJtPjsD/fASwY2Yx4fHfC4AvgH1e2D+DTLQQHj8MEsp
         41JQ==
X-Gm-Message-State: AOAM533JCMQv2fXe31EQhZzKGf1MHvn2Oh89Q4vZQ/FOyB69ME46UOAp
        PIDIG3THd7x8m3vJw3kBqKV0yPmj1kB9hsRvhJxIKw==
X-Google-Smtp-Source: ABdhPJxj23CcVoU2G/j6AmW76nVrLEJDkFcKwB2cHxkARfXYKZn8efkHby1z9v8OEEJy2MniPGOPolrt3ASSSs3lFUw=
X-Received: by 2002:a17:907:d8b:: with SMTP id go11mr29551693ejc.247.1606025370389;
 Sat, 21 Nov 2020 22:09:30 -0800 (PST)
MIME-Version: 1.0
References: <20201120104539.706905067@linuxfoundation.org>
In-Reply-To: <20201120104539.706905067@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 22 Nov 2020 11:39:19 +0530
Message-ID: <CA+G9fYutCwAuH3BfDQ4P5g_RhhNokqV5+Tbkx2SiwZ2xvUxXqg@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/16] 4.9.245-rc1 review
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

On Fri, 20 Nov 2020 at 16:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.245 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 22 Nov 2020 10:45:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.245-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
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

kernel: 4.4.245-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 11095ab90e22ac875983239a445f6b4ad64b6e08
git describe: v4.4.244-16-g11095ab90e22
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.4.=
y/build/v4.4.244-16-g11095ab90e22

No regressions (compared to build v4.4.244)

No fixes (compared to build v4.4.244)


Ran 32775 total tests in the following environments and test suites.

Environments
--------------
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
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
- x15 - arm
- x86_64
- x86-kasan

Test Suites
-----------
* build
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
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
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* ltp-tracing-tests
* install-android-platform-tools-r2600

Summary
------------------------------------------------------------------------

kernel: 4.4.245-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.245-rc1-hikey-20201120-861
git commit: a395e149575bc8d8ec23a677f979301bfefd8862
git describe: 4.4.245-rc1-hikey-20201120-861
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.245-rc1-hikey-20201120-861

No regressions (compared to build 4.4.244-rc1-hikey-20201117-859)

No fixes (compared to build 4.4.244-rc1-hikey-20201117-859)

Ran 1722 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-cve-tests
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
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance

--=20
Linaro LKFT
https://lkft.linaro.org
