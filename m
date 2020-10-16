Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E8E290B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 20:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391870AbgJPSbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 14:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391688AbgJPSar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 14:30:47 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EECBC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 11:30:47 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id i7so1711463ils.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 11:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XwC1t/kd5tVFB0hOhwkLMyhbDe+C5ISqOwxwxSmqbmo=;
        b=ytTZHlGiXHV0W6YLcMA4COSY3JJc6ptnBpuiiH78AyHZrAX9KUF0+AUFCeSJjf3NZ7
         VaHkNuSnD4R8V22D8sb6JYqfeww8izw6ud5dKiUCB9EPwZHTIEJsfk2oeX3o3Er2pwXI
         c3qsxBTRX8rwk2uPmM3JUoxnynde8AZNIM8BQWekIV5IszE/H7TWCQhoUUb2k7+HpJbx
         l63Tm37HQwbCO3JTLz4jlRdDJztM2zMhCG/TvalJRdZgJvbWfFoMMMvpCTvnz8VWhRrI
         LDLXgSAiUtu8wsO7teJWT/C44EevUQjmzLSoNnvjWXndPETryFLY4kwaoxuUNVMUGY2y
         YSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XwC1t/kd5tVFB0hOhwkLMyhbDe+C5ISqOwxwxSmqbmo=;
        b=FNzBp5ATB2ZskL25xFhwlB6WYGmz73H9zNL7Dgt1P9q0Zu0/NUboNfdwazVFyAxPjs
         WDV6HR6sXg++psw6mBwyhSQ0mr+X3qj31BgniLuKTYHoXZ2Xgo9HlGtHnQcoWV6hPTmK
         Uc50hSJuoAqD33fthNMB7Yz8LjffhKUbxbOvBVYrRdNHdbQzVedfq2mpE5bdRnS3/0qS
         p3DvIqrVPwlKiKAUCqPGcPWtONxhr8m1Q14gAjldW0XLby2VKzhwYLd7jr20MeptcyVg
         xdWrp46R96zPN7oUiD63fjC46ky0vGGdx0oL/QzAxxO9zNdXW877u11eVts9iXkUCZ1E
         +/dw==
X-Gm-Message-State: AOAM530VzIsOAJeU0WN8osfEINm0LTP7P4Bg7VpDNpHOcbUmeuuKaubp
        iCTVQY1xR7Jgvp6qtch/H2ex1Yqb8eVG5OtXA863xg==
X-Google-Smtp-Source: ABdhPJy3GERS3QJnHLyVKXmmixtnI3c0S9Pvt4tAFwMmL5OZcxhR1vJwxhnnmBWZ9+HitJSPykH0Pz2hjweVN4m0hMc=
X-Received: by 2002:a92:9944:: with SMTP id p65mr3592525ili.127.1602873046288;
 Fri, 16 Oct 2020 11:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201016090437.153175229@linuxfoundation.org>
In-Reply-To: <20201016090437.153175229@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 17 Oct 2020 00:00:33 +0530
Message-ID: <CA+G9fYu211uHcMAo-m5zA4xzcAuU8boWvFajxU7NM=GLw_b3ww@mail.gmail.com>
Subject: Re: [PATCH 5.8 00/14] 5.8.16-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>, pavel@denx.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Oct 2020 at 14:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.8.16 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 18 Oct 2020 09:04:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.8.16-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.8.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Summary
------------------------------------------------------------------------

kernel: 5.8.16-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.8.y
git commit: a69084e6863a56b57c00d2ab5f4da07ea351cdd7
git describe: v5.8.15-15-ga69084e6863a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.8.=
y/build/v5.8.15-15-ga69084e6863a

No regressions (compared to build v5.8.15)

No fixes (compared to build v5.8.15)


Ran 29148 total tests in the following environments and test suites.

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
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests
* perf
* libhugetlbfs
* ltp-sched-tests
* network-basic-tests
* v4l2-compliance
* ltp-quickhit-tests
* kselftest
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
