Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014D42A630E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 12:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbgKDLOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 06:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729263AbgKDLOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:14:09 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233BFC061A4A
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 03:14:08 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id v4so22045736edi.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 03:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AHN6dcB+x7JmTySm6Da2brK4RLL/Z+0Yk0lOnUmP3LE=;
        b=aKAvQTZqnfzfXla01T2u1ZzL9zYxmifM0cln3k0RO/RHYnJMZQpLuO30EEMpGzcdOA
         wIe/hFBWEHlvoJMif1vaaS5Ta1jh2CnbaVcLdd8d9JJ1sbu0+8yC9Z2/s5rJazixrcFk
         fANfEbXMDAS7hiD+akOp8XBrsQJf/p4BvNZ8LZrAwFl+xeILlPjwzT9JGrjp8RM8gI99
         Bj36q4Csw2v3OjzNFAH66xQB6+NQ0mS17mboz747TGrEXT47oMifPW0Dq5AaEHULPVkv
         BLSa+LPnIAl6PolFyjGXtbpNFlL2JXDSs5vi/HqjPFNHRZ8+3mQrhyfPPqAJES1Wn4b9
         MpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AHN6dcB+x7JmTySm6Da2brK4RLL/Z+0Yk0lOnUmP3LE=;
        b=T+YgqNDm4Pf45HdVzIxX5AyZUruDuneOmbfG3KxIDM+H0Qwrm3j1I2CJKATa/rNN2f
         wmD/cwRDjddhdyaO+xJK+05sSjX7rNpt2mGdiFeMYQjEw2KDeyCi++5smqW3z4JmC/tf
         6phhdADi9QIs79U8YnwDYEgJo7JB+kzJ1ep2XIhT6w3BlgSAaC6xkRiE7cW19cdhoeTN
         YFSG2TbadjzCfrTz76RKp84bspFIWqWIHOYv0GZWbEGD6Qce3CRInhy1opuE4+ovAxwM
         4IC4p25RpLk8N+mQ6MBi0V8pw1Fsb3OIolPyKzSulSfDqhD8zgEL5KSpvm404I0MB6+Q
         +4IA==
X-Gm-Message-State: AOAM533vVM3zDwKQv3vp1CDfHOJG4RDuBHqWCRpphszvO4K+nXfsKKVH
        I9CmUKGw3dpN9+arEtJ7qDVwl7s+LzhGY008Vv7aaw==
X-Google-Smtp-Source: ABdhPJxCx19XRBtvgRipWPFDJIDLsr1NIrDBE8K9OQewpneKbyZR9j8jNJJ3I9tNrBov6V7/XIViQxJchy2FrOxP20A=
X-Received: by 2002:aa7:d54f:: with SMTP id u15mr26719279edr.239.1604488446703;
 Wed, 04 Nov 2020 03:14:06 -0800 (PST)
MIME-Version: 1.0
References: <20201103203156.372184213@linuxfoundation.org>
In-Reply-To: <20201103203156.372184213@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 4 Nov 2020 16:43:55 +0530
Message-ID: <CA+G9fYtgux3o=nmN8ty8S=b+1zd87wmSUBCnhtYwmf=6qbi6zA@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/125] 4.14.204-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Nov 2020 at 02:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.204 release.
> There are 125 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 05 Nov 2020 20:29:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.204-rc1.gz
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

NOTE:
LTP syscalls test shmctl04 test modified in latest LTP release and this tes=
t
reported as fail. so reporting to LTP mailig list.
Failed on 4.14, 4.9 and 4.4 branches But
Passed on 4.19, 5.4 and 5.9 branches,

shmctl04.c:115: TFAIL: SHM_INFO haven't returned a valid index: SUCCESS (0)
shmctl04.c:131: TFAIL: Counted used =3D 0, used_ids =3D 1
shmctl04.c:72: TPASS: used_ids =3D 1
shmctl04.c:79: TPASS: shm_rss =3D 0
shmctl04.c:86: TPASS: shm_swp =3D 0
shmctl04.c:93: TPASS: shm_tot =3D 1

https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14.y/build/v4.14=
.203-126-g8c25e7a92b2f/testrun/3392140/suite/ltp-syscalls-tests/test/shmctl=
04/log

Summary
------------------------------------------------------------------------

kernel: 4.14.204-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 8c25e7a92b2f1688d46addf84ba6e3ec6f8d7d52
git describe: v4.14.203-126-g8c25e7a92b2f
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.14=
.y/build/v4.14.203-126-g8c25e7a92b2f

No regressions (compared to build v4.14.203)

No fixes (compared to build v4.14.203)

Ran 35206 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- qemu-arm64-kasan
- qemu-x86_64-kasan
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
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
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
* perf
* v4l2-compliance
* ltp-controllers-tests
* ltp-fs-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* network-basic-tests
* ltp-open-posix-tests
* ltp-sched-tests
* kvm-unit-tests

--=20
Linaro LKFT
https://lkft.linaro.org
