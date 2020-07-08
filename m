Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D09217F47
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 07:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbgGHF43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 01:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729450AbgGHF42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 01:56:28 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63308C08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 22:56:27 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id j11so3983339ljo.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 22:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xTA9wtH1lLSUNwm6vjcqZv4w0az/iyPfRuwwmpvGZdc=;
        b=rgthVhHUThyUAYY+Hlj2YWNZzEshJAMA0Pf8FRmCzaUZ2JDpG8vl4t+3VsEGXnst+B
         oj4CFY/ifEgTVWvm6Eix+nzUcik+s/nkmgvkHej0J2sFIXev1HyMWb8Rotz22KBD2puG
         uiIeQePdbpHTnE6HM4HutDNEV1tMwXOwcYXazExHe9mZqOgxh+EUYoqofd/X15x7Rig8
         tHeTGg5OP+s3jaXk5yNIzDrkZPYyLAhX/YqnkS6jTLRjbpdK2fSKkewMVo2P9F0Rf4Fp
         Hjx5Pjl+yaVmR9z4mXJ4Qbf7dpNxhC0EPyytPUvFz/gkT1HXOmUH8aGeLRG42PzCEB2Z
         f5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xTA9wtH1lLSUNwm6vjcqZv4w0az/iyPfRuwwmpvGZdc=;
        b=Tp5Eh7F36ebwbeVs2Kg5Yx83EcLFHTp0idk1mkrjBIEU8/jQU9GNnatbrtUR5ZD+bf
         ZfxZvb3+OfZPJpw3elm1l2jbfPQ0o5vUZ1CH/DOKROfjLaJVcwIekeDaEvZJetI69cL2
         5DrmMRk2F3VlqPwrft54F4Z0IK7CLTrbbKsYnP5eogYFFFUCdJ4/J4tGpoBTJWmLi0yd
         INViiCgVbDs8l+rqq6n/JHkLAnTUQ2l89WS+L0SbHPAed2rqjWPe3P47OCSQLgjD7yCa
         jV639KOC5JwtR7GyVgkvQhvT8cZB2JiQPBs33os17lMuo749C11HRvSAB+g19fjB/KWW
         PY1Q==
X-Gm-Message-State: AOAM530EXDVIJVzgVXpbrPk/zsnS4Y6SczCkhuxHsjZI8xDPAi9BxmTU
        i8+CUZzVknyaBSJWKQoD7KRs5IsB1NpvCsMxBxjluJeq5gsSiw==
X-Google-Smtp-Source: ABdhPJzy6IS//cmE7cy7+em7+9Qp+w4r1y1BkSX2PCLWFbEUzLJgbAVjzLSoTTWkbZ4JE6aam+fkfRJry5RPoA+x4RI=
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr31703150ljj.102.1594187785588;
 Tue, 07 Jul 2020 22:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200707145749.130272978@linuxfoundation.org>
In-Reply-To: <20200707145749.130272978@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 8 Jul 2020 11:26:14 +0530
Message-ID: <CA+G9fYvkRi6=Eky_unsZW=3EtmThZiW5f=7KaEmtMe6dunggMA@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/36] 4.19.132-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jul 2020 at 20:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.132 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 09 Jul 2020 14:57:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.132-rc1.gz
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

Summary
------------------------------------------------------------------------

kernel: 4.19.132-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: 168e2945aaf526364ca3aa3e674490d363c32a33
git describe: v4.19.130-164-g168e2945aaf5
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.130-164-g168e2945aaf5

No regressions (compared to build v4.19.130)

No fixes (compared to build v4.19.130)

Ran 33084 total tests in the following environments and test suites.

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
* libhugetlbfs
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* v4l2-compliance
* kvm-unit-tests
* ltp-controllers-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-io-tests
* network-basic-tests
* perf
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-native/net
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems
* kselftest-vsyscall-mode-none/net

--=20
Linaro LKFT
https://lkft.linaro.org
