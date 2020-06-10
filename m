Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723F71F4EC0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 09:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgFJHUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 03:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgFJHUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:20:21 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AF7C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 00:20:20 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i27so1131847ljb.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 00:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uZ/PfOScGoa3FweXz1QNDV3wu1XkvanILF/cLBpzXMc=;
        b=ASYIj2xeGskpwMp1GFHyDoUpd7q4oglT4HkpTJcQssddVLikaxHDbct0piykmh8FkH
         cUx19DG0LVPO6yF9RSlkRG18C9c68djfAfoEjXew039zxeJko/Db1fHbah2MAvfRBit1
         74di4GuJZsta7BS0CulmIHEeD65wHFFpHv/QY+XnuYKDr3+hpB0nFEukpTnGta+fNjIM
         cpfOSFgjW9w/3tXZaaEqOXLegwaWU+Y10KcmZbQukbZHud4K9FW2GNJ89TH8p5hx70n7
         iRV1P1POgNWrkrdXU22PjcNgORqfXz/zLjDWr9WlFygv7zqqg8cMfK3fVj03l4RGmV6s
         Zc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uZ/PfOScGoa3FweXz1QNDV3wu1XkvanILF/cLBpzXMc=;
        b=VI1v0LGO+PVtkDJi0fA/Gzt6yllXQXb+KZJ9GZftJby3RA2SE+8owTHnlCk0dxMxZJ
         P076lhDxFy7QG+0O8r6CX5vVgphTiZfNv8RPk01dY8qnyt3qChUrJ2tpyOrzD/vE1H20
         MM81X/oWLAJosHvQHb/VZBj9o+oA/oGO8EB+wzEe3sVme0ZjB0uk4dVftNuUTH0EyJhz
         ZeQwJeHbhVZ5m7IE4ZOwqI6jisE96etPBY+CpVIdzZ8WvjfLvdpLmIOMOq9dDLkXebNH
         TrkQWSSz7UcDURmii1uRkPtnGrxZpGf3Xot7SOYrErSWT/OsVjPqFaGt8LdbOggvbQz6
         tLDw==
X-Gm-Message-State: AOAM530ia9u29c3aXIQql6JNZs+PqQZFzwBSJ1fcyRCntR4LCQ7O08w6
        M6kom70pKIojEs4Y6CQ3Ww/R/kaD+Fxk5Li8WkyPF+Afriwefg==
X-Google-Smtp-Source: ABdhPJyfasAA+T2A7c7gUSsvWqCE7C1lsqY2OfVMnORTtCOe6dUbeYbKeMb3PcxfB/GVl+kp8qmijhyNbr0dI5WgZN0=
X-Received: by 2002:a2e:974e:: with SMTP id f14mr988228ljj.102.1591773619174;
 Wed, 10 Jun 2020 00:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200609185946.866927360@linuxfoundation.org>
In-Reply-To: <20200609185946.866927360@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 10 Jun 2020 12:50:07 +0530
Message-ID: <CA+G9fYvOazOi0_QofyxjENdicKH1yzFwBQGVTw9Z2VdgZ=xvGQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/25] 4.19.128-rc2 review
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

On Wed, 10 Jun 2020 at 00:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.128 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 Jun 2020 18:59:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.128-rc2.gz
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

kernel: 4.19.128-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: f6c346f2d42df9a649df8616aa529f7564b9c0b8
git describe: v4.19.127-26-gf6c346f2d42d
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.127-26-gf6c346f2d42d

No regressions (compared to build v4.19.126-29-g65151bf9f715)

No fixes (compared to build v4.19.126-29-g65151bf9f715)

Ran 33547 total tests in the following environments and test suites.

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
* ltp-commands-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-hugetlb-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* perf
* v4l2-compliance
* kvm-unit-tests
* ltp-cap_bounds-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-dio-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-sched-tests
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
