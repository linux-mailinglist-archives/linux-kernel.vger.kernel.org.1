Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAA42B7CA1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 12:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgKRLZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 06:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgKRLZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 06:25:24 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3311FC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 03:25:24 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id a16so2247671ejj.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 03:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fWKyRf2WsGHgLb7HiAmjkYpOWmKSOplli+A+DLy0S1A=;
        b=d6h2oBOgo8mPEvFFMG9ikJzYINgr2PJUstL/3YRrVJBCArbW00nZK8tLfkWao49J+B
         R0NmkkNXipiwcl71+pRwsbyJZR9JIdjpUGRlcXW1caUKFKQqoPy15C9pkc434Xa2vHY3
         kp1YXrFqF6YRnSLHJj9qo7+XuOW3mF8ueGL5bgKR8Z8zbPu2KwngbvhDhmWHFAi4T/+g
         QavwecWVrRbsgG47fe5PJrafK+RLkwElzsd4Y/Q/y1zga6R9vjN90WtzGeVaqWgLZpkl
         IAu6A0Fcx+3SmE/JdaXrZeTsry6+aBWkJ4wygNqPdakgW6ER4FW3e3AHIHiG0Oq3S+BA
         60FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fWKyRf2WsGHgLb7HiAmjkYpOWmKSOplli+A+DLy0S1A=;
        b=qg1QLz0oBXKcfvMUquxqOS3vqY/hpqWduiijuI0PTpjLa/4QqlBSF9GixNmEfA4sXW
         EnwaRrIwuwlW0c6P00YzC9ppt9wD9zXdOvY50JP/iofpsmNOrHIYZ83EE0Dn15IaghGj
         MWiV9hkTr/06DET1WRTWr5ax3aaCXL8kQIYYZY8A0GfiOhhvuIrTJU3qtn/kHiFx1hVz
         4QUQgAzaXVOD9K7AoUIjznc8bZw3puws4CvDJ+LWqzmE0jHHdcutefVGdHskjWtWMu/5
         ted3FGO/1/p8CiOoZTLj5UkwQ3K8CBLWAyoSYxmCwmFhyrrx+u2WAfGIH0WgPgiLGGEu
         BPiQ==
X-Gm-Message-State: AOAM530tvkfPtTNRCJ2GTrOKASVnNaeZmZLvwUyJAHWwWgiFNVUHZEKV
        RbIxmlNTK+Qg33HAa0yAe3JpDf4yr0SiZUv1VIAQqw==
X-Google-Smtp-Source: ABdhPJya9T6m7LJWsC7KLQDRV29Lbf+oR9VCfnP5P0PVMelIFdzdzjtVjdfHlmk3dHQuMc4dgqV8K+p2WgsBb3YOt0Q=
X-Received: by 2002:a17:906:af8b:: with SMTP id mj11mr5668211ejb.170.1605698722788;
 Wed, 18 Nov 2020 03:25:22 -0800 (PST)
MIME-Version: 1.0
References: <20201117122106.144800239@linuxfoundation.org>
In-Reply-To: <20201117122106.144800239@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 18 Nov 2020 16:55:10 +0530
Message-ID: <CA+G9fYuQYufAewC_CzZ4ibo42iJNGZ2rU_1wRn8Z9zgXoi8W6g@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/64] 4.4.244-rc1 review
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

On Tue, 17 Nov 2020 at 18:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.244 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 19 Nov 2020 12:20:51 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.244-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
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

kernel: 4.4.244-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 5c64a4febafe0af1834cf497df8985d917a94b05
git describe: v4.4.243-65-g5c64a4febafe
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.4.=
y/build/v4.4.243-65-g5c64a4febafe

No regressions (compared to build v4.4.243)

No fixes (compared to build v4.4.243)

Ran 32841 total tests in the following environments and test suites.

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
* ltp-tracing-tests
* network-basic-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* install-android-platform-tools-r2600

Summary
------------------------------------------------------------------------

kernel: 4.4.244-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.244-rc1-hikey-20201117-859
git commit: cdeaa8f4dfeb6e5920b76b6ee2d57b77b2810576
git describe: 4.4.244-rc1-hikey-20201117-859
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.244-rc1-hikey-20201117-859

No regressions (compared to build 4.4.244-rc1-hikey-20201114-857)

No fixes (compared to build 4.4.244-rc1-hikey-20201114-857)


Ran 1760 total tests in the following environments and test suites.

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
* ltp-mm-tests
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
