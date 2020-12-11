Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2FF2D7120
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 08:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405444AbgLKH4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 02:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392064AbgLKHzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 02:55:47 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF9EC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 23:55:07 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id w1so6410393ejf.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 23:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6WgZgvG/ljgMIOXiku6yUi70xFbZwsNxGe2W8rsUeyA=;
        b=cysbuFJrtojnGriqj91ZKxBOHZxGBvOQ3tmrV8C8mjj3vRhpADscrR+XUDvPj5uVFN
         zcMuSTVtTSpwxqpuZXurNQr9F7Kqqwebg9FcGv54/LYHpmrDnjF5zLW6A1eV4mdJAM29
         Pgi2zq9flqdRaU/c/mbsSsbZLa3LnJwYyNhBl8aPkFRIC1vPQS3NShOA6OiyiUKXE70P
         y9tadBT9miL0vBnxFshsi4Fbp3Gwpj4X16H6bzCKNn5uxdWvpXvsTqBMIWSVpXPxmCIY
         ztm+1ZWuN5kwilzoKvpEJn38ssy2orGOHuodUbrlyflHY6zCk5Mrn4gmI7nQK/82iuaE
         YQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6WgZgvG/ljgMIOXiku6yUi70xFbZwsNxGe2W8rsUeyA=;
        b=m65NF9WIFDFU2E3hEl9mOJm6jwNmhGBswq37u4jyJ0T4OYOhBmSsOKRIGf4YxC//R0
         WM/v8Z6gaCqG34KMmOR9rNsIjLqNJXFHU1WfItH/13L1H6qyNQNeDww+RRhOQDPvaKzj
         HW04ybhPsHv71jTgjZAzvmWW4A1i/urV7tqzL6cBkDwje0UlVbUASqry9DIzqJQDHonn
         pRW4uYVvGQaYwnAP6m2HfIubT63VX2ZoD9hn6MyrEn/TYB9I0Rj2PNr9WgddHptG4pFJ
         IEFeNHqFepT5bwkc8ZLvIc1XGA9zPMfK4YIdMeqaqrbaASjeT/A0qrKTZCe6PSDd8OeT
         1zqA==
X-Gm-Message-State: AOAM5301u74yImp9eCElgc3ITiY5kDi81l3pJtDp7TilIH4efMYeklpm
        UYwGGkgvRjyM5aRKX2117zbOCO7DwB1WS2DsStiJ0g==
X-Google-Smtp-Source: ABdhPJx9DKvx3b5K0JDsdFmRIh+FWVkw1DrPYZsLv/SWpk+vEaSWN0y3Rj3ItJPKzDtKXnnQNeggWRupMf/1xzT2fXk=
X-Received: by 2002:a17:906:1758:: with SMTP id d24mr10170113eje.287.1607673305947;
 Thu, 10 Dec 2020 23:55:05 -0800 (PST)
MIME-Version: 1.0
References: <20201210142602.272595094@linuxfoundation.org>
In-Reply-To: <20201210142602.272595094@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 11 Dec 2020 13:24:54 +0530
Message-ID: <CA+G9fYudCcZciZxoZL4YVgF6eRmWfipQj=xwsPnusy0y_xNQww@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/39] 4.19.163-rc1 review
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

On Thu, 10 Dec 2020 at 20:05, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.163 release.
> There are 39 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 12 Dec 2020 14:25:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.163-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
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

kernel: 4.19.163-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: a1b1c60de6b977bc1a2fc8176b647879030ab862
git describe: v4.19.162-41-ga1b1c60de6b9
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19=
.y/build/v4.19.162-41-ga1b1c60de6b9

No regressions (compared to build v4.19.162)

No fixes (compared to build v4.19.162)

Ran 43756 total tests in the following environments and test suites.

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
- nxp-ls2088
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
- s390
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
* ltp-controllers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-sched-tests
* kselftest
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-ipc-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* network-basic-tests
* perf
* v4l2-compliance
* ltp-commands-tests
* ltp-fs-tests
* ltp-math-tests
* ltp-open-posix-tests
* kvm-unit-tests
* rcutorture
* fwts

--=20
Linaro LKFT
https://lkft.linaro.org
