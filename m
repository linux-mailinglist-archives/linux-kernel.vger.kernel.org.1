Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3122CB4E4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 07:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgLBGO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 01:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgLBGO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 01:14:58 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D69C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 22:14:18 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id f23so1434783ejk.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 22:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EuICHgSSDwR0PQ8D2vWp77EHBQ0KIkrC0mpkYP8zoyA=;
        b=QGKkzN4V47I8IDWe3smCmOlOTISqCu6/q4DKaO9lz5hEvD0QIaT5Dbf49OcuJ+7mgc
         AxaEa6mMWNG86kTlKDbbLPxOzE9yJOwH5FRzsV9tPigz+386yx0C/Vn5taUMO3wiEYHP
         XOasFdH0I7P5zlNUfAdK9IuYw0IsSQayOFmxjWljZY6vuuO/8B+LbKxDJ2C9j/kMJ7mZ
         J3p1tXL0s1e8YXRI2E2mdy+jxJl6l8Yhp/YcqnKNEuK+QczY6e0QmGOPyxRdRs3wUP1c
         X7HBeNCzRYAx5YbNHD458uXNErZ6Z0Fsel/Rv9iG6H3QzENYzpGNfuxtK0PXSPctiM7H
         F1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EuICHgSSDwR0PQ8D2vWp77EHBQ0KIkrC0mpkYP8zoyA=;
        b=YKJVyCH6QiYa4GSdOiteRCjDBLX7aEAYzjTZkX/3XqTTFP20yED+/vDcghJWFueCx3
         ilN4HorSegDoRAoOlPanpCOpuBZyVMlnuztyzV5xhGI/M4IdjocteLi5Hp6N9Zw2qCab
         D/zDmzuvU/RlVwp8RqR+QwQPxVyLZkcruKlSXuisxL7Qo3sH2NvgEKBjzvh9THq14BFC
         3hEWo3feFiatd7/PH/+4to9aL8GLgLRG8AvBMpTvcyQfc3ym7fPvqmPcRS4LVWy98TZs
         i4gFxdnYdnpuFD6Lg1KfNFpivGEBkP7WCPqhc07/GkjwlEMUcGnRCB9ytgKxVsegMz6o
         GCgw==
X-Gm-Message-State: AOAM5321KI6FOT2f0mJ76v0Up81gX9g2E6Di8IamQ+nzPiom1s+ARSaY
        oFSPOIYQ/aj67Sj6LttdUaMZaVThe93A34gwiIFQQQ==
X-Google-Smtp-Source: ABdhPJzdZlJea73AeLYu92Y+ZvWcNM20R9dDfFH6P6h9mr+p04eyH5vuUFiGhuF1c2jj46FSLBD5ysR2FJI3XmqAyUQ=
X-Received: by 2002:a17:906:bd2:: with SMTP id y18mr836262ejg.503.1606889656578;
 Tue, 01 Dec 2020 22:14:16 -0800 (PST)
MIME-Version: 1.0
References: <20201201084642.194933793@linuxfoundation.org>
In-Reply-To: <20201201084642.194933793@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 2 Dec 2020 11:44:05 +0530
Message-ID: <CA+G9fYtERgH=zTCzBeN40eQtdiO5Y23bsmSjmn2Htc7EsD=xqw@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/42] 4.9.247-rc1 review
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

On Tue, 1 Dec 2020 at 14:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.247 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 03 Dec 2020 08:46:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.247-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
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

kernel: 4.9.247-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: c2b4ff37ba1a5a9bbb5160e311d472b8185fb347
git describe: v4.9.246-43-gc2b4ff37ba1a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.9.=
y/build/v4.9.246-43-gc2b4ff37ba1a

No regressions (compared to build v4.9.246)

No fixes (compared to build v4.9.246)

Ran 24845 total tests in the following environments and test suites.

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
* igt-gpu-tools
* install-android-platform-tools-r2600
* kvm-unit-tests
* libhugetlbfs
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
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-tracing-tests
* perf
* v4l2-compliance
* ltp-syscalls-tests
* network-basic-tests
* ltp-open-posix-tests

--=20
Linaro LKFT
https://lkft.linaro.org
