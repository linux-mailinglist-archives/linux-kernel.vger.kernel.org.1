Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9158C2678A5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 09:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgILHuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 03:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgILHuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 03:50:25 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6847CC061757
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 00:50:25 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id j12so1131049ual.7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 00:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FTuNTK/bJRI2Ou6e+rsGCVdvqU5FCz4oSQ1Nmp3iR9g=;
        b=AIyFZtofSHC4NZ8LrDj+vVDz8VB3aathntovmSQA+xE2uscBU4F5H8swxGt/Bhh7YX
         RqgRhZ8Kb5UjqZAt3cGbuOyh29rNauK/U8nmXFjIlfO+f4+1CGPI5lt9WboFB6woIsvr
         IEVcyvgZnoR8YCaUMSOGrKg2IL1ij0p8UHYjTCXR0zL8jalMYA94kDScxe+4t4jTK+TN
         88+1JrpM/Iu3GfenHbD+gVsPDJjfYqiHO2nKvNwM8/bdV2saBxkmwJTMvxJBgWOMuKFM
         SuhKn83kYevLeATUFPOX6s5jubyLWDbFfT7sn62U0t1hNT48Q/otRHrbOWgmfWMNjXSZ
         HJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FTuNTK/bJRI2Ou6e+rsGCVdvqU5FCz4oSQ1Nmp3iR9g=;
        b=FyDjS/DkE3ixjczCEibZXf0Ymh1/NxRvO5W8Y8wYKoqoDmxaeq7T1QO1cNQtZAvb9L
         2GcNOffNk10rg0OLN5Wk6ioZ60aE+WSApTM7201KVs6xLq2ngkTWvJ1b3y1UCB1KkHWa
         CvcI4axWwn2DUVWM+j2A9IcJ7kVyYcMXgTcuxZTPsanXISUhXFdVsNq3EVz3xf7cpAzs
         PCmT6uiyuyk9iSrz2tpIb2r3/SsQTmFk4BSiNid36PC2DLKAH+qslqatg8xJiqFTP0f2
         G6eLD1nF1KkYWAFKhBxQiNozChpcEOdiTL0XnhvvVcOzXCaWJ4wW/wfvudZ23tkNGnGi
         XO9g==
X-Gm-Message-State: AOAM53080SEaG6m6IyrzBb/TMXJp/SnbIcQZ95kbnhLVMsA6k8LcIl+E
        HpozjHUc60pNTr9+TY8bQT5o39/fuAVnCjtbppS0ig==
X-Google-Smtp-Source: ABdhPJzOr52V0CgCy3vBurnhB9QkIXUKIr6vTBOih8NRPc/xGoEsnZdpRF8+vjT+w1dK7dduO13gJo/6rQd4+TMOnl0=
X-Received: by 2002:ab0:2c1a:: with SMTP id l26mr3211110uar.6.1599897022041;
 Sat, 12 Sep 2020 00:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200911125421.695645838@linuxfoundation.org>
In-Reply-To: <20200911125421.695645838@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 12 Sep 2020 13:20:10 +0530
Message-ID: <CA+G9fYsCoUKzFqNiV_EJv0RepSNGHgc2Ckh=rWk_s25XDdKU0g@mail.gmail.com>
Subject: Re: [PATCH 4.19 0/8] 4.19.145-rc1 review
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

On Fri, 11 Sep 2020 at 18:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.145 release.
> There are 8 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 13 Sep 2020 12:54:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.145-rc1.gz
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

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

Summary
------------------------------------------------------------------------

kernel: 4.19.145-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: dc4669f837af87843c89b6eaccfe395fd83bc1df
git describe: v4.19.144-9-gdc4669f837af
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19=
.y/build/v4.19.144-9-gdc4669f837af

No regressions (compared to build v4.19.144)

No fixes (compared to build v4.19.144)

Ran 19565 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* build
* install-android-platform-tools-r2600
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* linux-log-parser
* network-basic-tests
* perf
* libhugetlbfs
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
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-tracing-tests
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
* ssuite

--=20
Linaro LKFT
https://lkft.linaro.org
