Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E340F29DAA7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390327AbgJ1X0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732861AbgJ1XYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:24:17 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23448C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:24:17 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i7so785700qti.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lncSFXoccijzIx7cCu7fz2TYCVLmVq6ViISKM0iPxwQ=;
        b=EiPHWs5M/eHjBcDWcrcCXLi3xpU0W5cOyGIu6+r64yElzDv+66CBDK7sKQ5Iv+273G
         uQUWSrbmavi9z5ONzaumJiRgENYTnngUWKrC/LHrvJTXG8yQqUfPxX52skVezNeKOyXS
         OBS+thGHpP+6sLOqJz3+iNfX2dte+s0XMbHWazZs+gr+yTCM6pfaQ522ZP2LKzT19ZAc
         waRWCPoA9dfu2qScnC2pXIqWE/s+0wTsFuGlUbisTrjq345nQxFKkSy/Od0xlz1FBzVh
         STHdMhb0EQBsA2SSDyLWt0DOj64SZhs80oZA/7+zoa+BZFFHCX8jHlPK0kdBnYi/T9/s
         YlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lncSFXoccijzIx7cCu7fz2TYCVLmVq6ViISKM0iPxwQ=;
        b=SQluz9oSenyl6eixISfcm0HvslaSqhFrwPv87IXXfdw+1bOctCAf9+3OIUyMEXY1HU
         xb51qBfLYLn74T3jDQA4FyedzgRrcAaZfxlDml54WTMqHpruAYxgBhKXbP6Qzjh0tjeF
         sLokLywg+blkMfhQ0PsTTdZwA55gjtq53sbXo40pY1t/grTUH2gqJf3s9FotPWT3LLIK
         ZGx7I8rcwUR3BFheQSP1dohjhW/q0pzKyXe7Sac2jsLeKz3wA9v35iXBDkinUYnpMVj5
         uE8yeqMFDgsPYwdqo/kt+Bqjr1bwsGDD3/F1M/WR1MrIKufpdGsqH01G9l9ZkqhcWL4k
         vfGQ==
X-Gm-Message-State: AOAM5326Ax+hl/e1sqck4dyPut05xX0axDYH44QhW/KuU2Cu12KHe889
        O82U7pkyXVsOkcX8fHtmVMVlUUsPuBR5dPLD0iVpPkqqLVxkLaX4
X-Google-Smtp-Source: ABdhPJxNDBIqJiViYPoY45bIuG7FvBmKWlkdKA7c1YbLbRDzJ553Un85py/+9pn5wIwI9FnTcVRdmMOer+fP+Jf6Nsc=
X-Received: by 2002:a02:ec3:: with SMTP id 186mr5397376jae.92.1603866372171;
 Tue, 27 Oct 2020 23:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201027135522.655719020@linuxfoundation.org>
In-Reply-To: <20201027135522.655719020@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 28 Oct 2020 11:56:00 +0530
Message-ID: <CA+G9fYtoEtGQScL8YssnKDVxpmdEZjTjS5yT7AOJWrFTz8Mtmw@mail.gmail.com>
Subject: Re: [PATCH 5.8 000/633] 5.8.17-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>, pavel@denx.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Oct 2020 at 20:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.8.17 release.
> There are 633 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Oct 2020 13:53:43 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.8.17-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.8.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
The Kunit test is a part of the LKFT test plan from now on 5.8, 5.9 and
Linus mainline and Linux next master branches.

Summary
------------------------------------------------------------------------

kernel: 5.8.17-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.8.y
git commit: 5be39e9f29ceb931a3c8bfa71a3f18345bb6d3d5
git describe: v5.8.16-634-g5be39e9f29ce
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.8.=
y/build/v5.8.16-634-g5be39e9f29ce

No regressions (compared to build v5.8.16)

No fixes (compared to build v5.8.16)

Ran 42308 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c
- hi6220-hikey
- i386
- juno-r2
- juno-r2-compat
- juno-r2-kasan
- nxp-ls2088
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15
- x86
- x86-kasan

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* kselftest
* linux-log-parser
* ltp-containers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* libhugetlbfs
* ltp-commands-tests
* ltp-controllers-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-tracing-tests
* network-basic-tests
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-open-posix-tests
* ltp-sched-tests
* kunit
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
