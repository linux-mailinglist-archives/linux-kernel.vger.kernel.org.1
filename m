Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A1C1D1D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 20:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390092AbgEMSPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 14:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733175AbgEMSPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:15:08 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584E3C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:15:08 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u15so649508ljd.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Bkr4q6KgnIghiuZ1zTrapdF/Gu24379MOs7c4e1m2Yo=;
        b=eQW/TUMeuC16ZZo/W86VPQ7vAGrBb+8hrhuKb1qKAsK6M7M+owMmBxIHkFSmhNOMHI
         xTpqefWhiMZ/TV2a1WFk7Zb/+AHbxiTbYBb6EXnJ/ilQU+TVIomYKuUT7cvMoL51clKY
         FtND/mYn38cocMoLwXTSlLhDKvPQEA3v6+I1j1Q5/N8Vim0OBicIIgBYxrlbKTNvvedz
         9DyZpM9uE/vWXvbur8w905LQTxgj6uQ1W38SnI6S3SCQWNb+G7FV6iFIuWhg0N6ViGhv
         Evey2/hgtPkakdKiQp+6wLVAYS2/2WpEmDsXgp2+Xp0wpkXyoqgZ0/NodL9jIAMw1wvB
         j1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bkr4q6KgnIghiuZ1zTrapdF/Gu24379MOs7c4e1m2Yo=;
        b=I/9qSVa63g8JEY5igS3I5mY3Tv4bCT8LQA8ueFRyj+ZTr/kDCIlQG7YcABkBGKsIIs
         BPBI8cp1dvN2ZNVZKLfhRXeZoQB+pr2lobWy5I4/1MqkPDsUTUhFxB7cCojVv9g9vQLP
         170GcE+u1h8VTns9MtO6PQsDf+UJKumvtdauZc2daqfroUBgwW+G04M8tSXyXAxjzDK6
         o5Pq+rjVLEABwFrYYU0svGb9Uh6x78eMrLFdosUGQbaNieUxFQnoaVlPTtlspULgjv9S
         0TuR8/qL5gaLr8dZ2y7JMl+n9wEuLI8tJ/NvQ/y2ZZnDGxOicU8kWdE1x2AjbFxTbg6g
         89jA==
X-Gm-Message-State: AOAM531Mdsgo7BtjFxMnrd9ZepVsCOoIWhTlgf686GXkjn4nUfIMYRVe
        kPngQIBiRndYACbwmiPWZQqcwl2s8wZZVTOOqdY5Ng==
X-Google-Smtp-Source: ABdhPJy3XT5ZxT6sKZtaU1bh/J3kW03+8WYfZ0HkT0FrgmtUHBjJkSNcX7SDYsr3UbhBtzBNXRn3W/XDywUzvZFaTWM=
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr193118ljm.165.1589393706623;
 Wed, 13 May 2020 11:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200513094351.100352960@linuxfoundation.org>
In-Reply-To: <20200513094351.100352960@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 13 May 2020 23:44:54 +0530
Message-ID: <CA+G9fYtM7ajECL6tJySrkSH2X-UG_S33cxDt18y5-zE1MUHbjQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/48] 4.19.123-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 at 15:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.123 release.
> There are 48 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 15 May 2020 09:41:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.123-rc1.gz
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

NOTE:
While running LTP sched on stable-rc 4.19 branch kernel on arm64 hikey devi=
ce.
Thermal alarm triggered and followed by kernel warnings and Internal error:
https://lore.kernel.org/stable/CA+G9fYvo2yUVicoZ7fOYf8=3DQxTtS8nW-Z2JGD4iLt=
U61E6xNdw@mail.gmail.com/T/#u

Summary
------------------------------------------------------------------------

kernel: 4.19.123-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 6d5c161fb73d8e3d1a5a0efcf2d089b939a1e165
git describe: v4.19.122-49-g6d5c161fb73d
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.122-49-g6d5c161fb73d

No regressions (compared to build v4.19.122)

No fixes (compared to build v4.19.122)

Ran 32876 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- nxp-ls2088
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64
- x86-kasan

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* install-android-platform-tools-r2800
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* kselftest/networking
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-hugetlb-tests
* ltp-ipc-tests
* ltp-mm-tests
* ltp-sched-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-io-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-native/net
* kselftest-vsyscall-mode-native/networking
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems
* kselftest-vsyscall-mode-none/net
* kselftest-vsyscall-mode-none/networking

--=20
Linaro LKFT
https://lkft.linaro.org
