Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419EB2BBEC6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 12:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgKULqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 06:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbgKULqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 06:46:30 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425F9C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 03:46:29 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id l5so12171202edq.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 03:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ff4oF0cuFPWI/wGz47sbc9grPQs4m0FXv8uXi2g6pOU=;
        b=wL+2+n+/02ZW3TcVr525bVMRoiuc/Hnc5of0kozEfmO+wgmNHoLYgPy3f4zhNQO9XH
         Q8tFtDAVQf27RMAvAn2dNqDovbsAW0fjbjuq9lgp+VJYym+VKnFfpmUeC0nQTeJvbwOs
         QPSRQxyF1lv3LIT8DSX7yk52qsK29jXXBeDea0V3UwVMyeVUAM0BgFwAhRWOrCUd4hMf
         /IzBOaz1DfY5oTIK/c2cp1VsqwwEUQU2PU2OSREpspr/zCyG5bzKKxKqH22Yi2TUGkfA
         IlwA4QFM2p3jiRBdPBxLzp/KFcew5RhFzTgY57/AiFzSl563EwKBDHmDwdNflR7MibEj
         DYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ff4oF0cuFPWI/wGz47sbc9grPQs4m0FXv8uXi2g6pOU=;
        b=fClbl2uB2Y+V3dp7amBzSOjHUAmVab0F5ZAap+JGJNn2sHAqcnkUb0qlNN74GFSh+R
         enQ9qmfXXM57Ji+sGLbjEZ24Aj/u9+UV7n8H7nmlG+uyEvJyc6Fx/cpMefJkQfvDyeZR
         SlGUd1mdinMzMp8uBpjzrW8GMeA8zl+5oeNy3sCfuZS0LZeKtCGmknQ4HU/qi414e8jQ
         YPhdaJwDEjih6/rjTm2Q3LvtXyI83azJmNUF6m73BOTCMdwuqw1pKrJUU+03VIccYpev
         +xzr5YCb6Q6m0rnH21+5NDjvBGEZvcv1at8t4oXV/QIFRv8uncn2sH2dvYCM9vZLGeNj
         y0FA==
X-Gm-Message-State: AOAM53378fD24g8Fi++/ur5ZJhPDcC0oRSOP5a+Qb0WV5qmLGtVrNUSU
        7kJoXHTM8E9pb722KUb8LJrooBG19mgGGgrYfuzFsw==
X-Google-Smtp-Source: ABdhPJzKNhsLsEkK4H1rXQc2d0To33z83w8kbwfQD5oXIGJ0ktpFD5o2aYGv7gs8UNlabMJJnze7sQkbo5Klq+7UoZk=
X-Received: by 2002:a50:9f2e:: with SMTP id b43mr29626653edf.239.1605959187807;
 Sat, 21 Nov 2020 03:46:27 -0800 (PST)
MIME-Version: 1.0
References: <20201120104540.414709708@linuxfoundation.org>
In-Reply-To: <20201120104540.414709708@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 21 Nov 2020 17:16:16 +0530
Message-ID: <CA+G9fYuOK7oZcSn3qKUNf6sC18jb_W35HSC1Jw9ZUmwUZTQW0A@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/17] 4.14.208-rc1 review
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

On Fri, 20 Nov 2020 at 16:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.208 release.
> There are 17 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 22 Nov 2020 10:45:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.208-rc1.gz
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

kernel: 4.14.208-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 6334af4e50696e5e03708e10c1da2015a9f37c6a
git describe: v4.14.207-18-g6334af4e5069
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14=
.y/build/v4.14.207-18-g6334af4e5069

No regressions (compared to build v4.14.207)

No fixes (compared to build v4.14.207)

Ran 41882 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
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
* install-android-platform-tools-r2600
* libhugetlbfs
* linux-log-parser
* ltp-commands-tests
* ltp-containers-tests
* ltp-controllers-tests
* ltp-hugetlb-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-tracing-tests
* perf
* v4l2-compliance
* ltp-cap_bounds-tests
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
* ltp-io-tests
* ltp-ipc-tests
* ltp-syscalls-tests
* network-basic-tests
* ltp-open-posix-tests
* kvm-unit-tests

--=20
Linaro LKFT
https://lkft.linaro.org
