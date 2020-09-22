Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E782739FC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 07:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgIVFC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 01:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbgIVFCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 01:02:25 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B72C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 22:02:25 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id z19so2921901uap.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 22:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xrn1BNnpKslvnuVNZTOkMjF6zJNusZTWxQhyjjhwsTo=;
        b=H/853HYRqDdNgnVs8/D5fhLGsl/Ya3BHJejlNCnAwBQw2AJdw5wnvzGx3Ovzu7oFwr
         sfBrw2iw1hKHEtt6fyXoPIeCq+tL38fUDa9zU536sW+pK/lnG0eLcEWUFh70PFpwG6v6
         GBjPnBMq2ZkbI9HP2FMtTUs5vYuayQu9Oo8pyuveZwtOwSJIlmubUkWZOMJAg/p2AZPw
         U+9C0uwAKh/acO3MLq3La18m9YKJEAVws5YagjM/4JUpN6gI3mK0r90Fry2hefw6u5/C
         WB9/NPmWifdhDWSVA68qJvnFgTcdFmHRq05UV8viqV5g7EnGxjG79QLV+5Ezexii/+Za
         W0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xrn1BNnpKslvnuVNZTOkMjF6zJNusZTWxQhyjjhwsTo=;
        b=j/3FnLaIE4pVMvZ3ndrEa+MISrXLx7mcRXzOl1nrByUulhKkmCJDLfXukqmP1rI1zx
         3qhDpea5ySHoDMd4E1blOkr1TqtSjPHQsB95Db8vb2ocJ3q1Pw+z586qtBcpcuVRcsRJ
         Nf5BJck/RVeGamOsrtal4SZe10DOU1pmqr+IZECxvzA40aqPYFlHnScilQgWzZ/keGA+
         XW26Z0kWNjiUAapkcLTTNMx+lvQJ2ZAzZFE6R2S2xFhZIzPYyAmSu8TgloP2yAfqd5dj
         EAk0UFW+AvDJd37O7oaIPuiZdgsPMg5Xtbvr0PmG0WNE25q4upIs/wjd960/9rfYucxs
         UcZw==
X-Gm-Message-State: AOAM532ZqA4cfgAR9mqxZWOGi7/JHfqu5KY+08h5w7E23trzMCeT58Nr
        qGU8UfbgSDOSunhO7hF6t7zfP639Sp5xKn1YvozKGg==
X-Google-Smtp-Source: ABdhPJxZYBm/gPA1csf+TQs4z1hOrwheMiPKzUFzM/G34/P73Wh6PTc00c86Ij8VS7rmBuzOZSuotXvvyr5zWLbUn2Q=
X-Received: by 2002:ab0:2c1a:: with SMTP id l26mr2267048uar.6.1600750944494;
 Mon, 21 Sep 2020 22:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200921162036.324813383@linuxfoundation.org>
In-Reply-To: <20200921162036.324813383@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 22 Sep 2020 10:32:13 +0530
Message-ID: <CA+G9fYvt-f_h_6Fr7qo2MDuWbgi4W9QHOMt_eOB3=r+isGV8dQ@mail.gmail.com>
Subject: Re: [PATCH 5.8 000/118] 5.8.11-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, pavel@denx.de,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Sep 2020 at 22:14, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.8.11 release.
> There are 118 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 23 Sep 2020 16:20:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.8.11-rc1.gz
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

kernel: 5.8.11-rc1
git repo: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
git branch: linux-5.8.y
git commit: f2ae9d9cdf48e015834ce21030249793bf0c44f5
git describe: v5.8.9-296-gf2ae9d9cdf48
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.8.=
y/build/v5.8.9-296-gf2ae9d9cdf48

No regressions (compared to build v5.8.9-178-g337aafeeb4cd)

No fixes (compared to build v5.8.9-178-g337aafeeb4cd)

Ran 36879 total tests in the following environments and test suites.

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
* libhugetlbfs
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
* v4l2-compliance
* ltp-fs-tests
* ltp-open-posix-tests
* ltp-tracing-tests
* network-basic-tests
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
