Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4EA61FC993
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 11:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgFQJNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 05:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgFQJM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 05:12:59 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DB1C061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 02:12:59 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id i27so1906988ljb.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 02:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G+xHJi7KZrfWRccJgJGXsYFSSP0ptf2Y6b2mzIG6RXA=;
        b=BbXQK9zAiOYwyQir0D+QfF5ssMF0f5abzjtBAMyE6gYV7Xq+gXnv1bMvrVygXcUz77
         Rd7tm5ejer2KlO80ADxxAe6tGLSwZAZos1LzgDOlvq5U1+IjhCynYkegIxxqHxEV3NSQ
         6UfgMolvwKY5+f2Ov0H7qRV77AuMj3Bk5fF6EmeEXZynmMn6pfM37gkU61VH1BXOpYDy
         4HmF8xm+EaZ0z4M/GGn51otZTEgCvZ2TTlnY/RKU3AMToWzatk1TMnC4tDRlkoTIjniH
         9RDsE9puy61BOFnc5BT2nEsVISARUFEwWnf+6vMQ9UvxnMGQ+LiixxSNkiEfGmA+hSl0
         bKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G+xHJi7KZrfWRccJgJGXsYFSSP0ptf2Y6b2mzIG6RXA=;
        b=nQjcTk250bU1SWnKBHS/ijsfxB6AAbPMNc85h+10mc+NNfZf8/bah5XhL1ddEL/6M6
         P3SsNrQtiMx8MUDhU5669YWcOwVPnjSsXroVDJ1EGa+ec15UhQ01XgTiVy/p+gMt5xwz
         SZ7xVxzzIMpDSVrinNsQi725DUMlyqzx1iRjnyJF0ew7TBW0xC90vdcQnij++lT4Esi8
         wrXfm4N2ZbVZg4TpjVO5gvMD4xCjCB6Ysm6LNuZqjuNkud58cnJxQ8c28eTgJq83ekcH
         Aeh1CrndTMqm+XyRuyT+37NPa9tfONp38jN0IpKA9LujPbFuB/nazRBfFNU6ozO8l/K7
         geag==
X-Gm-Message-State: AOAM532fLfgroSVialxYl0fTW5/IBKEGlD8ZniTCGz/Z64jldZKl7RDA
        xFdEWLxQ2OgLOkBt59elIk7j1yGAj7AMOciuXFWfkw==
X-Google-Smtp-Source: ABdhPJygRPotntp3D+jaMFxjuEezcDXsQXnCUHceRL/eiSi3tHegxR9o2aByM+xPBj/cayEp7N1JonM6dqRlSCZ8aUs=
X-Received: by 2002:a2e:b88c:: with SMTP id r12mr3482623ljp.266.1592385177365;
 Wed, 17 Jun 2020 02:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200616172616.044174583@linuxfoundation.org>
In-Reply-To: <20200616172616.044174583@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 17 Jun 2020 14:42:45 +0530
Message-ID: <CA+G9fYuigTP5KNny+v5TV6SDSV=_WPMuF7wNNfJuM26goVdsLA@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/131] 5.4.47-rc2 review
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

On Tue, 16 Jun 2020 at 22:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.47 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Jun 2020 17:25:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.47-rc2.gz
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

kernel: 5.4.47-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-5.4.y
git commit: a7debb64f8b4820a8a003bf3bd0b702a111b4a4b
git describe: v5.4.46-132-ga7debb64f8b4
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-5.4-oe/bui=
ld/v5.4.46-132-ga7debb64f8b4

No regressions (compared to build v5.4.45-35-g12a5ce113626)

No fixes (compared to build v5.4.45-35-g12a5ce113626)

Ran 31495 total tests in the following environments and test suites.

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
* linux-log-parser
* ltp-cap_bounds-tests
* ltp-commands-tests
* ltp-controllers-tests
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
* ltp-sched-tests
* perf
* kvm-unit-tests
* libhugetlbfs
* ltp-containers-tests
* ltp-fs-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* network-basic-tests
* v4l2-compliance
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
