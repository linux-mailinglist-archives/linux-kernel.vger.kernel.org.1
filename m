Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95AB2F8BEA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 07:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbhAPGjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 01:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbhAPGjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 01:39:07 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A8FC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 22:38:27 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id hs11so14094621ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 22:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r4KuFhk3mIdWFgKPGA6LMV0gdGSNgz8mUt3ThYzBMfk=;
        b=FCJcws+D6FObyl29DE9jTxFUoZdY/6EpmXNNOD9VQh4lTUoiCqnPSEG1AEdMDOZFPn
         k7l7ksgUepHIdYv91rxfswY28sfPmsf+EwwZgasnYFjdRJ43WMXaGtnjNpmN52koqVLB
         47/knUfQR4LI7IJoQfvMOuM2GAJ76LGHm24PAgTpcShmWFuKWJLFvqQmL9bgET/6TPEO
         2X9KVX0zBCjrG8HtP+1ve04T8J1D+3ay4TKCmRFZ3Y1qVRjDtGaTd5c8EFMRWQNZrFJG
         BWJpVD1waiVEDqE704JNup2EAzqzbdQNJHQbzG9UtbcFUEcB7XtXLF1XRMzVrKYDr6Sx
         VvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r4KuFhk3mIdWFgKPGA6LMV0gdGSNgz8mUt3ThYzBMfk=;
        b=ieAEGK1LLUPEkvW7VrlA+n2h+ceVb+4qAeGlRfi2hbYI8NLOjV2kxiTJ2T3HIVuXvC
         3UHlqr/S7GGp5vvU2Kna9tCtRnx8AkBz133gCYl3ReNOQ98no3KwnDZ8I0Mcj1eAqKQW
         2S5bSfyCKtjETqLTyVCTEsMvTgL1Og5czIVxthwt5r97rdGPDrOqSwAwe5Zgd6NwMXDG
         lbDSpuolYl4YRdcmPTLcZz34Zvm3EWfqYsvRm9Ce6nxG/Q3deOcFjnaNbvlhI/uuHwD8
         7LNV5LY51uAaI2CpVEEhmUnzsuh+xRfae0c4Ese7G+VHGNGqhUDFV4jf1rYbte5L3HxX
         YckQ==
X-Gm-Message-State: AOAM5319hEZY74p4QlcatlB69Fk3ZYM1DHZl7OcN/yn+UBEcpFkMkxCV
        fIM//5B5F9rW2SPUkBLXjRFUrt2F+fVhwKK7gkMRqQ==
X-Google-Smtp-Source: ABdhPJzWSTWOML8CpVge4KsTvDl4Y3g3kgoT6d+ypCQp+H2lhl+L5i3rXcvJBz2qzvBUVnkxIEeVrvswfkKHtQ91lVE=
X-Received: by 2002:a17:906:2695:: with SMTP id t21mr11830597ejc.287.1610779105858;
 Fri, 15 Jan 2021 22:38:25 -0800 (PST)
MIME-Version: 1.0
References: <20210115121956.731354372@linuxfoundation.org>
In-Reply-To: <20210115121956.731354372@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 16 Jan 2021 12:08:14 +0530
Message-ID: <CA+G9fYtr5wOx1Ov2KFLDNxtJ_YAjB=7mi-XG5Y2KL3kSr4icAA@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/28] 4.14.216-rc1 review
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

On Fri, 15 Jan 2021 at 18:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.216 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 17 Jan 2021 12:19:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.216-rc1.gz
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

kernel: 4.14.216-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 4cfcf012355fcec6a76068a773208220deebc337
git describe: v4.14.215-29-g4cfcf012355f
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14=
.y/build/v4.14.215-29-g4cfcf012355f

No regressions (compared to build v4.14.215)

No fixes (compared to build v4.14.215)

Ran 40410 total tests in the following environments and test suites.

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
- x86_64

Test Suites
-----------
* build
* linux-log-parser
* install-android-platform-tools-r2600
* ltp-containers-tests
* ltp-cve-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-controllers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
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
* ltp-securebits-tests
* ltp-tracing-tests
* network-basic-tests
* ltp-open-posix-tests
* ltp-sched-tests
* kvm-unit-tests
* rcutorture
* fwts

--=20
Linaro LKFT
https://lkft.linaro.org
