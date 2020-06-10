Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEB51F4EA1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 09:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgFJHLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 03:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgFJHLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:11:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8495C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 00:11:00 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so1142767ljn.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 00:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/Nm0Q3g/j/4B7bpmdYEoTXXfBDp03YrbvNYgYoKMM+w=;
        b=unA+94puOuIKCYe3zEidd2KdidekSpcqwMz4XYwjesrEq8U/nbMwCjIScKcRWE+fqx
         DMIQRGEOD8Wtvl370dIZrgr93AZODQIr4Rl80z9O7mltsXeQ+NyfVyKloSSOb9ymu1VL
         NFQUN3+x1ocmF7bwUbnPrhTklt+OtaqqBkoOUOinkPEy44/qjnMOjB90ln0Ma7W67I2c
         QKXRBiU551708fTTUPq9onrYNmLjkPX7tH7A3/m6n/JcZaHc9mV4qlrxuMYAxEJ21nQN
         8ZpJprf9SWax2ea4ChpHsCq/7pHR286TeL5M9VA2UTeerPulhh5oyrDiyKxaUeqOO+M3
         Px6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/Nm0Q3g/j/4B7bpmdYEoTXXfBDp03YrbvNYgYoKMM+w=;
        b=GI2FA2wkXysbv+wbn22f0ve9x00faqIYE0v0hS8h79kjbykoL7MgHSOQIZNV83MCDO
         5lQJ7pdGq+CXBNo1NnfeA61EccQTboaSk09KiOO9AGSVaiauH93dLcp+TFQw34bXs7Hh
         GTku2QGewqCmXewZ9cFz8ooZgQ6r5/sf35KYOh+MVJmqqQJ4683Tyf5kYBOKyZeNRZFe
         q/5/UiX3f6pRCPAf0yXGygdJU5vZVF1vle5TariaA3Eto5yVf8z47uiWa5dNEmY/0wtc
         jwNPE8vXLV9yMcpKm1XWGJVibKoUchyJdfo1vXngSOHyyeSzPQ8e7gXpW75atuY4etYn
         Ra6w==
X-Gm-Message-State: AOAM530BePGR5bITYCwZPaNKSZC/aRJfAdJ2b1ICtm8MdELEPclXJG1w
        f1Z684NoVuNhI0IlcfrfgsyzrR1bnkO+mIHPF57UnA==
X-Google-Smtp-Source: ABdhPJx4wXpcSfxXsIqJjxGcGMI5lPyrN+46lFb8hyGL0/Q0SVTemXxEOqh5tlDMIiRl50LqgiLM5ainhuQqhlUm51I=
X-Received: by 2002:a2e:984b:: with SMTP id e11mr941262ljj.358.1591773059027;
 Wed, 10 Jun 2020 00:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200609174052.628006868@linuxfoundation.org>
In-Reply-To: <20200609174052.628006868@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 10 Jun 2020 12:40:47 +0530
Message-ID: <CA+G9fYtVXRzY0aWpamnK0WcqE=hLKZwBMPKasDPoHZJPAD=sGw@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/34] 5.4.46-rc1 review
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

On Tue, 9 Jun 2020 at 23:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.46 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 Jun 2020 17:40:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.46-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 5.4.46-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: 12a5ce113626ce8208aef76d4d2e9fc93ea48ddf
git describe: v5.4.45-35-g12a5ce113626
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.45-35-g12a5ce113626

No regressions (compared to build v5.4.44-39-g0e4e419d5fc3)

No fixes (compared to build v5.4.44-39-g0e4e419d5fc3)


Ran 29093 total tests in the following environments and test suites.

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
* install-android-platform-tools-r2800
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* libgpiod
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
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-sched-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* ltp-controllers-tests
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
