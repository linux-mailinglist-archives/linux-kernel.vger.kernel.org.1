Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001CA1C321D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 07:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgEDFO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 01:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgEDFO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 01:14:57 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC6BC061A41
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 22:14:57 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z22so8413333lfd.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 22:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9nzgDEWH6ImkLnYSJ3bM0OeaWawCZqATcdJo5AhI5iw=;
        b=UrYbd+ItU8UZTZCGOdlJqu9SK5CnqUpTadX1qm4yE1HQBwzJB3TsRjs1O+Zqo9Ea1m
         DAkeALp1NgYhyz+KMKWDZqpSF4f08SaeI+p4oIoPiIG/CxTL1Zo6yIOKcCPy94a7CWqA
         Hm0e/2K1lDfe7pQTADz6TidPKpfVVsZhOoq60RpHrZe1LrMBCqlTBSZqaxXIvRRSCH16
         pNWEYNgbyLxqreNPkpMPTOVFfaklho3FGUxD8yLbsGljo5BAqGouoxCHC/ognRQkt2y/
         yiMEHbFDntyZR69fGkFH3ymxiWipAxphWyZxc1HGBVMPvirubnQHD9TrRi0g74LsEnDw
         Xwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9nzgDEWH6ImkLnYSJ3bM0OeaWawCZqATcdJo5AhI5iw=;
        b=ZTXqS0tF2+O2lXw9CL6ytA4SWC9yKRLGOST0/KNzNK77XkyVsTaq0EO+b3P+yjscC2
         /9djKJDypKV24MYXNbqhGUOtIhciP0ylLdNoNPlnHwzqJpE3enSvMf3KEy4Ad1WO21EV
         GbmNAGYhax5hI4/Yow9dUk/SqlNw7jKy8a3ylBFB/F7zEzcsjQjxF5JqBNSsklMHLkvh
         nNjnZcbUbeQDKtW9BzzQBY7CpB6A9woEY8ZFM9ewx10G981SeB20kXEHE+vXuEYfeN7X
         r2Di3ocZjalkWzsXQWS0ZKKC1SEsJYeptF00WzUoC4mkwoUrOHws16hA5y0mi9YoDk8x
         bpiw==
X-Gm-Message-State: AGi0Puafqg9viaR9u1v9ZPjOODXvizeUTmc613fQWZ5pKKp95cKRsLSJ
        x+hRQTyQckbQcJbWGmO8MzGtUaQRmwhKWnyQryN4yA==
X-Google-Smtp-Source: APiQypIfBTBj9zSfUgCJxCm8ewLxuAOCxL6IVRaKyx8Dozauou+uabe1f080+DzXfSj/QLmvjG7yLnUORjgBEa1BmqQ=
X-Received: by 2002:a19:4883:: with SMTP id v125mr10222444lfa.95.1588569295652;
 Sun, 03 May 2020 22:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200502064235.767298413@linuxfoundation.org>
In-Reply-To: <20200502064235.767298413@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 4 May 2020 10:44:44 +0530
Message-ID: <CA+G9fYvreWQUzd3tu8yRADb5=zFs5eQ7kpHoMB+iHQg_kkL+BA@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/47] 4.19.120-rc2 review
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

On Sat, 2 May 2020 at 12:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.120 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 04 May 2020 06:40:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.120-rc2.gz
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

kernel: 4.19.120
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: fdc072324f3c66190a20f57490b4842a391d8233
git describe: v4.19.120
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.120

No regressions (compared to build v4.19.120)

No fixes (compared to build v4.19.120)

Ran 26686 total tests in the following environments and test suites.

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
* linux-log-parser
* perf
* libhugetlbfs
* ltp-commands-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-math-tests
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-securebits-tests
* network-basic-tests
* v4l2-compliance
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
* ltp-crypto-tests
* ltp-dio-tests
* ltp-fs-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-open-posix-tests
* ltp-sched-tests
* ltp-syscalls-tests
* kvm-unit-tests
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
