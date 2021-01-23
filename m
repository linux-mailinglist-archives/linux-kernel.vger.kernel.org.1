Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2453013C7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 08:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbhAWHfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 02:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbhAWHfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 02:35:33 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D682DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 23:34:45 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id g1so9158313edu.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 23:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MTXNT+spSERrYt7QDZLAPh2OjdE1rOC1Oi5GlPriYek=;
        b=Sxd4y0LouBnOrP1fwmqOApuZBWiQcmR3N9SSQGK+SH38jjarWzVrvoS8l7UY5c1g0a
         uHY3nLJVO5RRWELl9BMSSZo26RVmc3YDYM8EB+84S0FEMWkyUYWhOka3C8zmYJvnnAgC
         rGahpWa4Beh6omqgPhkrrtSwtWW6WrQhwzdbLfCzcoo1wAbOoWDdy6AAEgos2yYWMTC3
         AgFujKgYAIzEzsEVHOrhfBUqqcpyBQTdFl/jBF5x3VunDigSoeHRBj5NAwspuEVLYh0l
         eiP0lZTQVlONH4xtLd7bM2QUj0ITM7wOLtR9sHMq+Q47twACxtQMpqQ/Vd9qOQk7Li4T
         ubbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MTXNT+spSERrYt7QDZLAPh2OjdE1rOC1Oi5GlPriYek=;
        b=gmCbP+tlRYNkvIw7wHjG0oADpa0Zfx1LV1tLMQNhkcbg+mLaFZN/mg2rbyVsVKdSGe
         10gueL+xserh82l5JJ/drdSVhePRwXpXPf2lLcYh2rnQ/znjJDu/8IwafeWMx56pL0Cm
         X8jaRiUaW/EBbYQvktPKUoVfCwpnAX6HWAUc5sJpsw1AGG8MkHytYcS+YsrbYk2X5Zu5
         sKtveeGuGA4m3Nq8w28QEX8k37S0T0GAT7ZX3xI1fb9qCIvMl8jQZy/v6kjRRrIU6C8e
         w6Q4eKM2OwKWTkhl6QxBOQA47R29Oowk07IISWLBF7DmF7mnpaFLnJ6LsZkxx7y7OmW/
         X1CA==
X-Gm-Message-State: AOAM532NaZRbBD1EZoYTEDs4qKvGW96GTy7mJo6wE0mepImWyXe4nx56
        4rfjaxd8Vi91DEzjbTjIouqfB0pFv0M8Ip6+lvTG+Q==
X-Google-Smtp-Source: ABdhPJxRxkw//RsgyxF8xlXXZTdaLaQ/oEGtfwoOm/Nb12eFnBiIWAuJMmNw2aTc2TQ+BTD/3WHM+XbpAZANZcLkrQs=
X-Received: by 2002:a05:6402:3088:: with SMTP id de8mr4683215edb.221.1611387284506;
 Fri, 22 Jan 2021 23:34:44 -0800 (PST)
MIME-Version: 1.0
References: <20210122160822.198606273@linuxfoundation.org>
In-Reply-To: <20210122160822.198606273@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 23 Jan 2021 13:04:33 +0530
Message-ID: <CA+G9fYt=y9-NQFDmp8VjRcqFx+UeD30kzDtO0uNs08Dnn03HVA@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/29] 4.4.253-rc2 review
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

On Fri, 22 Jan 2021 at 21:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.253 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 24 Jan 2021 16:08:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.253-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
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

kernel: 4.4.253-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 36175a29c09cfbebb243f8515f60b3805846fe70
git describe: v4.4.252-30-g36175a29c09c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.4.=
y/build/v4.4.252-30-g36175a29c09c

No regressions (compared to build v4.4.252)

No fixes (compared to build v4.4.252)

Ran 18438 total tests in the following environments and test suites.

Environments
--------------
- i386
- juno-r2 - arm64
- qemu-arm64-kasan
- qemu-x86_64-kasan
- qemu_arm
- qemu_arm64
- qemu_arm64-compat
- qemu_i386
- qemu_x86_64
- qemu_x86_64-compat
- x15 - arm
- x86_64

Test Suites
-----------
* build
* linux-log-parser
* ltp-commands-tests
* ltp-containers-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* network-basic-tests
* v4l2-compliance
* kvm-unit-tests
* libhugetlbfs
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
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-mm-tests
* ltp-open-posix-tests
* ltp-tracing-tests
* ltp-syscalls-tests
* ltp-controllers-tests
* install-android-platform-tools-r2600
* perf
* fwts

Summary
------------------------------------------------------------------------

kernel: 4.4.253-rc2
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.253-rc2-hikey-20210122-904
git commit: de349d25fddae8bf11ff5dc914076c9c021e0505
git describe: 4.4.253-rc2-hikey-20210122-904
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.253-rc2-hikey-20210122-904

No regressions (compared to build 4.4.253-rc1-hikey-20210118-900)

No fixes (compared to build 4.4.253-rc1-hikey-20210118-900)

Ran 1761 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64

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
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* spectre-meltdown-checker-test
* v4l2-compliance

--=20
Linaro LKFT
https://lkft.linaro.org
